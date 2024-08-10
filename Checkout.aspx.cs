using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using TechBuy_FinalProject.Model;

namespace TechBuy_FinalProject
{
    public partial class Checkout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is logged in
            if (Session["Username"] == null)
            {
                Response.Redirect("~/LoginRegister.aspx");
            }

            if (!IsPostBack)
            {
                // Initialize or load any data required for the checkout process
                // For example, load user's cart items
                LoadCartItems();
            }
        }

        private void LoadCartItems()
        {
            // Assuming you have a session variable to store cart items
            var cartItems = Session["CartItems"] as List<Mobile>;

            if (cartItems != null)
            {
                // Example: Display cart items or use a Repeater/GridView to list them
                // Assuming you have a method to bind the items to a control
                BindCartItemsToControl(cartItems);
            }
        }

        private void BindCartItemsToControl(List<Mobile> cartItems)
        {
            // Implement this method based on your specific UI and control
            // For example, bind items to a Repeater or GridView
        }

        protected void PlaceOrderButton_Click(object sender, EventArgs e)
        {
            // Validate the form fields
            if (Page.IsValid)
            {
                // Collect order information
                string email = Email.Text;
                string firstName = FirstName.Text;
                string lastName = LastName.Text;
                string phoneNumber = PhoneNumber.Text;
                string address = Address.Text;
                string city = City.Text;
                string state = State.SelectedValue;
                string zipCode = ZipCode.Text;

                // Handle the order placement logic
                bool isOrderPlaced = PlaceOrder(email, firstName, lastName, phoneNumber, address, city, state, zipCode);

                if (isOrderPlaced)
                {
                    // Clear the cart or update the order status
                    Session["CartItems"] = null;
                    Response.Redirect("~/OrderConfirmation.aspx");
                }
                else
                {
                    // Show error message
                    // Example: Use a Label or JavaScript alert to show an error
                    ShowErrorMessage("There was a problem placing your order. Please try again.");
                }
            }
        }

        private bool PlaceOrder(string email, string firstName, string lastName, string phoneNumber, string address, string city, string state, string zipCode)
        {
            // Implement the order placement logic
            // For example, insert the order into the database and return the success status
            return true; // Placeholder, replace with actual implementation
        }

        private void ShowErrorMessage(string message)
        {
            // Implement this method to display error messages
            // Example: Use a Label control or JavaScript alert
        }
    }
}
