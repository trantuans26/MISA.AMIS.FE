/**
 * Đĩnh nghĩa enum cho toàn chương trình
 * Author: Tuan
 * Date: 10/12/2022
 */
export default {
    STATUS_CODE: {
        OK: 200, //Trả về thành công cho những phương thức GET, PUT, PATCH hoặc DELETE.
        CREATED: 201, //Trả về khi một Resouce vừa được tạo thành công.
        NOCONTENT: 204, //Trả về khi Resource xoá thành công.
        NOTMODIFIED: 304, //Client có thể sử dụng dữ liệu cache.
        BADREQUEST: 400, //Request không hợp lệ.
        UNAUTHORIZED: 401, //Request cần có auth.
        FORBIDDEN: 403, //Client không có quyền truy cập.
        NOTFOUND: 404, //Server không tìm thấy resource từ URI.
        METHODNOTALLOWED: 405, //Phương thức không cho phép với user hiện tại.
        GONE: 410, //Resource không còn tồn tại, Version cũ đã không còn hỗ trợ.
        UNSUPPORTEDMEDIATYPE: 415, //Không hỗ trợ kiểu Resource này.
        UNPROCESSABLEENTITY: 422, //Dữ liệu không được xác thực.
        TOOMANYREQUEST: 429, //Request bị từ chối do bị giới hạn
        INTERNALSERVERERROR: 500, //Máy chủ bị lỗi.
    },

    ERROR_CODE: {
        DUPLICATE_CODE: 1062, // Trùng mã
    },
 
    KEY_CODE: { // Mã phím
        ENTER: 13, // Mã phím Enter
        TAB: 9, // Mã phím Tab
        ESC: 27, // Mã phím Esc
        SPACE: 32, // Mã phím Space
        DELETE: 46, // Mã phím Delete
        BACKSPACE: 8, // Mã phím Backspace
        ARROW_LEFT: 37, // Mã phím Arrow Left
        ARROW_UP: 38, // Mã phím Arrow Up
        ARROW_RIGHT: 39, // Mã phím Arrow Right
        ARROW_DOWN: 40, // Mã phím Arrow 

        F1: 112, // Mã phím F1
        S: 83, // Mã phím S
        N: 78, // Mã phím N
        E: 69, // Mã phím E
        R: 82, // Mã phím R
        L: 76, // Mã phím L
        A: 65, // Mã phím A
        C: 67, // Mã phím C
        D: 68, // Mã phím D

        ZERO: 48, // Mã phím 0
        ONE: 49, // Mã phím 1
        TWO: 50, // Mã phím 2
        THREE: 51, // Mã phím 3
    },
}
