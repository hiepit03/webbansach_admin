using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace admin
{
    public partial class BaoTriTaiKhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTenDangNhap.Text) ||
                string.IsNullOrWhiteSpace(txtMatKhau.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtHoTen.Text) ||
                string.IsNullOrWhiteSpace(txtSoDienThoai.Text) ||
                string.IsNullOrWhiteSpace(txtVaiTro.Text) ||
                string.IsNullOrWhiteSpace(txtDiemThuong.Text) )
                {
                    // Hiển thị thông báo lỗi
                    Response.Write("<script>alert('Bạn phải nhập đầy đủ thông tin.');</script>");
                    return; // Thoát sớm khỏi phương thức nếu có thông tin bị thiếu
                }
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO TaiKhoan (TenDangNhap, MatKhau, Email, HoTen, SoDienThoai, VaiTro, DiemThuong) VALUES (@TenDangNhap, @MatKhau, @Email, @HoTen, @SoDienThoai, @VaiTro, @DiemThuong)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@TenDangNhap", txtTenDangNhap.Text);
                    cmd.Parameters.AddWithValue("@MatKhau", txtMatKhau.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@HoTen", txtHoTen.Text);
                    cmd.Parameters.AddWithValue("@SoDienThoai", txtSoDienThoai.Text);
                    cmd.Parameters.AddWithValue("@VaiTro", txtVaiTro.Text);
                    cmd.Parameters.AddWithValue("@DiemThuong", Convert.ToInt32(txtDiemThuong.Text));

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>alert('Thêm thành công');</script>");
                        GridView_taikhoan.DataBind(); // Cập nhật lại GridView
                        
                                              // Xóa trắng các TextBox sau khi thêm thành công
                        txtTenDangNhap.Text = "";
                        txtMatKhau.Text = "";
                        txtEmail.Text = "";
                        txtHoTen.Text = "";
                        txtSoDienThoai.Text = "";
                        txtVaiTro.Text = "";
                        txtDiemThuong.Text = "";
                    }
                    catch (Exception ex)
                    {
                        // Ghi log lỗi hoặc hiển thị thông báo lỗi
                        Response.Write("Có lỗi xảy ra: " + ex.Message);
                    }
                }
            }
        }





    }
}