using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class ExtendsController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();

        public JsonResult addMapNhanVien(string lat, string lng)
        {
            var session = SessionHelper.GetSession();
            if (session != null)
            {
                string maTrinhDuoc = db.TaiKhoan.Where(tk => tk.MaTK == session.MaTK).FirstOrDefault().MaTD;
                if (maTrinhDuoc == null || maTrinhDuoc.Trim() == "")
                {
                    return Json(new { success = "errorss", msg = "Không phải trình dược!" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    //add position
                    Position pos = new Position();
                    pos.MaTK = session.MaTK;
                    pos.Lat = lat;
                    pos.Lng = lng;
                    pos.Time = DateTime.Now;
                    db.Position.Add(pos);

                    //add positionNow
                    var posNow = db.PositionNow.Where(posN => posN.MaTK == session.MaTK).FirstOrDefault();
                    if (posNow != null)
                    {
                        var posNow1 = posNow;
                        posNow1.MaTK = session.MaTK;
                        posNow1.Lat = lat;
                        posNow1.Lng = lng;
                        posNow1.Time = DateTime.Now;
                        db.Entry(posNow1).CurrentValues.SetValues(posNow);
                    }
                    else
                    {
                        PositionNow posNow1 = new PositionNow();
                        posNow1.MaTK = session.MaTK;
                        posNow1.Lat = lat;
                        posNow1.Lng = lng;
                        posNow1.Time = DateTime.Now;
                        db.PositionNow.Add(posNow1);
                    }
                    db.SaveChanges();
                    return Json(new { success = "success" }, JsonRequestBehavior.AllowGet);
                }
            }
            else
                return Json(new { success = "error", msg = "Lỗi" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult layDanhSachDauThuocTheoNhom(string maNhomThuoc)
        {

            var JDauThuoc = db.DauThuoc.AsEnumerable()
                .Join(db.TagsDThuocNThuoc.Where(tag => tag.MaNhomThuoc == maNhomThuoc).AsEnumerable(), dt => dt.MaDT, tag => tag.MaDauThuoc,
                (dt, tag) => new
                {
                    maDauThuoc = dt.MaDT,
                    tenDauThuoc = dt.TenDauThuoc,
                    maNhomThuoc1 = tag.MaNhomThuoc
                }).ToList();

            return Json(JDauThuoc, JsonRequestBehavior.AllowGet);
        }

        //..Thao tác với kho
        //Chuyển số lượng từ đơn vị có mã "MaDonViOld" về đơn vị có mã "MaDonViNew" trong cùng 1 đầu thuốc
        protected int? convertSoLuongCon(string maDT, long? MaDonViOld, long? MaDonViNew, int? SoLuongCon)
        {
            var JDonVi = db.DonVi.Where(d => d.MaDT == maDT).OrderBy(d => d.ID)
                                            .Select(dv => new
                                            {
                                                dv.ID,
                                                dv.IDParent,
                                                dv.Ten,
                                                dv.Heso,
                                                dv.MaDT,
                                                dv.TenDinhNghia
                                            }).ToList();
            var IndexOld = JDonVi.FindIndex(dv => dv.ID == MaDonViOld);
            var IndexNew = JDonVi.FindIndex(dv => dv.ID == MaDonViNew);

            int? SLC = 0;
            if ( MaDonViOld == MaDonViNew)
            {
                SLC = SLC + SoLuongCon;
            }
            else
            {
                if(IndexNew > IndexOld)
                {
                    long? ID = 0;
                    //Tính hệ số
                    int? heso = 1;
                    int k = IndexNew;
                    do
                    {
                        ID = JDonVi[k].IDParent;
                        heso = heso * JDonVi[k].Heso;
                        k--;
                    }
                    while (ID != MaDonViOld);
                    SLC = SLC + SoLuongCon * heso;
                }
                else
                {
                    long? ID = 0;
                    //Tính hệ số
                    int? heso = 1;
                    int k = IndexOld;
                    do
                    {
                        ID = JDonVi[k].IDParent;
                        heso = heso * JDonVi[k].Heso;
                        k--;
                    }
                    while (ID != MaDonViNew);
                    SLC = SLC + SoLuongCon / heso;
                }
                
            }
            return SLC;
        }

        protected Boolean kiemtraVaTaoChiTietPhieuXuat(string maKho, string maDT, int? soLuongCan, long maDonVi)
        {
            var exits = db.KhoDauThuoc.Where(khdt => khdt.MaKho == maKho && khdt.MaDT == maDT).FirstOrDefault();
            if (exits != null)
            {
                //Lấy danh sách đơn vị hiện tại và đơn vị parent trong kho nếu = 0 return false
                var listParent = db.KhoDauThuoc.Where(khdt => khdt.MaKho == maKho && khdt.MaDT == maDT
                                                && khdt.MaDonVi <= maDonVi).ToList();
                if (listParent.Count() != 0)
                {

                    // Kiểm tra nếu đã có đầu thuốc với đơn vị này trong kho chưa
                    var dauThuoc = db.KhoDauThuoc.Where(khdt => khdt.MaDonVi == maDonVi).FirstOrDefault();
                    if (dauThuoc != null)
                    {
                        if(dauThuoc.SoLuongCon >= soLuongCan)
                        {
                            return true;
                        }
                        else
                        {
                            //Lấy IDparent cấp 1 nếu không có Parent thì return false
                            var iDdonviParent = db.DonVi.Where(dv => dv.ID == dauThuoc.MaDonVi).FirstOrDefault().IDParent;
                            if (iDdonviParent != null)
                            {
                                var khoParent = db.KhoDauThuoc.Where(khdt => khdt.MaDonVi == iDdonviParent).FirstOrDefault();
                                if (khoParent != null && khoParent.SoLuongCon > 0)
                                {
                                    khoParent.SoLuongCon = khoParent.SoLuongCon - 1;
                                    dauThuoc.SoLuongCon = dauThuoc.SoLuongCon + convertSoLuongCon(maDT, iDdonviParent, dauThuoc.MaDonVi, 1);
                                    db.SaveChanges();
                                    return kiemtraVaTaoChiTietPhieuXuat(maKho, maDT, soLuongCan, dauThuoc.MaDonVi);
                                }
                                else
                                {
                                    return false;
                                    ////Nếu parent cấp 1 không có hoặc số lượng = 0 Lấy parent cấp 2, số lượng 1 chuyển thành parent cấp 1
                                    //var iDdonviParent2 = db.DonVi.Where(dv => dv.ID == (dauThuoc.MaDonVi - 1)).FirstOrDefault().IDParent;
                                    //if (iDdonviParent2 != null)
                                    //{
                                    //    khoParent = db.KhoDauThuoc.Where(khdt => khdt.MaDonVi == iDdonviParent2).FirstOrDefault();
                                    //    if (khoParent != null && khoParent.SoLuongCon > 0)
                                    //    {
                                    //        khoParent.SoLuongCon = khoParent.SoLuongCon - 1;
                                    //        dauThuoc.SoLuongCon = dauThuoc.SoLuongCon + convertSoLuongCon(maDT, iDdonviParent2, dauThuoc.MaDonVi, 1);
                                    //        db.SaveChanges();
                                    //        return kiemtraVaTaoChiTietPhieuXuat(maKho, maDT, soLuongCan, dauThuoc.MaDonVi);
                                    //    }
                                    //    else return false;
                                    //}
                                    //else return false;
                                }
                            }
                            else return false;
                            
                        }
                    }
                    else
                    {
                        //Lấy ID parent cấp 1
                        var iDdonviParent = db.DonVi.Where(dv => dv.ID == maDonVi).FirstOrDefault().IDParent;
                        if (iDdonviParent != null)
                        {
                            
                            var khoParent = db.KhoDauThuoc.Where(kh => kh.MaDonVi == iDdonviParent).FirstOrDefault();
                            if (khoParent != null && khoParent.SoLuongCon > 0)
                            {
                                khoParent.SoLuongCon = khoParent.SoLuongCon - 1;

                                KhoDauThuoc khdt = new KhoDauThuoc();
                                khdt.MaKho = maKho;
                                khdt.MaDT = maDT;
                                khdt.MaDonVi = maDonVi;
                                khdt.SoLuongCon = convertSoLuongCon(maDT, iDdonviParent, maDonVi, 1);

                                db.KhoDauThuoc.Add(khdt);
                                db.SaveChanges();
                                return kiemtraVaTaoChiTietPhieuXuat(maKho, maDT, soLuongCan, maDonVi);
                            }
                            else
                            {
                                return false;
                                ////Lấy ID parent cấp 2
                                //var iDdonviParent2 = db.DonVi.Where(dv => dv.ID == (maDonVi-1)).FirstOrDefault().IDParent;
                                //if (iDdonviParent2 != null)
                                //{
                                //    khoParent = db.KhoDauThuoc.Where(kh => kh.MaDonVi == iDdonviParent2).FirstOrDefault();
                                //    if (khoParent != null && khoParent.SoLuongCon > 0)
                                //    {
                                //        khoParent.SoLuongCon = khoParent.SoLuongCon - 1;

                                //        KhoDauThuoc khdt = new KhoDauThuoc();
                                //        khdt.MaKho = maKho;
                                //        khdt.MaDT = maDT;
                                //        khdt.MaDonVi = maDonVi -1;
                                //        khdt.SoLuongCon = convertSoLuongCon(maDT, iDdonviParent2, maDonVi - 1, 1);

                                //        db.KhoDauThuoc.Add(khdt);
                                //        db.SaveChanges();
                                //        return kiemtraVaTaoChiTietPhieuXuat(maKho, maDT, soLuongCan, maDonVi);
                                //    }
                                //    else return false;
                                //}
                                //else return false;
                            }
                        }
                        else return false;
                    }
                }
                else return false;
            }
            else return false;
        }
    }
}