using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TechBuy_FinalProject
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    // User is logged in, change button to Logout
                    LoginLogoutButton.Attributes["href"] = "/Logout.aspx"; // or your logout logic page
                    LoginLogoutIcon.Attributes["class"] = "bi-box-arrow-right me-2"; // Change icon to logout icon
                    LoginLogoutText.InnerText = "Logout";
                }
                else
                {
                    // User is not logged in, keep button as Login
                    LoginLogoutButton.Attributes["href"] = "/LoginRegister.aspx";
                    LoginLogoutIcon.Attributes["class"] = "bi-box-arrow-in-right me-2"; // Ensure the icon is for login
                    LoginLogoutText.InnerText = "Login";
                }
            }
        }
    }
}