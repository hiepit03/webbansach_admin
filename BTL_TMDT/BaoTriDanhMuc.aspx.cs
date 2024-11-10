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
    public partial class BaoTriDanhMuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }




        protected void GridView_danhmucchinh_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Set the edit index.
            GridView_danhmucchinh.EditIndex = e.NewEditIndex;
            // Bind data to the GridView control.
            BindData();
        }

        protected void GridView_danhmucchinh_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Reset the edit index.
            GridView_danhmucchinh.EditIndex = -1;
            // Bind data to the GridView control.
            BindData();
        }

        protected void GridView_danhmucchinh_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Retrieve the row being edited.
            GridViewRow row = GridView_danhmucchinh.Rows[e.RowIndex];
            if (row != null)
            {
                // Extracting the values from the controls.
                int maDanhMucChinh = Convert.ToInt32(GridView_danhmucchinh.DataKeys[e.RowIndex].Value);
                string tenDanhMuc = (row.FindControl("TextBox_TenDanhMuc") as TextBox).Text;
                string moTa = (row.FindControl("TextBox_MoTa") as TextBox).Text;
                bool visible = (row.FindControl("CheckBox_Visible") as CheckBox).Checked;

                // Updating logic here.
                // Example: Call your method to update the database with the new values.

                // Reset the edit index.
                GridView_danhmucchinh.EditIndex = -1;

                // Re-bind the GridView to show the data after updating.
                BindData();
            }
        }



        private void BindData()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ToString();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM DanhMucChinh", conn); // Đảm bảo câu lệnh SQL và tên bảng đúng
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridView_danhmucchinh.DataSource = dt;
                    GridView_danhmucchinh.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi hoặc ghi log
                Console.WriteLine(ex.Message);
            }
        }

     
       
        protected void ButtonAdd_DanhMucChinh_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TextBoxTenDanhMuc.Text) ||
                string.IsNullOrWhiteSpace(TextBoxMoTa.Text) )
            {
                // Hiển thị thông báo lỗi
                Response.Write("<script>alert('Bạn phải nhập đầy đủ thông tin.');</script>");
                return; // Thoát sớm khỏi phương thức nếu có thông tin bị thiếu
            }
            // Khai báo chuỗi kết nối tới CSDL hoặc sử dụng ConnectionString từ Web.config
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Mở kết nối
                conn.Open();

                // Tạo câu lệnh SQL để thêm dữ liệu
                string sql = @"INSERT INTO [DanhMucChinh] ([TenDanhMuc], [MoTa], [Visible]) VALUES (@TenDanhMuc, @MoTa, @Visible)";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    // Thêm các tham số vào câu lệnh SQL
                    cmd.Parameters.AddWithValue("@TenDanhMuc", TextBoxTenDanhMuc.Text);
                    cmd.Parameters.AddWithValue("@MoTa", TextBoxMoTa.Text);
                    cmd.Parameters.AddWithValue("@Visible", CheckBoxVisible.Checked);

                    // Thực thi câu lệnh
                    int result = cmd.ExecuteNonQuery();

                    // Kiểm tra kết quả
                    if (result > 0)
                    {
                        // Thành công, có thể thông báo hoặc refresh GridView
                        Response.Write("<script>alert('Thêm thành công');</script>");
                        TextBoxTenDanhMuc.Text = string.Empty;
                        TextBoxMoTa.Text    = string.Empty;
                        CheckBoxVisible.Checked = false;
                    }
                    else
                    {
                        // Lỗi, xử lý thông báo
                    }
                }

                // Đóng kết nối
                conn.Close();
            }
            
            // Làm mới dữ liệu trong GridView
            GridView_danhmucchinh.DataBind();
        }


        private bool KiemTraDanhMuc(int maDanhMucChinh)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sqlQuery = "SELECT COUNT(*) FROM DanhMucPhu WHERE MaDanhMucChinh = @MaDanhMucChinh";
                SqlCommand cmd = new SqlCommand(sqlQuery, conn);
                cmd.Parameters.AddWithValue("@MaDanhMucChinh", maDanhMucChinh);

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



        private void XoaDanhMuc(int maDanhMucChinh)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sqlQuery = "DELETE FROM DanhMucChinh WHERE MaDanhMucChinh = @MaDanhMucChinh";
                SqlCommand cmd = new SqlCommand(sqlQuery, conn);
                cmd.Parameters.AddWithValue("@MaDanhMucChinh", maDanhMucChinh);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        protected void GridView_danhmucchinh_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maDanhMucChinh = Convert.ToInt32(GridView_danhmucchinh.DataKeys[e.RowIndex].Value);

            if (!KiemTraDanhMuc(maDanhMucChinh))
            {
                Response.Write("<script>alert('Danh mục này có chứa danh mục phụ!');</script>");
                e.Cancel = true; // Hủy bỏ sự kiện xóa
            }
            else
            {

                try
                {
                    XoaDanhMuc(maDanhMucChinh);
                    GridView_danhmucchinh.DataBind(); // Cập nhật lại GridView sau khi xóa
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("FK_DanhMucPhu_MaDanhMucChinh"))
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
    }
}