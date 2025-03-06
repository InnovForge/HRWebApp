using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HRWebApp.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
        public ActionResult Index()
        {
            //if (Session["CurrentUser"] == null)
            //{
            //    return RedirectToAction("Index", "Login");
            //}
            //ViewBag.CurrentUser = Session["CurrentUser"];
            return View();
        }
    }
}