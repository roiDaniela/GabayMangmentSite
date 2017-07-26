using System;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using GabayManageSite.Models;

namespace GabayManageSite.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterHyperLink.NavigateUrl = "Register";
            // Enable this once you have account confirmation enabled for password reset functionality
            //ForgotPasswordHyperLink.NavigateUrl = "Forgot";
            //OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Validate the user password
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();

                // This doen't count login failures towards account lockout
                // To enable password failures to trigger lockout, change to shouldLockout: true
                var result = signinManager.PasswordSignIn(Email.Text, Password.Text, RememberMe.Checked, shouldLockout: false);

                /*if (result == SignInStatus.Failure)
                {
                    // check in db
                    string real_pass = Models.ProductDatabaseInitializer.getPasswordForUser(Email.Text);
                    if (real_pass!= null && real_pass.Equals(Password.Text))
                    {
                        result = SignInStatus.Success;
                    }
                }*/

                switch (result)
                {
                    case SignInStatus.Success:
                        GabayManageSite.Logic.ShoppingCartActions usersShoppingCart = new GabayManageSite.Logic.ShoppingCartActions();
                        String cartId = usersShoppingCart.GetCartId();
                        //usersShoppingCart.MigrateCart(cartId, Email.Text);

                        GabayDataSet gabayDataSet = new GabayDataSet();
                        GabayDataSetTableAdapters.Mail2SynTableAdapter mail2SynTableAdapter = new GabayDataSetTableAdapters.Mail2SynTableAdapter();

                        mail2SynTableAdapter.GetDataBy(Email.Text);
                        Session["currSynName"] = mail2SynTableAdapter.GetDataBy(Email.Text)[0]["name"];
                        Session["currSynId"] = mail2SynTableAdapter.GetDataBy(Email.Text)[0]["id"];

                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                        break;
                    case SignInStatus.LockedOut:
                        Response.Redirect("/Account/Lockout");
                        break;
                    case SignInStatus.RequiresVerification:
                        Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}", 
                                                        Request.QueryString["ReturnUrl"],
                                                        RememberMe.Checked),
                                          true);
                        break;
                    case SignInStatus.Failure:
                    default:
                        FailureText.Text = "Invalid login attempt";
                        ErrorMessage.Visible = true;
                        break;
                }
            }
        }
    }
}