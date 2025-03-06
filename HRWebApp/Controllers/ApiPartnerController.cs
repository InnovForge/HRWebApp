using HRWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.Entity;
using System.Net;
using HRWebApp.Filters;

namespace HRWebApp.Controllers
{
    [RoutePrefix("api/v1/partner")]
    [ApiTokenAuthorize]
    public class ApiPartnerController : Controller
    {
        private HRDB db = new HRDB();

        [AllowAnonymous]
        [HttpGet]
        [Route("person")]
        public ActionResult Person()
        {

            var personals = db.Personals.Include(p => p.Benefit_Plans1).Include(p => p.Emergency_Contacts).Include(p => p.Employment);
            var data = new
            {
                status = "success",
                message = "Request processed successfully",
                data = personals.ToList()
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}
