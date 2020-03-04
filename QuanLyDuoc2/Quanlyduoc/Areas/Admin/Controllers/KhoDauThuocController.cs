using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class KhoDauThuocController : Controller
    {
        // GET: Admin/KhoDauThuoc
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        public ActionResult Index()
        {
            var JKhoThuoc = db.KhoDauThuoc.Select(n => new
            {
                maKho = n.MaKho,
                tenKho=db.Kho.Where(m=>m.MaKho==n.MaKho).FirstOrDefault().TenKho,
                tenThuoc=db.DauThuoc.Where(m=>m.MaDT==n.MaDT).FirstOrDefault().TenDauThuoc,
                n.SoLuongCon,
            }).ToList();
            return View(Json(new {JKhoThuoc},JsonRequestBehavior.AllowGet));
        }
        [HttpPost]
        public JsonResult ChuyenKho(ChiTietChuyenKhoThuoc chiTietChuyenKhoThuoc, KhoDauThuoc khoDauThuoc, string khodi,string tenthuoc,int soluongdi,string khoden, int soluongden)
        {
            var maKho = db.Kho.Where(m => m.TenKho == khodi).FirstOrDefault().MaKho;
            var maDT = db.DauThuoc.Where(m => m.TenDauThuoc == tenthuoc).FirstOrDefault().MaDT;
            KhoDauThuoc kho = db.KhoDauThuoc.Where( m=> m.MaDT == maDT && m.MaKho == maKho).FirstOrDefault();
            KhoDauThuoc khodii  = db.KhoDauThuoc.Where(m => m.MaKho == maKho  && m.MaDT == maDT && m.SoLuongCon==soluongdi).FirstOrDefault();
            KhoDauThuoc khodenn = db.KhoDauThuoc.Where(m => m.MaKho == khoden && m.MaDT == maDT ).FirstOrDefault();
            KhoDauThuoc khod = db.KhoDauThuoc.Where(m => m.MaKho == khoden && m.MaDT == maDT).FirstOrDefault();
            if(khodii != null) {
                khodii.SoLuongCon = soluongdi-soluongden;
                db.Entry(kho).CurrentValues.SetValues(khodii);
                db.SaveChanges();
                if (khodenn != null)
                {
                    khodenn.SoLuongCon = khodenn.SoLuongCon + soluongden;
                    db.Entry(khod).CurrentValues.SetValues(khodenn);
                    db.SaveChanges();
                }
                else
                {
                    khoDauThuoc.MaKho = khoden;
                    khoDauThuoc.MaDT = maDT;
                    khoDauThuoc.SoLuongCon = soluongden;
                    db.KhoDauThuoc.Add(khoDauThuoc);
                    db.SaveChanges();
                }

                chiTietChuyenKhoThuoc.MaDT = maDT;
                chiTietChuyenKhoThuoc.MaKhoChuyen = maKho;
                chiTietChuyenKhoThuoc.MaKhoNhan = khoden;
                chiTietChuyenKhoThuoc.Soluong = soluongden;
                chiTietChuyenKhoThuoc.NgayChuyen = DateTime.Now;
                db.ChiTietChuyenKhoThuoc.Add(chiTietChuyenKhoThuoc);
                db.SaveChanges();
                return Json(new { msg="chuyen thanh cong",success= "success" }, JsonRequestBehavior.AllowGet);
            }
            return Json(new {msg="chuyen that bai",success= "success" },JsonRequestBehavior.AllowGet);
        }

    }
}