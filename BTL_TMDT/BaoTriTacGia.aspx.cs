using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace admin
{
    public partial class BaoTriTacGia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnThemTacGia_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = @"INSERT INTO TacGia (TenTacGia,  MoTa, Visible) VALUES (@TenTacGia, @MoTa, @Visible)";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@TenTacGia", txtTenTacGia.Text);
                    
                    cmd.Parameters.AddWithValue("@MoTa", txtMoTa.Text);
                    cmd.Parameters.AddWithValue("@Visible", chkVisible.Checked);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            // Xóa trắng các trường sau khi thêm
            Response.Write("<script>alert('Thêm thành công');</script>");
            txtTenTacGia.Text = string.Empty;
            
            txtMoTa.Text = string.Empty;
            chkVisible.Checked = false;

            // Tùy chọn: Hiển thị thông báo hoặc làm mới gridView
            // ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Thêm tác giả thành công');", true);
            GridView_tacgia.DataBind(); // Gọi lại nếu bạn muốn cập nhật GridView sau khi thêm
        }

        protected void GridView_tacgia_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maTacGia = Convert.ToInt32(GridView_tacgia.DataKeys[e.RowIndex].Value);

            if (!KiemTraTacGia(maTacGia))
            {
                Response.Write("<script>alert('Tác giả này có liên quan đến sách!');</script>");
                e.Cancel = true; // Hủy bỏ sự kiện xóa
            }
            else
            {
                lblErrorMessage.Visible = false;
                try
                {
                    XoaTacGia(maTacGia);
                    GridView_tacgia.DataBind(); // Cập nhật lại GridView sau khi xóa
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("FK_Sach_TacGia"))
                    {
                        Response.Write("<script>alert('Tác giả này có liên quan đến sách!');</script>");
                    }
                    else
                    {
                        lblErrorMessage.Text = "Đã xảy ra lỗi khi xóa tác giả.";
                        lblErrorMessage.Visible = true;
                    }
                    e.Cancel = true; // Hủy bỏ sự kiện xóa nếu gặp lỗi
                }
                catch (Exception ex)
                {
                    lblErrorMessage.Text = "Đã xảy ra lỗi không xác định.";
                    lblErrorMessage.Visible = true;
                    e.Cancel = true; // Hủy bỏ sự kiện xóa nếu gặp lỗi
                }
            }
        }

        private bool KiemTraTacGia(int maTacGia)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sqlQuery = "SELECT COUNT(*) FROM Sach WHERE MaTacGia = @MaTacGia";
                SqlCommand cmd = new SqlCommand(sqlQuery, conn);
                cmd.Parameters.AddWithValue("@MaTacGia", maTacGia);

                try
                {
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    conn.Close();
                    return count == 0;
                }
                catch (Exception ex)
                {
                    // Xử lý lỗi (ví dụ ghi log)
                    return false;
                }
            }
        }

        private void XoaTacGia(int maTacGia)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sqlQuery = "DELETE FROM TacGia WHERE MaTacGia = @MaTacGia";
                SqlCommand cmd = new SqlCommand(sqlQuery, conn);
                cmd.Parameters.AddWithValue("@MaTacGia", maTacGia);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }



    }
}