using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using Quanlyduoc.Models;
using Quanlyduoc.Areas.Admin.Class;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    
    public class NhomQuyenController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/NhomQuyen
        public ViewResult Index()
        {
            var JNhomQuyen = from a in db.NhomQuyen
                             select (new
                             {
                                 maNhomQuyen = a.MaNhomQuyen,
                                 tenNhomQuyen = a.TenNhomQuyen,
                                 moTa = a.MoTa
                             });

            return View(Json(new { JNhomQuyen = JNhomQuyen }, JsonRequestBehavior.AllowGet));
        }

        [CheckSessionUser]
        [HttpPost]
        public ActionResult ThemNhomQuyen(string tenNhomQuyen, string moTaNhom)
        {
            NhomQuyen nq = new NhomQuyen();
            nq.TenNhomQuyen = tenNhomQuyen;
            nq.MoTa = moTaNhom;
            db.NhomQuyen.Add(nq);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult caiDatQuyen(int maNhomQuyen)
        {
            var JAction = db.Route.Select(m => new
            {
                m.ID,
                m.Namespace,
                m.Controller,
                m.Action,
                m.Name,
                Checked = m.NhomQuyenRoute.Where(n => n.MaNhomQuyen == maNhomQuyen).ToList().Count != 0 ? true : false
            }).ToList();

            var JModul = JAction
                .GroupBy(m => new
                {
                    m.Controller,
                    //m.Name
                }, (key, g) => new { Controller = key.Controller, Name = db.Page.Where(n => n.controller == key.Controller).FirstOrDefault().name, ListAction = g.ToList() })
                .Select(m => new
                {
                    m.Controller,
                    m.Name,
                    m.ListAction
                })
                .ToList();
            return Json(new
            {
                JModul = JModul,
                JAction = JAction
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult luuCaiDatQuyen(data data)
        {
            var maNhomQuyen = Int32.Parse(data.maNhomQuyen);
            List<JModul> listJModul = data.JModul;

            foreach (JModul modul in listJModul)
            {
                foreach (ListAction modulAc in modul.ListAction)
                {
                    if (modulAc.Checked == "True")
                    {
                        var count = db.NhomQuyenRoute.Where(x => x.IDRoute == modulAc.ID && x.MaNhomQuyen == maNhomQuyen).FirstOrDefault();
                        if (count == null)
                        {
                            NhomQuyenRoute nQrT = new NhomQuyenRoute();
                            nQrT.IDRoute = modulAc.ID;
                            nQrT.MaNhomQuyen = maNhomQuyen;
                            db.NhomQuyenRoute.Add(nQrT);
                            db.SaveChanges();
                        }
                    }
                    else
                    {
                        var count = db.NhomQuyenRoute.Where(x => x.IDRoute == modulAc.ID && x.MaNhomQuyen == maNhomQuyen).FirstOrDefault();
                        if (count != null)
                        {
                            db.NhomQuyenRoute.Remove(count);
                            db.SaveChanges();
                        }
                    }
                }
            }
            return Json(new
            {
                msg = "Sửa thành công!",
                ketqua = true
            }, JsonRequestBehavior.AllowGet);
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult xoaNhomQuyen(string maNhomQuyen)
        {
             
            if (maNhomQuyen != null)
            {
                var maNhomQuyen1 = Int32.Parse(maNhomQuyen);
                var count = db.NhomQuyen.Where(nq => nq.MaNhomQuyen == maNhomQuyen1).FirstOrDefault();
                if (count != null)
                {
                    var listNhomQuyenRoute = db.NhomQuyenRoute.Where(nQrT => nQrT.MaNhomQuyen == maNhomQuyen1).ToList();
                    foreach (var item in listNhomQuyenRoute)
                    {
                        db.NhomQuyenRoute.Remove(item);
                        db.SaveChanges();
                    }
                    var taiKhoan1 = db.TaiKhoan.Where(tk => tk.MaNhomQuyen == maNhomQuyen1).FirstOrDefault();
                    var taiKhoan2 = db.TaiKhoan.Where(tk => tk.MaNhomQuyen == maNhomQuyen1).FirstOrDefault();
                    if(taiKhoan2 != null)
                    {
                        taiKhoan2.MaNhomQuyen = null;
                        db.Entry(taiKhoan1).CurrentValues.SetValues(taiKhoan2);
                        db.SaveChanges();
                    }
                    db.NhomQuyen.Remove(count);
                    db.SaveChanges();
                    return Json(new { msg = "Xóa thành công nhóm quyền!", success = "success" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
                }

            }
            else
            {
                return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}