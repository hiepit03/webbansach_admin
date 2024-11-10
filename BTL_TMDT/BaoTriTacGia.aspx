<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="BaoTriTacGia.aspx.cs" Inherits="admin.BaoTriTacGia" %>
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
        <asp:GridView ID="GridView_tacgia" runat="server" CssClass="gridview-custom" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="MaTacGia" DataSourceID="SqlDataSource1" OnRowDeleting="GridView_tacgia_RowDeleting">
            <Columns>
                <asp:BoundField DataField="MaTacGia" HeaderText="MaTacGia" InsertVisible="False" ReadOnly="True" SortExpression="MaTacGia" />
                <asp:BoundField DataField="TenTacGia" HeaderText="TenTacGia" SortExpression="TenTacGia" />
                
                <asp:BoundField DataField="MoTa" HeaderText="MoTa" SortExpression="MoTa" />
                <asp:CheckBoxField DataField="Visible" HeaderText="Visible" SortExpression="Visible" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CuaHangSachDBConnectionString4 %>" DeleteCommand="DELETE FROM [TacGia] WHERE [MaTacGia] = @MaTacGia" InsertCommand="INSERT INTO [TacGia] ([TenTacGia], [AnhMinhHoa], [MoTa], [Visible]) VALUES (@TenTacGia, @AnhMinhHoa, @MoTa, @Visible)" SelectCommand="SELECT * FROM [TacGia]" UpdateCommand="UPDATE [TacGia] SET [TenTacGia] = @TenTacGia, [AnhMinhHoa] = @AnhMinhHoa, [MoTa] = @MoTa, [Visible] = @Visible WHERE [MaTacGia] = @MaTacGia">
            <DeleteParameters>
                <asp:Parameter Name="MaTacGia" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="TenTacGia" Type="String" />
               
                <asp:Parameter Name="MoTa" Type="String" />
                <asp:Parameter Name="Visible" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="TenTacGia" Type="String" />
               
                <asp:Parameter Name="MoTa" Type="String" />
                <asp:Parameter Name="Visible" Type="Boolean" />
                <asp:Parameter Name="MaTacGia" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>



          <div style="margin-left: 100px; font-family: 'Public Sans', sans-serif; font-weight: bold;" runat="server">
              <h5>Thêm Tác Giả</h5>

              <table>
                  <tr>
                      <td>Tên Tác Giả:</td>
                      <td>
                          <asp:TextBox ID="txtTenTacGia" runat="server"></asp:TextBox>
                      </td>
                  </tr>
                  
                  <tr>
                      <td>Mô Tả:</td>
                      <td>
                          <asp:TextBox ID="txtMoTa" runat="server"></asp:TextBox>
                      </td>
                  </tr>
                  <tr>
                      <td>Visible:</td>
                      <td>
                          <asp:CheckBox ID="chkVisible" runat="server" Text="TT Hiển Thị" />
                      </td>
                  </tr>
              </table>
               
          </div>

          <div style="margin-left: 390px;">
              <asp:Button ID="btnThemTacGia" runat="server" Text="Thêm Tác Giả" OnClick="btnThemTacGia_Click" />
          </div>

    </form>
</asp:Content>
