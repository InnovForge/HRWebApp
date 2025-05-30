﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using HRWebApp.Models;
using KafkaNet.Model;
using KafkaNet;
using Newtonsoft.Json;
using KafkaNet.Protocol;
namespace HRWebApp.Controllers
{
    public class PersonalsController : Controller
    {
        private HRDB db = new HRDB();
        KafkaProducerService kafkaProducerService = new KafkaProducerService();

        // GET: Personals
        public ActionResult Index()
        {
            var personals = db.Personals.Include(p => p.Benefit_Plans1).Include(p => p.Emergency_Contacts).Include(p => p.Employment);
            return View(personals.ToList());
        }

        // GET: Personals/Details/5
        public ActionResult Details(decimal id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Personal personal = db.Personals.Find(id);
            if (personal == null)
            {
                return HttpNotFound();
            }
            return View(personal);
        }

        // GET: Personals/Create
        public ActionResult Create()
        {
            ViewBag.Benefit_Plans = new SelectList(db.Benefit_Plans, "Benefit_Plan_ID", "Plan_Name");
            ViewBag.Employee_ID = new SelectList(db.Emergency_Contacts, "Employee_ID", "Emergency_Contact_Name");
            ViewBag.Employee_ID = new SelectList(db.Employments, "Employee_ID", "Employment_Status");
            return View();
        }

        // POST: Personals/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Employee_ID,First_Name,Last_Name,Middle_Initial,Address1,Address2,City,State,Zip,Email,Phone_Number,Social_Security_Number,Drivers_License,Marital_Status,Gender,Shareholder_Status,Benefit_Plans,Ethnicity")] Personal personal)
        {
            if (ModelState.IsValid)
            {
                db.Personals.Add(personal);
                db.SaveChanges();
              
                // Send the data to Kafka
                kafkaProducerService.SendMessageAsync("hr-created", JsonConvert.SerializeObject(personal));
                //_ = Task.Run(async () =>
                //{
                //    try
                //    {
                //        // Create the HttpClient to send the data
                //        using (var client = new HttpClient())
                //        {
                //            var json = JsonConvert.SerializeObject(personal);
                //            var content = new StringContent(json, Encoding.UTF8, "application/json");

                //            // Send the POST request to the Node.js API
                //            var response = await client.PostAsync("http://localhost:8090/api/v1/partner/personal", content);

                //            if (response.IsSuccessStatusCode)
                //            {
                //                var apiResponse = await response.Content.ReadAsStringAsync();
                //                Console.WriteLine(apiResponse); // Log the successful API response
                //            }
                //            else
                //            {
                //                Console.WriteLine("Error calling API: " + response.StatusCode); // Log the error if it fails
                //            }
                //        }
                //    }
                //    catch (Exception ex)
                //    {
                //        // Log any errors during the API call
                //        Console.WriteLine("Error calling API: " + ex.Message);
                //    }
                //});

                // Redirect to Index page after saving
                return RedirectToAction("Index");
            }
            ViewBag.Benefit_Plans = new SelectList(db.Benefit_Plans, "Benefit_Plan_ID", "Plan_Name", personal.Benefit_Plans);
            ViewBag.Employee_ID = new SelectList(db.Emergency_Contacts, "Employee_ID", "Emergency_Contact_Name", personal.Employee_ID);
            ViewBag.Employee_ID = new SelectList(db.Employments, "Employee_ID", "Employment_Status", personal.Employee_ID);
            return View(personal);
        }

        // GET: Personals/Edit/5
        public ActionResult Edit(decimal id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Personal personal = db.Personals.Find(id);
            if (personal == null)
            {
                return HttpNotFound();
            }
            ViewBag.Benefit_Plans = new SelectList(db.Benefit_Plans, "Benefit_Plan_ID", "Plan_Name", personal.Benefit_Plans);
            ViewBag.Employee_ID = new SelectList(db.Emergency_Contacts, "Employee_ID", "Emergency_Contact_Name", personal.Employee_ID);
            ViewBag.Employee_ID = new SelectList(db.Employments, "Employee_ID", "Employment_Status", personal.Employee_ID);
            return View(personal);
        }

        // POST: Personals/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Employee_ID,First_Name,Last_Name,Middle_Initial,Address1,Address2,City,State,Zip,Email,Phone_Number,Social_Security_Number,Drivers_License,Marital_Status,Gender,Shareholder_Status,Benefit_Plans,Ethnicity")] Personal personal)
        {
            if (ModelState.IsValid)
            {
                db.Entry(personal).State = EntityState.Modified;
                db.SaveChanges();
                kafkaProducerService.SendMessageAsync("hr-updated", JsonConvert.SerializeObject(personal));
                return RedirectToAction("Index");
            }
            ViewBag.Benefit_Plans = new SelectList(db.Benefit_Plans, "Benefit_Plan_ID", "Plan_Name", personal.Benefit_Plans);
            ViewBag.Employee_ID = new SelectList(db.Emergency_Contacts, "Employee_ID", "Emergency_Contact_Name", personal.Employee_ID);
            ViewBag.Employee_ID = new SelectList(db.Employments, "Employee_ID", "Employment_Status", personal.Employee_ID);
           
            return View(personal);
        }

        // GET: Personals/Delete/5
        public ActionResult Delete(decimal id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Personal personal = db.Personals.Find(id);
            if (personal == null)
            {
                return HttpNotFound();
            }
            return View(personal);
        }

        // POST: Personals/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(decimal id)
        {
            Personal personal = db.Personals.Find(id);
            db.Personals.Remove(personal);
            db.SaveChanges();
            kafkaProducerService.SendMessageAsync("hr-deleted", JsonConvert.SerializeObject(personal));
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
