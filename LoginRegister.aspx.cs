using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace TechBuy_FinalProject
{
    public partial class LoginRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string username = UsernameTextBox.Text.Trim();
            string password = PasswordTextBox.Text.Trim();

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TechBuyConnectionString"].ConnectionString;
            string query = "SELECT Role FROM Users WHERE Username = @Username AND Password = @Password";

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);

                    var role = command.ExecuteScalar();

                    if (role != null)
                    {
                        if (role.ToString() == "Admin")
                        {
                            Response.Redirect("~/Admin.aspx");
                        }
                        else
                        {
                            Response.Redirect("~/Products.aspx");
                        }
                    }
                    else
                    {
                        // Handle invalid login
                        Response.Write("<script>alert('Invalid username or password');</script>");
                    }
                }
            }
        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            string username = RegisterUsernameTextBox.Text.Trim();
            string password = RegisterPasswordTextBox.Text.Trim();
            string role = RoleDropDownList.SelectedValue;

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TechBuyConnectionString"].ConnectionString;
            string query = "INSERT INTO Users (Username, Password, Role) VALUES (@Username, @Password, @Role)";

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);
                    command.Parameters.AddWithValue("@Role", role);

                    command.ExecuteNonQuery();

                    Response.Write("<script>alert('Registration successful! You can now log in.');</script>");
                }
            }
        }
    }
}
