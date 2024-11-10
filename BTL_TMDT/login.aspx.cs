using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_TMDT
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            // Chuỗi kết nối CSDL của bạn
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Câu truy vấn kiểm tra tên tài khoản và mật khẩu
                string sql = "SELECT COUNT(*) FROM TaiKhoan WHERE TenDangNhap = @Username AND MatKhau = @Password";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    try
                    {
                        conn.Open();
                        int userCount = (int)cmd.ExecuteScalar();

                        if (userCount > 0)
                        {
                            // Đăng nhập thành công
                            Session["Username"] = username;
                            Response.Redirect("Thongke.aspx"); // Chuyển hướng đến trang chủ
                        }
                        else
                        {
                            // Đăng nhập thất bại
                            Response.Write("<script>alert('Tài khoản hoặc mật khẩu không đúng!');</script>");
                        }
                    }
                    catch (Exception ex)
                    {
                        // Xử lý lỗi
                        lblErrorMessage.Text = "Có lỗi xảy ra: " + ex.Message;
                    }
                }
            }
        }
    }
}