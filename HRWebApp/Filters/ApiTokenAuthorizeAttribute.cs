using System;
using System.Web;
using System.Web.Mvc;

/**
 * @author ngtuonghy
 *  2025-02-25 
 */
namespace HRWebApp.Filters{
    public class ApiTokenAuthorizeAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var token = filterContext.HttpContext.Request.QueryString["apiKey"];

            if (string.IsNullOrEmpty(token) || !IsValidToken(token))
            {
                filterContext.Result = new JsonResult
                {
                    Data = new
                    {
                        status = "error",
                        message = "Unauthorized: Invalid token",
                        data = (object)null
                    },
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
                filterContext.HttpContext.Response.StatusCode = 401;

            }

            base.OnActionExecuting(filterContext);
        }

        private bool IsValidToken(string token)
        {
            return token == "12345";
        }
    }
}
