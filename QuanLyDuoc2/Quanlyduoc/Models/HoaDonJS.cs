using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Quanlyduoc.Models
{
    public class HoaDonJS
    {
        
        public string maHoaDon { get; set; }
        public string maKhachHang { get; set; }
        public DateTime ngayMua { get; set; }
        public List<danhsachchon> danhsachchon { get; set; }
        
    }

    public class danhsachchon
    {
        public string MaDT { get; set; }
        public string MaNhomThuoc { get; set; }
        public string TenDauThuoc { get; set; }
        public Donvi Donvi { get; set; }
        public string soLuong { get; set; }
        public int? donGia { get; set; }
    }

    public class Donvi
    {
        public long ID { get; set; }
        public Nullable<long> IDParent { get; set; }
        public string Ten { get; set; }
        public Nullable<int> Heso { get; set; }
        public string MaDT { get; set; }
        public string TenDinhNghia { get; set; }
    }
}