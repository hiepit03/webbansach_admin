using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

using System.Threading;
using System.Linq;
namespace admin
{
    public partial class SuaSach : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string maSach = Request.QueryString["MaSach"];
                if (!String.IsNullOrEmpty(maSach))
                {
                   
                    FillMaTacGiaDropDownList();
                    FillMaDanhMucDropDownList();
                    LayThongTinSach(maSach);
                }
            }
        }

        private void LayThongTinSach(string maSach)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Sach WHERE MaSach = @MaSach";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MaSach", maSach);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtTenSach.Text = reader["TenSach"].ToString();
                            // Và làm tương tự cho các trường dữ liệu khác

                            // Gán giá trị cho các TextBox và Image tương tự như txtTenSach
                            Image1.ImageUrl = "~/Image/" + reader["AnhSach"].ToString();
                            txtGiaGoc.Text = reader["GiaGoc"].ToString();
                            txtGiaBan.Text = reader["GiaBan"].ToString();
                            txtSoLuongDaBan.Text = reader["SoLuongDaBan"].ToString();
                            txtSoLuongConDu.Text = reader["SoLuongConDu"].ToString();
                            txtTomTat.Text = reader["TomTat"].ToString();
                            txtNhaXuatBan.Text = reader["NhaXuatBan"].ToString();
                            txtNamXuatBan.Text = reader["NamXuatBan"].ToString();
                            txtHinhThuc.Text = reader["HinhThuc"].ToString();
                            txtSoTrang.Text = reader["SoTrang"].ToString();
                            txtKichThuoc.Text = reader["KichThuoc"].ToString();
                            txtTrongLuong.Text = reader["TrongLuong"].ToString();
                            string maTacGia = reader["MaTacGia"].ToString();
                            // Thực hiện sau khi tải danh sách tác giả
                            ddlMaTacGia.SelectedValue = maTacGia;

                            string maDanhMuc = reader["MaDanhMuc"].ToString();
                            // Thực hiện sau khi tải danh sách tác giả
                            ddlMaDanhMuc.SelectedValue = maDanhMuc;
                        }
                    }
                }
            }
        }


        private void FillMaTacGiaDropDownList()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ToString();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT MaTacGia, TenTacGia FROM TacGia WHERE Visible = 1", con);

                con.Open();
                ddlMaTacGia.DataSource = cmd.ExecuteReader();
                ddlMaTacGia.DataTextField = "TenTacGia"; // cột bạn muốn hiển thị
                ddlMaTacGia.DataValueField = "MaTacGia"; // giá trị khi chọn
                ddlMaTacGia.DataBind();

            }
            ddlMaTacGia.Items.Insert(0, new ListItem("--Chọn Tác Giả--", "0"));
        }




        private void FillMaDanhMucDropDownList()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ToString(); // Thay thế YourConnectionString với tên chuỗi kết nối thực của bạn

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT MaDanhMucPhu, TenDanhMuc FROM DanhMucPhu WHERE Visible = 1", con); // Đảm bảo tên cột và bảng chính xác với cơ sở dữ liệu của bạn

                con.Open();
                ddlMaDanhMuc.DataSource = cmd.ExecuteReader();
                ddlMaDanhMuc.DataTextField = "TenDanhMuc"; // cột bạn muốn hiển thị
                ddlMaDanhMuc.DataValueField = "MaDanhMucPhu"; // giá trị khi chọn
                ddlMaDanhMuc.DataBind();


            }
            ddlMaDanhMuc.Items.Insert(0, new ListItem("--Chọn Danh Mục--", "0")); // Thêm lựa chọn không chọn
        }





        string filename;










       
        protected void btnLuu_Click(object sender, EventArgs e)
        {
            

            if (fileUploadAnhSach.HasFile)
            {
                string filePath = Server.MapPath("~/Image/") + fileUploadAnhSach.FileName;
                try
                {
                    fileUploadAnhSach.SaveAs(filePath); // Lưu ảnh vào thư mục Images
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Có lỗi khi tải ảnh: " + ex.Message + "');</script>");
                    return; // Thoát sớm khỏi phương thức nếu có lỗi
                }
                filePath = string.Empty;
                try
                {
                    filename = Path.GetFileName(fileUploadAnhSach.FileName);
                    filePath = Path.Combine("~/Image/", filename);
                    string serverPath = Server.MapPath(filePath);

                    // Lưu file ảnh vào thư mục Images
                    fileUploadAnhSach.SaveAs(serverPath);

                    // Gán tên file (không kèm thư mục) vào tham số của SqlDataSource
                    // Chú ý: Ở đây chỉ gán tên file, không gán cả đường dẫn

                }
                catch (Exception ex2)
                {
                    // Xử lý lỗi ở đây, có thể log lỗi hoặc hiển thị thông báo
                    Response.Write("Có lỗi xảy ra: " + ex2.Message);
                    return; // Dừng việc xử lý nếu có lỗi
                }
            }
            else
            {
                string[] segments = Image1.ImageUrl.Split('/');
                filename = segments.Last();
            }
            string connectionString = ConfigurationManager.ConnectionStrings["CuaHangSachDBConnectionString4"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Sach SET TenSach = @TenSach, AnhSach = @AnhSach, GiaGoc = @GiaGoc, GiaBan = @GiaBan, 
                                 SoLuongDaBan = @SoLuongDaBan, SoLuongConDu = @SoLuongConDu, TomTat = @TomTat,
                                 NhaXuatBan = @NhaXuatBan, NamXuatBan = @NamXuatBan, HinhThuc = @HinhThuc, 
                                 SoTrang = @SoTrang, KichThuoc = @KichThuoc, TrongLuong = @TrongLuong,
                                 MaTacGia = @MaTacGia, MaDanhMuc = @MaDanhMuc, Visible = @Visible
                                 WHERE MaSach = @MaSach";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MaSach", Request.QueryString["MaSach"]);
                    cmd.Parameters.AddWithValue("@TenSach", txtTenSach.Text);
                    cmd.Parameters.AddWithValue("@AnhSach", filename);
                    cmd.Parameters.AddWithValue("@GiaGoc", txtGiaGoc.Text);
                    cmd.Parameters.AddWithValue("@GiaBan", txtGiaBan.Text);
                    cmd.Parameters.AddWithValue("@SoLuongDaBan", txtSoLuongDaBan.Text);
                    cmd.Parameters.AddWithValue("@SoLuongConDu", txtSoLuongConDu.Text);
                    cmd.Parameters.AddWithValue("@TomTat", txtTomTat.Text);
                    cmd.Parameters.AddWithValue("@NhaXuatBan", txtNhaXuatBan.Text);
                    cmd.Parameters.AddWithValue("@NamXuatBan", txtNamXuatBan.Text);
                    cmd.Parameters.AddWithValue("@HinhThuc", txtHinhThuc.Text);
                    cmd.Parameters.AddWithValue("@SoTrang", txtSoTrang.Text);
                    cmd.Parameters.AddWithValue("@KichThuoc", txtKichThuoc.Text);
                    cmd.Parameters.AddWithValue("@TrongLuong", txtTrongLuong.Text);
                    cmd.Parameters.AddWithValue("@MaTacGia", ddlMaTacGia.SelectedValue);
                    cmd.Parameters.AddWithValue("@MaDanhMuc", ddlMaDanhMuc.SelectedValue);
                    cmd.Parameters.AddWithValue("@Visible", chkVisible.Checked);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            Image1.ImageUrl = "~/Image/" + filename;
            // Redirect hoặc thông báo người dùng về kết quả
            
            Response.Write("<script>alert('Thông tin sách đã được cập nhật thành công!');</script>");
            ClientScript.RegisterStartupScript(this.GetType(), "redirect", "setTimeout(function(){ window.location.href = 'Bao tri Sach.aspx'; }, 3000);", true);
        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            Response.Redirect("Bao tri Sach.aspx"); // Redirect người dùng tới trang quản lý sách
        }
    }
}

