$(document).ready(function () {
    $.validator.addMethod("check", function (value, element, regex) {
        //return this.optional(element) || regex.test(value);
        //or
        return regex.test(value);
    }
    );
    $(".formNhap").validate({
        event: "submit",
        rules: {
            HoTen: {
                required: true,
            },
            DiaChi: {
                required: true,
            },
            SDT: {
                required: true
            }
        },
        messages: {
            HoTen: {
                required: ' Xin mời nhập họ tên! ',
            },
            DiaChi: {
                required: ' Xin mời nhập địa chỉ! ',
            },
            SDT: {
                required: ' Xin mời nhập số điện thoại! '
            }
        }
    });
});