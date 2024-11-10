<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="TrangThai.aspx.cs" Inherits="BTL_TMDT.TrangThai" %>

<asp:Content ID="Content1" ContentPlaceHolderID="home" runat="server">



        <!-- CSS Files -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/plugins.min.css" />
        <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />

        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link rel="stylesheet" href="assets/css/demo.css" />
        
        <style>
            td{
                padding:10px;
                text-align:left;
            }
        </style>


        <form runat="server">
            <div class="container">
                <div class="page-inner">
                    <div class="page-header">
                        <h3 class="fw-bold mb-3">Trạng thái đơn hàng</h3>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h4 class="card-title m-0">Danh sách đơn hàng</h4>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table
                                            id="basic-datatables"
                                            class="display table table-striped table-hover">
                                            <tbody>
                                                
                                                <asp:GridView ID="tt" runat="server" GridLines="None" CssClass="table dataTable"
                                                    AutoGenerateColumns="false" OnRowDataBound="dtgOrderShipment_RowDataBound"
                                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="tt_PageIndexChanging">

                                                    <Columns>
                                                        <asp:BoundField DataField="MaDonHang" HeaderText="Mã đơn hàng" />
                                                        <asp:BoundField DataField="HoTen" HeaderText="Họ tên" />
                                                        <asp:BoundField DataField="ThoiGianDatHang" HeaderText="Thời gian đặt hàng" DataFormatString="{0:dd/MM/yyyy}" />
                                                        <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" />
                                                        <asp:TemplateField HeaderText="Cập Nhật Trạng Thái">
                                                            <ItemTemplate>
                                                                <asp:DropDownList CssClass="form-select" ID="ddlUpdateStatus" runat="server">
                                                                    <asp:ListItem Text="Chờ Xác Nhận" Value="Chờ xác nhận"></asp:ListItem>
                                                                    <asp:ListItem Text="Đã Xác Nhận" Value="Đã xác nhận"></asp:ListItem>
                                                                    <asp:ListItem Text="Đang vận chuyển" Value="Đang vận chuyển"></asp:ListItem>
                                                                    <asp:ListItem Text="Đã Giao" Value="Đã giao"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="PhuongThucThanhToan" HeaderText="Phương thức thanh toán" />
                                                        <asp:BoundField DataField="TongGiaTri" HeaderText="Tổng giá trị" />
                                                        <asp:TemplateField HeaderText="Cập Nhật">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnUpdateStatus" runat="server" Text="Cập Nhật" CssClass="btn btn-info btn-sm" OnClick="btnUpdateStatus_Click" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>

                                                    <PagerSettings Mode="NumericFirstLast" Position="Bottom" />
                                                    <PagerStyle CssClass="gridview-pager" />

                                                </asp:GridView>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>


        <script src="assets/js/core/jquery-3.7.1.min.js"></script>
        <script src="assets/js/core/popper.min.js"></script>
        <script src="assets/js/core/bootstrap.min.js"></script>

        <!-- jQuery Scrollbar -->
        <script src="assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
        <!-- Datatables -->
        <script src="assets/js/plugin/datatables/datatables.min.js"></script>
        <!-- Kaiadmin JS -->
        <script src="assets/js/kaiadmin.min.js"></script>
        <!-- Kaiadmin DEMO methods, don't include it in your project! -->
        <script src="assets/js/setting-demo2.js"></script>
        
</asp:Content>
