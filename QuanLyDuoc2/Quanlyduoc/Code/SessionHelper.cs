using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Quanlyduoc.Models;

namespace Quanlyduoc.Code
{
    public class SessionHelper
    {
        public static void SetSession(TaiKhoan session)
        {
            HttpContext.Current.Session["loginSession"] = session;
        }

        public static TaiKhoan GetSession()
        {
            var session = HttpContext.Current.Session["loginSession"];
            if (session == null)
            {
                return null;
            }
            else
            {
                return session as TaiKhoan;
            }
        }
        public static string GetMa()
        {
            if (GetSession() != null)
            {
                string maACC = GetSession().MaTK.ToString();
                return maACC;
            }
            return "";
        }
        public static string GetAcount()
        {
            if (GetSession().TenTaiKhoan != null)
            {
                string acc = GetSession().TenTaiKhoan.ToString();
                return acc;
            }
            return "";
        }
        public static string GetName()
        {
            if (GetSession().TenTaiKhoan != null)
            {
                string ten = GetSession().HoTen.ToString();
                return ten;
            }
            return "";
        }
        public static string GetRoles()
        {
            if (GetSession().TenTaiKhoan != null)
            {
                string quyen = GetSession().MaQuyen.ToString();
                return quyen;
            }
            return "";
        }
        public static void HuySession()
        {
            HttpContext.Current.Session.Abandon();
        }


    }
}