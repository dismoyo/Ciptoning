namespace Dismoyo.Ciptoning.Web.Reports.ReportControls
{
    partial class DailySalesmanReportControl
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
            this.stockOnHandLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeader = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableHeaderProduct = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderQtyOnHandGood = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderQtyOnHandHold = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderQtyOnHandBad = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableData = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableDataProduct = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOnHandGood = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOnHandHold = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOnHandBad = new DevExpress.XtraReports.UI.XRTableCell();
            this.pivotGrid = new DevExpress.XtraReports.UI.XRPivotGrid();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
            this.pageHeaderLine = new DevExpress.XtraReports.UI.XRLine();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.pageInfoLeft = new DevExpress.XtraReports.UI.XRPageInfo();
            this.pageInfoRight = new DevExpress.XtraReports.UI.XRPageInfo();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.salesmanLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.salesman = new DevExpress.XtraReports.UI.XRLabel();
            this.dateLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.date = new DevExpress.XtraReports.UI.XRLabel();
            this.site = new DevExpress.XtraReports.UI.XRLabel();
            this.siteLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.companyLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.company = new DevExpress.XtraReports.UI.XRLabel();
            this.areaLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.area = new DevExpress.XtraReports.UI.XRLabel();
            this.regionLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.region = new DevExpress.XtraReports.UI.XRLabel();
            this.territory = new DevExpress.XtraReports.UI.XRLabel();
            this.territoryLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.lblTitle = new DevExpress.XtraReports.UI.XRLabel();
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            this.collectionSummaryLine = new DevExpress.XtraReports.UI.XRLine();
            this.salesSummaryLine = new DevExpress.XtraReports.UI.XRLine();
            this.totalCashLine = new DevExpress.XtraReports.UI.XRLine();
            this.totalCashTaken = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashTakenLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashPayment = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashPaymentLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.collectionSummaryLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalNonCashPayment = new DevExpress.XtraReports.UI.XRLabel();
            this.totalNonCashPaymentLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCollectionAdditionalCost = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCollectionAdditionalCostLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashCollectionTaken = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashCollectionTakenLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashSalesTakenLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashSalesTaken = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCreditBalanceLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCreditBalance = new DevExpress.XtraReports.UI.XRLabel();
            this.totalAdditionalCostLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalAdditionalCost = new DevExpress.XtraReports.UI.XRLabel();
            this.salesSummaryLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalSalesLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalSales = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashSalesLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.totalCashSales = new DevExpress.XtraReports.UI.XRLabel();
            ((System.ComponentModel.ISupportInitialize)(this.tableHeader)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tableData)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.stockOnHandLabel,
            this.tableHeader,
            this.tableData,
            this.pivotGrid});
            this.Detail.HeightF = 150F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // stockOnHandLabel
            // 
            this.stockOnHandLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.stockOnHandLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.stockOnHandLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 70F);
            this.stockOnHandLabel.Name = "stockOnHandLabel";
            this.stockOnHandLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.stockOnHandLabel.SizeF = new System.Drawing.SizeF(270F, 24F);
            this.stockOnHandLabel.StylePriority.UseFont = false;
            this.stockOnHandLabel.StylePriority.UseForeColor = false;
            this.stockOnHandLabel.Text = "--- STOCK ON HAND ---";
            // 
            // tableHeader
            // 
            this.tableHeader.BackColor = System.Drawing.Color.LightGray;
            this.tableHeader.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeader.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeader.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeader.LocationFloat = new DevExpress.Utils.PointFloat(0F, 95F);
            this.tableHeader.Name = "tableHeader";
            this.tableHeader.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow2});
            this.tableHeader.SizeF = new System.Drawing.SizeF(800F, 20F);
            this.tableHeader.StylePriority.UseBackColor = false;
            this.tableHeader.StylePriority.UseBorderColor = false;
            this.tableHeader.StylePriority.UseBorders = false;
            this.tableHeader.StylePriority.UseFont = false;
            this.tableHeader.StylePriority.UseTextAlignment = false;
            this.tableHeader.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // xrTableRow2
            // 
            this.xrTableRow2.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableHeaderProduct,
            this.tableHeaderQtyOnHandGood,
            this.tableHeaderQtyOnHandHold,
            this.tableHeaderQtyOnHandBad});
            this.xrTableRow2.Name = "xrTableRow2";
            this.xrTableRow2.Weight = 1D;
            // 
            // tableHeaderProduct
            // 
            this.tableHeaderProduct.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderProduct.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderProduct.Name = "tableHeaderProduct";
            this.tableHeaderProduct.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderProduct.StylePriority.UseBorderColor = false;
            this.tableHeaderProduct.StylePriority.UseBorders = false;
            this.tableHeaderProduct.StylePriority.UsePadding = false;
            this.tableHeaderProduct.Text = "Product";
            this.tableHeaderProduct.Weight = 2.187500181070984D;
            // 
            // tableHeaderQtyOnHandGood
            // 
            this.tableHeaderQtyOnHandGood.Name = "tableHeaderQtyOnHandGood";
            this.tableHeaderQtyOnHandGood.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderQtyOnHandGood.StylePriority.UsePadding = false;
            this.tableHeaderQtyOnHandGood.Text = "Good";
            this.tableHeaderQtyOnHandGood.Weight = 0.43750002469638194D;
            // 
            // tableHeaderQtyOnHandHold
            // 
            this.tableHeaderQtyOnHandHold.Name = "tableHeaderQtyOnHandHold";
            this.tableHeaderQtyOnHandHold.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderQtyOnHandHold.StylePriority.UsePadding = false;
            this.tableHeaderQtyOnHandHold.Text = "Hold";
            this.tableHeaderQtyOnHandHold.Weight = 0.43750003890931144D;
            // 
            // tableHeaderQtyOnHandBad
            // 
            this.tableHeaderQtyOnHandBad.Name = "tableHeaderQtyOnHandBad";
            this.tableHeaderQtyOnHandBad.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderQtyOnHandBad.StylePriority.UsePadding = false;
            this.tableHeaderQtyOnHandBad.Text = "Bad";
            this.tableHeaderQtyOnHandBad.Weight = 0.43750003127211923D;
            // 
            // tableData
            // 
            this.tableData.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableData.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableData.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableData.LocationFloat = new DevExpress.Utils.PointFloat(0F, 115F);
            this.tableData.Name = "tableData";
            this.tableData.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow1});
            this.tableData.SizeF = new System.Drawing.SizeF(800F, 20F);
            this.tableData.StylePriority.UseBorderColor = false;
            this.tableData.StylePriority.UseBorders = false;
            this.tableData.StylePriority.UseFont = false;
            this.tableData.StylePriority.UseTextAlignment = false;
            this.tableData.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // xrTableRow1
            // 
            this.xrTableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableDataProduct,
            this.tableDataQtyOnHandGood,
            this.tableDataQtyOnHandHold,
            this.tableDataQtyOnHandBad});
            this.xrTableRow1.Name = "xrTableRow1";
            this.xrTableRow1.Weight = 1D;
            // 
            // tableDataProduct
            // 
            this.tableDataProduct.Name = "tableDataProduct";
            this.tableDataProduct.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataProduct.StylePriority.UseFont = false;
            this.tableDataProduct.StylePriority.UsePadding = false;
            this.tableDataProduct.Text = "tableDataProduct";
            this.tableDataProduct.Weight = 2.28260854451019D;
            // 
            // tableDataQtyOnHandGood
            // 
            this.tableDataQtyOnHandGood.Name = "tableDataQtyOnHandGood";
            this.tableDataQtyOnHandGood.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOnHandGood.StylePriority.UseFont = false;
            this.tableDataQtyOnHandGood.StylePriority.UsePadding = false;
            this.tableDataQtyOnHandGood.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOnHandGood.Text = "tableDataQtyOnHandGood";
            this.tableDataQtyOnHandGood.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOnHandGood.Weight = 0.45652171373134837D;
            // 
            // tableDataQtyOnHandHold
            // 
            this.tableDataQtyOnHandHold.Name = "tableDataQtyOnHandHold";
            this.tableDataQtyOnHandHold.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOnHandHold.StylePriority.UseFont = false;
            this.tableDataQtyOnHandHold.StylePriority.UsePadding = false;
            this.tableDataQtyOnHandHold.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOnHandHold.Text = "tableDataQtyOnHandHold";
            this.tableDataQtyOnHandHold.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOnHandHold.Weight = 0.45652171909736983D;
            // 
            // tableDataQtyOnHandBad
            // 
            this.tableDataQtyOnHandBad.Name = "tableDataQtyOnHandBad";
            this.tableDataQtyOnHandBad.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOnHandBad.StylePriority.UseFont = false;
            this.tableDataQtyOnHandBad.StylePriority.UsePadding = false;
            this.tableDataQtyOnHandBad.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOnHandBad.Text = "tableData\r\nQtyOnHandBad";
            this.tableDataQtyOnHandBad.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOnHandBad.Weight = 0.45652169854347069D;
            // 
            // pivotGrid
            // 
            this.pivotGrid.Appearance.Cell.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pivotGrid.Appearance.CustomTotalCell.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pivotGrid.Appearance.FieldHeader.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pivotGrid.Appearance.FieldHeader.TextHorizontalAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.pivotGrid.Appearance.FieldHeader.TextVerticalAlignment = DevExpress.Utils.VertAlignment.Center;
            this.pivotGrid.Appearance.FieldValue.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pivotGrid.Appearance.FieldValue.TextHorizontalAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.pivotGrid.Appearance.FieldValue.TextVerticalAlignment = DevExpress.Utils.VertAlignment.Center;
            this.pivotGrid.Appearance.FieldValueGrandTotal.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pivotGrid.Appearance.FieldValueTotal.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pivotGrid.Appearance.GrandTotalCell.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pivotGrid.Appearance.TotalCell.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pivotGrid.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.pivotGrid.Name = "pivotGrid";
            this.pivotGrid.OptionsPrint.FilterSeparatorBarPadding = 3;
            this.pivotGrid.OptionsView.GroupFieldsInCustomizationWindow = false;
            this.pivotGrid.OptionsView.ShowColumnGrandTotals = false;
            this.pivotGrid.OptionsView.ShowColumnHeaders = false;
            this.pivotGrid.OptionsView.ShowColumnTotals = false;
            this.pivotGrid.OptionsView.ShowDataHeaders = false;
            this.pivotGrid.SizeF = new System.Drawing.SizeF(215F, 50F);
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
            // PageHeader
            // 
            this.PageHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.pageHeaderLine});
            this.PageHeader.HeightF = 6F;
            this.PageHeader.Name = "PageHeader";
            // 
            // pageHeaderLine
            // 
            this.pageHeaderLine.AnchorHorizontal = ((DevExpress.XtraReports.UI.HorizontalAnchorStyles)((DevExpress.XtraReports.UI.HorizontalAnchorStyles.Left | DevExpress.XtraReports.UI.HorizontalAnchorStyles.Right)));
            this.pageHeaderLine.BackColor = System.Drawing.Color.Transparent;
            this.pageHeaderLine.BorderColor = System.Drawing.Color.Transparent;
            this.pageHeaderLine.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.pageHeaderLine.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.pageHeaderLine.BorderWidth = 1F;
            this.pageHeaderLine.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.pageHeaderLine.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.pageHeaderLine.Name = "pageHeaderLine";
            this.pageHeaderLine.SizeF = new System.Drawing.SizeF(1554F, 3F);
            this.pageHeaderLine.StylePriority.UseBackColor = false;
            this.pageHeaderLine.StylePriority.UseBorderColor = false;
            this.pageHeaderLine.StylePriority.UseBorderDashStyle = false;
            this.pageHeaderLine.StylePriority.UseBorders = false;
            this.pageHeaderLine.StylePriority.UseBorderWidth = false;
            this.pageHeaderLine.StylePriority.UseForeColor = false;
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
            this.pageInfoRight.LocationFloat = new DevExpress.Utils.PointFloat(1110F, 6F);
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
            this.salesmanLabel,
            this.salesman,
            this.dateLabel,
            this.date,
            this.site,
            this.siteLabel,
            this.companyLabel,
            this.company,
            this.areaLabel,
            this.area,
            this.regionLabel,
            this.region,
            this.territory,
            this.territoryLabel,
            this.lblTitle});
            this.ReportHeader.HeightF = 170F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // salesmanLabel
            // 
            this.salesmanLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.salesmanLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.salesmanLabel.LocationFloat = new DevExpress.Utils.PointFloat(6.00001F, 140F);
            this.salesmanLabel.Name = "salesmanLabel";
            this.salesmanLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.salesmanLabel.SizeF = new System.Drawing.SizeF(100F, 24F);
            this.salesmanLabel.StylePriority.UseFont = false;
            this.salesmanLabel.StylePriority.UseForeColor = false;
            this.salesmanLabel.Text = "Salesman:";
            // 
            // salesman
            // 
            this.salesman.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.salesman.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.salesman.LocationFloat = new DevExpress.Utils.PointFloat(110.0001F, 140F);
            this.salesman.Name = "salesman";
            this.salesman.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.salesman.SizeF = new System.Drawing.SizeF(300F, 24F);
            this.salesman.StylePriority.UseFont = false;
            this.salesman.StylePriority.UseForeColor = false;
            this.salesman.Text = "[Salesman]";
            // 
            // dateLabel
            // 
            this.dateLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dateLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.dateLabel.LocationFloat = new DevExpress.Utils.PointFloat(6F, 116F);
            this.dateLabel.Name = "dateLabel";
            this.dateLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.dateLabel.SizeF = new System.Drawing.SizeF(100F, 24F);
            this.dateLabel.StylePriority.UseFont = false;
            this.dateLabel.StylePriority.UseForeColor = false;
            this.dateLabel.Text = "Date:";
            // 
            // date
            // 
            this.date.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.date.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.date.LocationFloat = new DevExpress.Utils.PointFloat(110F, 116F);
            this.date.Name = "date";
            this.date.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.date.SizeF = new System.Drawing.SizeF(300F, 24F);
            this.date.StylePriority.UseFont = false;
            this.date.StylePriority.UseForeColor = false;
            this.date.Text = "[Date]";
            // 
            // site
            // 
            this.site.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.site.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.site.LocationFloat = new DevExpress.Utils.PointFloat(524F, 60F);
            this.site.Name = "site";
            this.site.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.site.SizeF = new System.Drawing.SizeF(500F, 24F);
            this.site.StylePriority.UseFont = false;
            this.site.StylePriority.UseForeColor = false;
            this.site.Text = "[Site]";
            // 
            // siteLabel
            // 
            this.siteLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.siteLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.siteLabel.LocationFloat = new DevExpress.Utils.PointFloat(420F, 60F);
            this.siteLabel.Name = "siteLabel";
            this.siteLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.siteLabel.SizeF = new System.Drawing.SizeF(100F, 24F);
            this.siteLabel.StylePriority.UseFont = false;
            this.siteLabel.StylePriority.UseForeColor = false;
            this.siteLabel.Text = "Site:";
            // 
            // companyLabel
            // 
            this.companyLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.companyLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.companyLabel.LocationFloat = new DevExpress.Utils.PointFloat(420F, 36F);
            this.companyLabel.Name = "companyLabel";
            this.companyLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.companyLabel.SizeF = new System.Drawing.SizeF(100F, 24F);
            this.companyLabel.StylePriority.UseFont = false;
            this.companyLabel.StylePriority.UseForeColor = false;
            this.companyLabel.Text = "Company:";
            // 
            // company
            // 
            this.company.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.company.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.company.LocationFloat = new DevExpress.Utils.PointFloat(524F, 36F);
            this.company.Name = "company";
            this.company.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.company.SizeF = new System.Drawing.SizeF(500F, 24F);
            this.company.StylePriority.UseFont = false;
            this.company.StylePriority.UseForeColor = false;
            this.company.Text = "[Company]";
            // 
            // areaLabel
            // 
            this.areaLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.areaLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.areaLabel.LocationFloat = new DevExpress.Utils.PointFloat(6.00001F, 84.00002F);
            this.areaLabel.Name = "areaLabel";
            this.areaLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.areaLabel.SizeF = new System.Drawing.SizeF(100F, 24F);
            this.areaLabel.StylePriority.UseFont = false;
            this.areaLabel.StylePriority.UseForeColor = false;
            this.areaLabel.Text = "Area:";
            // 
            // area
            // 
            this.area.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.area.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.area.LocationFloat = new DevExpress.Utils.PointFloat(110.0001F, 84.00002F);
            this.area.Name = "area";
            this.area.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.area.SizeF = new System.Drawing.SizeF(300F, 24F);
            this.area.StylePriority.UseFont = false;
            this.area.StylePriority.UseForeColor = false;
            this.area.Text = "[Area]";
            // 
            // regionLabel
            // 
            this.regionLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.regionLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.regionLabel.LocationFloat = new DevExpress.Utils.PointFloat(6.00001F, 60.00001F);
            this.regionLabel.Name = "regionLabel";
            this.regionLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.regionLabel.SizeF = new System.Drawing.SizeF(100F, 24F);
            this.regionLabel.StylePriority.UseFont = false;
            this.regionLabel.StylePriority.UseForeColor = false;
            this.regionLabel.Text = "Region:";
            // 
            // region
            // 
            this.region.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.region.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.region.LocationFloat = new DevExpress.Utils.PointFloat(110.0001F, 60.00001F);
            this.region.Name = "region";
            this.region.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.region.SizeF = new System.Drawing.SizeF(300F, 24F);
            this.region.StylePriority.UseFont = false;
            this.region.StylePriority.UseForeColor = false;
            this.region.Text = "[Region]";
            // 
            // territory
            // 
            this.territory.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.territory.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.territory.LocationFloat = new DevExpress.Utils.PointFloat(110F, 36F);
            this.territory.Name = "territory";
            this.territory.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.territory.SizeF = new System.Drawing.SizeF(300F, 24F);
            this.territory.StylePriority.UseFont = false;
            this.territory.StylePriority.UseForeColor = false;
            this.territory.Text = "[Territory]";
            // 
            // territoryLabel
            // 
            this.territoryLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.territoryLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.territoryLabel.LocationFloat = new DevExpress.Utils.PointFloat(6.000002F, 36F);
            this.territoryLabel.Name = "territoryLabel";
            this.territoryLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.territoryLabel.SizeF = new System.Drawing.SizeF(100F, 24F);
            this.territoryLabel.StylePriority.UseFont = false;
            this.territoryLabel.StylePriority.UseForeColor = false;
            this.territoryLabel.Text = "Territory:";
            // 
            // lblTitle
            // 
            this.lblTitle.Font = new System.Drawing.Font("Calibri", 20.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTitle.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.lblTitle.LocationFloat = new DevExpress.Utils.PointFloat(6.00001F, 0F);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblTitle.SizeF = new System.Drawing.SizeF(1542F, 33F);
            this.lblTitle.StylePriority.UseFont = false;
            this.lblTitle.StylePriority.UseForeColor = false;
            this.lblTitle.Text = "DAILY SALESMAN REPORT";
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
            this.collectionSummaryLine,
            this.salesSummaryLine,
            this.totalCashLine,
            this.totalCashTaken,
            this.totalCashTakenLabel,
            this.totalCashPayment,
            this.totalCashPaymentLabel,
            this.collectionSummaryLabel,
            this.totalNonCashPayment,
            this.totalNonCashPaymentLabel,
            this.totalCollectionAdditionalCost,
            this.totalCollectionAdditionalCostLabel,
            this.totalCashCollectionTaken,
            this.totalCashCollectionTakenLabel,
            this.totalCashSalesTakenLabel,
            this.totalCashSalesTaken,
            this.totalCreditBalanceLabel,
            this.totalCreditBalance,
            this.totalAdditionalCostLabel,
            this.totalAdditionalCost,
            this.salesSummaryLabel,
            this.totalSalesLabel,
            this.totalSales,
            this.totalCashSalesLabel,
            this.totalCashSales});
            this.ReportFooter.HeightF = 218F;
            this.ReportFooter.Name = "ReportFooter";
            // 
            // collectionSummaryLine
            // 
            this.collectionSummaryLine.BorderColor = System.Drawing.Color.Transparent;
            this.collectionSummaryLine.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.collectionSummaryLine.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.collectionSummaryLine.BorderWidth = 1F;
            this.collectionSummaryLine.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.collectionSummaryLine.LocationFloat = new DevExpress.Utils.PointFloat(450F, 138F);
            this.collectionSummaryLine.Name = "collectionSummaryLine";
            this.collectionSummaryLine.SizeF = new System.Drawing.SizeF(370F, 3F);
            this.collectionSummaryLine.StylePriority.UseBorderColor = false;
            this.collectionSummaryLine.StylePriority.UseBorderDashStyle = false;
            this.collectionSummaryLine.StylePriority.UseBorders = false;
            this.collectionSummaryLine.StylePriority.UseBorderWidth = false;
            this.collectionSummaryLine.StylePriority.UseForeColor = false;
            // 
            // salesSummaryLine
            // 
            this.salesSummaryLine.BorderColor = System.Drawing.Color.Transparent;
            this.salesSummaryLine.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.salesSummaryLine.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.salesSummaryLine.BorderWidth = 1F;
            this.salesSummaryLine.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.salesSummaryLine.LocationFloat = new DevExpress.Utils.PointFloat(0F, 138F);
            this.salesSummaryLine.Name = "salesSummaryLine";
            this.salesSummaryLine.SizeF = new System.Drawing.SizeF(370F, 3F);
            this.salesSummaryLine.StylePriority.UseBorderColor = false;
            this.salesSummaryLine.StylePriority.UseBorderDashStyle = false;
            this.salesSummaryLine.StylePriority.UseBorders = false;
            this.salesSummaryLine.StylePriority.UseBorderWidth = false;
            this.salesSummaryLine.StylePriority.UseForeColor = false;
            // 
            // totalCashLine
            // 
            this.totalCashLine.BorderColor = System.Drawing.Color.Transparent;
            this.totalCashLine.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Solid;
            this.totalCashLine.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.totalCashLine.BorderWidth = 1F;
            this.totalCashLine.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.totalCashLine.LocationFloat = new DevExpress.Utils.PointFloat(0F, 172F);
            this.totalCashLine.Name = "totalCashLine";
            this.totalCashLine.SizeF = new System.Drawing.SizeF(820F, 3F);
            this.totalCashLine.StylePriority.UseBorderColor = false;
            this.totalCashLine.StylePriority.UseBorderDashStyle = false;
            this.totalCashLine.StylePriority.UseBorders = false;
            this.totalCashLine.StylePriority.UseBorderWidth = false;
            this.totalCashLine.StylePriority.UseForeColor = false;
            // 
            // totalCashTaken
            // 
            this.totalCashTaken.Font = new System.Drawing.Font("Calibri", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashTaken.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalCashTaken.LocationFloat = new DevExpress.Utils.PointFloat(204F, 188F);
            this.totalCashTaken.Name = "totalCashTaken";
            this.totalCashTaken.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashTaken.SizeF = new System.Drawing.SizeF(166F, 24F);
            this.totalCashTaken.StylePriority.UseFont = false;
            this.totalCashTaken.StylePriority.UseForeColor = false;
            this.totalCashTaken.Text = "[TotalCashTaken]";
            // 
            // totalCashTakenLabel
            // 
            this.totalCashTakenLabel.Font = new System.Drawing.Font("Calibri", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashTakenLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalCashTakenLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 188F);
            this.totalCashTakenLabel.Name = "totalCashTakenLabel";
            this.totalCashTakenLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashTakenLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalCashTakenLabel.StylePriority.UseFont = false;
            this.totalCashTakenLabel.StylePriority.UseForeColor = false;
            this.totalCashTakenLabel.Text = "Total Cash Taken:";
            // 
            // totalCashPayment
            // 
            this.totalCashPayment.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashPayment.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalCashPayment.LocationFloat = new DevExpress.Utils.PointFloat(653.9999F, 36F);
            this.totalCashPayment.Name = "totalCashPayment";
            this.totalCashPayment.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashPayment.SizeF = new System.Drawing.SizeF(165.9999F, 24F);
            this.totalCashPayment.StylePriority.UseFont = false;
            this.totalCashPayment.StylePriority.UseForeColor = false;
            this.totalCashPayment.StylePriority.UseTextAlignment = false;
            this.totalCashPayment.Text = "[TotalCashSales]";
            this.totalCashPayment.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // totalCashPaymentLabel
            // 
            this.totalCashPaymentLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashPaymentLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalCashPaymentLabel.LocationFloat = new DevExpress.Utils.PointFloat(450F, 36F);
            this.totalCashPaymentLabel.Name = "totalCashPaymentLabel";
            this.totalCashPaymentLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashPaymentLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalCashPaymentLabel.StylePriority.UseFont = false;
            this.totalCashPaymentLabel.StylePriority.UseForeColor = false;
            this.totalCashPaymentLabel.Text = "Total Cash Payment:";
            // 
            // collectionSummaryLabel
            // 
            this.collectionSummaryLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.collectionSummaryLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.collectionSummaryLabel.LocationFloat = new DevExpress.Utils.PointFloat(450F, 11.99999F);
            this.collectionSummaryLabel.Name = "collectionSummaryLabel";
            this.collectionSummaryLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.collectionSummaryLabel.SizeF = new System.Drawing.SizeF(270F, 24F);
            this.collectionSummaryLabel.StylePriority.UseFont = false;
            this.collectionSummaryLabel.StylePriority.UseForeColor = false;
            this.collectionSummaryLabel.Text = "--- COLLECTION SUMMARY ---";
            // 
            // totalNonCashPayment
            // 
            this.totalNonCashPayment.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalNonCashPayment.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalNonCashPayment.LocationFloat = new DevExpress.Utils.PointFloat(653.9999F, 60.00001F);
            this.totalNonCashPayment.Name = "totalNonCashPayment";
            this.totalNonCashPayment.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalNonCashPayment.SizeF = new System.Drawing.SizeF(165.9999F, 24F);
            this.totalNonCashPayment.StylePriority.UseFont = false;
            this.totalNonCashPayment.StylePriority.UseForeColor = false;
            this.totalNonCashPayment.StylePriority.UseTextAlignment = false;
            this.totalNonCashPayment.Text = "[TotalNonCashPayment]";
            this.totalNonCashPayment.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // totalNonCashPaymentLabel
            // 
            this.totalNonCashPaymentLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalNonCashPaymentLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalNonCashPaymentLabel.LocationFloat = new DevExpress.Utils.PointFloat(450F, 60.00001F);
            this.totalNonCashPaymentLabel.Name = "totalNonCashPaymentLabel";
            this.totalNonCashPaymentLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalNonCashPaymentLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalNonCashPaymentLabel.StylePriority.UseFont = false;
            this.totalNonCashPaymentLabel.StylePriority.UseForeColor = false;
            this.totalNonCashPaymentLabel.Text = "Total Non Cash Payment";
            // 
            // totalCollectionAdditionalCost
            // 
            this.totalCollectionAdditionalCost.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCollectionAdditionalCost.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalCollectionAdditionalCost.LocationFloat = new DevExpress.Utils.PointFloat(653.9999F, 84.00002F);
            this.totalCollectionAdditionalCost.Name = "totalCollectionAdditionalCost";
            this.totalCollectionAdditionalCost.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCollectionAdditionalCost.SizeF = new System.Drawing.SizeF(165.9999F, 24F);
            this.totalCollectionAdditionalCost.StylePriority.UseFont = false;
            this.totalCollectionAdditionalCost.StylePriority.UseForeColor = false;
            this.totalCollectionAdditionalCost.StylePriority.UseTextAlignment = false;
            this.totalCollectionAdditionalCost.Text = "[TotalAdditionalCost]";
            this.totalCollectionAdditionalCost.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // totalCollectionAdditionalCostLabel
            // 
            this.totalCollectionAdditionalCostLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCollectionAdditionalCostLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalCollectionAdditionalCostLabel.LocationFloat = new DevExpress.Utils.PointFloat(450F, 84.00002F);
            this.totalCollectionAdditionalCostLabel.Name = "totalCollectionAdditionalCostLabel";
            this.totalCollectionAdditionalCostLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCollectionAdditionalCostLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalCollectionAdditionalCostLabel.StylePriority.UseFont = false;
            this.totalCollectionAdditionalCostLabel.StylePriority.UseForeColor = false;
            this.totalCollectionAdditionalCostLabel.Text = "Total Additional Cost:";
            // 
            // totalCashCollectionTaken
            // 
            this.totalCashCollectionTaken.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashCollectionTaken.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalCashCollectionTaken.LocationFloat = new DevExpress.Utils.PointFloat(653.9999F, 144F);
            this.totalCashCollectionTaken.Name = "totalCashCollectionTaken";
            this.totalCashCollectionTaken.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashCollectionTaken.SizeF = new System.Drawing.SizeF(165.9999F, 24F);
            this.totalCashCollectionTaken.StylePriority.UseFont = false;
            this.totalCashCollectionTaken.StylePriority.UseForeColor = false;
            this.totalCashCollectionTaken.StylePriority.UseTextAlignment = false;
            this.totalCashCollectionTaken.Text = "[TotalCashCollectionTaken]";
            this.totalCashCollectionTaken.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // totalCashCollectionTakenLabel
            // 
            this.totalCashCollectionTakenLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashCollectionTakenLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalCashCollectionTakenLabel.LocationFloat = new DevExpress.Utils.PointFloat(450F, 144F);
            this.totalCashCollectionTakenLabel.Name = "totalCashCollectionTakenLabel";
            this.totalCashCollectionTakenLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashCollectionTakenLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalCashCollectionTakenLabel.StylePriority.UseFont = false;
            this.totalCashCollectionTakenLabel.StylePriority.UseForeColor = false;
            this.totalCashCollectionTakenLabel.Text = "Total Cash Collection Taken:";
            // 
            // totalCashSalesTakenLabel
            // 
            this.totalCashSalesTakenLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashSalesTakenLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalCashSalesTakenLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 144F);
            this.totalCashSalesTakenLabel.Name = "totalCashSalesTakenLabel";
            this.totalCashSalesTakenLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashSalesTakenLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalCashSalesTakenLabel.StylePriority.UseFont = false;
            this.totalCashSalesTakenLabel.StylePriority.UseForeColor = false;
            this.totalCashSalesTakenLabel.Text = "Total Cash Sales Taken:";
            // 
            // totalCashSalesTaken
            // 
            this.totalCashSalesTaken.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashSalesTaken.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalCashSalesTaken.LocationFloat = new DevExpress.Utils.PointFloat(203.9999F, 144F);
            this.totalCashSalesTaken.Name = "totalCashSalesTaken";
            this.totalCashSalesTaken.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashSalesTaken.SizeF = new System.Drawing.SizeF(165.9999F, 24F);
            this.totalCashSalesTaken.StylePriority.UseFont = false;
            this.totalCashSalesTaken.StylePriority.UseForeColor = false;
            this.totalCashSalesTaken.StylePriority.UseTextAlignment = false;
            this.totalCashSalesTaken.Text = "[TotalCashSalesTaken]";
            this.totalCashSalesTaken.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // totalCreditBalanceLabel
            // 
            this.totalCreditBalanceLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCreditBalanceLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalCreditBalanceLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 110F);
            this.totalCreditBalanceLabel.Name = "totalCreditBalanceLabel";
            this.totalCreditBalanceLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCreditBalanceLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalCreditBalanceLabel.StylePriority.UseFont = false;
            this.totalCreditBalanceLabel.StylePriority.UseForeColor = false;
            this.totalCreditBalanceLabel.Text = "Total Credit Balance:";
            // 
            // totalCreditBalance
            // 
            this.totalCreditBalance.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCreditBalance.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalCreditBalance.LocationFloat = new DevExpress.Utils.PointFloat(203.9999F, 110F);
            this.totalCreditBalance.Name = "totalCreditBalance";
            this.totalCreditBalance.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCreditBalance.SizeF = new System.Drawing.SizeF(165.9999F, 24F);
            this.totalCreditBalance.StylePriority.UseFont = false;
            this.totalCreditBalance.StylePriority.UseForeColor = false;
            this.totalCreditBalance.StylePriority.UseTextAlignment = false;
            this.totalCreditBalance.Text = "[TotalCreditBalance]";
            this.totalCreditBalance.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // totalAdditionalCostLabel
            // 
            this.totalAdditionalCostLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalAdditionalCostLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalAdditionalCostLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 86F);
            this.totalAdditionalCostLabel.Name = "totalAdditionalCostLabel";
            this.totalAdditionalCostLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalAdditionalCostLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalAdditionalCostLabel.StylePriority.UseFont = false;
            this.totalAdditionalCostLabel.StylePriority.UseForeColor = false;
            this.totalAdditionalCostLabel.Text = "Total Additional Cost:";
            // 
            // totalAdditionalCost
            // 
            this.totalAdditionalCost.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalAdditionalCost.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalAdditionalCost.LocationFloat = new DevExpress.Utils.PointFloat(204F, 86F);
            this.totalAdditionalCost.Name = "totalAdditionalCost";
            this.totalAdditionalCost.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalAdditionalCost.SizeF = new System.Drawing.SizeF(165.9999F, 24F);
            this.totalAdditionalCost.StylePriority.UseFont = false;
            this.totalAdditionalCost.StylePriority.UseForeColor = false;
            this.totalAdditionalCost.StylePriority.UseTextAlignment = false;
            this.totalAdditionalCost.Text = "[TotalAdditionalCost]";
            this.totalAdditionalCost.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // salesSummaryLabel
            // 
            this.salesSummaryLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.salesSummaryLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.salesSummaryLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 12F);
            this.salesSummaryLabel.Name = "salesSummaryLabel";
            this.salesSummaryLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.salesSummaryLabel.SizeF = new System.Drawing.SizeF(270F, 24F);
            this.salesSummaryLabel.StylePriority.UseFont = false;
            this.salesSummaryLabel.StylePriority.UseForeColor = false;
            this.salesSummaryLabel.Text = "--- SALES SUMMARY ---";
            // 
            // totalSalesLabel
            // 
            this.totalSalesLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalSalesLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalSalesLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 36F);
            this.totalSalesLabel.Name = "totalSalesLabel";
            this.totalSalesLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalSalesLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalSalesLabel.StylePriority.UseFont = false;
            this.totalSalesLabel.StylePriority.UseForeColor = false;
            this.totalSalesLabel.Text = "Total Sales:";
            // 
            // totalSales
            // 
            this.totalSales.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalSales.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalSales.LocationFloat = new DevExpress.Utils.PointFloat(204F, 36F);
            this.totalSales.Name = "totalSales";
            this.totalSales.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalSales.SizeF = new System.Drawing.SizeF(166F, 24F);
            this.totalSales.StylePriority.UseFont = false;
            this.totalSales.StylePriority.UseForeColor = false;
            this.totalSales.StylePriority.UseTextAlignment = false;
            this.totalSales.Text = "[TotalSales]";
            this.totalSales.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // totalCashSalesLabel
            // 
            this.totalCashSalesLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashSalesLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalCashSalesLabel.LocationFloat = new DevExpress.Utils.PointFloat(0F, 61.99999F);
            this.totalCashSalesLabel.Name = "totalCashSalesLabel";
            this.totalCashSalesLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashSalesLabel.SizeF = new System.Drawing.SizeF(200F, 24F);
            this.totalCashSalesLabel.StylePriority.UseFont = false;
            this.totalCashSalesLabel.StylePriority.UseForeColor = false;
            this.totalCashSalesLabel.Text = "Total Cash Sales:";
            // 
            // totalCashSales
            // 
            this.totalCashSales.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalCashSales.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.totalCashSales.LocationFloat = new DevExpress.Utils.PointFloat(204F, 61.99999F);
            this.totalCashSales.Name = "totalCashSales";
            this.totalCashSales.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalCashSales.SizeF = new System.Drawing.SizeF(165.9999F, 24F);
            this.totalCashSales.StylePriority.UseFont = false;
            this.totalCashSales.StylePriority.UseForeColor = false;
            this.totalCashSales.StylePriority.UseTextAlignment = false;
            this.totalCashSales.Text = "[TotalCashSales]";
            this.totalCashSales.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // DailySalesmanReportControl
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.PageHeader,
            this.PageFooter,
            this.ReportHeader,
            this.ReportFooter});
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(50, 50, 50, 50);
            this.PageHeight = 1169;
            this.PageWidth = 1654;
            this.PaperKind = System.Drawing.Printing.PaperKind.A3;
            this.StyleSheet.AddRange(new DevExpress.XtraReports.UI.XRControlStyle[] {
            this.PageInfo});
            this.Version = "15.2";
            ((System.ComponentModel.ISupportInitialize)(this.tableHeader)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tableData)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.PageHeaderBand PageHeader;
        private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
        private DevExpress.XtraReports.UI.XRPageInfo pageInfoLeft;
        private DevExpress.XtraReports.UI.XRPageInfo pageInfoRight;
        private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
        private DevExpress.XtraReports.UI.XRLabel lblTitle;
        private DevExpress.XtraReports.UI.XRControlStyle PageInfo;
        public DevExpress.XtraReports.UI.XRPivotGrid pivotGrid;
        public DevExpress.XtraReports.UI.XRLabel site;
        private DevExpress.XtraReports.UI.XRLabel siteLabel;
        private DevExpress.XtraReports.UI.XRLabel companyLabel;
        public DevExpress.XtraReports.UI.XRLabel company;
        private DevExpress.XtraReports.UI.XRLabel areaLabel;
        public DevExpress.XtraReports.UI.XRLabel area;
        private DevExpress.XtraReports.UI.XRLabel regionLabel;
        public DevExpress.XtraReports.UI.XRLabel region;
        public DevExpress.XtraReports.UI.XRLabel territory;
        private DevExpress.XtraReports.UI.XRLabel territoryLabel;
        private DevExpress.XtraReports.UI.XRLabel dateLabel;
        public DevExpress.XtraReports.UI.XRLabel date;
        private DevExpress.XtraReports.UI.XRLabel salesmanLabel;
        public DevExpress.XtraReports.UI.XRLabel salesman;
        private DevExpress.XtraReports.UI.ReportFooterBand ReportFooter;
        private DevExpress.XtraReports.UI.XRLabel totalAdditionalCostLabel;
        public DevExpress.XtraReports.UI.XRLabel totalAdditionalCost;
        private DevExpress.XtraReports.UI.XRLabel salesSummaryLabel;
        private DevExpress.XtraReports.UI.XRLabel totalSalesLabel;
        public DevExpress.XtraReports.UI.XRLabel totalSales;
        private DevExpress.XtraReports.UI.XRLabel totalCashSalesLabel;
        public DevExpress.XtraReports.UI.XRLabel totalCashSales;
        public DevExpress.XtraReports.UI.XRLabel totalCashPayment;
        private DevExpress.XtraReports.UI.XRLabel totalCashPaymentLabel;
        private DevExpress.XtraReports.UI.XRLabel collectionSummaryLabel;
        public DevExpress.XtraReports.UI.XRLabel totalNonCashPayment;
        private DevExpress.XtraReports.UI.XRLabel totalNonCashPaymentLabel;
        public DevExpress.XtraReports.UI.XRLabel totalCollectionAdditionalCost;
        private DevExpress.XtraReports.UI.XRLabel totalCollectionAdditionalCostLabel;
        public DevExpress.XtraReports.UI.XRLabel totalCashCollectionTaken;
        private DevExpress.XtraReports.UI.XRLabel totalCashCollectionTakenLabel;
        private DevExpress.XtraReports.UI.XRLabel totalCashSalesTakenLabel;
        public DevExpress.XtraReports.UI.XRLabel totalCashSalesTaken;
        private DevExpress.XtraReports.UI.XRLabel totalCreditBalanceLabel;
        public DevExpress.XtraReports.UI.XRLabel totalCreditBalance;
        private DevExpress.XtraReports.UI.XRLine collectionSummaryLine;
        private DevExpress.XtraReports.UI.XRLine salesSummaryLine;
        private DevExpress.XtraReports.UI.XRLine totalCashLine;
        public DevExpress.XtraReports.UI.XRLabel totalCashTaken;
        private DevExpress.XtraReports.UI.XRLabel totalCashTakenLabel;
        private DevExpress.XtraReports.UI.XRLine pageHeaderLine;
        public DevExpress.XtraReports.UI.XRTable tableHeader;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow2;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderProduct;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderQtyOnHandGood;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderQtyOnHandHold;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderQtyOnHandBad;
        public DevExpress.XtraReports.UI.XRTable tableData;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow1;
        public DevExpress.XtraReports.UI.XRTableCell tableDataProduct;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOnHandGood;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOnHandHold;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOnHandBad;
        private DevExpress.XtraReports.UI.XRLabel stockOnHandLabel;
    }
}
