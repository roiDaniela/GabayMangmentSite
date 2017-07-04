using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using WingtipToys.Models;

namespace WingtipToys.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        protected string SuccessMessage
        {
            get;
            private set;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        public bool HasPhoneNumber { get; private set; }

        public bool TwoFactorEnabled { get; private set; }

        public bool TwoFactorBrowserRemembered { get; private set; }

        public int LoginsCount { get; set; }

        //public string Email { get; set; }

        protected void Page_Load()
        {                        
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            HasPhoneNumber = String.IsNullOrEmpty(manager.GetPhoneNumber(User.Identity.GetUserId()));

            DataSourceAvailbleSyn.SelectParameters.Remove(DataSourceAvailbleSyn.SelectParameters["email"]);
            DataSourceAvailbleSyn.SelectParameters.Add("email", manager.GetEmail(User.Identity.GetUserId())); //Where userID is your variable
            SqlDataSource1.SelectParameters.Remove(SqlDataSource1.SelectParameters["email"]);
            SqlDataSource1.SelectParameters.Add("email", manager.GetEmail(User.Identity.GetUserId())); //Where userID is your variable
            // Enable this after setting up two-factor authentientication
            //PhoneNumber.Text = manager.GetPhoneNumber(User.Identity.GetUserId()) ?? String.Empty;

            TwoFactorEnabled = manager.GetTwoFactorEnabled(User.Identity.GetUserId());

            LoginsCount = manager.GetLogins(User.Identity.GetUserId()).Count;

            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            if (!IsPostBack)
            {
                // Determine the sections to render
                if (HasPassword(manager))
                {
                    ChangePassword.Visible = true;
                }
                else
                {
                    CreatePassword.Visible = true;
                    ChangePassword.Visible = false;
                }

                // Render success message
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Strip the query string from action
                    Form.Action = ResolveUrl("~/Account/Manage");

                    SuccessMessage =
                        message == "ChangePwdSuccess" ? "Your password has been changed."
                        : message == "SetPwdSuccess" ? "Your password has been set."
                        : message == "RemoveLoginSuccess" ? "The account was removed."
                        : message == "AddPhoneNumberSuccess" ? "Phone number has been added"
                        : message == "RemovePhoneNumberSuccess" ? "Phone number was removed"
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
            }
        }


        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        // Remove phonenumber from user
        protected void RemovePhone_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var result = manager.SetPhoneNumber(User.Identity.GetUserId(), null);
            if (!result.Succeeded)
            {
                return;
            }
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                IdentityHelper.SignIn(manager, user, isPersistent: false);
                Response.Redirect("/Account/Manage?m=RemovePhoneNumberSuccess");
            }
        }

        // DisableTwoFactorAuthentication
        protected void TwoFactorDisable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), false);

            Response.Redirect("/Account/Manage");
        }


        
        //EnableTwoFactorAuthentication 
        protected void TwoFactorEnable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), true);

            Response.Redirect("/Account/Manage");
        }

        protected void DropDownListCurrSyn_SelectedIndexChanged(object sender, EventArgs e)
        {
            //DropDownListCurrSyn.
            if (DropDownListCurrSyn.SelectedItem != null)
            {
                Session["currSyn"] = DropDownListCurrSyn.SelectedItem.Text;
            }
            else
            {
                Session["currSyn"] = String.Empty;
            }
        }

        protected void AddSynagogeToUser(object sender, EventArgs e)
        {
            string Password = SynPassword.Text;
            string realPassword = Models.ProductDatabaseInitializer.getPasswordForSynagogeId(DropDownListNotAvailbleSyn.SelectedValue);

            if (Password.Equals(realPassword))
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                GabayDataSet gabayDataSet = new GabayDataSet();
                GabayDataSetTableAdapters.Mail2SynTableAdapter mail2SynTableAdapter = new GabayDataSetTableAdapters.Mail2SynTableAdapter();
                GabayDataSet.Mail2SynRow rsDetails = gabayDataSet.Mail2Syn.NewMail2SynRow();

                rsDetails["Email"] = manager.GetEmail(User.Identity.GetUserId());
                rsDetails["Synagoge_Id"] = DropDownListNotAvailbleSyn.SelectedValue;

                gabayDataSet.Mail2Syn.Rows.Add(rsDetails.ItemArray);

                mail2SynTableAdapter.Update(gabayDataSet.Mail2Syn);
                
                DropDownListNotAvailbleSyn.DataBind();
                DropDownListCurrSyn.DataBind();
            }
        }
    }
}