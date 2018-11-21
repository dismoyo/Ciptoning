namespace Dismoyo.Ciptoning.Web.Reports.ReportControls
{
    partial class StockOpnameReportControl
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.tableData = new DevExpress.XtraReports.UI.XRTable();
            this.tableRowData = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableDataProduct = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOnHandGood = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOnHandHold = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOnHandBad = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOpnameConvGood = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOpnameConvHold = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOpnameConvBad = new DevExpress.XtraReports.UI.XRTableCell();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.tableHeaderQtyOnHandBad = new DevExpress.XtraReports.UI.XRLabel();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.pageInfoLeft = new DevExpress.XtraReports.UI.XRPageInfo();
            this.pageInfoRight = new DevExpress.XtraReports.UI.XRPageInfo();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.lblTitle = new DevExpress.XtraReports.UI.XRLabel();
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            this.warehousePICLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.warehousePICSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.approverLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.approverSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.siteAdministratorLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.driverSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderProduct = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOnHand = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOnHandGood = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOnHandHold = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOpnameConv = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOpnameConvGood = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOpnameConvHold = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOpnameConvBad = new DevExpress.XtraReports.UI.XRLabel();
            this.productLotCode = new DevExpress.XtraReports.UI.XRLabel();
            this.tableDataProductLotCode = new DevExpress.XtraReports.UI.XRTableCell();
            this.company = new DevExpress.XtraReports.UI.XRLabel();
            this.warehouseSite = new DevExpress.XtraReports.UI.XRLabel();
            this.documentCodeLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.documentCode = new DevExpress.XtraReports.UI.XRLabel();
            this.referenceNumberLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.referenceNumber = new DevExpress.XtraReports.UI.XRLabel();
            this.transactionDate = new DevExpress.XtraReports.UI.XRLabel();
            this.transactionDateLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.documentStatusNameLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.documentStatusName = new DevExpress.XtraReports.UI.XRLabel();
            this.pic = new DevExpress.XtraReports.UI.XRLabel();
            this.picLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalProducts = new DevExpress.XtraReports.UI.XRLabel();
            this.totalProductsLabel = new DevExpress.XtraReports.UI.XRLabel();
            ((System.ComponentModel.ISupportInitialize)(this.tableData)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.tableData});
            this.Detail.HeightF = 20F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // tableData
            // 
            this.tableData.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableData.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableData.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableData.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.tableData.Name = "tableData";
            this.tableData.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.tableRowData});
            this.tableData.SizeF = new System.Drawing.SizeF(1063F, 20F);
            this.tableData.StylePriority.UseBorderColor = false;
            this.tableData.StylePriority.UseBorders = false;
            this.tableData.StylePriority.UseFont = false;
            this.tableData.StylePriority.UseTextAlignment = false;
            this.tableData.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // tableRowData
            // 
            this.tableRowData.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableDataProduct,
            this.tableDataProductLotCode,
            this.tableDataQtyOnHandGood,
            this.tableDataQtyOnHandHold,
            this.tableDataQtyOnHandBad,
            this.tableDataQtyOpnameConvGood,
            this.tableDataQtyOpnameConvHold,
            this.tableDataQtyOpnameConvBad});
            this.tableRowData.Name = "tableRowData";
            this.tableRowData.Weight = 1D;
            // 
            // tableDataProduct
            // 
            this.tableDataProduct.Name = "tableDataProduct";
            this.tableDataProduct.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataProduct.ProcessDuplicatesMode = DevExpress.XtraReports.UI.ProcessDuplicatesMode.Merge;
            this.tableDataProduct.StylePriority.UsePadding = false;
            this.tableDataProduct.Text = "tableDataProduct";
            this.tableDataProduct.Weight = 3.2872377797261718D;
            // 
            // tableDataQtyOnHandGood
            // 
            this.tableDataQtyOnHandGood.Name = "tableDataQtyOnHandGood";
            this.tableDataQtyOnHandGood.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOnHandGood.StylePriority.UsePadding = false;
            this.tableDataQtyOnHandGood.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOnHandGood.Text = "tableDataQtyOnHandGood";
            this.tableDataQtyOnHandGood.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOnHandGood.Weight = 0.61690788917403716D;
            // 
            // tableDataQtyOnHandHold
            // 
            this.tableDataQtyOnHandHold.Name = "tableDataQtyOnHandHold";
            this.tableDataQtyOnHandHold.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOnHandHold.StylePriority.UsePadding = false;
            this.tableDataQtyOnHandHold.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOnHandHold.Text = "tableDataQtyOnHandHold";
            this.tableDataQtyOnHandHold.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOnHandHold.Weight = 0.61690788927176732D;
            // 
            // tableDataQtyOnHandBad
            // 
            this.tableDataQtyOnHandBad.Name = "tableDataQtyOnHandBad";
            this.tableDataQtyOnHandBad.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOnHandBad.StylePriority.UsePadding = false;
            this.tableDataQtyOnHandBad.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOnHandBad.Text = "tableDataQtyOnHandBad";
            this.tableDataQtyOnHandBad.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOnHandBad.Weight = 0.61690789016819769D;
            // 
            // tableDataQtyOpnameConvGood
            // 
            this.tableDataQtyOpnameConvGood.Name = "tableDataQtyOpnameConvGood";
            this.tableDataQtyOpnameConvGood.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOpnameConvGood.StylePriority.UsePadding = false;
            this.tableDataQtyOpnameConvGood.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOpnameConvGood.Text = "tableDataQtyOpnameConvGood";
            this.tableDataQtyOpnameConvGood.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOpnameConvGood.Weight = 1.0575563729971673D;
            // 
            // tableDataQtyOpnameConvHold
            // 
            this.tableDataQtyOpnameConvHold.Name = "tableDataQtyOpnameConvHold";
            this.tableDataQtyOpnameConvHold.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOpnameConvHold.StylePriority.UsePadding = false;
            this.tableDataQtyOpnameConvHold.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOpnameConvHold.Text = "tableDataQtyOpnameConvHold";
            this.tableDataQtyOpnameConvHold.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOpnameConvHold.Weight = 1.0575563452061365D;
            // 
            // tableDataQtyOpnameConvBad
            // 
            this.tableDataQtyOpnameConvBad.Name = "tableDataQtyOpnameConvBad";
            this.tableDataQtyOpnameConvBad.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOpnameConvBad.StylePriority.UsePadding = false;
            this.tableDataQtyOpnameConvBad.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOpnameConvBad.Text = "tableDataQtyOpnameConvBad";
            this.tableDataQtyOpnameConvBad.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOpnameConvBad.Weight = 1.0575563694526315D;
            // 
            // TopMargin
            // 
            this.TopMargin.HeightF = 50F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 50F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // tableHeaderQtyOnHandBad
            // 
            this.tableHeaderQtyOnHandBad.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOnHandBad.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOnHandBad.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOnHandBad.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOnHandBad.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOnHandBad.LocationFloat = new DevExpress.Utils.PointFloat(633F, 136F);
            this.tableHeaderQtyOnHandBad.Name = "tableHeaderQtyOnHandBad";
            this.tableHeaderQtyOnHandBad.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOnHandBad.SizeF = new System.Drawing.SizeF(70F, 20F);
            this.tableHeaderQtyOnHandBad.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOnHandBad.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOnHandBad.StylePriority.UseBorders = false;
            this.tableHeaderQtyOnHandBad.StylePriority.UseFont = false;
            this.tableHeaderQtyOnHandBad.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOnHandBad.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOnHandBad.Text = "Bad";
            this.tableHeaderQtyOnHandBad.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // PageFooter
            // 
            this.PageFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.pageInfoLeft,
            this.pageInfoRight});
            this.PageFooter.HeightF = 32F;
            this.PageFooter.Name = "PageFooter";
            // 
            // pageInfoLeft
            // 
            this.pageInfoLeft.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pageInfoLeft.ForeColor = System.Drawing.Color.Gray;
            this.pageInfoLeft.LocationFloat = new DevExpress.Utils.PointFloat(6F, 6F);
            this.pageInfoLeft.Name = "pageInfoLeft";
            this.pageInfoLeft.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.pageInfoLeft.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime;
            this.pageInfoLeft.SizeF = new System.Drawing.SizeF(438F, 23F);
            this.pageInfoLeft.StyleName = "PageInfo";
            this.pageInfoLeft.StylePriority.UseFont = false;
            this.pageInfoLeft.StylePriority.UseForeColor = false;
            // 
            // pageInfoRight
            // 
            this.pageInfoRight.AnchorHorizontal = DevExpress.XtraReports.UI.HorizontalAnchorStyles.Right;
            this.pageInfoRight.ForeColor = System.Drawing.Color.Gray;
            this.pageInfoRight.Format = "Page {0} of {1}";
            this.pageInfoRight.LocationFloat = new DevExpress.Utils.PointFloat(625F, 6F);
            this.pageInfoRight.Name = "pageInfoRight";
            this.pageInfoRight.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.pageInfoRight.SizeF = new System.Drawing.SizeF(438F, 23F);
            this.pageInfoRight.StyleName = "PageInfo";
            this.pageInfoRight.StylePriority.UseForeColor = false;
            this.pageInfoRight.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // ReportHeader
            // 
            this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.totalProducts,
            this.totalProductsLabel,
            this.pic,
            this.picLabel,
            this.documentStatusNameLabel,
            this.documentStatusName,
            this.referenceNumberLabel,
            this.referenceNumber,
            this.transactionDate,
            this.transactionDateLabel,
            this.documentCodeLabel,
            this.documentCode,
            this.company,
            this.warehouseSite,
            this.productLotCode,
            this.tableHeaderQtyOnHandHold,
            this.tableHeaderQtyOnHandGood,
            this.tableHeaderQtyOnHand,
            this.tableHeaderProduct,
            this.lblTitle,
            this.tableHeaderQtyOnHandBad,
            this.tableHeaderQtyOpnameConv,
            this.tableHeaderQtyOpnameConvGood,
            this.tableHeaderQtyOpnameConvHold,
            this.tableHeaderQtyOpnameConvBad});
            this.ReportHeader.HeightF = 157F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // lblTitle
            // 
            this.lblTitle.Font = new System.Drawing.Font("Calibri", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTitle.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.lblTitle.LocationFloat = new DevExpress.Utils.PointFloat(6.000005F, 0F);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblTitle.SizeF = new System.Drawing.SizeF(1057F, 33F);
            this.lblTitle.StylePriority.UseFont = false;
            this.lblTitle.StylePriority.UseForeColor = false;
            this.lblTitle.StylePriority.UseTextAlignment = false;
            this.lblTitle.Text = "STOCK OPNAME";
            this.lblTitle.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // PageInfo
            // 
            this.PageInfo.BackColor = System.Drawing.Color.Transparent;
            this.PageInfo.BorderColor = System.Drawing.Color.Black;
            this.PageInfo.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.PageInfo.BorderWidth = 1F;
            this.PageInfo.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.PageInfo.ForeColor = System.Drawing.Color.Black;
            this.PageInfo.Name = "PageInfo";
            // 
            // ReportFooter
            // 
            this.ReportFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.warehousePICLabel,
            this.warehousePICSignatureLabel,
            this.approverLabel,
            this.approverSignatureLabel,
            this.siteAdministratorLabel,
            this.driverSignatureLabel});
            this.ReportFooter.HeightF = 108F;
            this.ReportFooter.Name = "ReportFooter";
            // 
            // warehousePICLabel
            // 
            this.warehousePICLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.warehousePICLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.warehousePICLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 16F);
            this.warehousePICLabel.Name = "warehousePICLabel";
            this.warehousePICLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.warehousePICLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.warehousePICLabel.StylePriority.UseFont = false;
            this.warehousePICLabel.StylePriority.UseForeColor = false;
            this.warehousePICLabel.StylePriority.UseTextAlignment = false;
            this.warehousePICLabel.Text = "Warehouse PIC,";
            this.warehousePICLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // warehousePICSignatureLabel
            // 
            this.warehousePICSignatureLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.warehousePICSignatureLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.warehousePICSignatureLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 84F);
            this.warehousePICSignatureLabel.Name = "warehousePICSignatureLabel";
            this.warehousePICSignatureLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.warehousePICSignatureLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.warehousePICSignatureLabel.StylePriority.UseFont = false;
            this.warehousePICSignatureLabel.StylePriority.UseForeColor = false;
            this.warehousePICSignatureLabel.StylePriority.UseTextAlignment = false;
            this.warehousePICSignatureLabel.Text = "(                                    )";
            this.warehousePICSignatureLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // approverLabel
            // 
            this.approverLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.approverLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.approverLabel.LocationFloat = new DevExpress.Utils.PointFloat(190F, 16F);
            this.approverLabel.Name = "approverLabel";
            this.approverLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.approverLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.approverLabel.StylePriority.UseFont = false;
            this.approverLabel.StylePriority.UseForeColor = false;
            this.approverLabel.StylePriority.UseTextAlignment = false;
            this.approverLabel.Text = "Approved by,";
            this.approverLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // approverSignatureLabel
            // 
            this.approverSignatureLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.approverSignatureLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.approverSignatureLabel.LocationFloat = new DevExpress.Utils.PointFloat(190F, 84F);
            this.approverSignatureLabel.Name = "approverSignatureLabel";
            this.approverSignatureLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.approverSignatureLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.approverSignatureLabel.StylePriority.UseFont = false;
            this.approverSignatureLabel.StylePriority.UseForeColor = false;
            this.approverSignatureLabel.StylePriority.UseTextAlignment = false;
            this.approverSignatureLabel.Text = "(                                    )";
            this.approverSignatureLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // siteAdministratorLabel
            // 
            this.siteAdministratorLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.siteAdministratorLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.siteAdministratorLabel.LocationFloat = new DevExpress.Utils.PointFloat(380F, 16F);
            this.siteAdministratorLabel.Name = "siteAdministratorLabel";
            this.siteAdministratorLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.siteAdministratorLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.siteAdministratorLabel.StylePriority.UseFont = false;
            this.siteAdministratorLabel.StylePriority.UseForeColor = false;
            this.siteAdministratorLabel.StylePriority.UseTextAlignment = false;
            this.siteAdministratorLabel.Text = "Administrator,";
            this.siteAdministratorLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // driverSignatureLabel
            // 
            this.driverSignatureLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.driverSignatureLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.driverSignatureLabel.LocationFloat = new DevExpress.Utils.PointFloat(380F, 84F);
            this.driverSignatureLabel.Name = "driverSignatureLabel";
            this.driverSignatureLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.driverSignatureLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.driverSignatureLabel.StylePriority.UseFont = false;
            this.driverSignatureLabel.StylePriority.UseForeColor = false;
            this.driverSignatureLabel.StylePriority.UseTextAlignment = false;
            this.driverSignatureLabel.Text = "(                                    )";
            this.driverSignatureLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // tableHeaderProduct
            // 
            this.tableHeaderProduct.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderProduct.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderProduct.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderProduct.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderProduct.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderProduct.LocationFloat = new DevExpress.Utils.PointFloat(0F, 116F);
            this.tableHeaderProduct.Name = "tableHeaderProduct";
            this.tableHeaderProduct.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderProduct.SizeF = new System.Drawing.SizeF(373F, 41F);
            this.tableHeaderProduct.StylePriority.UseBackColor = false;
            this.tableHeaderProduct.StylePriority.UseBorderColor = false;
            this.tableHeaderProduct.StylePriority.UseBorders = false;
            this.tableHeaderProduct.StylePriority.UseFont = false;
            this.tableHeaderProduct.StylePriority.UseForeColor = false;
            this.tableHeaderProduct.StylePriority.UseTextAlignment = false;
            this.tableHeaderProduct.Text = "Product";
            this.tableHeaderProduct.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOnHand
            // 
            this.tableHeaderQtyOnHand.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOnHand.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOnHand.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top)));
            this.tableHeaderQtyOnHand.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOnHand.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOnHand.LocationFloat = new DevExpress.Utils.PointFloat(493F, 116F);
            this.tableHeaderQtyOnHand.Name = "tableHeaderQtyOnHand";
            this.tableHeaderQtyOnHand.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOnHand.SizeF = new System.Drawing.SizeF(210F, 20F);
            this.tableHeaderQtyOnHand.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOnHand.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOnHand.StylePriority.UseBorders = false;
            this.tableHeaderQtyOnHand.StylePriority.UseFont = false;
            this.tableHeaderQtyOnHand.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOnHand.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOnHand.Text = "On Hand Qty (Pcs)";
            this.tableHeaderQtyOnHand.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOnHandGood
            // 
            this.tableHeaderQtyOnHandGood.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOnHandGood.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOnHandGood.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOnHandGood.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOnHandGood.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOnHandGood.LocationFloat = new DevExpress.Utils.PointFloat(493F, 136F);
            this.tableHeaderQtyOnHandGood.Name = "tableHeaderQtyOnHandGood";
            this.tableHeaderQtyOnHandGood.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOnHandGood.SizeF = new System.Drawing.SizeF(70F, 20F);
            this.tableHeaderQtyOnHandGood.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOnHandGood.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOnHandGood.StylePriority.UseBorders = false;
            this.tableHeaderQtyOnHandGood.StylePriority.UseFont = false;
            this.tableHeaderQtyOnHandGood.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOnHandGood.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOnHandGood.Text = "Good";
            this.tableHeaderQtyOnHandGood.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOnHandHold
            // 
            this.tableHeaderQtyOnHandHold.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOnHandHold.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOnHandHold.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOnHandHold.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOnHandHold.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOnHandHold.LocationFloat = new DevExpress.Utils.PointFloat(563F, 136F);
            this.tableHeaderQtyOnHandHold.Name = "tableHeaderQtyOnHandHold";
            this.tableHeaderQtyOnHandHold.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOnHandHold.SizeF = new System.Drawing.SizeF(70F, 20F);
            this.tableHeaderQtyOnHandHold.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOnHandHold.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOnHandHold.StylePriority.UseBorders = false;
            this.tableHeaderQtyOnHandHold.StylePriority.UseFont = false;
            this.tableHeaderQtyOnHandHold.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOnHandHold.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOnHandHold.Text = "Hold";
            this.tableHeaderQtyOnHandHold.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOpnameConv
            // 
            this.tableHeaderQtyOpnameConv.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOpnameConv.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOpnameConv.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right)));
            this.tableHeaderQtyOpnameConv.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOpnameConv.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOpnameConv.LocationFloat = new DevExpress.Utils.PointFloat(703F, 116F);
            this.tableHeaderQtyOpnameConv.Name = "tableHeaderQtyOpnameConv";
            this.tableHeaderQtyOpnameConv.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOpnameConv.SizeF = new System.Drawing.SizeF(360F, 20F);
            this.tableHeaderQtyOpnameConv.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOpnameConv.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOpnameConv.StylePriority.UseBorders = false;
            this.tableHeaderQtyOpnameConv.StylePriority.UseFont = false;
            this.tableHeaderQtyOpnameConv.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOpnameConv.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOpnameConv.Text = "Opname Qty (L/M/S)";
            this.tableHeaderQtyOpnameConv.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOpnameConvGood
            // 
            this.tableHeaderQtyOpnameConvGood.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOpnameConvGood.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOpnameConvGood.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOpnameConvGood.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOpnameConvGood.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOpnameConvGood.LocationFloat = new DevExpress.Utils.PointFloat(703F, 136F);
            this.tableHeaderQtyOpnameConvGood.Name = "tableHeaderQtyOpnameConvGood";
            this.tableHeaderQtyOpnameConvGood.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOpnameConvGood.SizeF = new System.Drawing.SizeF(120F, 20F);
            this.tableHeaderQtyOpnameConvGood.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOpnameConvGood.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOpnameConvGood.StylePriority.UseBorders = false;
            this.tableHeaderQtyOpnameConvGood.StylePriority.UseFont = false;
            this.tableHeaderQtyOpnameConvGood.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOpnameConvGood.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOpnameConvGood.Text = "Good";
            this.tableHeaderQtyOpnameConvGood.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOpnameConvHold
            // 
            this.tableHeaderQtyOpnameConvHold.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOpnameConvHold.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOpnameConvHold.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOpnameConvHold.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOpnameConvHold.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOpnameConvHold.LocationFloat = new DevExpress.Utils.PointFloat(823F, 136F);
            this.tableHeaderQtyOpnameConvHold.Name = "tableHeaderQtyOpnameConvHold";
            this.tableHeaderQtyOpnameConvHold.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOpnameConvHold.SizeF = new System.Drawing.SizeF(120F, 20F);
            this.tableHeaderQtyOpnameConvHold.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOpnameConvHold.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOpnameConvHold.StylePriority.UseBorders = false;
            this.tableHeaderQtyOpnameConvHold.StylePriority.UseFont = false;
            this.tableHeaderQtyOpnameConvHold.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOpnameConvHold.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOpnameConvHold.Text = "Hold";
            this.tableHeaderQtyOpnameConvHold.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOpnameConvBad
            // 
            this.tableHeaderQtyOpnameConvBad.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOpnameConvBad.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOpnameConvBad.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOpnameConvBad.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOpnameConvBad.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOpnameConvBad.LocationFloat = new DevExpress.Utils.PointFloat(943F, 136F);
            this.tableHeaderQtyOpnameConvBad.Name = "tableHeaderQtyOpnameConvBad";
            this.tableHeaderQtyOpnameConvBad.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOpnameConvBad.SizeF = new System.Drawing.SizeF(120F, 20F);
            this.tableHeaderQtyOpnameConvBad.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOpnameConvBad.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOpnameConvBad.StylePriority.UseBorders = false;
            this.tableHeaderQtyOpnameConvBad.StylePriority.UseFont = false;
            this.tableHeaderQtyOpnameConvBad.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOpnameConvBad.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOpnameConvBad.Text = "Bad";
            this.tableHeaderQtyOpnameConvBad.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // productLotCode
            // 
            this.productLotCode.BackColor = System.Drawing.Color.LightGray;
            this.productLotCode.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.productLotCode.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.productLotCode.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.productLotCode.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.productLotCode.LocationFloat = new DevExpress.Utils.PointFloat(373F, 116F);
            this.productLotCode.Name = "productLotCode";
            this.productLotCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.productLotCode.SizeF = new System.Drawing.SizeF(120F, 39F);
            this.productLotCode.StylePriority.UseBackColor = false;
            this.productLotCode.StylePriority.UseBorderColor = false;
            this.productLotCode.StylePriority.UseBorders = false;
            this.productLotCode.StylePriority.UseFont = false;
            this.productLotCode.StylePriority.UseForeColor = false;
            this.productLotCode.StylePriority.UseTextAlignment = false;
            this.productLotCode.Text = "Lot Number";
            this.productLotCode.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableDataProductLotCode
            // 
            this.tableDataProductLotCode.Name = "tableDataProductLotCode";
            this.tableDataProductLotCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataProductLotCode.StylePriority.UsePadding = false;
            this.tableDataProductLotCode.Text = "tableDataProductLotCode";
            this.tableDataProductLotCode.Weight = 1.057556395898041D;
            // 
            // company
            // 
            this.company.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.company.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.company.LocationFloat = new DevExpress.Utils.PointFloat(6.000002F, 36F);
            this.company.Name = "company";
            this.company.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.company.SizeF = new System.Drawing.SizeF(390F, 24F);
            this.company.StylePriority.UseFont = false;
            this.company.StylePriority.UseForeColor = false;
            this.company.Text = "[Company]";
            // 
            // warehouseSite
            // 
            this.warehouseSite.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.warehouseSite.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.warehouseSite.LocationFloat = new DevExpress.Utils.PointFloat(6.000002F, 60.00004F);
            this.warehouseSite.Name = "warehouseSite";
            this.warehouseSite.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.warehouseSite.SizeF = new System.Drawing.SizeF(390F, 20F);
            this.warehouseSite.StylePriority.UseFont = false;
            this.warehouseSite.StylePriority.UseForeColor = false;
            this.warehouseSite.Text = "[WarehouseSite]";
            // 
            // documentCodeLabel
            // 
            this.documentCodeLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.documentCodeLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.documentCodeLabel.LocationFloat = new DevExpress.Utils.PointFloat(400F, 40F);
            this.documentCodeLabel.Name = "documentCodeLabel";
            this.documentCodeLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.documentCodeLabel.SizeF = new System.Drawing.SizeF(110F, 20F);
            this.documentCodeLabel.StylePriority.UseFont = false;
            this.documentCodeLabel.StylePriority.UseForeColor = false;
            this.documentCodeLabel.Text = "Document Number:";
            // 
            // documentCode
            // 
            this.documentCode.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.documentCode.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.documentCode.LocationFloat = new DevExpress.Utils.PointFloat(514F, 40F);
            this.documentCode.Name = "documentCode";
            this.documentCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.documentCode.SizeF = new System.Drawing.SizeF(206F, 20F);
            this.documentCode.StylePriority.UseFont = false;
            this.documentCode.StylePriority.UseForeColor = false;
            this.documentCode.Text = "[DocumentCode]";
            // 
            // referenceNumberLabel
            // 
            this.referenceNumberLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.referenceNumberLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.referenceNumberLabel.LocationFloat = new DevExpress.Utils.PointFloat(400F, 79.99995F);
            this.referenceNumberLabel.Name = "referenceNumberLabel";
            this.referenceNumberLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.referenceNumberLabel.SizeF = new System.Drawing.SizeF(110F, 20F);
            this.referenceNumberLabel.StylePriority.UseFont = false;
            this.referenceNumberLabel.StylePriority.UseForeColor = false;
            this.referenceNumberLabel.Text = "Reference Number:";
            // 
            // referenceNumber
            // 
            this.referenceNumber.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.referenceNumber.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.referenceNumber.LocationFloat = new DevExpress.Utils.PointFloat(514F, 79.99995F);
            this.referenceNumber.Name = "referenceNumber";
            this.referenceNumber.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.referenceNumber.SizeF = new System.Drawing.SizeF(206F, 20F);
            this.referenceNumber.StylePriority.UseFont = false;
            this.referenceNumber.StylePriority.UseForeColor = false;
            this.referenceNumber.Text = "[ReferenceNumber]";
            // 
            // transactionDate
            // 
            this.transactionDate.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.transactionDate.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.transactionDate.LocationFloat = new DevExpress.Utils.PointFloat(514F, 60.00001F);
            this.transactionDate.Name = "transactionDate";
            this.transactionDate.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.transactionDate.SizeF = new System.Drawing.SizeF(206F, 20F);
            this.transactionDate.StylePriority.UseFont = false;
            this.transactionDate.StylePriority.UseForeColor = false;
            this.transactionDate.Text = "[TransactionDate]";
            // 
            // transactionDateLabel
            // 
            this.transactionDateLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.transactionDateLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.transactionDateLabel.LocationFloat = new DevExpress.Utils.PointFloat(400F, 60.00001F);
            this.transactionDateLabel.Name = "transactionDateLabel";
            this.transactionDateLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.transactionDateLabel.SizeF = new System.Drawing.SizeF(110F, 20F);
            this.transactionDateLabel.StylePriority.UseFont = false;
            this.transactionDateLabel.StylePriority.UseForeColor = false;
            this.transactionDateLabel.Text = "Transaction Date:";
            // 
            // documentStatusNameLabel
            // 
            this.documentStatusNameLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.documentStatusNameLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.documentStatusNameLabel.LocationFloat = new DevExpress.Utils.PointFloat(724F, 40F);
            this.documentStatusNameLabel.Name = "documentStatusNameLabel";
            this.documentStatusNameLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.documentStatusNameLabel.SizeF = new System.Drawing.SizeF(100F, 20F);
            this.documentStatusNameLabel.StylePriority.UseFont = false;
            this.documentStatusNameLabel.StylePriority.UseForeColor = false;
            this.documentStatusNameLabel.Text = "Status:";
            // 
            // documentStatusName
            // 
            this.documentStatusName.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.documentStatusName.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.documentStatusName.LocationFloat = new DevExpress.Utils.PointFloat(828F, 39.99999F);
            this.documentStatusName.Name = "documentStatusName";
            this.documentStatusName.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.documentStatusName.SizeF = new System.Drawing.SizeF(235F, 20F);
            this.documentStatusName.StylePriority.UseFont = false;
            this.documentStatusName.StylePriority.UseForeColor = false;
            this.documentStatusName.Text = "[DocumentStatusName]";
            // 
            // pic
            // 
            this.pic.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pic.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.pic.LocationFloat = new DevExpress.Utils.PointFloat(70F, 80F);
            this.pic.Name = "pic";
            this.pic.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.pic.SizeF = new System.Drawing.SizeF(326F, 20F);
            this.pic.StylePriority.UseFont = false;
            this.pic.StylePriority.UseForeColor = false;
            this.pic.Text = "[PIC]";
            // 
            // picLabel
            // 
            this.picLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.picLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.picLabel.LocationFloat = new DevExpress.Utils.PointFloat(6.00001F, 79.99995F);
            this.picLabel.Name = "picLabel";
            this.picLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.picLabel.SizeF = new System.Drawing.SizeF(60F, 20F);
            this.picLabel.StylePriority.UseFont = false;
            this.picLabel.StylePriority.UseForeColor = false;
            this.picLabel.Text = "PIC:";
            // 
            // totalProducts
            // 
            this.totalProducts.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalProducts.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalProducts.LocationFloat = new DevExpress.Utils.PointFloat(828F, 79.99998F);
            this.totalProducts.Name = "totalProducts";
            this.totalProducts.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalProducts.SizeF = new System.Drawing.SizeF(235F, 20F);
            this.totalProducts.StylePriority.UseFont = false;
            this.totalProducts.StylePriority.UseForeColor = false;
            this.totalProducts.Text = "[TotalProducts]";
            // 
            // totalProductsLabel
            // 
            this.totalProductsLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalProductsLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalProductsLabel.LocationFloat = new DevExpress.Utils.PointFloat(724.0001F, 79.99995F);
            this.totalProductsLabel.Name = "totalProductsLabel";
            this.totalProductsLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalProductsLabel.SizeF = new System.Drawing.SizeF(100F, 20F);
            this.totalProductsLabel.StylePriority.UseFont = false;
            this.totalProductsLabel.StylePriority.UseForeColor = false;
            this.totalProductsLabel.Text = "Total Products:";
            // 
            // StockOpnameReportControl
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.PageFooter,
            this.ReportHeader,
            this.ReportFooter});
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(50, 50, 50, 50);
            this.PageHeight = 827;
            this.PageWidth = 1169;
            this.PaperKind = System.Drawing.Printing.PaperKind.A4;
            this.StyleSheet.AddRange(new DevExpress.XtraReports.UI.XRControlStyle[] {
            this.PageInfo});
            this.Version = "15.2";
            ((System.ComponentModel.ISupportInitialize)(this.tableData)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
        private DevExpress.XtraReports.UI.XRPageInfo pageInfoLeft;
        private DevExpress.XtraReports.UI.XRPageInfo pageInfoRight;
        private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
        private DevExpress.XtraReports.UI.XRControlStyle PageInfo;
        public DevExpress.XtraReports.UI.XRTable tableData;
        private DevExpress.XtraReports.UI.XRTableRow tableRowData;
        public DevExpress.XtraReports.UI.XRTableCell tableDataProduct;
        private DevExpress.XtraReports.UI.DetailBand Detail;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOnHandGood;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOnHandHold;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOnHandBad;
        public DevExpress.XtraReports.UI.XRLabel lblTitle;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOnHandBad;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOpnameConvGood;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOpnameConvHold;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOpnameConvBad;
        private DevExpress.XtraReports.UI.ReportFooterBand ReportFooter;
        private DevExpress.XtraReports.UI.XRLabel warehousePICLabel;
        private DevExpress.XtraReports.UI.XRLabel warehousePICSignatureLabel;
        private DevExpress.XtraReports.UI.XRLabel approverLabel;
        private DevExpress.XtraReports.UI.XRLabel approverSignatureLabel;
        private DevExpress.XtraReports.UI.XRLabel siteAdministratorLabel;
        private DevExpress.XtraReports.UI.XRLabel driverSignatureLabel;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOnHandHold;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOnHandGood;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOnHand;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderProduct;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOpnameConv;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOpnameConvGood;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOpnameConvHold;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOpnameConvBad;
        private DevExpress.XtraReports.UI.XRLabel productLotCode;
        public DevExpress.XtraReports.UI.XRTableCell tableDataProductLotCode;
        public DevExpress.XtraReports.UI.XRLabel company;
        public DevExpress.XtraReports.UI.XRLabel warehouseSite;
        private DevExpress.XtraReports.UI.XRLabel documentCodeLabel;
        public DevExpress.XtraReports.UI.XRLabel documentCode;
        private DevExpress.XtraReports.UI.XRLabel referenceNumberLabel;
        public DevExpress.XtraReports.UI.XRLabel referenceNumber;
        public DevExpress.XtraReports.UI.XRLabel transactionDate;
        private DevExpress.XtraReports.UI.XRLabel transactionDateLabel;
        private DevExpress.XtraReports.UI.XRLabel documentStatusNameLabel;
        public DevExpress.XtraReports.UI.XRLabel documentStatusName;
        public DevExpress.XtraReports.UI.XRLabel pic;
        private DevExpress.XtraReports.UI.XRLabel picLabel;
        public DevExpress.XtraReports.UI.XRLabel totalProducts;
        private DevExpress.XtraReports.UI.XRLabel totalProductsLabel;
    }
}
