using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_TMDT
{
    public partial class KhongBanDuoc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView(3); // Default to top 3 least selling books
            }
        }

        protected void ddlTopCount_SelectedIndexChanged(object sender, EventArgs e)
        {
            int topCount = int.Parse(ddlTopCount.SelectedValue);
            BindGridView(topCount);
        }

        protected void top5sale_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            top5sale.PageIndex = e.NewPageIndex;
            BindGridView(int.Parse(ddlTopCount.SelectedValue));
        }

        private void BindGridView(int topCount)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = $@"
                SELECT TOP {topCount} 
                    s.MaSach, 
                    s.TenSach, 
                    s.AnhSach, 
                    s.GiaBan, 
                    s.SoLuongDaBan, 
                    s.SoLuongConDu, 
                    dm.TenDanhMuc,
                    s.NhaXuatBan,
                    s.NamXuatBan
                FROM Sach s
                JOIN DanhMucChinh dm ON s.MaDanhMuc = dm.MaDanhMucChinh
                ORDER BY s.SoLuongDaBan ASC"; // Order by ascending to get least selling books

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    top5sale.DataSource = dt;
                    top5sale.DataBind();
                }
            }
        }
    }
}