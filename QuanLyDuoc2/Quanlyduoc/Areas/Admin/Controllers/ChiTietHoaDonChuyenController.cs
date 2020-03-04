using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;
namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class ChiTietHoaDonChuyenController : Controller
    {
        // GET: Admin/ChiTietHoaDonChuyen
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        public ActionResult Index(string maKho)
        {
            var JKho= db.ChiTietChuyenKhoThuoc.Where(m => m.MaKhoNhan == maKho)
                .Select(m=>new {
                    m.MaDT,
                    m.MaKhoChuyen,
                    m.MaKhoNhan,

                    TenThuoc=db.DauThuoc.Where(n=>n.MaDT== m.MaDT).FirstOrDefault().TenDauThuoc,
                    KhoChuyen=db.Kho.Where(n=>n.MaKho==m.MaKhoChuyen).FirstOrDefault().TenKho,
                    KhoNhan=db.Kho.Where(n=>n.MaKho==m.MaKhoNhan).FirstOrDefault().TenKho,

                    m.Soluong,
                    ngayChuyen= m.NgayChuyen + " ",
                    m.ID
                }).ToList();
            return View(Json(new {Kho=JKho },JsonRequestBehavior.AllowGet));
        }
        public JsonResult XacNhan(HoaDonNhap hoaDonNhap, string maKhoNhan, string maDT,int soLuong,int ID) {
            ChiTietHoaDonNhap chiTietHoaDonNhap = new ChiTietHoaDonNhap();
            string maHD = "HD" + SinhMa.getMa("MaHD", "HoaDonNhap");
            //var maNSX =from sx in db.NhaSanXuat
            //            join dt in db.DauThuoc on sx.MaNSX equals dt.MaNSX
            //            where (dt.MaDT == maDT) select sx.MaNSX ;

            var maNSX = db.NhaSanXuat.Where(m => m.MaNSX == (db.DauThuoc.Where(n => n.MaDT == maDT).FirstOrDefault().MaNSX)).FirstOrDefault().MaNSX;
            string maTk = SessionHelper.GetMa();
            //var donGia = db.DauThuoc.Where(m => m.MaDT == maDT).FirstOrDefault().GiaMoi;
                      
            hoaDonNhap.MaHD  = maHD;
            hoaDonNhap.NgayNhap = DateTime.Now;
            hoaDonNhap.MaKho = maKhoNhan;
            hoaDonNhap.MaNSX = maNSX.ToString();
            hoaDonNhap.MaTK  = maTk;
            hoaDonNhap.GhiChu = "";
            db.HoaDonNhap.Add(hoaDonNhap);
            db.SaveChanges();
            if (maHD != null)
            {
                chiTietHoaDonNhap.MaHD = maHD;
                chiTietHoaDonNhap.MaDT = maDT;
                chiTietHoaDonNhap.SoLuong = soLuong;
                //chiTietHoaDonNhap.DonGia = soLuong * Convert.ToInt32(donGia);
                db.ChiTietHoaDonNhap.Add(chiTietHoaDonNhap);
                db.SaveChanges();
            }

            //ChiTietChuyenKhoThuoc ct = new ChiTietChuyenKhoThuoc();
            db.ChiTietChuyenKhoThuoc.Remove(db.ChiTietChuyenKhoThuoc.Find(ID));
            db.SaveChanges();
            return Json(new { success="success",msg=" Thanh Cong "}, JsonRequestBehavior.AllowGet);
        }

    }
}