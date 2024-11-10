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
    public partial class SuaDanhMucPhu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsPostBack)
                {
                    FillDdlMaDanhMucChinh();


                    int maDanhMucPhu;
                    if (int.TryParse(Request.QueryString["MaDanhMucPhu"], out maDanhMucPhu))
                    {
                        FillDanhMucPhuInformation(maDanhMucPhu);
                    }
                }
            }
        }
        private void FillDanhMucPhuInformation(int maDanhMucPhu)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();
                    string query = @"SELECT TenDanhMuc, MoTa, Visible, MaDanhMucChinh 
                             FROM DanhMucPhu 
                             WHERE MaDanhMucPhu = @MaDanhMucPhu";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@MaDanhMucPhu", maDanhMucPhu);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtTenDanhMuc.Text = reader["TenDanhMuc"].ToString();
                            txtMoTa.Text = reader["MoTa"].ToString();
                            chkVisible.Checked = Convert.ToBoolean(reader["Visible"]);
                            ddlMaDanhMucChinh.SelectedValue = reader["MaDanhMucChinh"].ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Xử lý lỗi, ví dụ: ghi lại lỗi vào log
                    Console.WriteLine(ex.Message);
                }
            }
        }
        private void FillDdlMaDanhMucChinh()
        {
            DataTable dtDanhMucChinh = new DataTable();

            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT MaDanhMucChinh, TenDanhMuc FROM DanhMucChinh WHERE Visible = 1 ORDER BY TenDanhMuc";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                    con.Open();
                    adapter.Fill(dtDanhMucChinh);
                    con.Close();
                }
                catch (Exception ex)
                {
                    // Log lỗi hoặc xử lý lỗi
                    Console.WriteLine(ex.Message);
                    // Đảm bảo con luôn được đóng ngay cả khi có lỗi
                    if (con.State == ConnectionState.Open)
                    {
                        con.Close();
                    }
                }
            }

            if (dtDanhMucChinh.Rows.Count > 0)
            {
                ddlMaDanhMucChinh.DataSource = dtDanhMucChinh;
                ddlMaDanhMucChinh.DataTextField = "TenDanhMuc"; // Cột bạn muốn hiển thị
                ddlMaDanhMucChinh.DataValueField = "MaDanhMucChinh"; // Giá trị khi chọn một mục
                ddlMaDanhMucChinh.DataBind();
            }

            // Thêm dòng mặc định
            ddlMaDanhMucChinh.Items.Insert(0, new ListItem("-- Chọn Danh Mục Chính --", "0"));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string updateQuery = @"UPDATE DanhMucPhu 
                                SET TenDanhMuc = @TenDanhMuc, 
                                    MoTa = @MoTa, 
                                    Visible = @Visible, 
                                    MaDanhMucChinh = @MaDanhMucChinh 
                                WHERE MaDanhMucPhu = @MaDanhMucPhu";

                SqlCommand cmd = new SqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@TenDanhMuc", txtTenDanhMuc.Text);
                cmd.Parameters.AddWithValue("@MoTa", txtMoTa.Text);
                cmd.Parameters.AddWithValue("@Visible", chkVisible.Checked);
                cmd.Parameters.AddWithValue("@MaDanhMucChinh", int.Parse(ddlMaDanhMucChinh.SelectedValue));
                cmd.Parameters.AddWithValue("@MaDanhMucPhu", int.Parse(Request.QueryString["MaDanhMucPhu"]));

                con.Open();
                int rowsAffected = cmd.ExecuteNonQuery(); // Thực thi và trả về số hàng được cập nhật
                con.Close();

                if (rowsAffected > 0)
                {
                    // Hiển thị thông báo thành công hoặc chuyển hướng người dùng
                    Response.Write("<script>alert('Sửa thành công');</script>");
                    Response.Redirect("BaoTriDanhMucPhu.aspx"); // Ví dụ chuyển hướng về trang danh sách
                }
                else
                {
                    // Hiển thị thông báo lỗi
                    // Ví dụ: lblMessage.Text = "Cập nhật không thành công!";
                }
            }
        }
















    }
}