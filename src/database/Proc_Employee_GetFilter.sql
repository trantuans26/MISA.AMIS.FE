CREATE DEFINER = 'root'@'localhost'
PROCEDURE misaamis_development.Proc_Employee_GetByFilter(IN $Keyword varchar(100), -- Dữ liệu tìm kiếm
IN $PageSize int,  -- Số bản ghi hiển thị trong một trang
IN $PageNumber int -- Số trang
)
BEGIN
  -- Auth: TTTuan
  -- Created date: 22/12/2022
  -- Desc: Lấy danh sách nhân viên theo mã, tên, đt di động, đt cố định của nhân viên
  -- Modified by: TTTuan (22/12/2022)
  -- Running test: CALL Proc_Employee_GetByFilter('02168859', 20, 1)
  DECLARE $Offset int;
  DECLARE $Limit int;
  DECLARE $Search varchar(100);

  set $Offset = $PageNumber;
  set $Limit = $PageSize;
  SET $Search = $Keyword;

  -- SET giá trị mặc định
  IF $Search IS NULL 
    OR $Search REGEXP '--|SELECT|ORDER BY|GROUP BY|LIMIT' THEN
    SET $Search = '';
  END IF;

  IF $Limit IS NULL
    OR $Limit <= 0
    OR $Limit REGEXP '[A-Za-z-]' THEN
    SET $Limit = 20;
  END IF;

  IF $Offset IS NULL
    OR $Offset <= 0 THEN
    SET $Offset = 1;
  END IF;

  -- Xử lý SQL Injection
  $Offset = REGEXP_REPLACE($Offset, '[A-Za-z-]', '');

  -- SET điểm bắt đầu 
  SET $Offset = ($PageNumber - 1) * $Offset;

  -- Câu lệnh truy vấn trả về tổng số bản ghi thoả mãn điều kiện
  SELECT
    COUNT(e.EmployeeID)
  FROM employee e JOIN department d ON e.DepartmentID = d.DepartmentID
  WHERE (e.EmployeeCode LIKE CONCAT('%', $Keyword, '%')
  OR e.EmployeeName LIKE CONCAT('%', $Keyword, '%'))
  OR e.Phone LIKE CONCAT('%', $Keyword, '%');

  -- Câu lệnh truy vấn trả về dữ liệu phân trang
  SELECT
    e.EmployeeID,
    e.EmployeeCode,
    e.EmployeeName,
    e.DepartmentID,
    d.DepartmentCode,
    d.DepartmentName,
    e.JobPosition,
    e.DateOfBirth,
    e.Gender,
    e.IdentityNumber,
    e.IdentityDate,
    e.IdentityPlace,
    e.Address,
    e.Phone,
    e.Fax,
    e.Email,
    e.BankNumber,
    e.BankName,
    e.BankBranch
  FROM employee e JOIN department d ON e.DepartmentID = d.DepartmentID
  WHERE (e.EmployeeCode LIKE CONCAT('%', $Keyword, '%')
  OR e.EmployeeName LIKE CONCAT('%', $Keyword, '%'))
  OR e.Phone LIKE CONCAT('%', $Keyword, '%')
  LIMIT $PageSize
  OFFSET $Offset;
EN