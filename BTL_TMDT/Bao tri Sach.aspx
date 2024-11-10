<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="Bao tri Sach.aspx.cs" Inherits="admin.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="home" runat="server">
    <style type="text/css">
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
            background-color: #FF3030; /* Màu nền */
            color: white; /* Màu chữ */
            border: none; /* Xóa viền */
            padding: 10px 20px; /* Khoảng cách trên dưới và trái phải */
            cursor: pointer; /* Cursor khi di chuột qua nút */
            border-radius: 5px; /* Bo tròn góc */
        }

</style>

    <form id="form1" runat="server">

        <div style="margin-left: 20px;">
            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Tìm Kiếm" OnClick="btnSearch_Click" />
        </div>
        



        <div>

                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="MaSach" DataSourceID="SqlDataSource1" CssClass="gridview-custom" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" >
                                <Columns>
                                    <asp:BoundField DataField="MaSach" HeaderText="Mã sách" InsertVisible="False" ReadOnly="True" SortExpression="MaSach" />
                                    <asp:BoundField DataField="TenSach" HeaderText="Tên sách" SortExpression="TenSach" />
                                    <%--<asp:BoundField DataField="AnhSach" HeaderText="Ảnh sách" SortExpression="AnhSach" />--%>
                                    <asp:BoundField DataField="GiaGoc" HeaderText="Giá gốc" SortExpression="GiaGoc" />
                                    <asp:BoundField DataField="GiaBan" HeaderText="Giá bán" SortExpression="GiaBan" />
                                    <asp:BoundField DataField="SoLuongDaBan" HeaderText="Sô lượng đã bán" SortExpression="SoLuongDaBan" />
                                    <asp:BoundField DataField="SoLuongConDu" HeaderText="Số lượng còn dư" SortExpression="SoLuongConDu" />
                                    <asp:BoundField DataField="TomTat" HeaderText="Tóm tắt" SortExpression="TomTat" />
                                    <asp:BoundField DataField="NhaXuatBan" HeaderText="Nhà xuất bản" SortExpression="NhaXuatBan" />
                                    <asp:BoundField DataField="NamXuatBan" HeaderText="Năm xuất bản" SortExpression="NamXuatBan" />
                                    <asp:BoundField DataField="HinhThuc" HeaderText="Hình thức" SortExpression="HinhThuc" />
                                    <asp:BoundField DataField="SoTrang" HeaderText="Số trang" SortExpression="SoTrang" />
                                    <asp:BoundField DataField="KichThuoc" HeaderText="Kích thước" SortExpression="KichThuoc" />
                                    <asp:BoundField DataField="TrongLuong" HeaderText="Trọng lượng" SortExpression="TrongLuong" />
                                    <asp:BoundField DataField="MaTacGia" HeaderText="Mã tác giả " SortExpression="MaTacGia" />
                                    <asp:BoundField DataField="MaDanhMuc" HeaderText="Mã danh mục" SortExpression="MaDanhMuc" />
                                    <asp:CheckBoxField DataField="Visible" HeaderText="Hiển thị" SortExpression="Visible" />


                                    

                                    <asp:TemplateField>                                     
                                        <ItemTemplate>                                                                            
                                            <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="delete-button-class" OnClientClick="return confirm('Bạn có chắc muốn xóa không?');"></asp:LinkButton>
                                        </ItemTemplate>
                                        
                                        <ItemTemplate>                                          
                                            <img src='<%# Eval("AnhSach", "image/{0}") %>' style="width:100px; height:150px;" alt="Book Image" />
                                        </ItemTemplate>

                                    </asp:TemplateField>


                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="EditButton" runat="server" Text="Edit" CssClass="btnEdit" CommandName="Edit" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' />
                                        </ItemTemplate>
                                       </asp:TemplateField>


                                    
                                </Columns>         
                            </asp:GridView>



                            <div id="PanelThem" style=" margin-left: 20px; display: grid; grid-template-columns: repeat(0, 1fr); gap: 5px;" runat="server">
                                
                                <asp:TextBox ID="txtNewTenSach" runat="server" placeholder="Nhập tên sách" /> 
                                <asp:RegularExpressionValidator ID="RegexValidatorTenSach" runat="server" ErrorMessage="chỉ được phép chứa chữ cái." ControlToValidate="txtNewTenSach" ValidationExpression="[a-zA-Z0-9\sàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ,.!?;:()]+" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>
                                <asp:FileUpload ID="fileUploadAnhSach" runat="server" />
                                
                                <asp:TextBox ID="txtNewGiaGoc" runat="server" placeholder="Nhập giá gốc" />
                                <br />
                                <asp:RegularExpressionValidator ID="RegexValidatorGiaGoc" runat="server" ErrorMessage="chỉ được nhập số." ControlToValidate="txtNewGiaGoc" ValidationExpression="^\d+(\.\d{1,2})?$" Display="Dynamic" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtNewGiaBan" runat="server" placeholder="Nhập giá bán" /> 
                                <asp:RegularExpressionValidator ID="RegexValidatorGiaBan" runat="server" ErrorMessage="chỉ được nhập số." ControlToValidate="txtNewGiaBan" ValidationExpression="^\d+$" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtNewSoLuongDaBan" runat="server" placeholder="Nhập số lượng đã bán" /> 
                                <asp:RegularExpressionValidator ID="RegexValidatorSoLuongDaBan" runat="server" ErrorMessage="chỉ được nhập số." ControlToValidate="txtNewSoLuongDaBan" ValidationExpression="^\d+$" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtNewSoLuongConDu" runat="server" placeholder="Nhập Số lượng còn dư" />
                                <asp:RegularExpressionValidator ID="RegexValidatorSoLuongConDu" runat="server" ErrorMessage="chỉ được nhập số." ControlToValidate="txtNewSoLuongConDu" ValidationExpression="^\d+$" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtNewTomTat" runat="server" placeholder="Nhập tóm tắt"/>
                                <asp:RegularExpressionValidator ID="RegularExpressionTomTat" runat="server" ErrorMessage="chỉ được phép chứa chữ cái." ControlToValidate="txtNewTomTat" ValidationExpression="[a-zA-Z0-9\sàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ,.!?;:()]+" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>

                                <asp:TextBox ID="txtNewNhaXuatBan" runat="server" placeholder="Nhập nhà xuất bản" />
                                <asp:RegularExpressionValidator ID="RegularExpressionNhaXuatBan" runat="server" ErrorMessage="chỉ được phép chứa chữ cái." ControlToValidate="txtNewNhaXuatBan" ValidationExpression="[a-zA-Z0-9\sàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ,.!?;:()]+" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>

                                <asp:TextBox ID="txtNewNamXuatBan" runat="server" placeholder="nhập năm xuất bản" /> 
                                <asp:RegularExpressionValidator ID="RegularExpressionNamXuatBan" runat="server" ErrorMessage="chỉ được nhập số." ControlToValidate="txtNewNamXuatBan" ValidationExpression="^\d+$" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtNewHinhThuc" runat="server" placeholder="Nhập hình thức" />
                                <asp:RegularExpressionValidator ID="RegularExpressionHinhThuc" runat="server" ErrorMessage="chỉ được phép chứa chữ cái." ControlToValidate="txtNewHinhThuc" ValidationExpression="[a-zA-Z0-9\sàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ,.!?;:()]+" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>

                                <asp:TextBox ID="txtNewSoTrang" runat="server" placeholder="Nhập số trang" /> 
                                <asp:RegularExpressionValidator ID="RegularExpressionSoTrang" runat="server" ErrorMessage="chỉ được nhập số." ControlToValidate="txtNewSoTrang" ValidationExpression="^\d+$" ForeColor="Red" ValidationGroup="AddBookGroup"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtNewKichThuoc" runat="server" placeholder="Nhập kích thước" />
                                <br />

                                <asp:TextBox ID="txtNewTrongLuong" runat="server" placeholder="Nhập trọng lượng" />
                                <br />
                                <!-- Thay thế cho txtNewMaTacGia -->
                                <asp:DropDownList ID="ddlMaTacGia" runat="server">
                                </asp:DropDownList>

                                <!-- Thay thế cho txtNewMaDanhMuc -->
                                <asp:DropDownList ID="ddlMaDanhMuc" runat="server">
                                </asp:DropDownList>
                                <br />

                                <div>
                                    <label for="chkVisible" class="form-check-label">Visible</label>
                                    
                                    <asp:CheckBox ID="chkVisible" runat="server" />
                                    <br />
                                    <br />
                                    <asp:Button ID="Button1" runat="server" Text="Thêm sách mới" OnClick="btnAddBook_Click" CssClass="add-button-class" OnClientClick="return ValidateForm();" ValidationGroup="AddBookGroup" />
                                </div>
                                
                            </div>


                            


                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CuaHangSachDBConnectionString4 %>" InsertCommand="INSERT INTO [Sach] ([TenSach], [AnhSach], [GiaGoc], [GiaBan], [SoLuongDaBan], [SoLuongConDu], [TomTat], [NhaXuatBan], [NamXuatBan], [HinhThuc], [SoTrang], [KichThuoc], [TrongLuong], [MaTacGia], [MaDanhMuc], [Visible]) VALUES (@TenSach, @AnhSach, @GiaGoc, @GiaBan, @SoLuongDaBan, @SoLuongConDu, @TomTat, @NhaXuatBan, @NamXuatBan, @HinhThuc, @SoTrang, @KichThuoc, @TrongLuong, @MaTacGia, @MaDanhMuc, @Visible)" SelectCommand="SELECT * FROM [Sach]" UpdateCommand="UPDATE [Sach] SET [TenSach] = @TenSach, [AnhSach] = @AnhSach, [GiaGoc] = @GiaGoc, [GiaBan] = @GiaBan, [SoLuongDaBan] = @SoLuongDaBan, [SoLuongConDu] = @SoLuongConDu, [TomTat] = @TomTat, [NhaXuatBan] = @NhaXuatBan, [NamXuatBan] = @NamXuatBan, [HinhThuc] = @HinhThuc, [SoTrang] = @SoTrang, [KichThuoc] = @KichThuoc, [TrongLuong] = @TrongLuong, [MaTacGia] = @MaTacGia, [MaDanhMuc] = @MaDanhMuc, [Visible] = @Visible WHERE [MaSach] = @MaSach">


                                <InsertParameters>
                                    <asp:Parameter Name="TenSach" Type="String" />
                                    <asp:Parameter Name="AnhSach" Type="String" />
                                    <asp:Parameter Name="GiaGoc" Type="Decimal" />
                                    <asp:Parameter Name="GiaBan" Type="Decimal" />
                                    <asp:Parameter Name="SoLuongDaBan" Type="Int32" />
                                    <asp:Parameter Name="SoLuongConDu" Type="Int32" />
                                    <asp:Parameter Name="TomTat" Type="String" />
                                    <asp:Parameter Name="NhaXuatBan" Type="String" />
                                    <asp:Parameter Name="NamXuatBan" Type="Int32" />
                                    <asp:Parameter Name="HinhThuc" Type="String" />
                                    <asp:Parameter Name="SoTrang" Type="Int32" />
                                    <asp:Parameter Name="KichThuoc" Type="String" />
                                    <asp:Parameter Name="TrongLuong" Type="Double" />
                                    <asp:Parameter Name="MaTacGia" Type="Int32" />
                                    <asp:Parameter Name="MaDanhMuc" Type="Int32" />
                                    <asp:Parameter Name="Visible" Type="Boolean" />
                                </InsertParameters>

                                <UpdateParameters>
                                    <asp:Parameter Name="TenSach" Type="String" />
                                    <asp:Parameter Name="AnhSach" Type="String" />
                                    <asp:Parameter Name="GiaGoc" Type="Decimal" />
                                    <asp:Parameter Name="GiaBan" Type="Decimal" />
                                    <asp:Parameter Name="SoLuongDaBan" Type="Int32" />
                                    <asp:Parameter Name="SoLuongConDu" Type="Int32" />
                                    <asp:Parameter Name="TomTat" Type="String" />
                                    <asp:Parameter Name="NhaXuatBan" Type="String" />
                                    <asp:Parameter Name="NamXuatBan" Type="Int32" />
                                    <asp:Parameter Name="HinhThuc" Type="String" />
                                    <asp:Parameter Name="SoTrang" Type="Int32" />
                                    <asp:Parameter Name="KichThuoc" Type="String" />
                                    <asp:Parameter Name="TrongLuong" Type="Double" />
                                    <asp:Parameter Name="MaTacGia" Type="Int32" />
                                    <asp:Parameter Name="MaDanhMuc" Type="Int32" />
                                    <asp:Parameter Name="Visible" Type="Boolean" />
                                    <asp:Parameter Name="MaSach" Type="Int32" />
                                </UpdateParameters>


                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtSearch" Name="TenSach" PropertyName="Text" Type="String" DefaultValue="%" />
                                </SelectParameters>


                            </asp:SqlDataSource>
<%--                            <asp:Button ID="btnAddBook" runat="server" Text="Thêm sách mới" OnClick="btnAddBook_Click" CssClass="add-button-class" OnClientClick="return ValidateForm();" ValidationGroup="AddBookGroup"/>--%>
            
        </div>
                          
    </form>



<script>
    document.addEventListener("DOMContentLoaded", function (event) {
        // Thêm thuộc tính 'accept' cho FileUpload control sau khi trang tải xong
        document.getElementById('<%= fileUploadAnhSach.ClientID %>').setAttribute('accept', 'image/png, image/jpeg, image/gif');
    });
</script>

<script type="text/javascript">
    function ValidateForm() {
        // Thực hiện validation cho nhóm 'AddBookGroup'
        var isValid = Page_ClientValidate('AddBookGroup');

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
