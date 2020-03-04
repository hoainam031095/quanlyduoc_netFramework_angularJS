using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Quanlyduoc
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapMvcAttributeRoutes();

            Quanlyduoc.Areas.Admin.Class.Util.SyncRoutes();

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "TrangChu", action = "Index", id = UrlParameter.Optional }
            );


        }
        //private static IEnumerable<Route> GetAllRoutes()
        //{
        //    //Get the executing assembly
        //    var assembly = Assembly.GetExecutingAssembly();

        //    //Get all classes that inherit from the Controller class that are public and not abstract
        //    //Replace Controller with ApiController for Web Api
        //    var types = assembly.GetTypes()
        //    .Where(t => t.IsSubclassOf(typeof(Controller)) && t.IsPublic && !t.IsAbstract);
        //    foreach (var type in types)
        //    {
        //        //Get the Controller Name minus the word Controller
        //        string controllerName = type.Name
        //        .Substring(0, type.Name.IndexOf("Controller", System.StringComparison.InvariantCulture));

        //        //Get all Methods within the inherited class
        //        var methods = type.GetMethods()
        //        .Where(x => x.IsPublic && x.DeclaringType.Equals(type));
        //        foreach (var method in methods)
        //        {
        //            //Construct the initial url pattern which will contain the Controller and Method name.
        //            string url = string.Format("{0}/{1}", controllerName, method.Name);

        //            //Create a new Dictionary and add the controller name and method name
        //            var routeDictionary = new Dictionary<string, object>();
        //            routeDictionary.Add("controller", controllerName);
        //            routeDictionary.Add("action", method.Name);

        //            // Get all method parameters and add them to the dictionary
        //            var paramInfo = method.GetParameters();
        //            if (paramInfo.Count() > 0)
        //            {
        //                foreach (var parameter in paramInfo)
        //                {
        //                    //Append the url format with the parameter name
        //                    url += "/{" + parameter.Name + "}";

        //                    //Check if parameter is optional and add the name and value to the dictionary
        //                    if (parameter.IsOptional)
        //                        routeDictionary.Add(parameter.Name, UrlParameter.Optional);
        //                    else
        //                        routeDictionary.Add(parameter.Name, parameter.Name);
        //                }
        //            }
        //            yield return new Route(url, new RouteValueDictionary(routeDictionary), new MvcRouteHandler());
        //        }
        //    }
        //}
    }
    
}
