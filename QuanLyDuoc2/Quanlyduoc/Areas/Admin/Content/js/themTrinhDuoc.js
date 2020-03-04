$(document).ready(function () {
    $("#formTrinhDuoc").validate({
        event: "submit",
        rules: {
            HoTen: {
                required: true,
                minlength: 2,
            },
            SDT: {
                required: true,
                digits: true
            },
            NgaySinh: {
                required: true,
            },
            DiaChi: {
                required: true
            },
            MaTinhThanh: {
                required: true,
            },
            MaQuanHuyen: {
                required: true,
            }
        },
        messages: {
            HoTen: {
                required: ' Nhập vào họ tên! ',
                minlength: 'Dữ liệu nhập vào quá ngắn!'
            },
            SDT: {
                required: ' Nhập vào số điện thoại! ',
                digits: 'Số điện thoại không hợp lệ!'
            },
            NgaySinh: {
                required: 'Nhập ngày sinh! ',
            },
            DiaChi: {
                required: ' Nhập địa chỉ! ',
            },
            MaTinhThanh: {
                required: ' Chọn tình thành! ',
            },
            MaQuanHuyen: {
                required: ' Chọn quận huyện! ',
            }
        }
    });
});