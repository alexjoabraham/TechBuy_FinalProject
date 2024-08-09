using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using TechBuy_FinalProject.Model;

namespace TechBuy_FinalProject
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string username = Session["Username"] as string;

                if (!string.IsNullOrEmpty(username))
                {
                    WelcomeMessage.Text = $"<h4 class='welcome-message'>Welcome, {username}!</h4>";
                }

                // Load brands on initial page load
                LoadBrands();
                MobileDropDown.Enabled = false; // Initially disable the Mobile dropdown
            }
        }

        private void LoadBrands()
        {
            using (var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TechBuyConnectionString"].ConnectionString))
            {
                connection.Open();
                using (var command = new SqlCommand("SELECT BrandId, BrandName FROM Brands", connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            BrandDropDown.Items.Add(new ListItem(reader["BrandName"].ToString(), reader["BrandId"].ToString()));
                        }
                    }
                }
            }
        }

        protected void BrandDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            MobileDropDown.Items.Clear();
            MobileDropDown.Items.Add(new ListItem("Select Mobile", "0"));

            string brandId = BrandDropDown.SelectedValue;
            if (brandId != "0")
            {
                LoadMobilesByBrand(brandId);
                MobileDropDown.Enabled = true;
            }
            else
            {
                MobileDropDown.Enabled = false;
            }

            MobilesRepeater.DataSource = null;
            MobilesRepeater.DataBind();
        }

        private void LoadMobilesByBrand(string brandId)
        {
            using (var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TechBuyConnectionString"].ConnectionString))
            {
                connection.Open();
                string query = @"
                    SELECT MobileId, Title, Description, Price, Image 
                    FROM Mobiles 
                    WHERE BrandId = @BrandId
                ";

                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BrandId", brandId);
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            MobileDropDown.Items.Add(new ListItem(reader["Title"].ToString(), reader["MobileId"].ToString()));
                        }
                    }
                }
            }
        }

        protected void MobileDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            string mobileId = MobileDropDown.SelectedValue;
            if (mobileId != "0")
            {
                MobilesByBrandSqlDataSource.SelectParameters["MobileId"].DefaultValue = mobileId;
                MobilesRepeater.DataBind();
            }
            else
            {
                MobilesRepeater.DataSource = null;
                MobilesRepeater.DataBind();
            }
        }

        protected void AddToCartButton_Click(object sender, EventArgs e)
        {
            var button = (Button)sender;
            var repeaterItem = (RepeaterItem)button.NamingContainer;
            var quantityDropDown = (DropDownList)repeaterItem.FindControl("QuantityDropDown");
            var quantityValidator = (CustomValidator)repeaterItem.FindControl("QuantityCustomValidator");
            var mobileId = button.CommandArgument;

            quantityValidator.Validate();

            if (quantityValidator.IsValid)
            {
                int quantity = int.Parse(quantityDropDown.SelectedValue);

                using (var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TechBuyConnectionString"].ConnectionString))
                {
                    connection.Open();
                    using (var command = new SqlCommand("SELECT * FROM Mobiles WHERE MobileId = @MobileId", connection))
                    {
                        command.Parameters.AddWithValue("@MobileId", mobileId);
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                var mobile = new Mobile
                                {
                                    MobileId = reader["MobileId"].ToString(),
                                    Title = reader["Title"].ToString(),
                                    Description = reader["Description"].ToString(),
                                    BrandId = reader["BrandId"].ToString(),
                                    Image = reader["Image"].ToString(),
                                    Price = Convert.ToDecimal(reader["Price"])
                                };
                                var cart = Session["Cart"] as List<Mobile> ?? new List<Mobile>();

                                for (int i = 0; i < quantity; i++)
                                {
                                    cart.Add(mobile);
                                }

                                Session["Cart"] = cart;

                                MessageLabel.Text = "Item(s) added to cart successfully!";
                            }
                        }
                    }
                }
            }
            else
            {
                MessageLabel.Text = "Please select a valid quantity.";
            }
        }

        protected void ValidateQuantity(object source, ServerValidateEventArgs args)
        {
            var validator = (CustomValidator)source;
            var repeaterItem = (RepeaterItem)validator.NamingContainer;
            var quantityDropDown = (DropDownList)repeaterItem.FindControl("QuantityDropDown");
            args.IsValid = quantityDropDown.SelectedValue != "0";
        }
    }
}
