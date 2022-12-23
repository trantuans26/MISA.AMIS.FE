CREATE DEFINER = 'root'@'localhost'
PROCEDURE misaamis_development.Proc_Employee_DeleteByIDs(IN $EmployeeIDs varchar(2000))
BEGIN
-- Auth: TTTuan
-- Created date: 22/12/2022
-- Desc: Xoá nhiều nhân viên theo danh sách ID
-- Modified by: TTTuan (22/12/2022)
-- Running test: CALL Proc_Employee_DeleteByIDs('1343d389-1cc2-4ab7-88f6-423b4e874d0f,1343d389-1cc2-4ab7-88f6-423b4e874d0f,1343d389-1cc2-4ab7-88f6-423b4e874d0f')

  DECLARE $Result varchar(2000);
  SET $Result = REPLACE($EmployeeIDs, '"', '');
  
  DELETE
  FROM Employee e 
  WHERE FIND_IN_SET(e.EmployeeID, $Result);
END