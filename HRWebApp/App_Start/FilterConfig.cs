using HRWebApp.Filters;
using System.Web;
using System.Web.Mvc;

namespace HRWebApp
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            //filters.Add(new AuthorizeAttribute());
            filters.Add(new SessionAuthorizeAttribute());
        }
    }
}
