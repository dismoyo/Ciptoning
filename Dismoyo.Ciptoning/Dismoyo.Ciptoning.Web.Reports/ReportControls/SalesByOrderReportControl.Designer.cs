namespace Dismoyo.Ciptoning.Web.Reports.ReportControls
{
    partial class SalesByOrderReportControl
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
            this.tableDataRow = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableDataSample = new DevExpress.XtraReports.UI.XRTableCell();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
            this.tableHeader = new DevExpress.XtraReports.UI.XRTable();
            this.tableHeaderRow = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableHeaderSample = new DevExpress.XtraReports.UI.XRTableCell();
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
            this.pageInfoRight = new DevExpress.XtraReports.UI.XRPageInfo();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.pageInfoLeft = new DevExpress.XtraReports.UI.XRPageInfo();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.periodLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.period = new DevExpress.XtraReports.UI.XRLabel();
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
            ((System.ComponentModel.ISupportInitialize)(this.tableData)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tableHeader)).BeginInit();
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
            this.tableData.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableData.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.tableData.Name = "tableData";
            this.tableData.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.tableDataRow});
            this.tableData.SizeF = new System.Drawing.SizeF(180F, 20F);
            this.tableData.StylePriority.UseBorderColor = false;
            this.tableData.StylePriority.UseBorders = false;
            this.tableData.StylePriority.UseFont = false;
            this.tableData.StylePriority.UseTextAlignment = false;
            this.tableData.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // tableDataRow
            // 
            this.tableDataRow.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableDataSample});
            this.tableDataRow.Name = "tableDataRow";
            this.tableDataRow.Weight = 1D;
            // 
            // tableDataSample
            // 
            this.tableDataSample.Name = "tableDataSample";
            this.tableDataSample.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataSample.ProcessDuplicatesMode = DevExpress.XtraReports.UI.ProcessDuplicatesMode.Merge;
            this.tableDataSample.StylePriority.UsePadding = false;
            this.tableDataSample.Text = "tableDataSample";
            this.tableDataSample.Weight = 1.1269564840410711D;
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
            this.PageHeader.BorderColor = System.Drawing.Color.Black;
            this.PageHeader.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.PageHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.tableHeader});
            this.PageHeader.HeightF = 20F;
            this.PageHeader.Name = "PageHeader";
            this.PageHeader.StylePriority.UseBorderColor = false;
            this.PageHeader.StylePriority.UseBorders = false;
            // 
            // tableHeader
            // 
            this.tableHeader.BackColor = System.Drawing.Color.LightGray;
            this.tableHeader.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeader.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeader.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeader.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.tableHeader.Name = "tableHeader";
            this.tableHeader.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.tableHeaderRow});
            this.tableHeader.SizeF = new System.Drawing.SizeF(180F, 20F);
            this.tableHeader.StylePriority.UseBackColor = false;
            this.tableHeader.StylePriority.UseBorderColor = false;
            this.tableHeader.StylePriority.UseBorders = false;
            this.tableHeader.StylePriority.UseFont = false;
            this.tableHeader.StylePriority.UseTextAlignment = false;
            this.tableHeader.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderRow
            // 
            this.tableHeaderRow.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableHeaderSample});
            this.tableHeaderRow.Name = "tableHeaderRow";
            this.tableHeaderRow.Weight = 1D;
            // 
            // tableHeaderSample
            // 
            this.tableHeaderSample.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderSample.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderSample.Name = "tableHeaderSample";
            this.tableHeaderSample.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderSample.StylePriority.UseBorderColor = false;
            this.tableHeaderSample.StylePriority.UseBorders = false;
            this.tableHeaderSample.StylePriority.UsePadding = false;
            this.tableHeaderSample.Text = "Sample";
            this.tableHeaderSample.Weight = 1.2000000769020718D;
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
            // PageFooter
            // 
            this.PageFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.pageInfoLeft,
            this.pageInfoRight});
            this.PageFooter.HeightF = 32F;
            this.PageFooter.Name = "PageFooter";
            this.PageFooter.Visible = false;
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
            // ReportHeader
            // 
            this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.periodLabel,
            this.period,
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
            this.ReportHeader.HeightF = 114F;
            this.ReportHeader.Name = "ReportHeader";
            this.ReportHeader.Visible = false;
            // 
            // periodLabel
            // 
            this.periodLabel.Font = new System.Drawing.Font("Calibri", 12F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.periodLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.periodLabel.LocationFloat = new DevExpress.Utils.PointFloat(420F, 84F);
            this.periodLabel.Name = "periodLabel";
            this.periodLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.periodLabel.SizeF = new System.Drawing.SizeF(100F, 24F);
            this.periodLabel.StylePriority.UseFont = false;
            this.periodLabel.StylePriority.UseForeColor = false;
            this.periodLabel.Text = "Period:";
            // 
            // period
            // 
            this.period.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.period.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.period.LocationFloat = new DevExpress.Utils.PointFloat(524F, 84F);
            this.period.Name = "period";
            this.period.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.period.SizeF = new System.Drawing.SizeF(500F, 24F);
            this.period.StylePriority.UseFont = false;
            this.period.StylePriority.UseForeColor = false;
            this.period.Text = "[Period]";
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
            this.lblTitle.Text = "SALES BY ORDER REPORT";
            // 
            // SalesByOrderReportControl
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.PageHeader,
            this.PageFooter,
            this.ReportHeader});
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(50, 50, 50, 50);
            this.PageHeight = 1169;
            this.PageWidth = 1654;
            this.PaperKind = System.Drawing.Printing.PaperKind.A3;
            this.StyleSheet.AddRange(new DevExpress.XtraReports.UI.XRControlStyle[] {
            this.PageInfo});
            this.Version = "15.2";
            ((System.ComponentModel.ISupportInitialize)(this.tableData)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tableHeader)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.PageHeaderBand PageHeader;
        private DevExpress.XtraReports.UI.XRControlStyle PageInfo;
        private DevExpress.XtraReports.UI.DetailBand Detail;
        public DevExpress.XtraReports.UI.XRTable tableData;
        public DevExpress.XtraReports.UI.XRTable tableHeader;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderSample;
        private DevExpress.XtraReports.UI.XRTableCell tableDataSample;
        public DevExpress.XtraReports.UI.XRTableRow tableDataRow;
        public DevExpress.XtraReports.UI.XRTableRow tableHeaderRow;
        private DevExpress.XtraReports.UI.XRPageInfo pageInfoRight;
        private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
        private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
        private DevExpress.XtraReports.UI.XRPageInfo pageInfoLeft;
        private DevExpress.XtraReports.UI.XRLabel periodLabel;
        public DevExpress.XtraReports.UI.XRLabel period;
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
        public DevExpress.XtraReports.UI.XRLabel lblTitle;
    }
}
