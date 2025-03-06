using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HRWebApp.Controllers
{
    [AllowAnonymous]
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Index()
        {
            if (Session["CurrentUser"] != null)
            {
                return RedirectToAction("Index", "Admin");
            }
            return View();
        }

        public ViewResult Login()
        {
            ViewBag.Message = "Vui lòng đăng nhập lại.";
            return View();
        }
    }
}