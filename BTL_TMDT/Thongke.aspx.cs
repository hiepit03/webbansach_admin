
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
using System.Text;

namespace BTL_TMDT
{
    public partial class Thongke : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateYearDropdown();

                // Bind the GridView initially for "Today"
                BindGridView("Today");
                revThang.SelectedIndexChanged += new EventHandler(revThang_SelectedIndexChanged);
                loadScreen();
            }
        }

        private void loadScreen()
        {
            string selectedValue = ddlDateRange.SelectedValue;
            BindGridView(selectedValue);
            string selectedMonth = revThang.SelectedValue;
            LoadOrderDataThang(selectedMonth);
            string selectedYear = revNam.SelectedValue;
            LoadOrderDataNam(selectedYear);
        }

        protected void ddlDateRange_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadScreen();
        }

        protected void grvRecentSale_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvRecentSale.PageIndex = e.NewPageIndex;
            loadScreen();
        }



          

        private void BindGridView(string dateRange)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Query to get the order details
                string query = @"SELECT 
                    dh.MaDonHang, 
                    dh.ThoiGianDatHang, 
                    tk.HoTen, 
                    s.TenSach, 
                    ctdh.SoLuong,
                    dh.TongGiaTri, 
                    dh.TrangThai
                FROM 
                    DonHang dh
                INNER JOIN 
                    ChiTietDonHang ctdh ON dh.MaDonHang = ctdh.MaDonHang
                INNER JOIN 
                    Sach s ON ctdh.MaSach = s.MaSach
                INNER JOIN 
                    TaiKhoan tk ON dh.MaTaiKhoan = tk.MaTaiKhoan";

                // Query to get the total quantity sold and the distinct dates
                string totalQuantityAndDateQuery = @"SELECT 
                                        SUM(ctdh.SoLuong) AS TotalQuantity, 
                                        MIN(CAST(dh.ThoiGianDatHang AS DATE)) AS StartDate,
                                        MAX(CAST(dh.ThoiGianDatHang AS DATE)) AS EndDate
                                     FROM 
                                        DonHang dh
                                     INNER JOIN 
                                        ChiTietDonHang ctdh ON dh.MaDonHang = ctdh.MaDonHang";

                // Query to get the total revenue
                string totalRevenueQuery = @"SELECT 
                                SUM(dh.TongGiaTri) AS TotalRevenue
                             FROM 
                                DonHang dh
                             ";

                // Append date filter based on selected value
                string dateFilter = string.Empty;
                string dateText = string.Empty;
                switch (dateRange)
                {
                    case "Today":
                        dateFilter = " WHERE CAST(dh.ThoiGianDatHang AS DATE) = CAST(GETDATE() AS DATE)";
                        DateTime currentTime = DateTime.Now;
                        dateText = currentTime.ToString("dd/MM/yyyy");
                        break;
                    case "Yesterday":
                        dateFilter = " WHERE CAST(dh.ThoiGianDatHang AS DATE) = CAST(GETDATE() - 1 AS DATE)";
                        break;
                    case "7Days":
                        dateFilter = " WHERE dh.ThoiGianDatHang >= DATEADD(DAY, -7, CAST(GETDATE() AS DATE))";
                        DateTime endDate = DateTime.Now;
                        DateTime startDate = endDate.AddDays(-7);
                        dateText = $"{startDate:dd/MM/yyyy} - {endDate:dd/MM/yyyy}";
                        break;
                    default:
                        break;
                }

                query += dateFilter;
                totalQuantityAndDateQuery += dateFilter;
                totalRevenueQuery += dateFilter;

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            pnlNoSales.Visible = true;
                            grvRecentSale.Visible = false;
                        }
                        else
                        {
                            pnlNoSales.Visible = false;
                            grvRecentSale.Visible = true;
                            grvRecentSale.DataSource = dt;
                            grvRecentSale.DataBind();
                        }
                    }
                }

                // Get the total quantity sold and the dates
                using (SqlCommand totalQuantityAndDateCmd = new SqlCommand(totalQuantityAndDateQuery, con))
                {
                    con.Open();
                    SqlDataReader reader = totalQuantityAndDateCmd.ExecuteReader();
                    string quantityAndDateText = "";
                    if (reader.Read())
                    {
                        int totalQuantity = reader["TotalQuantity"] != DBNull.Value ? Convert.ToInt32(reader["TotalQuantity"]) : 0;
                        DateTime startDate = reader["StartDate"] != DBNull.Value ? Convert.ToDateTime(reader["StartDate"]) : DateTime.MinValue;
                        DateTime endDate = reader["EndDate"] != DBNull.Value ? Convert.ToDateTime(reader["EndDate"]) : DateTime.MinValue;

                        if (string.IsNullOrEmpty(dateText))
                        {
                            dateText = startDate == endDate ? startDate.ToString("dd/MM/yyyy") : $"{startDate:dd/MM/yyyy} - {endDate:dd/MM/yyyy}";
                        }
                        quantityAndDateText = $"Tổng số sách đã bán: {totalQuantity}";
                    }
                    reader.Close();
                    con.Close();

                    // Display the dates in thoigian panel
                    thoigianban.Controls.Clear();
                    thoigianban.Controls.Add(new Literal { Text = dateText });
                    thoigiandt.Controls.Clear();
                    thoigiandt.Controls.Add(new Literal { Text = dateText });

                    // Display the total items sold in slDay panel
                    //slDay.Controls.Clear();
                    //slDay.Controls.Add(new Literal { Text = quantityAndDateText });
                    Literalban.Text = quantityAndDateText;


                    // Get the total revenue
                    using (SqlCommand totalRevenueCmd = new SqlCommand(totalRevenueQuery, con))
                    {
                        con.Open();
                        object revenueResult = totalRevenueCmd.ExecuteScalar();
                        con.Close();

                        decimal totalRevenue = revenueResult != DBNull.Value ? Convert.ToDecimal(revenueResult) : 0;
                        string formattedTotalRevenue = $"{totalRevenue:C}";

                        // Display total revenue in doanhthu panel
                        //doanhthu.Controls.Clear();
                        //doanhthu.Controls.Add(new Literal { Text = $"{totalRevenue:C}" });
                        contentLiteral.Text = formattedTotalRevenue;

                    }
                }
            }
        }



        protected void revThang_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadScreen();
        }

        
        

        private void LoadOrderDataThang(string monthValue)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;
            string dateFilter = string.Empty;

            switch (monthValue)
            {
                case "t1":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 1";
                    break;
                case "t2":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 2";
                    break;
                case "t3":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 3";
                    break;
                case "t4":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 4";
                    break;
                case "t5":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 5";
                    break;
                case "t6":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 6";
                    break;
                case "t7":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 7";
                    break;
                case "t8":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 8";
                    break;
                case "t9":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 9";
                    break;
                case "t10":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 10";
                    break;
                case "t11":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 11";
                    break;
                case "t12":
                    dateFilter = " WHERE MONTH(dh.ThoiGianDatHang) = 12";
                    break;
                default:
                    break;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = $@"
                SELECT 
                    COUNT(MaDonHang) AS TotalOrders, 
                    ISNULL(SUM(TongGiaTri), 0) AS TotalRevenue 
                FROM DonHang dh
                {dateFilter}";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        int totalOrdersmonth = reader.GetInt32(0);
                        decimal totalRevenue = reader.GetDecimal(1);

                        pnThang.Controls.Clear();
                        SumDoanhThuThang.Controls.Clear();

                        if (totalOrdersmonth == 0)
                        {
                            pnThang.Controls.Add(new Literal { Text = "Không có đơn hàng nào trong tháng này." });
                            SumDoanhThuThang.Controls.Add(new Literal { Text = "Không có doanh thu trong tháng này." });
                            
                        }
                        else
                        {
                            pnThang.Controls.Add(new Literal { Text = totalOrdersmonth.ToString() });
                            SumDoanhThuThang.Controls.Add(new Literal { Text = totalRevenue.ToString("C2") });
                        }
                    }
                }
            }
        }


        private void PopulateYearDropdown()
        {
            // Clear existing items to avoid duplicates
            revNam.Items.Clear();

            // Populate DropDownList with a range of years (e.g., from 2000 to current year)
            int startYear = 2000;
            int currentYear = DateTime.Now.Year;

            for (int year = startYear; year <= currentYear; year++)
            {
                revNam.Items.Add(new System.Web.UI.WebControls.ListItem(year.ToString(), year.ToString()));
            }

            // Set the default selected value to the current year
            revNam.SelectedValue = currentYear.ToString();
        }

        protected void revNam_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadScreen();
        }

        private void LoadOrderDataNam(string yearValue)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;

            string dateFilter = $" WHERE YEAR(dh.ThoiGianDatHang) = {yearValue}";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = $@"
                SELECT 
                    COUNT(MaDonHang) AS TotalOrders, 
                    ISNULL(SUM(TongGiaTri), 0) AS TotalRevenue 
                FROM DonHang dh
                {dateFilter}";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        int totalOrders = reader.GetInt32(0);
                        decimal totalRevenue = reader.GetDecimal(1);

                        pnNam.Controls.Clear();
                        SumDoanhThuNam.Controls.Clear();

                        if (totalOrders == 0)
                        {
                            pnNam.Controls.Add(new Literal { Text = "Không có đơn hàng nào trong năm này." });
                            SumDoanhThuNam.Controls.Add(new Literal { Text = "Không có doanh thu trong năm này." });


                        }
                        else
                        {
                            pnNam.Controls.Add(new Literal { Text = totalOrders.ToString() });
                            SumDoanhThuNam.Controls.Add(new Literal { Text = totalRevenue.ToString("C2") });
                        }
                    }
                }
            }
        }



        protected void btnExportToPdf_Click(object sender, EventArgs e)
        {

            ExportGridToPDF();

        }

        private string GetDoanhThuContent()
        {
            // Accessing the content inside doanhthu panel
            return contentLiteral.Text.Trim();

        }

        private string getSLBAN()
        {
            return Literalban.Text.Trim();
        }


        private void ExportGridToPDF()
        {
            string doanhThuContent = GetDoanhThuContent();
            string daBanContent = getSLBAN();

            // Your existing PDF generation code...
            // Example:
            using (MemoryStream memoryStream = new MemoryStream())
            {
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);

                string fontPath = Server.MapPath("~/Fonts/TIMES.TTF"); //loi font

                // Register font with iTextSharp
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                Font unicodeFont = new Font(baseFont, 12, Font.NORMAL);

                pdfDoc.Open();

                // Add custom text for no data or data present
                if (grvRecentSale.Rows.Count == 0)
                {
                    // Add custom text for no data
                    Paragraph noDataParagraph = new Paragraph("Không có sản phẩm nào được bán hôm nay", unicodeFont)
                    {
                        Alignment = Element.ALIGN_CENTER
                    };
                    pdfDoc.Add(noDataParagraph);
                }
                else
                {
                    // Add custom text
                    Paragraph reportTitle = new Paragraph("Báo cáo thống kê bán hàng", unicodeFont)
                    {
                        Alignment = Element.ALIGN_CENTER
                    };
                    pdfDoc.Add(reportTitle);

                    // Add a blank line
                    pdfDoc.Add(new Paragraph("\n", unicodeFont));

                    // Add doanhThuContent from doanhthu panel
                    string doanhThuText = "Doanh thu:";
                    Paragraph doanhThuParagraph = new Paragraph(doanhThuText + " " + doanhThuContent, unicodeFont);
                    pdfDoc.Add(doanhThuParagraph);

                    pdfDoc.Add(new Paragraph("\n", unicodeFont));
                    pdfDoc.Add(new Paragraph("\n", unicodeFont));

                    string DaBanText = "";
                    Paragraph daBanParagraph = new Paragraph(DaBanText + " " + daBanContent, unicodeFont);
                    pdfDoc.Add(daBanParagraph);

                    pdfDoc.Add(new Paragraph("\n", unicodeFont));
                    pdfDoc.Add(new Paragraph("\n", unicodeFont));


                    PdfPTable pdfTable = new PdfPTable(grvRecentSale.HeaderRow.Cells.Count);

                    // Add header row
                    foreach (TableCell headerCell in grvRecentSale.HeaderRow.Cells)
                    {
                        PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text, unicodeFont));
                        pdfTable.AddCell(pdfCell);
                    }

                    // Add data rows
                    foreach (GridViewRow gridViewRow in grvRecentSale.Rows)
                    {
                        foreach (TableCell tableCell in gridViewRow.Cells)
                        {
                            PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text, unicodeFont));
                            pdfTable.AddCell(pdfCell);
                        }
                    }

                    pdfDoc.Add(pdfTable);
                }

                pdfDoc.Close();

                byte[] bytes = memoryStream.ToArray();
                memoryStream.Close();

                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=BaoCao.pdf");
                Response.Buffer = true;
                Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
                Response.BinaryWrite(bytes);
                Response.End();
            }
        }


        public override void VerifyRenderingInServerForm(Control control)
        {
            // Confirms that an HtmlForm control is rendered for the specified ASP.NET
            // server control at run time.
        }



        protected void btnExportToExcel_Click(object sender, EventArgs e)
        {
            if (grvRecentSale.Rows.Count == 0)
            {
                loadScreen();
            }
            else
            {
                ExportGridToExcel();
            }
        }

        private void ExportGridToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                // To export all pages
                grvRecentSale.AllowPaging = false;
                BindGridView("Today"); // Example date range, replace as needed

                grvRecentSale.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in grvRecentSale.HeaderRow.Cells)
                {
                    cell.BackColor = grvRecentSale.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in grvRecentSale.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = grvRecentSale.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = grvRecentSale.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                grvRecentSale.RenderControl(hw);

                // style to format numbers to string
                string style = @"<style> .textmode { mso-number-format:\@; } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }


    }
}