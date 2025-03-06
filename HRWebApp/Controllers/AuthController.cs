using System;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using System.Web.UI;
using HRWebApp.Models;

namespace HRWebApp.Controllers
{
    [AllowAnonymous]
    public class AuthController : Controller
    {
        private static readonly string SECRET_KEY = "0123456789abcdef0123456789abcdef";
        public ActionResult SSO(string token)
        {
            if (!string.IsNullOrEmpty(token))
            {
                string isValid = validateToken(token);
                if (isValid != null)
                {
                    string[] parts = isValid.Split('|');
                    {
                        if (!IsTimestampExpired(long.Parse(parts[1]), 1))
                        {
                            Session.Timeout = 30;
                            Session["CurrentUser"] = new User { Name = parts[0], };
                            return RedirectToAction("Index", "Admin");
                        }
                    }
                }
            }
            return RedirectToAction("Index", "Login");
        }

        static bool IsTimestampExpired(long timestamp, int minutes)
        {
            long currentTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
            return (currentTimestamp - timestamp) > (minutes * 60);
        }

        public static String validateToken(string token)
        {
            var parts = token.Split('.');
            if (parts.Length != 2) return null;

            string signature = parts[0];
            string data = parts[1];

            string paddedData = data.PadRight((data.Length + 3) / 4 * 4, '=');

            string decodedData = Encoding.UTF8.GetString(Convert.FromBase64String(paddedData));

            using (var hmac = new HMACSHA256(Encoding.UTF8.GetBytes(SECRET_KEY)))
            {
                string expectedSignature = Convert.ToBase64String(hmac.ComputeHash(Encoding.UTF8.GetBytes(decodedData))).TrimEnd('=').Replace('+', '-').Replace('/', '_');
                return signature == expectedSignature ? decodedData : null;
            }
        }

    }
}
