using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using GabayManageSite.Models;

namespace GabayManageSite.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser() { UserName = Email.Text, Email = Email.Text};
            IdentityResult result = manager.Create(user, Password.Text);

            if (result.Succeeded)
            {
                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                //string code = manager.GenerateEmailConfirmationToken(user.Id);
                //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
                //manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>.");

                IdentityHelper.SignIn(manager, user, isPersistent: false);

                // save to users table
                saveToUsresTable(Email.Text, Password.Text);
                using (GabayManageSite.Logic.ShoppingCartActions usersShoppingCart = new GabayManageSite.Logic.ShoppingCartActions())
                {
                  String cartId = usersShoppingCart.GetCartId();
                  usersShoppingCart.MigrateCart(cartId, user.Id);
                }

                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }

        private void saveToUsresTable(string email, string password)
        {            
            GabayDataSet gabayDataSet = new GabayDataSet();
            GabayDataSetTableAdapters.UsersTableAdapter usersTableAdapter = new GabayDataSetTableAdapters.UsersTableAdapter();
            GabayDataSet.UsersRow rsDetails = gabayDataSet.Users.NewUsersRow();

            rsDetails["email"] = email;
            rsDetails["password"] = password;

            gabayDataSet.Users.Rows.Add(rsDetails.ItemArray);

            usersTableAdapter.Update(gabayDataSet.Users);

            // add to mail2syn
            GabayDataSetTableAdapters.Mail2SynTableAdapter mail2SynTableAdapter = new GabayDataSetTableAdapters.Mail2SynTableAdapter();
            GabayDataSet.Mail2SynRow rsDetails2 = gabayDataSet.Mail2Syn.NewMail2SynRow();

            rsDetails2["Synagoge_Id"] = DropDownListSyn.SelectedValue;
            rsDetails2["email"] = email;

            gabayDataSet.Mail2Syn.Rows.Add(rsDetails2.ItemArray);

            mail2SynTableAdapter.Update(gabayDataSet.Mail2Syn);
        }

        private bool checkSynagogeWithDB()
        {       
            //string synDBPassword = Models.ProductDatabaseInitializer.getPasswordForSynagogeId(Synagoge.SelectedValue);
            //return (synPassword.Equals(synPassword.Text));           
            return true;
        }

        protected void DropDownListName_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownListSyn.Visible = true;
            synNameLabel.Visible = true;
            SqlDataSourceSynName.SelectParameters.Remove(SqlDataSourceSynName.SelectParameters["city"]);
            SqlDataSourceSynName.SelectParameters.Add("city", DropDownListName.SelectedValue);
            if (!string.IsNullOrEmpty(DropDownListSyn.SelectedValue))
            {
                Session["currSynName"] = DropDownListSyn.SelectedItem.Text;
                Session["currSynId"] = DropDownListSyn.SelectedValue;
            }
        }
    }
}