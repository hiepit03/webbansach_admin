<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="BaoTriTaiKhoan.aspx.cs" Inherits="admin.BaoTriTaiKhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="home" runat="server">

    <style>
                .gridview-custom th a {
            color: black;
            text-decoration: none;
            font-weight: bold;
        }

        .gridview-custom {
            width: auto; /* Cho phép GridView mở rộng theo nội dung */
            white-space: nowrap; /* Ngăn chặn tự xuống hàng của nội dung trong cell */
        }

        .gridview-custom th, .gridview-custom td {
            overflow: hidden; /* Ẩn bất kỳ nội dung nào vượt quá kích thước của cell */
            text-overflow: ellipsis; /* Hiển thị dấu ba chấm nếu nội dung bị cắt ngắn */
        }
        .gridview-custom {
            border: 1px solid black;
            font-family: 'Public Sans', sans-serif;
        }

        .gridview-custom th, .gridview-custom td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        .gridview-custom th {
            background-color: #f2f2f2;
        }
        .gridview-custom {
           margin-left: 100px;
        }

    </style>



    <form id="form1" runat="server">
        <asp:GridView ID="GridView_taikhoan" style="margin-left: 100px;" CssClass="gridview-custom" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="MaTaiKhoan" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="MaTaiKhoan" HeaderText="MaTaiKhoan" InsertVisible="False" ReadOnly="True" SortExpression="MaTaiKhoan" />
                <asp:BoundField DataField="TenDangNhap" HeaderText="TenDangNhap" SortExpression="TenDangNhap" />
                <asp:BoundField DataField="MatKhau" HeaderText="MatKhau" SortExpression="MatKhau" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="HoTen" HeaderText="HoTen" SortExpression="HoTen" />
                <asp:BoundField DataField="SoDienThoai" HeaderText="SoDienThoai" SortExpression="SoDienThoai" />
                <asp:BoundField DataField="VaiTro" HeaderText="VaiTro" SortExpression="VaiTro" />
                <asp:BoundField DataField="DiemThuong" HeaderText="DiemThuong" SortExpression="DiemThuong" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CuaHangSachDBConnectionString4 %>" DeleteCommand="DELETE FROM [TaiKhoan] WHERE [MaTaiKhoan] = @MaTaiKhoan" InsertCommand="INSERT INTO [TaiKhoan] ([TenDangNhap], [MatKhau], [Email], [HoTen], [SoDienThoai], [VaiTro], [DiemThuong]) VALUES (@TenDangNhap, @MatKhau, @Email, @HoTen, @SoDienThoai, @VaiTro, @DiemThuong)" SelectCommand="SELECT * FROM [TaiKhoan]" UpdateCommand="UPDATE [TaiKhoan] SET [TenDangNhap] = @TenDangNhap, [MatKhau] = @MatKhau, [Email] = @Email, [HoTen] = @HoTen, [SoDienThoai] = @SoDienThoai, [VaiTro] = @VaiTro, [DiemThuong] = @DiemThuong WHERE [MaTaiKhoan] = @MaTaiKhoan">
            <DeleteParameters>
                <asp:Parameter Name="MaTaiKhoan" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="TenDangNhap" Type="String" />
                <asp:Parameter Name="MatKhau" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="HoTen" Type="String" />
                <asp:Parameter Name="SoDienThoai" Type="String" />
                <asp:Parameter Name="VaiTro" Type="String" />
                <asp:Parameter Name="DiemThuong" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="TenDangNhap" Type="String" />
                <asp:Parameter Name="MatKhau" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="HoTen" Type="String" />
                <asp:Parameter Name="SoDienThoai" Type="String" />
                <asp:Parameter Name="VaiTro" Type="String" />
                <asp:Parameter Name="DiemThuong" Type="Int32" />
                <asp:Parameter Name="MaTaiKhoan" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>




          <div style =" margin-left: 100px; width:450px; display: grid; grid-template-columns: repeat(0, 1fr); gap: 5px;" runnat="server" >
            <h2>Thêm Tài Khoản</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
            <label>Tên Đăng Nhập:</label>
            <asp:TextBox ID="txtTenDangNhap" runat="server"></asp:TextBox>
            <label>Mật khẩu:</label>
            <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password"></asp:TextBox>
            <label>Email:</label>
            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            <label>Họ Tên:</label>
            <asp:TextBox ID="txtHoTen" runat="server"></asp:TextBox>
            <label>Số Điện Thoại:</label>
            <asp:TextBox ID="txtSoDienThoai" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegexValidatorSoDienThoai" runat="server" ErrorMessage="chỉ được nhập số." ControlToValidate="txtSoDienThoai" ValidationExpression="^\d+(\.\d{1,2})?$" Display="Dynamic" ForeColor="Red" ValidationGroup="AddTK"></asp:RegularExpressionValidator>

            <label>Vai Trò:</label>
            <asp:TextBox ID="txtVaiTro" runat="server"></asp:TextBox>
            <label>Điểm Thưởng:</label>
            <asp:TextBox ID="txtDiemThuong" runat="server"></asp:TextBox>
            
            <asp:Button ID="btnThem" runat="server" Text="Thêm" OnClick="btnThem_Click" OnClientClick="return ValidateForm();" ValidationGroup="AddTK" />

        </div>




    </form>


<script type="text/javascript">
    function ValidateForm() {
        // Thực hiện validation cho nhóm 'AddBookGroup'
        var isValid = Page_ClientValidate('AddTK');

        // Kiểm tra nếu validation thất bại
        if (!isValid) {
            alert("Đảm bảo tất cả các trường đã được điền đúng. Hãy kiểm tra lại thông tin bạn đã nhập.");
            // Có thể thêm mã để xử lý thêm, ví dụ như scroll tới phần tử lỗi đầu tiên
            scrollToValidationError();
            return false; // Ngăn chặn việc submit form
        }

        // Nếu tất cả điều kiện validation được thoả mãn, cho phép form được submit
        return true;
    }

    function scrollToValidationError() {
        // Tìm phần tử đầu tiên có lỗi và scroll tới đó
        var errorElements = document.querySelectorAll('.validation-error');
        if (errorElements.length > 0) {
            errorElements[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }
</script>

</asp:Content>
