using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Quanlyduoc.Models
{
    public class HoaDonVanChuyenAjax
    {
        public string maHoaDon { get; set; }
        public hoaDonVanChuyen hoaDonVanChuyen { get; set; }
    }
    public class hoaDonVanChuyen
    {
        public string maNguoiVanChuyen { get; set; }
        public string ngayGioVanChuyen { get; set; }
        public string soGio { get; set; }
    }
}