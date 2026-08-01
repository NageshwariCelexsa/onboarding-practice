using System;

namespace _5__Login_Page
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            // Server-side validation
            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                lblMessage.Text = "Username and Password are required.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Dummy credentials
            if (username == "admin" && password == "Password123")
            {
                lblMessage.Text = "Login successful.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMessage.Text = "Invalid username or password.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}