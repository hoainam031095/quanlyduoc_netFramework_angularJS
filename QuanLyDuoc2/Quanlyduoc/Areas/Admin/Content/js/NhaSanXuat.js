$(document).ready(function (){
    $("#NhaSanXuat").validate({
        event: "submit",
        rules: {
            TenNSX: "required",
            DiaChi: "required",
            SDT: {
                required: true,
                minlength:8,
            },
            Email: {
                required: true,
                email: true
            },
        },
        messages: {
            TenNSX: "Nhap Ten NSX",
            DiaChi: "Nhap Dia Chi",
            SDT: {
                required: "Nhap So Dien Thoai",
                minlength:"SDT co 8 chu so"
            },
            Email: {
                required: "Nhap email",
                email:"VD: bao1@gmail.com",
            },
        },
    });
});