﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class QL_Duoc1Entities : DbContext
    {
        public QL_Duoc1Entities()
            : base("name=QL_Duoc1Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<CongTy> CongTy { get; set; }
        public virtual DbSet<ChamCong> ChamCong { get; set; }
        public virtual DbSet<ChiTietChuyenKhoThuoc> ChiTietChuyenKhoThuoc { get; set; }
        public virtual DbSet<ChiTietHoaDonMua> ChiTietHoaDonMua { get; set; }
        public virtual DbSet<ChiTietHoaDonNhap> ChiTietHoaDonNhap { get; set; }
        public virtual DbSet<ChiTietHoaDonXuat> ChiTietHoaDonXuat { get; set; }
        public virtual DbSet<DauThuoc> DauThuoc { get; set; }
        public virtual DbSet<DonVi> DonVi { get; set; }
        public virtual DbSet<HoaDonMua> HoaDonMua { get; set; }
        public virtual DbSet<HoaDonNhap> HoaDonNhap { get; set; }
        public virtual DbSet<HoaDonVanChuyen> HoaDonVanChuyen { get; set; }
        public virtual DbSet<HoaDonXuat> HoaDonXuat { get; set; }
        public virtual DbSet<KeHoachLamViec> KeHoachLamViec { get; set; }
        public virtual DbSet<KhachHang> KhachHang { get; set; }
        public virtual DbSet<Kho> Kho { get; set; }
        public virtual DbSet<KhoDauThuoc> KhoDauThuoc { get; set; }
        public virtual DbSet<KhoNhanVien> KhoNhanVien { get; set; }
        public virtual DbSet<KhuyenMai> KhuyenMai { get; set; }
        public virtual DbSet<KhuyenMaiDauThuoc> KhuyenMaiDauThuoc { get; set; }
        public virtual DbSet<NhaSanXuat> NhaSanXuat { get; set; }
        public virtual DbSet<NhomDauThuoc> NhomDauThuoc { get; set; }
        public virtual DbSet<NhomQuyen> NhomQuyen { get; set; }
        public virtual DbSet<NhomQuyenRoute> NhomQuyenRoute { get; set; }
        public virtual DbSet<Page> Page { get; set; }
        public virtual DbSet<Position> Position { get; set; }
        public virtual DbSet<PositionNow> PositionNow { get; set; }
        public virtual DbSet<QuanHuyen> QuanHuyen { get; set; }
        public virtual DbSet<Route> Route { get; set; }
        public virtual DbSet<TagsDThuocNThuoc> TagsDThuocNThuoc { get; set; }
        public virtual DbSet<TaiKhoan> TaiKhoan { get; set; }
        public virtual DbSet<TinhThanhPho> TinhThanhPho { get; set; }
        public virtual DbSet<TuVan> TuVan { get; set; }
        public virtual DbSet<ThuChi> ThuChi { get; set; }
        public virtual DbSet<TrinhDuoc> TrinhDuoc { get; set; }
        public virtual DbSet<TrinhDuocKhachHang> TrinhDuocKhachHang { get; set; }
        public virtual DbSet<VanChuyen> VanChuyen { get; set; }
    }
}
