using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_TMDT
{
    public partial class TrangThai : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        protected void BindGridView()
        {
            tt.DataSource = data.GetDonHangData();
            tt.DataBind();
        }

        protected void tt_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            tt.PageIndex = e.NewPageIndex;
            // Rebind your data here or call your data binding method
            BindGridView(); // Replace BindGridView() with your actual method name
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            foreach (GridViewRow row in tt.Rows)
            {
                // Lấy DropDownList trong mỗi dòng của GridView
                DropDownList ddlUpdateStatus = (DropDownList)row.FindControl("ddlUpdateStatus");

                // Lấy giá trị đã chọn từ DropDownList
                string newStatus = ddlUpdateStatus.SelectedValue;

                // Lấy giá trị của cột khóa chính (Mã đơn hàng) để xác định đơn hàng cần cập nhật
                int maDonHang = int.Parse(row.Cells[0].Text);

                // Cập nhật trạng thái đơn hàng vào cơ sở dữ liệu
                UpdateOrderStatus(connectionString, maDonHang, newStatus);
            }
            BindGridView();
        }

        private void UpdateOrderStatus(string connectionString, int maDonHang, string newStatus)
        {
            // Chuỗi truy vấn SQL để cập nhật trạng thái đơn hàng
            string query = "UPDATE DonHang SET TrangThai = @TrangThai WHERE MaDonHang = @MaDonHang";

            // Mở kết nối đến cơ sở dữ liệu
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Tạo đối tượng Command
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Thêm các tham số
                    command.Parameters.AddWithValue("@TrangThai", newStatus);
                    command.Parameters.AddWithValue("@MaDonHang", maDonHang);

                    // Mở kết nối
                    connection.Open();

                    // Thực hiện câu lệnh cập nhật
                    int rowsAffected = command.ExecuteNonQuery();

                    connection.Close();
                }
            }
        }

        protected void dtgOrderShipment_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Lấy ra giá trị trạng thái từ dòng hiện tại của GridView
                string status = DataBinder.Eval(e.Row.DataItem, "TrangThai").ToString();

                // Tìm và lấy ra DropDownList trong dòng hiện tại của GridView
                DropDownList ddlUpdateStatus = (DropDownList)e.Row.FindControl("ddlUpdateStatus");

                // Thiết lập giá trị được chọn cho DropDownList dựa trên trạng thái của đơn hàng
                ddlUpdateStatus.SelectedValue = status;
            }
        }

        

    }
}