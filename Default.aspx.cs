using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Reflection;
using System.Web.UI;
using TechBuy_FinalProject.Model;

namespace TechBuy_FinalProject
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMobiles();
            }
        }

        private void BindMobiles()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TechBuyConnectionString"].ConnectionString;
            string query = @"
        SELECT TOP 3 m.MobileId, m.Title, m.Image, m.Price, b.BrandName
        FROM Mobiles m
        JOIN Brands b ON m.BrandId = b.BrandId";

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        var mobiles = new List<Mobile>();
                        while (reader.Read())
                        {
                            mobiles.Add(new Mobile
                            {
                                MobileId = reader["MobileId"].ToString(),
                                Title = reader["Title"].ToString(), // Update this to the correct column name
                                Image = reader["Image"].ToString(),
                                Price = Convert.ToDecimal(reader["Price"]),
                                BrandId = reader["BrandName"].ToString() // Adjust if needed
                            });
                        }

                        MobilesRepeater.DataSource = mobiles;
                        MobilesRepeater.DataBind();
                    }
                }
            }
        }
    }
}
