using System;
using System.Web.Mvc;
using System.Web.Routing;
/**
 * @author ngtuonghy
 *  2025-02-25 
 */
namespace HRWebApp.Filters
{
    public class SessionAuthorizeAttribute : AuthorizeAttribute
    {
        protected override bool AuthorizeCore(System.Web.HttpContextBase httpContext)
        {
            string controllerName = httpContext.Request.RequestContext.RouteData.Values["controller"]?.ToString();

            if (controllerName?.Equals("Auth", StringComparison.OrdinalIgnoreCase) == true)
            {
                return true;
            }
            return httpContext.Session["CurrentUser"] != null;
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {

            filterContext.Result = new RedirectToRouteResult(
                new RouteValueDictionary(new { controller = "Login", action = "Index" })
            );
        }
    }
}
