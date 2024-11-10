<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="SuaSach.aspx.cs" Inherits="admin.SuaSach" %>
<asp:Content ID="Content1" ContentPlaceHolderID="home" runat="server">


<style>
    .form-field {
    display: flex;
    flex-direction: column; /* Stack elements vertically */
    max-width: 700px; /* Adjust according to your requirement */
    gap: 10px; /* Spacing between elements */
    margin-bottom: 20px; /* Spacing after each field */
}

.form-container {
    display: flex;
    flex-direction: column;
    margin-left: 100px;
    width: 100%; /* Adjust this to control the width of the form */
}
</style>



    <form runat="server">
        <h5 class="card-title m-3">Sửa thông tin sách</h5>
<div class="form-container">
        <h2>Chỉnh Sửa Thông Tin Sách</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="text-danger"></asp:Label>

        <div class="form-field" runat="server">
            <asp:Label ID="lblTenSach" runat="server" Text="Tên Sách: "></asp:Label>
            <asp:TextBox ID="txtTenSach" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


    <div class="form-field">
        
        <asp:Label ID="lblAnhSach" runat="server" Text="Ảnh Sách: "></asp:Label>
        <%--<asp:TextBox ID="txtAnhSach" runat="server" CssClass="form-control"></asp:TextBox>--%>
        <asp:Image ID="Image1" runat="server" Height="100px" Width="100px" />
        <asp:FileUpload ID="fileUploadAnhSach" runat="server" />

    </div>

    


        <div class="form-field">
            <asp:Label ID="lblGiaGoc" runat="server" Text="Giá Gốc: "  ></asp:Label>
            <asp:TextBox ID="txtGiaGoc" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="form-field">
            <asp:Label ID="lblGiaBan" runat="server" Text="Giá Bán: "></asp:Label>
            <asp:TextBox ID="txtGiaBan" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="form-field">
            <asp:Label ID="lblSoLuongDaBan" runat="server" Text="Số lượng đã bán: "></asp:Label>
            <asp:TextBox ID="txtSoLuongDaBan" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
        </div>

        <div class="form-field">
            <asp:Label ID="lblSoLuongConDu" runat="server" Text="Số lượng còn dư "></asp:Label>
            <asp:TextBox ID="txtSoLuongConDu" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="form-field">
            <asp:Label ID="lblTomTat" runat="server" Text="Tóm tắt: "></asp:Label>
            <asp:TextBox ID="txtTomTat" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="form-field">
            <asp:Label ID="lblNhaXuatBan" runat="server" Text="Nhà Xuất Bản: "></asp:Label>
            <asp:TextBox ID="txtNhaXuatBan" runat="server" CssClass="form-control"></asp:TextBox>
        </div>



        <div class="form-field">
            <asp:Label ID="lblNamXuatBan" runat="server" Text="Năm Xuất Bản: "></asp:Label>
            <asp:TextBox ID="txtNamXuatBan" runat="server" CssClass="form-control"></asp:TextBox>
        </div>




        <div class="form-field">
            <asp:Label ID="lblHinhThuc" runat="server" Text="Hình thức: "></asp:Label>
            <asp:TextBox ID="txtHinhThuc" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="form-field">
            <asp:Label ID="lblSoTrang" runat="server" Text="Số Trang: "></asp:Label>
            <asp:TextBox ID="txtSoTrang" runat="server" CssClass="form-control"></asp:TextBox>
        </div>



        <div class="form-field">
            <asp:Label ID="lblKichThuoc" runat="server" Text="Kích Thước: "></asp:Label>
            <asp:TextBox ID="txtKichThuoc" runat="server" CssClass="form-control"></asp:TextBox>
        </div>




        <div class="form-field">
            <asp:Label ID="lblTrongLuong" runat="server" Text="Trọng Lượng: "></asp:Label>
            <asp:TextBox ID="txtTrongLuong" runat="server" CssClass="form-control"></asp:TextBox>
        </div>




        <asp:Label ID="lblMâTcGia" runat="server" Text="Mã Tác Giả: "></asp:Label>
        <asp:DropDownList ID="ddlMaTacGia" runat="server">
        </asp:DropDownList>



        <br />
        <br />
        <asp:Label ID="lblMaDanhMuc" runat="server" Text="Mã Danh Mục: "></asp:Label>
        <asp:DropDownList ID="ddlMaDanhMuc" runat="server">
        </asp:DropDownList>


        <div>
            <label for="chkVisible" class="form-check-label">Visible</label>
            <asp:CheckBox ID="chkVisible" runat="server" />
            <br />
        </div>
       
        






        <!-- Thêm các trường khác tương tự -->
        <div style="margin-top:20px;">
            <asp:Button ID="btnLuu" runat="server" Text="Lưu Thay Đổi" OnClick="btnLuu_Click" CssClass="btn btn-primary" />
            <asp:Button ID="btnHuy" runat="server" Text="Hủy Bỏ" OnClick="btnHuy_Click" CssClass="btn btn-secondary" />

         
        </div>



    </div>


        </form>
   

<script>
    document.addEventListener("DOMContentLoaded", function (event) {
        // Thêm thuộc tính 'accept' cho FileUpload control sau khi trang tải xong
        document.getElementById('<%= fileUploadAnhSach.ClientID %>').setAttribute('accept', 'image/png, image/jpeg, image/gif');
});
</script>







</asp:Content>
