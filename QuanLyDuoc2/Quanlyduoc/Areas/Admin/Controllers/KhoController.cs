using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Models;
using Quanlyduoc.Code;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class KhoController : ExtendsController
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/Kho
        public ActionResult Index()
        {
            var JKho = db.Kho
                        .Select(kho => new
                        {
                            kho.MaKho,
                            kho.TenKho,
                            kho.DiaChi,
                            kho.SDT
                        }).ToList();
            return View(Json(new { JKho = JKho }, JsonRequestBehavior.AllowGet));
        }

        [HttpPost]
        public JsonResult layThongTinKho(string maKho)
        {
            if (SessionHelper.GetRoles() == "1")
            {
            }
            else
            {

                string maTK = SessionHelper.GetMa();
                var count = db.KhoNhanVien.Where(ko => ko.MaKho == maKho && ko.MaTK == maTK).FirstOrDefault();
                if (count == null)
                {
                    return Json(new { msg = "Bạn không được xem kho này", success = "error" }, JsonRequestBehavior.AllowGet);
                }
            }
            var JtonKho1 = db.KhoDauThuoc.Where(khdt => khdt.MaKho == maKho).AsEnumerable()
                                .Join(db.DauThuoc.AsEnumerable(),
                                dt => dt.MaDT, khdt => khdt.MaDT,
                                (khdt, dt) => new
                                {
                                    MaDT = dt.MaDT,
                                    TenDauThuoc = dt.TenDauThuoc,
                                    NhomDauThuoc = db.NhomDauThuoc.AsEnumerable()
                                                    .Join(db.TagsDThuocNThuoc.Where(tag=>tag.MaDauThuoc == dt.MaDT).AsEnumerable(), nh => nh.MaNhomThuoc, tag=>tag.MaNhomThuoc,
                                                    (nh, tag) => new {
                                                        nh.TenNhom,
                                                    }).ToList(),
                                    MaDonVi = db.DonVi.Where(d => d.MaDT == dt.MaDT).OrderByDescending(d => d.ID).FirstOrDefault().ID,
                                    TenDonVi = db.DonVi.Where(d => d.MaDT == dt.MaDT).OrderByDescending(d => d.ID).FirstOrDefault().Ten,
                                    JDonVi = db.DonVi.Where(dv => dv.MaDT == dt.MaDT).OrderBy(d => d.ID)
                                                        .Select(dv => new
                                                        {
                                                            dv.ID,
                                                            dv.IDParent,
                                                            dv.Ten,
                                                            dv.Heso,
                                                            dv.MaDT,
                                                            dv.TenDinhNghia
                                                        }).ToList(),
                                    SoLuongCon = convertSoLuongCon(dt.MaDT, khdt.MaDonVi, db.DonVi.Where(d => d.MaDT == dt.MaDT).OrderByDescending(d => d.ID).FirstOrDefault().ID, khdt.SoLuongCon)
                                }).ToList();

                var JtonKho = JtonKho1.GroupBy(tk => tk.MaDT)
                              .Select(g => new
                              {
                                  MaDT = g.First().MaDT,
                                  TenDauThuoc = g.First().TenDauThuoc,
                                  NhomDauThuoc = g.First().NhomDauThuoc,
                                  MaDonVi = g.First().MaDonVi,
                                  TenDonVi = g.First().TenDonVi,
                                  JDonVi = g.First().JDonVi,
                                  SoLuongCon = g.Sum(l => l.SoLuongCon)
                              }).ToList();

                var JhoaDonMua = db.HoaDonMua.Where(hdm => hdm.MaKho == maKho && hdm.TrangThai == 2)
                                 .ToList()
                                 .Select(hd => new
                                 {
                                     hd.MaHD,
                                     hd.MaKH,
                                     TenKH = db.KhachHang.Where(kh => kh.MaKH == hd.MaKH).FirstOrDefault().HoTen,
                                     hd.MaKho,
                                     TenKho = db.Kho.Where(ko => ko.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                                     TrangThai = hd.TrangThai == 1 ? "Chưa duyệt" : (hd.TrangThai == 2 ? "Chưa xuất" : (hd.TrangThai == 3 ? "Đã xuất" : "Hoàn thành")),
                                     MaHoaDonVanChuyen = hd.MaHoaDonVanChuyen == null ? "" : hd.MaHoaDonVanChuyen,
                                     NguoiVanChuyen = hd.MaHoaDonVanChuyen == null ? "" :
                                                     db.VanChuyen.Where(vc => vc.MaNguoiVanChuyen == (
                                                                             db.HoaDonVanChuyen
                                                                             .Where(hdvc => hdvc.MaHoaDonVanChuyen == hd.MaHoaDonVanChuyen)
                                                                             .FirstOrDefault()
                                                                             .MaNguoiVanChuyen)
                                                                         ).FirstOrDefault().HoTen,

                                 }).ToList();
                var Jxuat = db.HoaDonXuat.Where(hdx => hdx.MaKho == maKho)
                                  .ToList()
                                  .Select(hd => new
                                  {
                                      hd.MaHD,
                                      hd.MaKho,
                                      TenKho = db.Kho.Where(kh => kh.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                                      hd.MaTK,
                                      NguoiXuat = db.TaiKhoan.Where(tk => tk.MaTK == hd.MaTK).FirstOrDefault().HoTen,
                                      hd.MaKH,
                                      KhachHang = db.KhachHang.Where(kh => kh.MaKH == hd.MaKH).FirstOrDefault().HoTen,
                                      NgayXuat = hd.NgayXuat.Value.ToString("dd/MM/yyyy"),
                                      hd.TrangThai,
                                      hd.MaHoaDonMua,
                                      MaHoaDonVanChuyen = hd.MaHoaDonVanChuyen == null ? "" : hd.MaHoaDonVanChuyen,
                                      NguoiVanChuyen = hd.MaHoaDonVanChuyen == null ? "" :
                                                     db.VanChuyen.Where(vc => vc.MaNguoiVanChuyen == (
                                                                             db.HoaDonVanChuyen
                                                                             .Where(hdvc => hdvc.MaHoaDonVanChuyen == hd.MaHoaDonVanChuyen)
                                                                             .FirstOrDefault()
                                                                             .MaNguoiVanChuyen)
                                                                         ).FirstOrDefault().HoTen,
                                  }).ToList();

            var Jnhap = db.HoaDonNhap.Where(hdn => hdn.MaKho == maKho)
                        .ToList()
                        .Select(hd => new
                        {
                            hd.MaHD,
                            hd.MaKho,
                            TenKho = db.Kho.Where(kh => kh.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                            hd.MaTK,
                            NguoiNhap = db.TaiKhoan.Where(tk => tk.MaTK == hd.MaTK).FirstOrDefault().HoTen,
                            hd.MaNSX,
                            NhaSanXuat = db.NhaSanXuat.Where(nsx => nsx.MaNSX == hd.MaNSX).FirstOrDefault().TenNSX,
                            NgayXuat = hd.NgayNhap.Value.ToString("dd/MM/yyyy"),
                            hd.GhiChu
                        }).ToList();

            var Jquankho = db.KhoNhanVien.Where(knv => knv.MaKho == maKho).AsEnumerable()
                            .Join(db.TaiKhoan.AsEnumerable(), knv => knv.MaTK, tk => tk.MaTK,
                            (knv, tk) => new
                            {
                                tk.MaTK,
                                tk.HoTen,
                                tk.SDT,
                                tk.Email,
                                knv.ChucVu

                            }).ToList();
                return Json(new { JtonKho = JtonKho, JhoaDonMua = JhoaDonMua, Jxuat = Jxuat, Jnhap = Jnhap, Jquankho = Jquankho, success = "success" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult themKho(Kho Kho)
        {
            var kho = new Kho();
            string maKho = "KO" + SinhMa.getMa("MaKho", "Kho");
            kho.MaKho = maKho;
            kho.TenKho = Kho.TenKho;
            kho.DiaChi = Kho.DiaChi;
            kho.SDT = Kho.DiaChi;
            db.Kho.Add(kho);
            if (db.SaveChanges() == 1)
            {
                return Json(new { msg = "Thêm thành công kho", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
            }


        }

        [HttpPost]
        public JsonResult suakho(Kho kho)
        {
            var kho1 = db.Kho.Where(k => k.MaKho == kho.MaKho).FirstOrDefault();
            db.Entry(kho1).CurrentValues.SetValues(kho);
            if (db.SaveChanges() == 1)
            {
                return Json(new { msg = "Sửa thành công kho", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
            }


        }
    }
}