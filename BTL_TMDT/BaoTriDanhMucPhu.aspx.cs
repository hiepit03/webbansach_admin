using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace admin
{
    public partial class BaoTriDanhMucPhu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillDanhMucChinh();
            }
        }

        protected void GridView_danhmucphu_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        private void FillDanhMucChinh()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT MaDanhMucChinh, TenDanhMuc FROM DanhMucChinh WHERE Visible = 1";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlDanhMucChinh.DataSource = reader;
                        ddlDanhMucChinh.DataTextField = "TenDanhMuc"; // Cột hiển thị tên danh mục
                        ddlDanhMucChinh.DataValueField = "MaDanhMucChinh"; // Giá trị khi chọn
                        ddlDanhMucChinh.DataBind();
                        con.Close();
                        // Thêm một item mặc định vào đầu dropdown
                        ddlDanhMucChinh.Items.Insert(0, new ListItem("--Chọn Danh Mục Chính--", "0"));
                    }
                    catch (Exception ex)
                    {
                        // Ghi log lỗi hoặc hiển thị thông báo
                        ltThongBao.Text = "Có lỗi khi tải danh mục chính: " + ex.Message;
                    }
                }
            }
        }

        protected void GridView_danhmucphu_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maDanhMucPhu = Convert.ToInt32(GridView_danhmucphu.DataKeys[e.RowIndex].Value);

            if (!KiemTraDanhMuc(maDanhMucPhu))
            {
                Response.Write("<script>alert('Danh mục này có chứa sách!');</script>");
                e.Cancel = true; // Hủy bỏ sự kiện xóa
            }
            else
            {

                try
                {
                    XoaDanhMuc(maDanhMucPhu);
                    GridView_danhmucphu.DataBind(); // Cập nhật lại GridView sau khi xóa
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("FK_Sach_MaDanhMuc"))
                    {
                        Response.Write("<script>alert('Tác giả này có liên quan đến sách!');</script>");
                    }
                    else
                    {

                    }
                    e.Cancel = true; // Hủy bỏ sự kiện xóa nếu gặp lỗi
                }
                catch (Exception ex)
                {

                    e.Cancel = true; // Hủy bỏ sự kiện xóa nếu gặp lỗi
                }
            }
        }

        private bool KiemTraDanhMuc(int maDanhMucPhu)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sqlQuery = "SELECT COUNT(*) FROM Sach WHERE MaDanhMuc = @MaDanhMuc";
                SqlCommand cmd = new SqlCommand(sqlQuery, conn);
                cmd.Parameters.AddWithValue("@MaDanhMuc", maDanhMucPhu);

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



        private void XoaDanhMuc(int maDanhMucPhu)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sqlQuery = "DELETE FROM DanhMucPhu WHERE MaDanhMucPhu = @MaDanhMuc";
                SqlCommand cmd = new SqlCommand(sqlQuery, conn);
                cmd.Parameters.AddWithValue("@MaDanhMuc", maDanhMucPhu);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }


        public DataTable GetDanhMucData()
        {
            DataTable dataTable = new DataTable();

            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString; // Thay thế YourConnectionString bằng tên chuỗi kết nối trong web.config của bạn

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT MaDanhMucPhu, TenDanhMuc, MoTa FROM DanhMucPhu"; // Thay thế MaDanhMuc, TenDanhMuc, MoTa với tên cột thực tế của bạn
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    adapter.Fill(dataTable);
                }
            }

            return dataTable;
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTenDanhMuc.Text) ||
                string.IsNullOrWhiteSpace(txtMoTa.Text) ||

                ddlDanhMucChinh.SelectedIndex == 0)
            {
                // Hiển thị thông báo lỗi
                Response.Write("<script>alert('Bạn phải nhập đầy đủ thông tin.');</script>");
                return; // Thoát sớm khỏi phương thức nếu có thông tin bị thiếu
            }
            string tenDanhMuc = txtTenDanhMuc.Text.Trim();
            string moTa = txtMoTa.Text.Trim();
            int maDanhMucChinh = Convert.ToInt32(ddlDanhMucChinh.SelectedValue);
            bool Visible = chkVisible.Checked; // Sử dụng thuộc tính Checked của CheckBox
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sqlQuery = "INSERT INTO DanhMucPhu(TenDanhMuc, MoTa, Visible, MaDanhMucChinh) VALUES(@TenDanhMuc, @MoTa, @Visible, @MaDanhMucChinh)";
                using (SqlCommand cmd = new SqlCommand(sqlQuery, con))
                {
                    cmd.Parameters.AddWithValue("@TenDanhMuc", tenDanhMuc);
                    cmd.Parameters.AddWithValue("@MoTa", moTa);
                    cmd.Parameters.AddWithValue("@MaDanhMucChinh", maDanhMucChinh);
                    cmd.Parameters.AddWithValue("@Visible", Visible); // Thêm giá trị boolean vào danh sách tham số
                    try
                    {
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            GridView_danhmucphu.DataBind();
                            Response.Write("<script>alert('Thêm thành công');</script>");
                            txtTenDanhMuc.Text = string.Empty;
                            txtMoTa.Text = string.Empty;
                            ddlDanhMucChinh.SelectedIndex = 0;
                            chkVisible.Checked = false; // Reset CheckBox
                        }
                        else
                        {
                            ltThongBao.Text = "Có lỗi xảy ra. Vui lòng thử lại.";
                        }
                    }
                    catch (Exception ex)
                    {
                        ltThongBao.Text = "Có lỗi xảy ra: " + ex.Message;
                    }
                }
            }







        }
    }

}