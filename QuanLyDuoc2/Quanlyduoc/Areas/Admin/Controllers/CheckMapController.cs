using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Code;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class CheckMapController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/CheckMap

        public ActionResult Index()
        {
            var JListCty = db.CongTy.ToList()
                            .Select(ct => new
                            {
                                ct.MaCongTy,
                                ct.TenCongTy,
                                ct.ToaDo1,
                                ct.ToaDo2,
                                ct.ToaDo3,
                                ct.ToaDo4
                            });
            return View(Json(new { JListCty = JListCty }, JsonRequestBehavior.AllowGet));
        }

        [CheckSessionUser]
        public ActionResult mapNhanVien()
        {
            var JMapTrinhDuoc = from a in db.TrinhDuoc
                                join b in db.TaiKhoan on a.MaTD equals b.MaTD
                                select (new
                                {
                                    a.HoTen,
                                    a.SDT,
                                    a.DiaChi,
                                    a.MaTD,
                                    b.MaTK,
                                    Lat = db.PositionNow.Where(pos => pos.MaTK == b.MaTK)
                                                .FirstOrDefault().Lat,
                                    Lng = db.PositionNow.Where(pos => pos.MaTK == b.MaTK)
                                                .FirstOrDefault().Lng,
                                    Times = db.PositionNow.Where(pos => pos.MaTK == b.MaTK)
                                                .FirstOrDefault().Time.Value + ""
                                });
            return View(Json(new { JMapTrinhDuoc = JMapTrinhDuoc }, JsonRequestBehavior.AllowGet));
        }

        public JsonResult locMapNhanVien(string maTK, DateTime? ngayLamViec)
        {
            if (maTK == null || maTK == "")
            {
                var list = db.PositionNow.Where(ps => ps.Time.Value.Day == ngayLamViec.Value.Day && ps.Time.Value.Month == ngayLamViec.Value.Month && ps.Time.Value.Year == ngayLamViec.Value.Year).ToList();
                if (list.Count > 0)
                {
                    var JMap = list.Select(pst => new
                    {
                        pst.ID,
                        pst.MaTK,
                        HoTen = db.TaiKhoan.Where(tk => tk.MaTK == pst.MaTK).FirstOrDefault().HoTen,
                        SDT = db.TaiKhoan.Where(tk => tk.MaTK == pst.MaTK).FirstOrDefault().SDT,
                        pst.Lat,
                        pst.Lng,
                        Times = pst.Time.Value + ""
                    });
                    return Json(new { JMap = JMap, success = "success" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = "error", msg = "Không có dữ liệu!" }, JsonRequestBehavior.AllowGet);
                }
            }
            else
            {
                var list = db.Position.Where(ps => ps.MaTK == maTK && ps.Time.Value.Day == ngayLamViec.Value.Day && ps.Time.Value.Month == ngayLamViec.Value.Month && ps.Time.Value.Year == ngayLamViec.Value.Year).ToList();
                if (list.Count > 0)
                {
                    var JMap = list.Select(pst => new
                    {
                        pst.ID,
                        pst.MaTK,
                        HoTen = db.TaiKhoan.Where(tk => tk.MaTK == pst.MaTK).FirstOrDefault().HoTen,
                        SDT = db.TaiKhoan.Where(tk => tk.MaTK == pst.MaTK).FirstOrDefault().SDT,
                        pst.Lat,
                        pst.Lng,
                        Times = pst.Time.Value + ""
                    });
                    return Json(new { JMap = JMap, success = "success" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = "error", msg = "Không có dữ liệu!" }, JsonRequestBehavior.AllowGet);
                }
            }


        }

        [CheckSessionUser]
        public ActionResult chamCong()
        {
            var maTK = SessionHelper.GetMa();
            var maTrinhDuoc = db.TaiKhoan.Where(tk => tk.MaTK == maTK).FirstOrDefault().MaTD;
            if (maTrinhDuoc != null)
            {
                var JNhanVien = db.TrinhDuoc.Where(td => td.MaTD == maTrinhDuoc)
                            .Select(td1 => new
                            {
                                td1.HoTen,
                                td1.NgaySinh,
                                td1.DiaChi,
                                td1.SDT,
                                avatar = db.TaiKhoan.Where(tk => tk.MaTK == maTK).FirstOrDefault().avatar == null ? "avatar.png" : db.TaiKhoan.Where(tk => tk.MaTK == maTK).FirstOrDefault().avatar
            }).FirstOrDefault();
                var JListChamCong = db.ChamCong.Where(c => c.MaTK == maTK).ToList()
                                .Select(c1 => new
                                {
                                    c1.DiaDiem,
                                    ThoiGian = c1.ThoiGian.Value.ToString(),
                                    c1.XepLoai,
                                    c1.GhiChu
                                });
                return View(Json(new { JNhanVien = JNhanVien, JListChamCong = JListChamCong}, JsonRequestBehavior.AllowGet));
            }
            else
            {
                var JNhanVien = db.TaiKhoan.Where(tk => tk.MaTK == maTK)
                                .Select(tk1 => new
                                {
                                    tk1.HoTen,
                                    NgaySinh = "Không có",
                                    DiaChi = "Không có",
                                    tk1.SDT,
                                    avatar = tk1.avatar == null ? "avatar.png" : tk1.avatar
                                }).FirstOrDefault();


                return View(Json(new { JNhanVien = JNhanVien }, JsonRequestBehavior.AllowGet));
            }

        }

        [HttpPost]
        public JsonResult chamCong(string xlat, string xlng)
        {
            var maTK = SessionHelper.GetMa();
            var maTrinhDuoc = db.TaiKhoan.Where(tk => tk.MaTK == maTK).FirstOrDefault().MaTD;
            if (maTrinhDuoc != null)
            {
                var X = double.Parse(xlat, System.Globalization.CultureInfo.InvariantCulture);
                var Y = double.Parse(xlng, System.Globalization.CultureInfo.InvariantCulture);

                //Edit code chọn cty theo mã
                var cty = db.CongTy.FirstOrDefault();
                List<string> poly = new List<string>();
                poly.Add(cty.ToaDo1 + "");
                poly.Add(cty.ToaDo2);
                poly.Add(cty.ToaDo3);
                poly.Add(cty.ToaDo4);

                if (CheckPointInPolygon.PointInPolygon1(X, Y, poly) == true)
                {
                    DateTime datetime = DateTime.Now;
                    var hh = datetime.Hour;
                    var mm = datetime.Minute;

                    //Kiểm tra đã chấm công hôm nay chưa
                    var list = db.ChamCong.Where(ps => ps.MaTK == maTK && ps.ThoiGian.Value.Day == datetime.Day && ps.ThoiGian.Value.Month == datetime.Month && ps.ThoiGian.Value.Year == datetime.Year).ToList();
                    if (list.Count > 0)
                    {
                        return Json(new { msg = "Công hôm nay đã lưu!", success = "error" }, JsonRequestBehavior.AllowGet);
                    }

                    ChamCong cong = new ChamCong();
                    cong.ThoiGian = datetime;
                    cong.MaTK = maTK;
                    //kiểm tra xếp loại công: Đạt, muộn, vắng
                    if (hh <= 9)
                    {
                        cong.XepLoai = 1;
                        cong.DiaDiem = xlat + ", " + xlng;
                    }
                    else
                    {
                        if (hh > 9 && hh < 12)
                        {
                            cong.XepLoai = 2;
                            cong.DiaDiem = xlat + ", " + xlng;
                        }
                        else
                            return Json(new { msg = "Thời gian chấm công không hợp lệ!", success = "error" }, JsonRequestBehavior.AllowGet);
                    }

                    db.ChamCong.Add(cong);
                    db.SaveChanges();
                    return Json(new { msg = "Chấm công thành công", success = "success", xeploai = cong.XepLoai, ThoiGian = cong.ThoiGian.Value.ToString() }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { msg = "Không đúng địa điểm", success = "error" }, JsonRequestBehavior.AllowGet);
                }
            }
            else
            {
                return Json(new { msg = "Không thể thực hiện thao tác!", success = "error" }, JsonRequestBehavior.AllowGet);
            }
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult xinNghi(string ghiChu) { 
            var maTK = SessionHelper.GetMa();
            var maTrinhDuoc = db.TaiKhoan.Where(tk => tk.MaTK == maTK).FirstOrDefault().MaTD;
            if (maTrinhDuoc != null)
            {
                DateTime datetime = DateTime.Now;
                var hh = datetime.Hour;
                var mm = datetime.Minute;

                //Kiểm tra đã chấm công hôm nay chưa
                var list = db.ChamCong.Where(ps => ps.MaTK == maTK && ps.ThoiGian.Value.Day == datetime.Day && ps.ThoiGian.Value.Month == datetime.Month && ps.ThoiGian.Value.Year == datetime.Year).ToList();
                if (list.Count > 0)
                {
                    return Json(new { msg = "Công hôm nay đã lưu!", success = "error" }, JsonRequestBehavior.AllowGet);
                }

                ChamCong cong = new ChamCong();
                cong.ThoiGian = datetime;
                cong.MaTK = maTK;
                cong.GhiChu = ghiChu;
                cong.XepLoai = 3;
                if (hh > 8 || (hh == 8 && mm > 0))
                {
                    return Json(new { msg = "Quá thời gian xin nghỉ", success = "error"}, JsonRequestBehavior.AllowGet);
                }

                db.ChamCong.Add(cong);
                db.SaveChanges();
                return Json(new { msg = "Xin nghỉ thành công!", success = "success", xeploai = cong.XepLoai, ThoiGian = cong.ThoiGian.Value.ToString() }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { msg = "Không thể thực hiện thao tác!", success = "error" }, JsonRequestBehavior.AllowGet);
            }
        }

        [CheckSessionUser]
        public JsonResult luuToaDoCongTy(string toaDo1, string toaDo2, string toaDo3, string toaDo4, string maCongTy)
        {
            if (toaDo1 == null || toaDo2 == null || toaDo3 == null || toaDo4 == null)
            {
                return Json(new { success = "error", msg = "Trường dữ liệu không hợp lệ!" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var cty = db.CongTy.Where(ct => ct.MaCongTy == maCongTy).FirstOrDefault();
                var cty1 = db.CongTy.Where(ct => ct.MaCongTy == maCongTy).FirstOrDefault();
                cty1.ToaDo1 = toaDo1;
                cty1.ToaDo2 = toaDo2;
                cty1.ToaDo3 = toaDo3;
                cty1.ToaDo4 = toaDo4;
                db.Entry(cty1).CurrentValues.SetValues(cty);
                db.SaveChanges();
                return Json(new { success = "success", msg = "Cài đặt thành công!" }, JsonRequestBehavior.AllowGet);
            }

        }

    }
}