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
    
    public partial class DauThuoc
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DauThuoc()
        {
            this.ChiTietChuyenKhoThuoc = new HashSet<ChiTietChuyenKhoThuoc>();
            this.ChiTietHoaDonMua = new HashSet<ChiTietHoaDonMua>();
            this.ChiTietHoaDonNhap = new HashSet<ChiTietHoaDonNhap>();
            this.ChiTietHoaDonXuat = new HashSet<ChiTietHoaDonXuat>();
            this.DonVi = new HashSet<DonVi>();
            this.KhoDauThuoc = new HashSet<KhoDauThuoc>();
            this.KhuyenMaiDauThuoc = new HashSet<KhuyenMaiDauThuoc>();
            this.TagsDThuocNThuoc = new HashSet<TagsDThuocNThuoc>();
        }
    
        public string MaDT { get; set; }
        public string TenDauThuoc { get; set; }
        public string CongDung { get; set; }
        public string CachDung { get; set; }
        public string Image { get; set; }
        public string Status { get; set; }
        public Nullable<int> GiaBanLe { get; set; }
        public string MaNSX { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietChuyenKhoThuoc> ChiTietChuyenKhoThuoc { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietHoaDonMua> ChiTietHoaDonMua { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietHoaDonNhap> ChiTietHoaDonNhap { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietHoaDonXuat> ChiTietHoaDonXuat { get; set; }
        public virtual NhaSanXuat NhaSanXuat { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DonVi> DonVi { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<KhoDauThuoc> KhoDauThuoc { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<KhuyenMaiDauThuoc> KhuyenMaiDauThuoc { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TagsDThuocNThuoc> TagsDThuocNThuoc { get; set; }
    }
}
