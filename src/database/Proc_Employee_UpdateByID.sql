CREATE DEFINER = 'root'@'localhost'
PROCEDURE misaamis_development.Proc_Employee_UpdateByID(IN $EmployeeID char(36), -- ID nhân viên
IN $EmployeeCode varchar(20), -- mã nhân viên
IN $EmployeeName varchar(100), -- tên nhân viên
IN $DepartmentID char(36), -- ID đơn vị
IN $JobPosition char(100), -- Chức danh
IN $DateOfBirth date, -- ngày sinh nhân viên
IN $Gender tinyint, -- giới tính nhân viên
IN $IdentityNumber varchar(255), -- số chứng nhân dân
IN $IdentityDate date, -- ngày cấp chứng nhân dân
IN $IdentityPlace varchar(255), -- nơi cấp chứng nhân dân
IN $Address varchar(255), -- địa chỉ nhân viên
IN $Phone varchar(50), -- số điện thoại cá nhân
IN $Fax varchar(50), -- số điện thoại cá nhân
IN $Email varchar(100), -- email nhân viên
IN $BankNumber varchar(255), -- số tài khoản ngân hàng
IN $BankName varchar(255), -- tên ngân hàng
IN $BankBranch varchar(255), -- chi nhánh ngân hàng
IN $CreatedBy varchar(100), -- người tạo nhân viên
IN $CreatedDate datetime, -- ngày tạo nhân viên
IN $ModifiedBy varchar(100), -- người sửa nhân viên gần nhất
IN $ModifiedDate datetime -- ngày sửa nhân viên gần nhấn
)
BEGIN
-- Auth: TTTuan
-- Created date: 22/12/2022
-- Desc: Sửa 1 nhân viên theo ID
-- Modified by: TTTu(22/12/2022)
-- Running test: CALL Proc_Employee_UpdateByID('1343d389-1cc2-4ab7-88f6-423b4e874d0f', 'NV-1046', 'Tuấn', '469b3ece-744a-45d5-957d-e8c757976496', 'Designer', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,  NULL, NULL, 'Tuan', NOW())

  IF $DepartmentID IS NULL THEN
    SET $DepartmentID = '';
  END IF;

  UPDATE employee e
  SET 
    e.EmployeeCode = $EmployeeCode,
    e.EmployeeName = $EmployeeName,
    e.DepartmentID = $DepartmentID,
    e.JobPosition = $JobPosition,
    e.DateOfBirth = $DateOfBirth,
    e.Gender = $Gender,
    e.IdentityNumber = $IdentityNumber,
    e.IdentityDate = $IdentityDate,
    e.IdentityPlace = $IdentityPlace,
    e.Address = $Address,
    e.Phone = $Phone,
    e.Fax = $Fax,
    e.Email = $Email,
    e.BankNumber = $BankNumber,
    e.BankName = $BankName,
    e.BankBranch = $BankBranch,
    e.ModifiedBy = $ModifiedBy,
    e.ModifiedDate = $ModifiedDate
  WHERE e.EmployeeID = $EmployeeID;
END
