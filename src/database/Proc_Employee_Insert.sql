CREATE DEFINER = 'root'@'localhost'
PROCEDURE misaamis_development.Proc_Employee_Insert(IN $EmployeeID char(36),-- ID nhân viên
IN $EmployeeCode varchar(20), -- mã nhân viên
IN $EmployeeName varchar(100), -- tên nhân viên
IN $DepartmentID char(36), -- ID đơn vị
IN $JobPosition char(100), -- Chức danh
IN $DateOfBirth date, -- ngày sinh nhân viên
IN $Gender tinyint, -- giới tính nhân viên
IN $IdentityNumber varchar(255), -- số chứng minh nhân dân
IN $IdentityDate date, -- ngày cấp chứng minh nhân dân
IN $IdentityPlace varchar(255), -- nơi cấp chứng minh nhân dân
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
-- Desc: Thêm 1 nhân viên
-- Modified by: TTTuan (22/12/2022)
-- Running test: CALL Proc_Employee_INSERT('1343d389-1cc2-4ab7-88f6-423b4e874d0f', 'NV-22222', 'Tuấn', '469b3ece-744a-45d5-957d-e8c757976496', 'Designer', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Tuan', NOW(), NULL, NULL)

    INSERT INTO employee (EmployeeID, EmployeeCode, DepartmentID, EmployeeName, DateOfBirth, Gender, IdentityNumber, IdentityDate, IdentityPlace, Address, Phone, Fax, Email, BankNumber, BankName, BankBranch, CreatedBy, CreatedDate)
    VALUES ($EmployeeID, $EmployeeCode, $DepartmentID, $EmployeeName, $DateOfBirth, $Gender, $IdentityNumber, $IdentityDate, $IdentityPlace, $Address, $Phone, $Fax, $Email, $BankNumber, $BankName, $BankBranch, $CreatedBy, $CreatedDate);
END