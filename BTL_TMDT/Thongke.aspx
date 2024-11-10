<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Master.Master" AutoEventWireup="true" CodeBehind="Thongke.aspx.cs" Inherits="BTL_TMDT.Thongke" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="home" runat="server">
    
    <!DOCTYPE html>

<html>
<head>
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <style>
        td{
            padding:5px;
        }
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

    </style>

    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/plugins.min.css" />
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />

    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <meta charset="utf-8">
  </head>

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <body>
    <form id="form1" runat="server">
        <h5 class="card-title m-3">Thống kê doanh thu </h5>

        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="card border-left-primary shadow h-80 py-2 m-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1" style="display: inline-block; white-space: nowrap;">
                                        Đã bán
                                        <span style="display: inline-block;color: red;">
                                            <asp:Panel ID="thoigianban" runat="server"></asp:Panel>
                                        </span>
                                    </div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                        <asp:Panel ID="slDay" runat="server">
                                             <asp:Literal ID="Literalban" runat="server"></asp:Literal>

                                        </asp:Panel>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <span class="stamp stamp-md bg-success me-3">
                                        <i class="fa fa-shopping-cart"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-left-primary shadow h-80 py-2 m-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1" style="display: inline-block; white-space: nowrap;">
                                        Doanh thu
                                        <span style="display: inline-block;color: red;">
                                            <asp:Panel ID="thoigiandt" runat="server"></asp:Panel>
                                        </span>
                                    </div>

                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                        <asp:Panel ID="doanhthu" runat="server">
                                                    <asp:Literal ID="contentLiteral" runat="server"></asp:Literal>
                                        </asp:Panel>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <i class="icon-wallet text-success fa-3x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h6><b>In báo cáo</b></h6>
                                </div>

                            </div>
                            <div class="progress progress-sm">
                                <div class="progress-bar bg-secondary w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-evenly mt-2">
                                <asp:Button ID="btnExportToPdf" runat="server" Text="Export to PDF" OnClick="btnExportToPdf_Click" class="btn btn-primary" />

                                <asp:Button ID="btnExportToExcel" runat="server" Text="Export to Excel" OnClick="btnExportToExcel_Click" class="btn btn-success" />


                            </div>

                        </div>
                    </div>
                </div>

                
            </div>
        </div>
        <h5 class="card-title m-3">Thông tin đơn hàng 
    <asp:DropDownList ID="ddlDateRange" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDateRange_SelectedIndexChanged">
        <asp:ListItem Text="Hôm nay" Value="Today"></asp:ListItem>
        <asp:ListItem Text="Hôm qua" Value="Yesterday"></asp:ListItem>
        <asp:ListItem Text="7 ngày qua" Value="7days"></asp:ListItem>
    </asp:DropDownList>
        </h5>
        <div class="card-body m-3">
            <asp:Panel ID="pnlNoSales" runat="server" Visible="false">
                <h5 class="card-title">Thông báo</h5>
                <p style="color: red;">Chưa có sản phẩm nào được bán trong ngày !</p>
            </asp:Panel>
        </div>
        <div class="view m-3">
            

            <asp:GridView AutoGenerateColumns="false" GridLines="None" CssClass="table datatable" runat="server" ID="grvRecentSale"
                AllowPaging="true" PageSize="10" OnPageIndexChanging="grvRecentSale_PageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="MaDonHang" HeaderText="Mã đơn hàng" />
                    <asp:BoundField DataField="ThoiGianDatHang" HeaderText="Thời gian đặt hàng" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="HoTen" HeaderText="Họ tên" />
                    <asp:BoundField DataField="TenSach" HeaderText="Tên Sách" />
                    <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" />
                    <asp:BoundField DataField="TongGiaTri" HeaderText="Tổng giá trị" />
                    <asp:TemplateField HeaderText="Trạng thái đơn hàng">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("TrangThai") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
               <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" />
            </asp:GridView>
        </div>
        
        <h5 class="card-title m-3">Thống kê số lượng, doanh thu theo tháng</h5>

        <div class="row row-card-no-pd m-3">
              <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
                  <div class="card-body">
                    <div class="d-flex justify-content-between">
                      <div>
                        <h6><b>Tháng</b></h6>
                        <p class="text-muted">
                            <asp:DropDownList ID="revThang" runat="server" AutoPostBack="true" OnSelectedIndexChanged="revThang_SelectedIndexChanged" >
                                <asp:ListItem Text="Tháng 1" Value="t1"></asp:ListItem>
                                <asp:ListItem Text="Tháng 2" Value="t2"></asp:ListItem>
                                <asp:ListItem Text="Tháng 3" Value="t3"></asp:ListItem>
                                <asp:ListItem Text="Tháng 4" Value="t4"></asp:ListItem>
                                <asp:ListItem Text="Tháng 5" Value="t5"></asp:ListItem>
                                <asp:ListItem Text="Tháng 6" Value="t6"></asp:ListItem>
                                <asp:ListItem Text="Tháng 7" Value="t7"></asp:ListItem>
                                <asp:ListItem Text="Tháng 8" Value="t8"></asp:ListItem>
                                <asp:ListItem Text="Tháng 9" Value="t9"></asp:ListItem>
                                <asp:ListItem Text="Tháng 10" Value="10"></asp:ListItem>
                                <asp:ListItem Text="Tháng 11" Value="t11"></asp:ListItem>
                                <asp:ListItem Text="Tháng 12" Value="t12"></asp:ListItem>                                
                            </asp:DropDownList>

                        </p>
                          
                              <%--<h6><b>Năm</b></h6>
                          <asp:DropDownList ID="NambyThang" runat="server" AutoPostBack="true" OnSelectedIndexChanged="NambyThang_SelectedIndexChanged">
                            </asp:DropDownList>--%>
                          
                      </div>
                    </div>                    
                  </div>
                </div>
              </div>

              <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
                  <div class="card-body">
                    <div class="d-flex justify-content-between">
                      <div>
                        <h6><b>Tổng đơn hàng</b></h6>
                        <p class="text-muted">
                            <asp:Panel ID="pnThang" runat="server"></asp:Panel>
                        </p>
                      </div>                     
                    </div>                   
                  </div>
                </div>
              </div>
              <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
                  <div class="card-body">
                    <div class="d-flex justify-content-between">
                      <div>
                        <h6><b>Tổng doanh thu</b></h6>
                        <p class="text-muted">
                            <asp:Panel ID="SumDoanhThuThang" runat="server"></asp:Panel>
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-12 col-sm-6 col-md-6 col-xl-3">
   <div class="card">
     <div class="card-body">
       <div class="d-flex justify-content-between">
         <div>
           <h6><b>In báo cáo</b></h6>
         </div>
         
       </div>
       <div class="progress progress-sm">
         <div class="progress-bar bg-secondary w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
       </div>
       <div class="d-flex justify-content-between mt-2">
         <button type="button" class="btn btn-primary">PDF</button>
         <button type="button" class="btn btn-success">EXEL</button>

       </div>
     </div>
   </div>
 </div>
            </div>

     <h5 class="card-title m-3">Thống kê số lượng, doanh thu theo năm</h5>
        <div class="row row-card-no-pd m-3">
            <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6><b>Năm</b></h6>
                                <p class="text-muted">
                                    <asp:DropDownList ID="revNam" runat="server" AutoPostBack="true" OnSelectedIndexChanged="revNam_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-md-6 col-xl-3">
                <div class="card">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h6><b>Tổng đơn hàng</b></h6>
                        <p class="text-muted">
                            <asp:Panel ID="pnNam" runat="server"></asp:Panel>
                        </p>
                    </div>
                </div>
                
            </div>
        </div>
                </div>
        <div class="col-12 col-sm-6 col-md-6 col-xl-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h6><b>Tổng doanh thu</b></h6>
                            <p class="text-muted">
                                <asp:Panel ID="SumDoanhThuNam" runat="server"></asp:Panel>
                            </p>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
        
            <div class="col-12 col-sm-6 col-md-6 col-xl-3">
   <div class="card">
     <div class="card-body">
       <div class="d-flex justify-content-between">
         <div>
           <h6><b>In báo cáo</b></h6>
         </div>
         
       </div>
       <div class="progress progress-sm">
         <div class="progress-bar bg-secondary w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
       </div>
       <div class="d-flex justify-content-between mt-2">
         <button type="button" class="btn btn-primary">PDF</button>
         <button type="button" class="btn btn-success">EXEL</button>

       </div>
     </div>
   </div>
 </div>
            </div>

    </form>
    

    <script src="assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="assets/js/core/popper.min.js"></script>
    <script src="assets/js/core/bootstrap.min.js"></script>
    <!-- Chart JS -->
    <script src="assets/js/plugin/chart.js/chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
    <!-- jQuery Scrollbar -->
    <script src="assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <!-- Kaiadmin JS -->
    <script src="assets/js/kaiadmin.min.js"></script>
    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="assets/js/setting-demo2.js"></script>
    </body>
</html>
</asp:Content>
