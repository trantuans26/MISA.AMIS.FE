/* Hàm dùng toàn chương trình
    Author: Tuan
    Date: 10/12/2022
 */
export default {
    Author: "Trần Thái Tuấn",

    Url:{
        Employees: "https://localhost:44368/api/v1/Employees",
        Departments: "https://localhost:44368/api/v1/Departments",
    },

    TextVi:{
        Header: {
            CompanyName: "Công ty TNHH Sản xuất - Thương mại - Dịch vụ Qui Phúc",
            EmployeeName: "Trần Thái Tuấn",
        },

        Content: {
            Title: "Nhân viên",
            Add: "Thêm mới nhân viên",
        },

        Table: {
            Search: "Tìm kiếm theo mã, tên và ĐT di động",
            Batch: "Thực hiện hàng loạt",
            
            /* Tên cột */
            EmployeeCode: "Mã nhân viên",
            EmployeeName: "Tên nhân viên",
            Gender: "Giới tính",
            Birthday: "Ngày sinh",
            Identity: "Số CMND",
            Role: "Chức danh",
            OrganizationName: "Tên đơn vị",
            BankNumber: "Số tài khoản",
            BankName: "Tên ngân hàng",
            BankBranch: "Chi nhánh TK ngân hàng",
            Function: "Chức năng",

            /* Tên chức năng */
            Update: "Sửa",
            Replicate: "Nhân bản",
            Delete: "Xoá",
            Stop: "Ngừng sử dụng",
            RecordPerPage: " bản ghi trên 1 trang",
            Next: "Trước",
            Previous: "Sau",
            Total: "Tổng số",
            Record: "bản ghi",
        },

        Modal:{
            InsertModal: "Thêm mới nhân viên",
            UpdateModal: "Thông tin nhân viên",

            Customer: "Là khách hàng",
            Supplier: "Là nhà cung cấp",

            EmployeeCode: "Mã",
            EmployeeName: "Tên",
            DateOfBirth: "Ngày sinh",
            Gender: "Giới tính",
            DepartmentName: "Đơn vị",
            IdentityNumber: "Số CMND",
            IdentityDate: "Ngày cấp",
            JobPosition: "Chức danh",
            IdentityPlace: "Nơi cấp",
            Address: "Địa chỉ",
            Phone: "ĐT di động",
            Fax: "ĐT cố định",
            Email: "Email",
            BankNumber: "Tài khoản ngân hàng",
            BankName: "Tên ngân hàng",
            BankBranch: "Chi nhánh",

            Placeholder: {
                Department: "Chọn đơn vị",
                Address: "VD: Số 82 Duy Tân, Dịch Vọng, Cầu Giấy, Hà Nội",
            },

            /* Tên chức năng */
            Cancel: "Huỷ",
            Close: "Đóng",
            Save: "Cất",
            SaveAndInsert: "Cất và Thêm",
            Update: "Sửa",
            Accept: "Đồng ý",
            Yes: "Có",
            No: "Không",
        },

        Dialog: {
            Save: "Cất",
            NotSave: "Không cất",
            No: "Không",
            Yes: "Có",
            Close: "Đóng",
            Cancel: "Huỷ bỏ",
            Delete: "Xoá",
            Accept: "Đồng ý",
            Title: {
                Delete: "Xoá nhân viên",
                Change: "Dữ liệu đã bị thay đổi.",    
                Error: "Thông báo",         
            },
            Text: {
                Save: "Bạn có muốn cất không?",
                Employee: "Bạn có thực sự muốn xoá Nhân viên",
                After: "không?",
                DeleteBatch: "Bạn có thực sự muốn xoá những nhân viên đã chọn không?",
            }
        },

        ErrorMessage: {
            EmployeeCode: "Mã nhân viên",
            DuplicateCode: "đã tồn tại trong hệ thống, vui lòng kiểm tra lại",
            EmptyCode: "Mã nhân viên không được để trống",
            EmptyName: "Tên nhân viên không được để trống",
            EmptyDepartmentName: "Tên đơn vị không được để trống",
            InvalidEmail: "Email không đúng định dạng",
            InternalServerError: "Có lỗi xảy ra, vui lòng liên hệ MISA để được hỗ trợ",
            InvalidDateOfBirth: "Ngày sinh không hợp lệ",
            InvalidIdentityDate: "Ngày cấp không hợp lệ",
            InvalidIdentityNumber: "Số CMND không hợp lệ",
        },

        ToastMessage: {
            Success: {
                Title: "Thành công!",
                Delete: "Nhân viên đã bị xoá.",
                Insert: "Nhân viên đã được thêm.",
                Update: "Nhân viên đã được thay đổi."
            }
        },

        Dropdown: {
            DepartmentCode: "Mã đơn vị",
            DepartmentName: "Tên đơn vị",
            NoChoice: "Chọn đơn vị"
        },

        Tooltip: {
            IdentityNumber: "Số Chứng Minh Nhân Dân",
            Phone: "Điện thoại di động",
            Fax: "Điện thoại cố định",
            BankBranch: "Chi nhánh tài khoản ngân hàng",
            Reload: "Tải lại dữ liệu",
            ExportExcel: "Xuất tệp Excel",
            SaveAndInsert: "Cất và thêm(Ctrl + Shift + S)",
            Save: "Cất(Ctrl + S)",
            Close: "Đóng(ESC)",
            Help: "Giúp(F1)",
        },

        KeyboardShortcuts: {
            SaveAndInsert: "Ctrl + Shift + S",
            Save: "Ctrl + S",
        },

        Gender: {
            Male: "Nam",
            Female: "Nữ",
            Other: "Khác",
        },

        Sidebar: {
            Total: "Tổng quan",
            Money: "Tiền mặt",
            Deposit: "Tiền gửi",
            Shop: "Mua hàng",
            Sale: "Bán hàng",
            Bill: "Quản lý hóa đơn",
            Store: "Quản lý kho",
            Tool: "Công cụ",
            FixedAsset: "Tài sản cố định",
            Tax: "Thuế",
            Cost: "Giá thành",
            General: "Tổng hợp",
            Budget: "Ngân sách",
            Report: "Báo cáo",
            Analyst: "Phân tích tài chính",
          },
    }
}
