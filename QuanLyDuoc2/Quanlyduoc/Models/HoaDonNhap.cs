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
    
    public partial class HoaDonNhap
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public HoaDonNhap()
        {
            this.ChiTietHoaDonNhap = new HashSet<ChiTietHoaDonNhap>();
        }
    
        public string MaHD { get; set; }
        public string MaKho { get; set; }
        public string MaTK { get; set; }
        public string MaNSX { get; set; }
        public Nullable<System.DateTime> NgayNhap { get; set; }
        public string GhiChu { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietHoaDonNhap> ChiTietHoaDonNhap { get; set; }
        public virtual Kho Kho { get; set; }
        public virtual NhaSanXuat NhaSanXuat { get; set; }
        public virtual TaiKhoan TaiKhoan { get; set; }
    }
}
