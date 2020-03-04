$(document).ready(function () {
    $("#formThemHoaDonMua").validate({
        event: "submit",
        rules: {
            chonKhachHang: {
                required: true,
            },
            ngayMua: {
                required: true,
            },
            MaNhomThuoc: {
                required: true,
            },
            chonDauThuoc: {
                required: true,
            },
            chonSoLuong: {
                required: true,
                digits: true,
            }
        },
        messages: {
            chonKhachHang: {
                required: ' Xin mời chọn khách hàng! ',
            },
            ngayMua: {
                required: ' Nhập vào ngày mua! ',
            },
            MaNhomThuoc: {
                required: ' Xin mời chọn nhóm thuốc! ',
            },
            chonDauThuoc: {
                required: ' Xin mời chọn đầu thuốc! ',
            },
            chonSoLuong: {
                required: ' Xin mời nhập số lượng thuốc!',
                digits: 'Số lượng thuốc không hợp lệ!'
            }
        }
    });
});