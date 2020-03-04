using Quanlyduoc.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using Quanlyduoc.Code;
using Quanlyduoc.Areas.Admin.Class;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class DauThuocController : Controller
    {

        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/DauThuoc

        [HttpGet]
        public ActionResult Index(string maNhomThuoc)
        {
            if (string.IsNullOrEmpty(maNhomThuoc) || maNhomThuoc.Trim() == "" || maNhomThuoc== "undefined")
            {
                ViewBag.NhomThuoc = db.NhomDauThuoc.ToList()
                                .Select(nh => new
                                {
                                    nh.MaNhomThuoc,
                                    nh.TenNhom
                                }).ToList();
                return View(db.DauThuoc.ToList());
            }
            else
            {
                ViewBag.NhomThuoc = db.NhomDauThuoc.ToList()
                                .Select(nh => new
                                {
                                    nh.MaNhomThuoc,
                                    nh.TenNhom
                                }).ToList();
                ViewBag.nhomSelect = maNhomThuoc;
                var listDauThuoc = db.DauThuoc.AsEnumerable()
                .Join(db.TagsDThuocNThuoc.Where(tag => tag.MaNhomThuoc == maNhomThuoc).AsEnumerable(), dt => dt.MaDT, tag => tag.MaDauThuoc,
                (dt, tag) => dt).ToList();
                return View(listDauThuoc);
            }
            
        }

        [HttpGet]
        public ViewResult chitietdauthuoc(string MaDT)
        {
            var dauThuoc = db.DauThuoc.Where(dt => dt.MaDT == MaDT).FirstOrDefault();
            return View(dauThuoc);
        }

        [HttpGet]
        public ActionResult Themdauthuoc()
        {
            //ViewBag.MaNhomThuoc = new SelectList(db.NhomDauThuoc.ToList(), "MaNhomThuoc", "TenNhom");
            ViewBag.NhomThuoc = db.NhomDauThuoc.ToList()
                                .Select(nh => new
                                {
                                    id = nh.MaNhomThuoc,
                                    text = nh.TenNhom
                                }).ToList();
            ViewBag.MaNSX = new SelectList(db.NhaSanXuat.ToList(), "MaNSX", "TenNSX");
            return View();
        }

        [HttpPost]
        public ActionResult Themdauthuoc(DauThuocDonVi dtDV, string tagsNhom, HttpPostedFileBase anhDauThuoc)
        {
            DauThuoc dauThuoc = new DauThuoc();

            string maDT = "DT" + SinhMa.getMa("MaDT", "DauThuoc");
            dauThuoc.MaDT = maDT;
            dauThuoc.TenDauThuoc = dtDV.TenDauThuoc;
            dauThuoc.CongDung = dtDV.CongDung;
            dauThuoc.CachDung = dtDV.CachDung;
            dauThuoc.Image = dtDV.Image;
            dauThuoc.Status = dtDV.Status;
            dauThuoc.GiaBanLe = dtDV.GiaBanLe;
            dauThuoc.MaNSX = dtDV.MaNSX;
            if (tagsNhom == null || tagsNhom.Trim() == "")
            {
                ViewBag.Thongbao = "Chưa chọn tag nhóm thuốc";
            }
            else
            {
                if (anhDauThuoc == null)
                {
                    ViewBag.Thongbao = "Chưa chọn hình ảnh.";
                }
                else
                {
                    //Lấy tên file ghép vào thời gian update để tạo tên ảnh mới
                    string nowDate = DateTime.Now.ToString("MM_dd_yyyy_hh_mm_ss");
                    var imagefileName = Path.GetFileName(anhDauThuoc.FileName).Split('.')[0] + "_" + nowDate + "."
                        + Path.GetFileName(anhDauThuoc.FileName).Split('.')[1];

                    var path = Path.Combine(Server.MapPath("~/Content/Images/DauThuoc"), imagefileName);
                    //if (System.IO.File.Exists(path))
                    //{
                    //    ViewBag.ThongBao = "Hình ảnh đã tồn tại";
                    //}
                    //else
                    //{
                    dauThuoc.Image = imagefileName;
                    if (dtDV.TenDonVi != null)
                    {
                        DonVi dv = new DonVi();
                        //dv.ID = Guid.NewGuid();
                        dv.ID = SinhMa.getMaInt("ID", "DonVi");
                        dv.Ten = dtDV.TenDonVi;
                        dv.Heso = 1;
                        dv.MaDT = dauThuoc.MaDT;
                        //db.DonVi.Add(dv);

                        dauThuoc.DonVi.Add(dv);

                        if (dtDV.TenDonVi1 != null && dtDV.HeSoDonVi1 != 0)
                        {
                            DonVi dv1 = new DonVi();
                            dv1.ID = dv.ID + 1;
                            dv1.Ten = dtDV.TenDonVi1;
                            dv1.Heso = dtDV.HeSoDonVi1;
                            dv1.IDParent = dv.ID;
                            dv1.MaDT = dauThuoc.MaDT;

                            dauThuoc.DonVi.Add(dv1);

                            //db.DonVi.Add(dv1);
                            //db.SaveChanges();

                            if (dtDV.TenDonVi2 != null && dtDV.HeSoDonVi2 != 0)
                            {
                                DonVi dv2 = new DonVi();
                                dv2.ID = dv1.ID + 1;
                                dv2.Ten = dtDV.TenDonVi2;
                                dv2.Heso = dtDV.HeSoDonVi2;
                                dv2.IDParent = dv1.ID;
                                dv2.MaDT = dauThuoc.MaDT;

                                dauThuoc.DonVi.Add(dv2);

                                //db.DonVi.Add(dv2);
                                //db.SaveChanges();
                                if (dtDV.TenDonVi3 != null && dtDV.HeSoDonVi3 != 0)
                                {
                                    DonVi dv3 = new DonVi();
                                    dv3.ID = dv2.ID + 1;
                                    dv3.Ten = dtDV.TenDonVi3;
                                    dv3.Heso = dtDV.HeSoDonVi3;
                                    dv3.IDParent = dv2.ID;
                                    dv2.MaDT = dauThuoc.MaDT;

                                    dauThuoc.DonVi.Add(dv3);
                                    //db.DonVi.Add(dv3);
                                    //db.SaveChanges();
                                }
                            }
                        }
                        db.DauThuoc.Add(dauThuoc);
                        anhDauThuoc.SaveAs(path);
                        db.SaveChanges();

                        var listTagsNhom = tagsNhom.Split(',').ToList();
                        foreach (var nhom in listTagsNhom)
                        {
                            TagsDThuocNThuoc tag = new TagsDThuocNThuoc();
                            tag.MaDauThuoc = maDT;
                            tag.MaNhomThuoc = nhom;
                            db.TagsDThuocNThuoc.Add(tag);
                            db.SaveChanges();
                        }

                        return RedirectToAction("Index");
                    }
                    //}
                }
            }
            ViewBag.MaNhomThuoc = new SelectList(db.NhomDauThuoc.ToList(), "MaNhomThuoc", "TenNhom");
            ViewBag.MaNSX = new SelectList(db.NhaSanXuat.ToList(), "MaNSX", "TenNSX");
            return View();
        }

        [HttpGet]
        public ActionResult SuaDauThuoc(string MaDT)
        {
            ViewBag.NhomThuoc = db.NhomDauThuoc.ToList()
                                .Select(nh => new
                                {
                                    id = nh.MaNhomThuoc,
                                    text = nh.TenNhom
                                }).ToList();
            ViewBag.tagSelect = db.NhomDauThuoc.AsEnumerable()
                                                    .Join(db.TagsDThuocNThuoc.Where(tag => tag.MaDauThuoc == MaDT).AsEnumerable(), nh => nh.MaNhomThuoc, tag => tag.MaNhomThuoc,
                                                    (nh, tag) => new
                                                    {
                                                        id = nh.MaNhomThuoc,
                                                        text = nh.TenNhom
                                                    }).ToList();
            ViewBag.MaNSX = new SelectList(db.NhaSanXuat.ToList(), "MaNSX", "TenNSX");
            DauThuoc dauThuoc = db.DauThuoc.Where(m => m.MaDT == MaDT).FirstOrDefault();
            var Donvi = db.DonVi.Where(dv => dv.MaDT == MaDT).OrderBy(s => s.ID).ToList();
            DauThuocDonVi dtDv = new DauThuocDonVi();
            dtDv.MaDT = MaDT;
            dtDv.TenDauThuoc = dauThuoc.TenDauThuoc;
            dtDv.CongDung = dauThuoc.CongDung;
            dtDv.CachDung = dauThuoc.CachDung;
            dtDv.Image = dauThuoc.Image;
            dtDv.Status = dauThuoc.Status;
            dtDv.GiaBanLe = dauThuoc.GiaBanLe;
            dtDv.MaNSX = dauThuoc.MaNSX;

            if (Donvi.Count() > 0)
            {
                dtDv.TenDonVi = Donvi[0].Ten; dtDv.HeSoDonVi = 1;
                if (Donvi.Count() > 1)
                {
                    dtDv.TenDonVi1 = Donvi[1].Ten; dtDv.HeSoDonVi1 = Donvi[1].Heso;
                    if (Donvi.Count() > 2)
                    {
                        dtDv.TenDonVi2 = Donvi[2].Ten; dtDv.HeSoDonVi2 = Donvi[2].Heso;
                        if (Donvi.Count > 3)
                        {
                            dtDv.TenDonVi3 = Donvi[3].Ten; dtDv.HeSoDonVi3 = Donvi[3].Heso;
                        }
                    }
                }
            }
            return View(dtDv);
        }

        [HttpPost]
        public ActionResult SuaDauThuoc(DauThuocDonVi dtDV, string tagsNhom, HttpPostedFileBase anhDauThuoc)
        {
            var imagefileName = "";
            DauThuoc dauThuoc1 = db.DauThuoc.Where(n => n.MaDT == dtDV.MaDT).FirstOrDefault();
            DauThuoc dauThuoc = db.DauThuoc.Where(n => n.MaDT == dtDV.MaDT).FirstOrDefault();
            dauThuoc.TenDauThuoc = dtDV.TenDauThuoc;
            dauThuoc.CongDung = dtDV.CongDung;
            dauThuoc.CachDung = dtDV.CachDung;
            dauThuoc.Status = dtDV.Status;
            dauThuoc.GiaBanLe = dtDV.GiaBanLe;
            dauThuoc.MaNSX = dtDV.MaNSX;
            if (tagsNhom == null || tagsNhom.Trim() == "")
            {
                ViewBag.Thongbao = "Chưa chọn tag nhóm thuốc";
            }
            else
            {
                if (anhDauThuoc == null)
                {
                    imagefileName = dauThuoc1.Image;

                }
                else
                {
                    //Lấy tên file ghép vào thời gian update để tạo tên ảnh mới
                    string nowDate = DateTime.Now.ToString("MM_dd_yyyy_hh_mm_ss");
                    imagefileName = Path.GetFileName(anhDauThuoc.FileName).Split('.')[0] + "_" + nowDate + "."
                        + Path.GetFileName(anhDauThuoc.FileName).Split('.')[1];

                    //Lưu đường dẫn ảnh
                    var path = Path.Combine(Server.MapPath("~/Content/Images/DauThuoc"), imagefileName);
                    var path1 = Path.Combine(Server.MapPath("~/Content/Images/DauThuoc"), dauThuoc1.Image);
                    anhDauThuoc.SaveAs(path);
                    if (System.IO.File.Exists(path1))
                    {
                        System.IO.File.Delete(path1);
                    }
                }
                dauThuoc.Image = imagefileName;

                //Đếm số đơn vị đã có trong csdl
                var Donvi = db.DonVi.Where(dv => dv.MaDT == dtDV.MaDT).OrderBy(s => s.ID).ToList();
                if (Donvi.Count() > 0)
                {
                    var x = Donvi[0];
                    DonVi dv = db.DonVi.Where(d => d.ID == x.ID).FirstOrDefault();
                    DonVi dv1 = db.DonVi.Where(d => d.ID == x.ID).FirstOrDefault();
                    dv.Ten = dtDV.TenDonVi;
                    dv.Heso = 1;
                    db.Entry(dv1).CurrentValues.SetValues(dv);
                    db.SaveChanges();
                    if (Donvi.Count() > 1)
                    {
                        var x1 = Donvi[1];
                        DonVi dv2 = db.DonVi.Where(d => d.ID == x1.ID).FirstOrDefault();
                        DonVi dv3 = db.DonVi.Where(d => d.ID == x1.ID).FirstOrDefault();
                        dv2.Ten = dtDV.TenDonVi1;
                        dv2.Heso = dtDV.HeSoDonVi1;
                        db.Entry(dv3).CurrentValues.SetValues(dv2);
                        db.SaveChanges();
                        if (Donvi.Count() > 2)
                        {
                            var x2 = Donvi[2];
                            DonVi dv4 = db.DonVi.Where(d => d.ID == x2.ID).FirstOrDefault();
                            DonVi dv5 = db.DonVi.Where(d => d.ID == x2.ID).FirstOrDefault();
                            dv4.Ten = dtDV.TenDonVi2;
                            dv4.Heso = dtDV.HeSoDonVi2;
                            db.Entry(dv5).CurrentValues.SetValues(dv4);
                            db.SaveChanges();
                            if (Donvi.Count() > 3)
                            {
                                var x3 = Donvi[3];
                                DonVi dv6 = db.DonVi.Where(d => d.ID == x3.ID).FirstOrDefault();
                                DonVi dv7 = db.DonVi.Where(d => d.ID == x3.ID).FirstOrDefault();
                                dv6.Ten = dtDV.TenDonVi3;
                                dv6.Heso = dtDV.HeSoDonVi3;
                                db.Entry(dv7).CurrentValues.SetValues(dv6);
                                db.SaveChanges();
                            }
                        }
                    }
                }
                db.TagsDThuocNThuoc.RemoveRange(db.TagsDThuocNThuoc.Where(tag => tag.MaDauThuoc == dtDV.MaDT));
                var listTagsNhom = tagsNhom.Split(',').ToList();
                foreach (var nhom in listTagsNhom)
                {
                    TagsDThuocNThuoc tag = new TagsDThuocNThuoc();
                    tag.MaDauThuoc = dtDV.MaDT;
                    tag.MaNhomThuoc = nhom;
                    db.TagsDThuocNThuoc.Add(tag);
                    db.SaveChanges();
                }

                db.Entry(dauThuoc1).CurrentValues.SetValues(dauThuoc);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            //Trả về trang edit
            ViewBag.NhomThuoc = db.NhomDauThuoc.ToList()
                                .Select(nh => new
                                {
                                    id = nh.MaNhomThuoc,
                                    text = nh.TenNhom
                                }).ToList();
            ViewBag.tagSelect = db.NhomDauThuoc.AsEnumerable()
                                                    .Join(db.TagsDThuocNThuoc.Where(tag => tag.MaDauThuoc == dtDV.MaDT).AsEnumerable(), nh => nh.MaNhomThuoc, tag => tag.MaNhomThuoc,
                                                    (nh, tag) => new
                                                    {
                                                        id = nh.MaNhomThuoc,
                                                        text = nh.TenNhom
                                                    }).ToList();
            ViewBag.MaNSX = new SelectList(db.NhaSanXuat.ToList(), "MaNSX", "TenNSX");
            return View(dtDV);
        }

        [HttpPost]
        public ActionResult XoaDauThuoc(string MaDT)
        {
            DauThuoc dauThuoc = db.DauThuoc.Where(m => m.MaDT == MaDT).FirstOrDefault();
            if (dauThuoc == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            var anhDauThuoc = dauThuoc.Image;
            if (anhDauThuoc != null)
            {
                var path = Path.Combine(Server.MapPath("~/Content/Images/DauThuoc"), anhDauThuoc);
                if (System.IO.File.Exists(path))
                {
                    System.IO.File.Delete(path);
                }
            }
            var listDonVi = db.DonVi.Where(d => d.MaDT == dauThuoc.MaDT).ToList();
            if (listDonVi != null)
                foreach (DonVi dv in listDonVi)
                    db.DonVi.Remove(dv);

            db.DauThuoc.Remove(dauThuoc);
            db.TagsDThuocNThuoc.RemoveRange(db.TagsDThuocNThuoc.Where(tag => tag.MaDauThuoc == MaDT));
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}