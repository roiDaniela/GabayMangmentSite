using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Data.Entity;
using GabayManageSite.Models;
using GabayManageSite.Logic;

namespace GabayManageSite
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Initialize the product database.
            Database.SetInitializer(new ProductDatabaseInitializer());

            // Create the custom role and user.
            RoleActions roleActions = new RoleActions();
            roleActions.AddUserAndRole();

            // Add Routes.
            RegisterCustomRoutes(RouteTable.Routes);
        }

        void RegisterCustomRoutes(RouteCollection routes)
        {
          routes.MapPageRoute(
              "ProductsByCategoryRoute",
              "Category/{categoryName}",
              "~/ProductList.aspx"
          );
          routes.MapPageRoute(
              "ProductByNameRoute",
              "Product/{productName}",
              "~/ProductDetails.aspx"
          );
          routes.MapPageRoute(
              "PrayerByIdRoute",
              "Prayer/{prayerId}",
              "~/PrayerDetails.aspx"
          );
        }

        void Session_End(object sender, EventArgs e)
        {
            string alert = "<SCRIPT LANGUAGE='JavaScript'>alert('Session expired')</SCRIPT>";
            Session["SessionExpire"] = true;
            Response.Redirect("/Account/Login");
            System.Web.HttpContext.Current.Response.Write(alert);
        }

        void Session_Start(object sender, EventArgs e)
        {
            if (Session.IsNewSession && Session["SessionExpire"] == null)
            {

            }
        }

        void Application_Error(object sender, EventArgs e)
        {
          // Code that runs when an unhandled error occurs.

          // Get last error from the server
          Exception exc = Server.GetLastError();

          if (exc is HttpUnhandledException)
          {
            if (exc.InnerException != null)
            {
              exc = new Exception(exc.InnerException.Message);
              Server.Transfer("ErrorPage.aspx?handler=Application_Error%20-%20Global.asax",
                  true);
            }
          }
        }
    }
}