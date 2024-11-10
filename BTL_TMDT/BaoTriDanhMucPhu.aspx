<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="BaoTriDanhMucPhu.aspx.cs" Inherits="admin.BaoTriDanhMucPhu" %>
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
        }




        .btnEdit {
            background-color: #FF3030;
            color: white; 
            border: none;  
            padding: 10px 20px; 
            cursor: pointer;  
            border-radius: 5px;  
        }

        .btnDelete {
            background-color: #FF3030;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }


</style>




    <form id="form1" runat="server">
        <asp:GridView ID="GridView_danhmucphu" CssClass="gridview-custom" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="MaDanhMucPhu" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView_danhmucphu_SelectedIndexChanged" OnRowDeleting="GridView_danhmucphu_RowDeleting" Width="489px">
            <Columns>
                <asp:BoundField DataField="MaDanhMucPhu" HeaderText="MaDanhMucPhu" InsertVisible="False" ReadOnly="True" SortExpression="MaDanhMucPhu" />
                <asp:BoundField DataField="TenDanhMuc" HeaderText="TenDanhMuc" SortExpression="TenDanhMuc" />
                <asp:BoundField DataField="MoTa" HeaderText="MoTa" SortExpression="MoTa" />
                <asp:CheckBoxField DataField="Visible" HeaderText="Visible" SortExpression="Visible" />
                <asp:BoundField DataField="MaDanhMucChinh" HeaderText="MaDanhMucChinh" SortExpression="MaDanhMucChinh" />


                <asp:TemplateField>
                    <itemtemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Sửa" CssClass="btnEdit" PostBackUrl='<%# "SuaDanhMucPhu.aspx?MaDanhMucPhu=" + Eval("MaDanhMucPhu") %>' />
                    </ItemTemplate>
                </asp:TemplateField>






                <asp:CommandField ShowDeleteButton="True" />






            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CuaHangSachDBConnectionString4 %>" DeleteCommand="DELETE FROM [DanhMucPhu] WHERE [MaDanhMucPhu] = @MaDanhMucPhu" InsertCommand="INSERT INTO [DanhMucPhu] ([TenDanhMuc], [MoTa], [Visible], [MaDanhMucChinh]) VALUES (@TenDanhMuc, @MoTa, @Visible, @MaDanhMucChinh)" SelectCommand="SELECT * FROM [DanhMucPhu]" UpdateCommand="UPDATE [DanhMucPhu] SET [TenDanhMuc] = @TenDanhMuc, [MoTa] = @MoTa, [Visible] = @Visible, [MaDanhMucChinh] = @MaDanhMucChinh WHERE [MaDanhMucPhu] = @MaDanhMucPhu">
            <DeleteParameters>
                <asp:Parameter Name="MaDanhMucPhu" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="TenDanhMuc" Type="String" />
                <asp:Parameter Name="MoTa" Type="String" />
                <asp:Parameter Name="Visible" Type="Boolean" />
                <asp:Parameter Name="MaDanhMucChinh" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="TenDanhMuc" Type="String" />
                <asp:Parameter Name="MoTa" Type="String" />
                <asp:Parameter Name="Visible" Type="Boolean" />
                <asp:Parameter Name="MaDanhMucChinh" Type="Int32" />
                <asp:Parameter Name="MaDanhMucPhu" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>










        <div style="margin-left: 20px; font-family: 'Public Sans', sans-serif; font-weight: bold;" runat="server">
            <h5>Thêm Danh Mục Phụ</h5>

            <table>
                <tr>
                    <td>Tên Danh Mục:</td>
                    <td>
                        <asp:TextBox ID="txtTenDanhMuc" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Mô Tả:</td>
                    <td>
                        <asp:TextBox ID="txtMoTa" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Danh Mục Chính:</td>
                    <td>
                        <asp:DropDownList ID="ddlDanhMucChinh" runat="server"></asp:DropDownList>
                    </td>
                </tr>

                <tr>
                    <td>Visible:</td>
                    <td>
                        <asp:CheckBox ID="chkVisible" runat="server"></asp:CheckBox>
                    </td>
                </tr>

            </table>
        </div>

        <div style="margin-left: 20px;">
            <asp:Button ID="btnLuu" runat="server" Text="Lưu" OnClick="btnLuu_Click" />
            <asp:Literal ID="ltThongBao" runat="server"></asp:Literal>
        </div>




    </form>







</asp:Content>
