<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="BaoTriDanhMuc.aspx.cs" Inherits="admin.BaoTriDanhMuc" %>
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
           margin-left: 20px;
            margin-top: 9px;
        }




        

    </style>


    <form id="form1" runat="server">
        <h5 class="card-title m-3">Bảo Trì Danh Mục Chính </h5>
        <asp:GridView ID="GridView_danhmucchinh" runat="server" AllowPaging="True" AllowSorting="True" CssClass="gridview-custom" AutoGenerateColumns="False" DataKeyNames="MaDanhMucChinh" DataSourceID="SqlDataSource1" Width="399px" OnRowDeleting="GridView_danhmucchinh_RowDeleting">
            <Columns>
                <asp:BoundField DataField="MaDanhMucChinh" HeaderText="Mã Danh Mục Chính" InsertVisible="False" ReadOnly="True" SortExpression="MaDanhMucChinh" />
                <asp:BoundField DataField="TenDanhMuc" HeaderText="Tên Danh Mục" SortExpression="TenDanhMuc" />
                <asp:BoundField DataField="MoTa" HeaderText="Mô Tả" SortExpression="MoTa" />
                <asp:CheckBoxField DataField="Visible" HeaderText="Visible" SortExpression="Visible" />
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />

            </Columns>
        </asp:GridView> 
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CuaHangSachDBConnectionString4 %>" DeleteCommand="DELETE FROM [DanhMucChinh] WHERE [MaDanhMucChinh] = @MaDanhMucChinh" InsertCommand="INSERT INTO [DanhMucChinh] ([TenDanhMuc], [MoTa], [Visible]) VALUES (@TenDanhMuc, @MoTa, @Visible)" SelectCommand="SELECT * FROM [DanhMucChinh]" UpdateCommand="UPDATE [DanhMucChinh] SET [TenDanhMuc] = @TenDanhMuc, [MoTa] = @MoTa, [Visible] = @Visible WHERE [MaDanhMucChinh] = @MaDanhMucChinh">
            <DeleteParameters>
                <asp:Parameter Name="MaDanhMucChinh" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="TenDanhMuc" Type="String" />
                <asp:Parameter Name="MoTa" Type="String" />
                <asp:Parameter Name="Visible" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="TenDanhMuc" Type="String" />
                <asp:Parameter Name="MoTa" Type="String" />
                <asp:Parameter Name="Visible" Type="Boolean" />
                <asp:Parameter Name="MaDanhMucChinh" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:Panel ID="PanelAddCategory" style="margin-left: 20px; font-family: 'Public Sans', sans-serif; font-weight: bold;" runat="server" DefaultButton="ButtonAdd_DanhMucChinh">
            <h6>Thêm Danh Mục Chính</h6>
            <table>
                <tr>
                    <td>Tên Danh Mục:</td>
                    <td>
                        <asp:TextBox ID="TextBoxTenDanhMuc" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Mô Tả:</td>
                    <td>
                        <asp:TextBox ID="TextBoxMoTa" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Visible:</td>
                    <td>
                        <asp:CheckBox ID="CheckBoxVisible" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="ButtonAdd_DanhMucChinh" runat="server" Text="Thêm" OnClick="ButtonAdd_DanhMucChinh_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>





        










        















    </form>
</asp:Content>
