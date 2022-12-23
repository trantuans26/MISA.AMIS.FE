CREATE DEFINER = 'root'@'localhost'
PROCEDURE misaamis_development.Proc_Employee_GetFilter(IN $EmployeeFilter varchar(100), IN $PageSize int, IN $PageNumber int)
BEGIN
  DECLARE $Start int;

  -- SET giá trị mặc định
  IF $EmployeeFilter IS NULL THEN
    SET $Keyword = '';
  END IF;

  IF $PageSize IS NULL
    OR $PageSize <= 0 THEN
    SET $PageSize = 20;
  END IF;

  IF $PageIndex IS NULL
    OR $PageIndex <= 0 THEN
    SET $PageIndex = 1;
  END IF;

  -- SET điểm bắt đầu 
  SET $Start = ($PageIndex - 1) * $PageSize;

  -- Câu lệnh truy vấn
  SELECT
    e.EmployeeID,
    e.EmployeeCode,
    e.EmployeeName,
    e.DepartmentID,
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
    e.BankBranch,
    e.CreatedBy,
    e.CreateDate,
    e.ModifiedBy,
    e.ModifiedDate
  FROM employee e
  WHERE (e.EmployeeCode LIKE CONCAT('%', $EmployeeFilter, '%') OR e.EmployeeName LIKE CONCAT('%', $EmployeeFilter, '%'))
  OR e.Phone LIKE CONCAT('%', $EmployeeFilter, '%'))
  OR e.Fax LIKE CONCAT('%', $EmployeeFilter, '%'))
  AND e.department_id LIKE IF($DepartmentId IS NOT NULL, $DepartmentId, '%')
  AND e.fixed_asset_category_id LIKE IF($FixedAssetCategoryId IS NOT NULL, $FixedAssetCategoryId, '%')
  LIMIT $PageSize
  OFFSET $Start;
END