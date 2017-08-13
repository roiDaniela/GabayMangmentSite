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
using Microsoft.AspNet.Identity;

namespace GabayManageSite
{
    public class Global : HttpApplication
    {
        private bool firstSession {get; set;}
        private object currsyn { get; set; }
        private object synname { get; set; }
        
        void Application_Start(object sender, EventArgs e)
        {
            firstSession = true;
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

        }

        void Session_Start(object sender, EventArgs e)
        {
            if (Context.User.Identity.GetUserName() != null && !string.IsNullOrEmpty(Context.User.Identity.GetUserName()))
            {
                GabayDataSet gabayDataSet = new GabayDataSet();
                GabayDataSetTableAdapters.Mail2SynTableAdapter mail2SynTableAdapter = new GabayDataSetTableAdapters.Mail2SynTableAdapter();

                mail2SynTableAdapter.GetDataBy(Context.User.Identity.GetUserName());
                Session["currSynName"] = mail2SynTableAdapter.GetDataBy(Context.User.Identity.GetUserName())[0]["name"];
                Session["currSynId"] = mail2SynTableAdapter.GetDataBy(Context.User.Identity.GetUserName())[0]["id"];
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