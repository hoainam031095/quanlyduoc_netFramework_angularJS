//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Quanlyduoc.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ChiTietHoaDonXuat
    {
        public string MaHD { get; set; }
        public string MaDT { get; set; }
        public long MaDonVi { get; set; }
        public Nullable<int> SoLuong { get; set; }
        public Nullable<int> DonGia { get; set; }
    
        public virtual DauThuoc DauThuoc { get; set; }
        public virtual DonVi DonVi { get; set; }
        public virtual HoaDonXuat HoaDonXuat { get; set; }
    }
}