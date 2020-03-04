using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;

namespace Quanlyduoc.Areas.Admin.Class
{
    public class Util
    {
        public Util()
        {

        }
        public static void SyncRoutes()
        {
            using (var ctx = new QL_Duoc1Entities())
            {
                var rt = new List<Route>();
                var assembly = Assembly.GetExecutingAssembly();
                //var types = assembly.GetTypes().Where(t => t.IsSubclassOf(typeof(Controller)) && t.IsPublic && !t.IsAbstract);
                var tt = assembly.GetTypes().Where(m => m.IsSubclassOf(typeof(Controller)) && m.IsPublic && !m.IsAbstract);
                foreach (var type in tt)
                {
                    string _namespace = type.Namespace;
                    string _controller = type.Name.Substring(0, type.Name.IndexOf("Controller", System.StringComparison.InvariantCulture));
                    if (type.CustomAttributes.Where(c => c.AttributeType == typeof(CheckSessionUser)).Any())
                    {
                        var methods = type.GetMethods()
                        .Where(x => x.IsPublic && x.DeclaringType.Equals(type));
                        foreach (var method in methods)
                        {
                            string _action = method.Name;
                            rt.Add(new Route()
                            {
                                Namespace = _namespace,
                                Controller = _controller,
                                Action = _action
                            });
                        }
                    }
                    else
                    {
                        var methods = type.GetMethods()
                        .Where(x => x.CustomAttributes.Where(c => c.AttributeType == typeof(CheckSessionUser)).Any() && x.IsPublic && x.DeclaringType.Equals(type));
                        foreach (var method in methods)
                        {
                            string _action = method.Name;
                            rt.Add(new Route()
                            {
                                Namespace = _namespace,
                                Controller = _controller,
                                Action = _action
                            });
                        }
                    }
                }

                //Remove route from db when non exist in new list route
                ctx.Route
                    .AsEnumerable()
                    .Where(p => !rt.Any(p2 => p2.Namespace == p.Namespace && p2.Controller == p.Controller && p2.Action == p.Action))
                    .ToList()
                    .All(p =>
                    {
                        ctx.Route.Remove(p);
                        ctx.SaveChanges();
                        return true;
                    });

                //Add route from new list route when non exist in db
                rt.Where(p => !ctx.Route.Any(p2 => p2.Namespace == p.Namespace && p2.Controller == p.Controller && p2.Action == p.Action))
                    .All(p =>
                    {
                        ctx.Route.Add(p);
                        ctx.SaveChanges();
                        return true;
                    });

                //Remove page from db when non exist in new list page
                ctx.Page
                    .AsEnumerable()
                    .Where(p => !rt.GroupBy(p2 => new
                    {
                        p2.Namespace,
                        p2.Controller
                    }, p2 => p2, (key, g) => new
                    {
                        key,
                        g
                    })
                    .Any(p2 => p2.key.Namespace == p.@namespace && p2.key.Controller == p.controller))
                    .ToList()
                    .All(p =>
                    {
                        ctx.Page.Remove(p);
                        ctx.SaveChanges();
                        return true;
                    });

                //Add page from new list page when non exist in db
                rt.GroupBy(p2 => new
                {
                    p2.Namespace,
                    p2.Controller
                }, p2 => p2, (key, g) => new
                {
                    key,
                    g
                }).Where(p2 => !ctx.Page.Any(p => p2.key.Namespace == p.@namespace && p2.key.Controller == p.controller))
                    .ToList()
                    .All(p =>
                    {
                        ctx.Page.Add(new Page()
                        {
                            @namespace = p.key.Namespace,
                            controller = p.key.Controller
                        });
                        ctx.SaveChanges();
                        return true;
                    });
            }
        }
    }
   
}