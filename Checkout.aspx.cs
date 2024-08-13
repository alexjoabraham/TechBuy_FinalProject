using System;
using System.Collections.Generic;
using System.Web.UI;
using TechBuy_FinalProject.Model;

namespace TechBuy_FinalProject
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("~/LoginRegister.aspx");
            }
        }

        protected void PlaceOrderButton_Click(object sender, EventArgs e)
        {
            string email = Email.Text.Trim();
            string firstName = FirstName.Text.Trim();
            string lastName = LastName.Text.Trim();
            string phoneNumber = PhoneNumber.Text.Trim();
            string address = Address.Text.Trim();
            string city = City.Text.Trim();
            string state = State.SelectedValue;
            string zipCode = ZipCode.Text.Trim();

            OrderDetails orderDetails = new OrderDetails
            {
                Email = email,
                FirstName = firstName,
                LastName = lastName,
                PhoneNumber = phoneNumber,
                Address = address,
                City = city,
                State = state,
                ZipCode = zipCode
            };

            Session["OrderDetails"] = orderDetails;

            Session["PurchasedItems"] = Session["Cart"];

            Session["Cart"] = null;

            Response.Redirect("~/Order.aspx");
        }
    }
}
