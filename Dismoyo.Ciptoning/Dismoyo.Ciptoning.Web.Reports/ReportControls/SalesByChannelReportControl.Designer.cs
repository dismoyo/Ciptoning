namespace Dismoyo.Ciptoning.Web.Reports.ReportControls
{
    partial class SalesByChannelReportControl
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
            this.xrTableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableDataChannel = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataProductBrand = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataProductGroup = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataLYActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataLMActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataTargetSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataAchActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataGrowthLYActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataGrowthLMActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataGapTargetVsActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
            this.pageHeaderLine = new DevExpress.XtraReports.UI.XRLine();
            this.tableHeader = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
            this.tableHeaderChannel = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderProductBrand = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderProductGroup = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderLYActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderLMActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderTarget = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderAchActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderGrowthLYActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderGrowthLMActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableHeaderGapTargetVsActualSalesOrder = new DevExpress.XtraReports.UI.XRTableCell();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.pageInfoLeft = new DevExpress.XtraReports.UI.XRPageInfo();
            this.pageInfoRight = new DevExpress.XtraReports.UI.XRPageInfo();
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
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
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
            this.xrTableRow1});
            this.tableData.SizeF = new System.Drawing.SizeF(1240F, 20F);
            this.tableData.StylePriority.UseBorderColor = false;
            this.tableData.StylePriority.UseBorders = false;
            this.tableData.StylePriority.UseFont = false;
            this.tableData.StylePriority.UseTextAlignment = false;
            this.tableData.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // xrTableRow1
            // 
            this.xrTableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableDataChannel,
            this.tableDataProductBrand,
            this.tableDataProductGroup,
            this.tableDataLYActualSalesOrder,
            this.tableDataLMActualSalesOrder,
            this.tableDataTargetSalesOrder,
            this.tableDataActualSalesOrder,
            this.tableDataAchActualSalesOrder,
            this.tableDataGrowthLYActualSalesOrder,
            this.tableDataGrowthLMActualSalesOrder,
            this.tableDataGapTargetVsActualSalesOrder});
            this.xrTableRow1.Name = "xrTableRow1";
            this.xrTableRow1.Weight = 1D;
            // 
            // tableDataChannel
            // 
            this.tableDataChannel.Name = "tableDataChannel";
            this.tableDataChannel.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataChannel.ProcessDuplicatesMode = DevExpress.XtraReports.UI.ProcessDuplicatesMode.Merge;
            this.tableDataChannel.StylePriority.UsePadding = false;
            this.tableDataChannel.Text = "tableDataChannel";
            this.tableDataChannel.Weight = 1.1269564840410711D;
            // 
            // tableDataProductBrand
            // 
            this.tableDataProductBrand.Name = "tableDataProductBrand";
            this.tableDataProductBrand.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataProductBrand.ProcessDuplicatesMode = DevExpress.XtraReports.UI.ProcessDuplicatesMode.Merge;
            this.tableDataProductBrand.StylePriority.UsePadding = false;
            this.tableDataProductBrand.Text = "tableDataProductBrand";
            this.tableDataProductBrand.Weight = 1.1269565318077144D;
            // 
            // tableDataProductGroup
            // 
            this.tableDataProductGroup.Name = "tableDataProductGroup";
            this.tableDataProductGroup.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataProductGroup.StylePriority.UsePadding = false;
            this.tableDataProductGroup.Text = "tableDataProductGroup";
            this.tableDataProductGroup.Weight = 0.62608695312351248D;
            // 
            // tableDataLYActualSalesOrder
            // 
            this.tableDataLYActualSalesOrder.Name = "tableDataLYActualSalesOrder";
            this.tableDataLYActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataLYActualSalesOrder.StylePriority.UsePadding = false;
            this.tableDataLYActualSalesOrder.StylePriority.UseTextAlignment = false;
            this.tableDataLYActualSalesOrder.Text = "tableDataLYActualSalesOrder";
            this.tableDataLYActualSalesOrder.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataLYActualSalesOrder.Weight = 0.56347825717514988D;
            // 
            // tableDataLMActualSalesOrder
            // 
            this.tableDataLMActualSalesOrder.Name = "tableDataLMActualSalesOrder";
            this.tableDataLMActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataLMActualSalesOrder.StylePriority.UsePadding = false;
            this.tableDataLMActualSalesOrder.StylePriority.UseTextAlignment = false;
            this.tableDataLMActualSalesOrder.Text = "tableDataLMActualSalesOrder";
            this.tableDataLMActualSalesOrder.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataLMActualSalesOrder.Weight = 0.56347825717514988D;
            // 
            // tableDataTargetSalesOrder
            // 
            this.tableDataTargetSalesOrder.Name = "tableDataTargetSalesOrder";
            this.tableDataTargetSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataTargetSalesOrder.StylePriority.UsePadding = false;
            this.tableDataTargetSalesOrder.StylePriority.UseTextAlignment = false;
            this.tableDataTargetSalesOrder.Text = "tableDataTargetSalesOrder";
            this.tableDataTargetSalesOrder.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataTargetSalesOrder.Weight = 0.56347825717514988D;
            // 
            // tableDataActualSalesOrder
            // 
            this.tableDataActualSalesOrder.Name = "tableDataActualSalesOrder";
            this.tableDataActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataActualSalesOrder.StylePriority.UsePadding = false;
            this.tableDataActualSalesOrder.StylePriority.UseTextAlignment = false;
            this.tableDataActualSalesOrder.Text = "tableDataActualSalesOrder";
            this.tableDataActualSalesOrder.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataActualSalesOrder.Weight = 0.56347825717514988D;
            // 
            // tableDataAchActualSalesOrder
            // 
            this.tableDataAchActualSalesOrder.Name = "tableDataAchActualSalesOrder";
            this.tableDataAchActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataAchActualSalesOrder.StylePriority.UsePadding = false;
            this.tableDataAchActualSalesOrder.StylePriority.UseTextAlignment = false;
            this.tableDataAchActualSalesOrder.Text = "tableDataAchActualSalesOrder";
            this.tableDataAchActualSalesOrder.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataAchActualSalesOrder.Weight = 0.56347825717514988D;
            // 
            // tableDataGrowthLYActualSalesOrder
            // 
            this.tableDataGrowthLYActualSalesOrder.Name = "tableDataGrowthLYActualSalesOrder";
            this.tableDataGrowthLYActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataGrowthLYActualSalesOrder.StylePriority.UsePadding = false;
            this.tableDataGrowthLYActualSalesOrder.StylePriority.UseTextAlignment = false;
            this.tableDataGrowthLYActualSalesOrder.Text = "tableDataGrowthLYActualSalesOrder";
            this.tableDataGrowthLYActualSalesOrder.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataGrowthLYActualSalesOrder.Weight = 0.62608695312351248D;
            // 
            // tableDataGrowthLMActualSalesOrder
            // 
            this.tableDataGrowthLMActualSalesOrder.Name = "tableDataGrowthLMActualSalesOrder";
            this.tableDataGrowthLMActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataGrowthLMActualSalesOrder.StylePriority.UsePadding = false;
            this.tableDataGrowthLMActualSalesOrder.StylePriority.UseTextAlignment = false;
            this.tableDataGrowthLMActualSalesOrder.Text = "tableDataGrowthLMActualSalesOrder";
            this.tableDataGrowthLMActualSalesOrder.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataGrowthLMActualSalesOrder.Weight = 0.62608695312351248D;
            // 
            // tableDataGapTargetVsActualSalesOrder
            // 
            this.tableDataGapTargetVsActualSalesOrder.Name = "tableDataGapTargetVsActualSalesOrder";
            this.tableDataGapTargetVsActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataGapTargetVsActualSalesOrder.StylePriority.UsePadding = false;
            this.tableDataGapTargetVsActualSalesOrder.StylePriority.UseTextAlignment = false;
            this.tableDataGapTargetVsActualSalesOrder.Text = "tableDataGapTargetVsActualSalesOrder";
            this.tableDataGapTargetVsActualSalesOrder.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataGapTargetVsActualSalesOrder.Weight = 0.81391313650188857D;
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
            this.pageHeaderLine,
            this.tableHeader});
            this.PageHeader.HeightF = 26F;
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
            // tableHeader
            // 
            this.tableHeader.BackColor = System.Drawing.Color.LightGray;
            this.tableHeader.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeader.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeader.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeader.LocationFloat = new DevExpress.Utils.PointFloat(0F, 6F);
            this.tableHeader.Name = "tableHeader";
            this.tableHeader.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow2});
            this.tableHeader.SizeF = new System.Drawing.SizeF(1240F, 20F);
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
            this.tableHeaderChannel,
            this.tableHeaderProductBrand,
            this.tableHeaderProductGroup,
            this.tableHeaderLYActualSalesOrder,
            this.tableHeaderLMActualSalesOrder,
            this.tableHeaderTarget,
            this.tableHeaderActualSalesOrder,
            this.tableHeaderAchActualSalesOrder,
            this.tableHeaderGrowthLYActualSalesOrder,
            this.tableHeaderGrowthLMActualSalesOrder,
            this.tableHeaderGapTargetVsActualSalesOrder});
            this.xrTableRow2.Name = "xrTableRow2";
            this.xrTableRow2.Weight = 1D;
            // 
            // tableHeaderChannel
            // 
            this.tableHeaderChannel.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderChannel.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderChannel.Name = "tableHeaderChannel";
            this.tableHeaderChannel.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderChannel.StylePriority.UseBorderColor = false;
            this.tableHeaderChannel.StylePriority.UseBorders = false;
            this.tableHeaderChannel.StylePriority.UsePadding = false;
            this.tableHeaderChannel.Text = "Channel";
            this.tableHeaderChannel.Weight = 1.2000000769020718D;
            // 
            // tableHeaderProductBrand
            // 
            this.tableHeaderProductBrand.Name = "tableHeaderProductBrand";
            this.tableHeaderProductBrand.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderProductBrand.StylePriority.UsePadding = false;
            this.tableHeaderProductBrand.Text = "Brand";
            this.tableHeaderProductBrand.Weight = 1.2000001182496587D;
            // 
            // tableHeaderProductGroup
            // 
            this.tableHeaderProductGroup.Name = "tableHeaderProductGroup";
            this.tableHeaderProductGroup.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderProductGroup.StylePriority.UsePadding = false;
            this.tableHeaderProductGroup.Text = "Product Group";
            this.tableHeaderProductGroup.Weight = 0.66666676179103D;
            // 
            // tableHeaderLYActualSalesOrder
            // 
            this.tableHeaderLYActualSalesOrder.Name = "tableHeaderLYActualSalesOrder";
            this.tableHeaderLYActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderLYActualSalesOrder.StylePriority.UsePadding = false;
            this.tableHeaderLYActualSalesOrder.Text = "Last Year";
            this.tableHeaderLYActualSalesOrder.Weight = 0.60000004617762714D;
            // 
            // tableHeaderLMActualSalesOrder
            // 
            this.tableHeaderLMActualSalesOrder.Name = "tableHeaderLMActualSalesOrder";
            this.tableHeaderLMActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderLMActualSalesOrder.StylePriority.UsePadding = false;
            this.tableHeaderLMActualSalesOrder.Text = "Last Month";
            this.tableHeaderLMActualSalesOrder.Weight = 0.60000004617762082D;
            // 
            // tableHeaderTarget
            // 
            this.tableHeaderTarget.Name = "tableHeaderTarget";
            this.tableHeaderTarget.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderTarget.StylePriority.UsePadding = false;
            this.tableHeaderTarget.Text = "Target";
            this.tableHeaderTarget.Weight = 0.60000004617762071D;
            // 
            // tableHeaderActualSalesOrder
            // 
            this.tableHeaderActualSalesOrder.Name = "tableHeaderActualSalesOrder";
            this.tableHeaderActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderActualSalesOrder.StylePriority.UsePadding = false;
            this.tableHeaderActualSalesOrder.Text = "Actual";
            this.tableHeaderActualSalesOrder.Weight = 0.60000004617762093D;
            // 
            // tableHeaderAchActualSalesOrder
            // 
            this.tableHeaderAchActualSalesOrder.Name = "tableHeaderAchActualSalesOrder";
            this.tableHeaderAchActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderAchActualSalesOrder.StylePriority.UsePadding = false;
            this.tableHeaderAchActualSalesOrder.Text = "Ach (%)";
            this.tableHeaderAchActualSalesOrder.Weight = 0.60000004617762071D;
            // 
            // tableHeaderGrowthLYActualSalesOrder
            // 
            this.tableHeaderGrowthLYActualSalesOrder.Name = "tableHeaderGrowthLYActualSalesOrder";
            this.tableHeaderGrowthLYActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderGrowthLYActualSalesOrder.StylePriority.UsePadding = false;
            this.tableHeaderGrowthLYActualSalesOrder.Text = "Growth LY (%)";
            this.tableHeaderGrowthLYActualSalesOrder.Weight = 0.66666671843494063D;
            // 
            // tableHeaderGrowthLMActualSalesOrder
            // 
            this.tableHeaderGrowthLMActualSalesOrder.Name = "tableHeaderGrowthLMActualSalesOrder";
            this.tableHeaderGrowthLMActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderGrowthLMActualSalesOrder.StylePriority.UsePadding = false;
            this.tableHeaderGrowthLMActualSalesOrder.Text = "Growth LM (%)";
            this.tableHeaderGrowthLMActualSalesOrder.Weight = 0.66666671843494052D;
            // 
            // tableHeaderGapTargetVsActualSalesOrder
            // 
            this.tableHeaderGapTargetVsActualSalesOrder.Name = "tableHeaderGapTargetVsActualSalesOrder";
            this.tableHeaderGapTargetVsActualSalesOrder.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableHeaderGapTargetVsActualSalesOrder.StylePriority.UsePadding = false;
            this.tableHeaderGapTargetVsActualSalesOrder.Text = "Gap Target vs Actual";
            this.tableHeaderGapTargetVsActualSalesOrder.Weight = 0.86666673520689985D;
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
            this.lblTitle.Text = "SALES BY CHANNEL {0}REPORT";
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
            // SalesByChannelReportControl
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
        private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
        private DevExpress.XtraReports.UI.XRPageInfo pageInfoLeft;
        private DevExpress.XtraReports.UI.XRPageInfo pageInfoRight;
        private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
        private DevExpress.XtraReports.UI.XRControlStyle PageInfo;
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
        private DevExpress.XtraReports.UI.XRLabel periodLabel;
        public DevExpress.XtraReports.UI.XRLabel period;
        public DevExpress.XtraReports.UI.XRTable tableData;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow1;
        public DevExpress.XtraReports.UI.XRTable tableHeader;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow2;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderChannel;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderProductBrand;
        public DevExpress.XtraReports.UI.XRTableCell tableDataChannel;
        private DevExpress.XtraReports.UI.DetailBand Detail;
        public DevExpress.XtraReports.UI.XRTableCell tableDataProductBrand;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderLYActualSalesOrder;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderLMActualSalesOrder;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderTarget;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderActualSalesOrder;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderAchActualSalesOrder;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderGrowthLYActualSalesOrder;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderGrowthLMActualSalesOrder;
        private DevExpress.XtraReports.UI.XRTableCell tableHeaderGapTargetVsActualSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataLYActualSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataLMActualSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataTargetSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataActualSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataAchActualSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataGrowthLYActualSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataGrowthLMActualSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataGapTargetVsActualSalesOrder;
        public DevExpress.XtraReports.UI.XRTableCell tableDataProductGroup;
        public DevExpress.XtraReports.UI.XRLabel lblTitle;
        private DevExpress.XtraReports.UI.XRLine pageHeaderLine;
        public DevExpress.XtraReports.UI.XRTableCell tableHeaderProductGroup;
    }
}
