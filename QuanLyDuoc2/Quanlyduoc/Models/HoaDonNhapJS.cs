using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Quanlyduoc.Models
{
    public class HoaDonNhapJS
    {
        public string MaHD { get; set; }
        public string MaKho { get; set; }
        public string MaTK { get; set; }
        public string MaNSX { get; set; }
        public Nullable<System.DateTime> NgayNhap { get; set; }
        public string GhiChu { get; set; }
        public List<danhsachnhap> danhsachnhaps { get; set; }

    }

    public class danhsachnhap
    {
        public string MaDT { get; set; }
        public long MaDonVi { get; set; }
        public string TenDonVi { get; set; }
        public Nullable<int> SoLuong { get; set; }
        public Nullable<int> DonGia { get; set; }
    }
}