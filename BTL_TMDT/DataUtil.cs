using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace BTL_TMDT
{
    public class DataUtil
    {
        private readonly SqlConnection con;

        public DataUtil()
        {
            string sqlCon = "Data Source=DESKTOP-SSUV6PV;Initial Catalog=CuaHangSachDB;Integrated Security=True;TrustServerCertificate=True";
            con = new SqlConnection(sqlCon);
        }

        public DataTable GetDonHangData()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT 
                        DH.MaDonHang,
                        TK.HoTen,
                        DH.ThoiGianDatHang,
                        SUM(CTDH.SoLuong) AS SoLuong,
                        DH.TrangThai,
                        DH.PhuongThucThanhToan,
                        DH.TongGiaTri
                    FROM 
                        DonHang DH
                    JOIN 
                        TaiKhoan TK ON DH.MaTaiKhoan = TK.MaTaiKhoan
                    JOIN 
                        ChiTietDonHang CTDH ON DH.MaDonHang = CTDH.MaDonHang
                    GROUP BY 
                        DH.MaDonHang, 
                        TK.HoTen, 
                        DH.ThoiGianDatHang, 
                        DH.TrangThai, 
                        DH.PhuongThucThanhToan, 
                        DH.TongGiaTri
                    ORDER BY 
                        DH.ThoiGianDatHang DESC;", con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    con.Open();
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                // Log exception here or handle it as needed
                throw new Exception("An error occurred while retrieving data: " + ex.Message);
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            return dt;
        }
    }
}
