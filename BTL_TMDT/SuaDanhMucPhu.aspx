<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="SuaDanhMucPhu.aspx.cs" Inherits="admin.SuaDanhMucPhu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="home" runat="server">

<style>
   
#form1 {
    display: flex;
    flex-direction: column;
    margin-left: 100px;
    width: 80%; /* Adjust this to control the width of the form */
}

</style>
    
    <form id="form1"   runat="server">
        <h5 class="card-title m-3">Sửa Thông Tin Danh Mục Phụ </h5>
        <div>
            <label for="txtTenDanhMuc">Tên Danh Mục:</label>
            <asp:TextBox ID="txtTenDanhMuc" runat="server"></asp:TextBox>
        </div>
        <div>
            <label for="txtMoTa">Mô Tả:</label>
            <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div>
            <label for="chkVisible">Hiển Thị:</label>
            <asp:CheckBox ID="chkVisible" runat="server" />
        </div> 
        <div>      
            <label for="ddlMaDanhMucChinh">Mã Danh Mục Chính:</label>
            <asp:DropDownList ID="ddlMaDanhMucChinh" runat="server"></asp:DropDownList>
        </div >

        <div style="width: 100px;">
        <asp:Button ID="btnSave" runat="server" Text="Lưu" OnClick="btnSave_Click" />
        </div>
    </form>


</asp:Content>
