﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Threading.Tasks;

namespace GabayManageSite
{
    public partial class Synagoges : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NameToAdd.ToolTip = "only " + Thread.CurrentThread.CurrentCulture.Name + " characters";

            if (Thread.CurrentThread.CurrentCulture.Name == "he-IL")
            {
                FilteredTextBoxExtenderSynName.ValidChars = "אבגדהוזחטיכלמנסעפצקרשתםך ";
            }
            else
            {
                FilteredTextBoxExtenderSynName.ValidChars = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            }
        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            GabayDataSet gabayDataSet = new GabayDataSet();
            GabayDataSetTableAdapters.SynagogeTableAdapter synagogeTableAdapter = new GabayDataSetTableAdapters.SynagogeTableAdapter();
            
            string Password = PasswordToAdd.Text;
            string synName = NameToAdd.Text;
            int city = int.Parse(DropDownListName.SelectedValue);

            if (!string.IsNullOrEmpty(Password) && !string.IsNullOrEmpty(synName))
            {
                synagogeTableAdapter.InsertQuery(synName, Password, city);
            }

            Response.Redirect("~/Synagoges");
            //SynagogesList.DataBind();
        }
    }
}