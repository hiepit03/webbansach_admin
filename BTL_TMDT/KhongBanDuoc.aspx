<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="KhongBanDuoc.aspx.cs" Inherits="BTL_TMDT.KhongBanDuoc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="home" runat="server">

    <head runat="server">
    <title>Least Selling Books</title>
    <style>
        .table.datatable {
            width: 100%;
            border-collapse: collapse;
        }

        .table.datatable th, .table.datatable td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .table.datatable th {
            background-color: #f2f2f2;
        }
        form {
            margin: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h5 class="card-title my-3">Danh sách các sản phẩm không bán được</h5>
        <div class="my-3">
            <asp:DropDownList ID="ddlTopCount" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTopCount_SelectedIndexChanged">
                <asp:ListItem Text="Top 3" Value="3" />
                <asp:ListItem Text="Top 5" Value="5" />
            </asp:DropDownList>
        </div>
        <asp:GridView AutoGenerateColumns="false" GridLines="None" CssClass="table datatable" runat="server" ID="top5sale" OnPageIndexChanging="top5sale_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="MaSach" HeaderText="Mã sách" />
                <asp:BoundField DataField="TenSach" HeaderText="Tên sách" />
                <asp:TemplateField HeaderText="Hình ảnh">
                    <ItemTemplate>
                        <img src='<%# Eval("AnhSach", "image/{0}") %>' style="width:100px; height:150px;" alt="Book Image" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="GiaBan" HeaderText="Giá bán" DataFormatString="{0:C}" />
                <asp:BoundField DataField="SoLuongDaBan" HeaderText="Số lượng đã bán" />
                <asp:BoundField DataField="SoLuongConDu" HeaderText="Số lượng còn dư" />
                <asp:BoundField DataField="TenDanhMuc" HeaderText="Tên danh mục" />
                <asp:BoundField DataField="NhaXuatBan" HeaderText="Nhà xuất bản" />
                <asp:BoundField DataField="NamXuatBan" HeaderText="Năm xuất bản" />
            </Columns>
        </asp:GridView>
    </form>
</body>

</asp:Content>
