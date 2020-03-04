$(document).ready(function () {
    $("#formAddDauThuoc").validate({
        event: "submit",
        rules: {
            TenDauThuoc: {
                required: true,
                minlength: 2,
            },
            CongDung: {
                required: true,
                minlength: 5,
            },
            CachDung: {
                required: true,
                minlength: 5,
            },
            GiaBanLe: {
                required: true,
                digits: true
            },
            TenDonVi: {
                required: true,
                minlength: 2,
            },
            tagsNhom: {
                required: true,
            }
        },
        messages: {
            TenDauThuoc: {
                required: ' Nhập tên đầu thuốc! ',
                minlength: 'Dữ liệu nhập vào quá ngắn!'
            },
            CongDung: {
                required: ' Nhập công dụng đầu thuốc! ',
                minlength: 'Dữ liệu nhập vào quá ngắn!',
            },
            CachDung: {
                required: ' Nhập cách dùng đầu thuốc! ',
                minlength: 'Dữ liệu nhập vào quá ngắn!',
            },
            GiaBanLe: {
                required: ' Nhập giá bán lẻ của đầu thuốc! ',
                digits: 'Dữ liệu phải là số nguyên dương!'
            },
            TenDonVi: {
                required: "Nhập tên đơn vị 1",
                minlength: "Tên đơn vị quá ngắn"
            },
            tagsNhom: {
                required: "Tag nhóm không được để trống",
            }
        }
    });
    function checkDonVi() {
        var a = $("#TenDonVi").val();
        var b = $("#TenDonVi1").val();
        var b1 = $("#HeSoDonVi1").val();
        var c = $("#TenDonVi32").val();
        var c1 = $("#HeSoDonVi2").val();

        //kiểm tra đơn vị 1
        if (a == "") {
            $("#TenDonVi1").addClass("disabled");
            $("#HeSoDonVi1").addClass("disabled");
        }
        else {
            $("#TenDonVi1").removeClass("disabled");
            $("#HeSoDonVi1").removeClass("disabled");
        }

        //kiểm tra đơn vị 2
        if (a == "" || b == "" || b1 == "") {
            $("#TenDonVi2").addClass("disabled");
            $("#HeSoDonVi2").addClass("disabled");
        }
        else {
            $("#TenDonVi2").removeClass("disabled");
            $("#HeSoDonVi2").removeClass("disabled");
        }

        //kiểm tra đơn vị 3
        if (a == "" || b == "" || b1 == "" || c == "" || c1 == "") {
            $("#TenDonVi3").addClass("disabled");
            $("#HeSoDonVi3").addClass("disabled");
        }
        else {
            $("#TenDonVi3").removeClass("disabled");
            $("#HeSoDonVi3").removeClass("disabled");
        }
    };
    $("#donviluukho").mousemove(function () {
        checkDonVi();
    });
    $("#donviluukho").keyup(function (){
        checkDonVi();
    });
    
});