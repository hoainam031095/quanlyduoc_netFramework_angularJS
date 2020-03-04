using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;
using Quanlyduoc.Areas.Admin.Class;
using ClosedXML.Excel;
using System.IO;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class ThuChiController : Controller
    {

        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/ThuChi
        public ActionResult Index()
        {
            var JthuChi = db.ThuChi.ToList()
                                   .Select(tc => new
                                   {
                                       tc.Ten,
                                       tc.Loai,
                                       NgayLap = tc.NgayLap.Value.ToString("MM/dd/yyyy"),
                                       tc.NguoiLap,
                                       tc.GiaTri
                                   }).ToList();
            return View(Json(new { JthuChi = JthuChi }, JsonRequestBehavior.AllowGet));
        }

        [HttpGet]
        public ActionResult themthuchi()
        {
            ViewBag.NguoiLap = SessionHelper.GetName();
            return View();
        }

        [HttpPost]
        public JsonResult themthuchi(ThuChi thuchi)
        {
            db.ThuChi.Add(thuchi);
            if (db.SaveChanges() == 1)
                return Json(new { msg = "Thêm thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { msg = "Thêm thất bại", success = "error" }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult danhsachthuchi()
        {
            var JthuChi = db.ThuChi.ToList()
                .Select(tc => new
                {
                    tc.ID,
                    tc.Ten,
                    tc.Loai,
                    NgayLap = tc.NgayLap.Value.ToString("MM/dd/yyyy"),
                    tc.NguoiLap,
                    tc.GiaTri
                }).ToList();
            return View(Json (new{ JthuChi = JthuChi },JsonRequestBehavior.AllowGet));
        }

        [HttpPost]
        public JsonResult xoathuchi(int mathuchi)
        {
            var thuchi = db.ThuChi.Where(tc => tc.ID == mathuchi).FirstOrDefault();
            if (thuchi != null)
            {
                db.ThuChi.Remove(thuchi);
                db.SaveChanges();
                return Json(new {msg ="Xóa thành công", success ="success" }, JsonRequestBehavior.AllowGet);
            }else return Json(new { msg = "Xóa không thành công", success = "error" }, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult suathuchi(ThuChi thuchi)
        {
            var thuchi1 = db.ThuChi.Where(tc => tc.ID == thuchi.ID).FirstOrDefault();
            if (thuchi1 != null)
            {
                thuchi1.Ten = thuchi.Ten;
                thuchi1.Loai = thuchi.Loai;
                thuchi1.NgayLap = thuchi.NgayLap;
                thuchi1.NguoiLap = thuchi.NguoiLap;
                thuchi1.GiaTri = thuchi.GiaTri;
                db.SaveChanges();
                return Json(new { msg = "Sửa thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else return Json(new { msg = "Sửa không thành công", success = "error" }, JsonRequestBehavior.AllowGet);

        }

        public void Export(string dateFrom, string dateTo)
        {
            var dateFrom1 = DateTime.Parse(dateFrom.Substring(1, 10));
            var dateTo1 = DateTime.Parse(dateTo.Substring(1, 10));
            //Get list export
            var hoaDonNhapEX = db.ThuChi.Where(hd => hd.NgayLap >= dateFrom1 && hd.NgayLap <= dateTo1)
                                .ToList()
                                .Select(hd => new
                                {
                                    hd.Ten,
                                    hd.Loai,
                                    hd.NgayLap,
                                    hd.NguoiLap,
                                    hd.GiaTri
                                }).ToList();
            if (hoaDonNhapEX.Count() == 0)
            {
                hoaDonNhapEX = db.ThuChi
                                .ToList()
                                .Select(hd => new
                                {
                                    hd.Ten,
                                    hd.Loai,
                                    hd.NgayLap,
                                    hd.NguoiLap,
                                    hd.GiaTri
                                }).ToList();
            }

            ///export///
            var filename = "Danh sách hóa đơn thu chi (" + DateTime.Now.ToString("dd-MM-yyyy hh:mm") + ").xlsx";
            var sheetname = "Customer";
            XLWorkbook workbook = new XLWorkbook();
            var workSheet = workbook.Worksheets.Add(sheetname);
            workSheet.SheetView.Freeze(1, 0);

            //Design header
            var obj = hoaDonNhapEX.FirstOrDefault();
            var comumns = obj.GetType().GetProperties();
            int i = 1;
            comumns.All(m =>
            {
                var name = m.Name
                .Replace("Ten", "Tên hóa đơn")
                .Replace("Loai", "Loại hóa đơn")
                .Replace("NgayLap", "Ngày lập")
                .Replace("NguoiLap", "Người lập")
                .Replace("GiaTri", "GiaTri");

                var h = workSheet.Cell(1, i).SetValue(name);
                h.Style.Font.Bold = true;
                h.Style.Font.FontColor = XLColor.White;
                h.Style.Fill.BackgroundColor = XLColor.Green;

                i++;
                return true;
            });

            //Bind data
            int rowIndex = 2;
            hoaDonNhapEX.All(b =>
            {
                int j = 1;
                comumns.All(m =>
                {
                    var vl = m.GetValue(b);
                    workSheet.Cell(rowIndex, j).SetValue(vl);
                    j++;
                    return true;
                });
                rowIndex++;
                return true;
            });

            //Response
            var httpResponse = Response; //Response;
            httpResponse.Clear();
            httpResponse.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            httpResponse.AddHeader("content-disposition", "attachment;filename=\"" + filename + "\"");
            using (MemoryStream MyMemoryStream = new MemoryStream())
            {
                workbook.SaveAs(MyMemoryStream);
                MyMemoryStream.WriteTo(Response.OutputStream);
                MyMemoryStream.Close();
            }
            httpResponse.End();
        }
    }
}