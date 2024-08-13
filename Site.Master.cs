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
                    LoginLogoutButton.Attributes["href"] = "/Logout.aspx"; 
                    LoginLogoutIcon.Attributes["class"] = "bi-box-arrow-right me-2"; 
                    LoginLogoutText.InnerText = "Logout";
                }
                else
                {
                    LoginLogoutButton.Attributes["href"] = "/LoginRegister.aspx";
                    LoginLogoutIcon.Attributes["class"] = "bi-box-arrow-in-right me-2"; 
                    LoginLogoutText.InnerText = "Login";
                }
            }
        }
    }
}