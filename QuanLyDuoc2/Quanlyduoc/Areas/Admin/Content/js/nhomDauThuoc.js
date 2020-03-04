$(document).ready(function () {
    $("#formNhomDauThuoc").validate({
        event: "submit",
        rules: {
            tenNhomThuoc: {
                required: true,
                minlength: 2,
            },
            status: {
                required: true,
                minlength: 5,
            },
            anhNhomDauThuoc: {
                required: true
            }
        },
        messages: {
            tenNhomThuoc: {
                required: ' Nhập vào tên nhóm thuốc! ',
                minlength: 'Dữ liệu nhập vào quá ngắn!'
            },
            status: {
                required: ' Nhập vào mô tả!',
                minlength: 'Dữ liệu nhập vào quá ngắn!'
            },
            anhNhomDauThuoc: {
                required: 'Mời chọn ảnh!'
            }
        }
    });
});