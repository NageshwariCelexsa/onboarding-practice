using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace EmployeeDirectory
{
    public partial class EmployeeDirectory : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployees();
            }
        }

        private void LoadEmployees(string search = "")
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT * FROM Employees
                             WHERE FullName LIKE @Search
                                OR Department LIKE @Search
                             ORDER BY EmployeeID DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Search", "%" + search + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvEmployees.DataSource = dt;
                gvEmployees.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtPosition.Text) ||
                string.IsNullOrWhiteSpace(txtDepartment.Text) ||
                string.IsNullOrWhiteSpace(txtHireDate.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "alert('All fields are required.');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                SqlCommand cmd;

                if (string.IsNullOrEmpty(hfEmployeeID.Value))
                {
                    cmd = new SqlCommand(@"INSERT INTO Employees
                    (FullName,Email,Position,Department,HireDate)
                    VALUES
                    (@FullName,@Email,@Position,@Department,@HireDate)", con);
                }
                else
                {
                    cmd = new SqlCommand(@"UPDATE Employees
                    SET FullName=@FullName,
                        Email=@Email,
                        Position=@Position,
                        Department=@Department,
                        HireDate=@HireDate
                    WHERE EmployeeID=@EmployeeID", con);

                    cmd.Parameters.AddWithValue("@EmployeeID", hfEmployeeID.Value);
                }

                cmd.Parameters.AddWithValue("@FullName", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Position", txtPosition.Text.Trim());
                cmd.Parameters.AddWithValue("@Department", txtDepartment.Text.Trim());
                cmd.Parameters.AddWithValue("@HireDate", txtHireDate.Text);

                cmd.ExecuteNonQuery();
            }

            ClearForm();
            LoadEmployees();
        }

        protected void gvEmployees_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(gvEmployees.DataKeys[e.NewEditIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Employees WHERE EmployeeID=@ID", con);
                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    hfEmployeeID.Value = dr["EmployeeID"].ToString();
                    txtName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtPosition.Text = dr["Position"].ToString();
                    txtDepartment.Text = dr["Department"].ToString();
                    txtHireDate.Text = Convert.ToDateTime(dr["HireDate"]).ToString("yyyy-MM-dd");
                }
            }

            gvEmployees.EditIndex = -1;
        }

        protected void gvEmployees_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvEmployees.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Employees WHERE EmployeeID=@ID", con);
                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadEmployees();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadEmployees(txtSearch.Text.Trim());
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfEmployeeID.Value = "";
            txtName.Text = "";
            txtEmail.Text = "";
            txtPosition.Text = "";
            txtDepartment.Text = "";
            txtHireDate.Text = "";
        }
    }
}