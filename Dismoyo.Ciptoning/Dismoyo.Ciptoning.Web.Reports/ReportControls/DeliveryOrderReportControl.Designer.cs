namespace Dismoyo.Ciptoning.Web.Reports.ReportControls
{
    partial class DeliveryOrderReportControl
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
            this.tableDataProduct = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataProductLotCode = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOrderConvGood = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOrderConvHold = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataQtyOrderConvBad = new DevExpress.XtraReports.UI.XRTableCell();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.pageInfoLeft = new DevExpress.XtraReports.UI.XRPageInfo();
            this.pageInfoRight = new DevExpress.XtraReports.UI.XRPageInfo();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.tableHeaderProduct = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOrderConv = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOrderConvGood = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOrderConvHold = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOrderConvBad = new DevExpress.XtraReports.UI.XRLabel();
            this.productLotCode = new DevExpress.XtraReports.UI.XRLabel();
            this.shipmentDateLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.shipmentDate = new DevExpress.XtraReports.UI.XRLabel();
            this.siteTaxNumberLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.sourceSiteTaxNumber = new DevExpress.XtraReports.UI.XRLabel();
            this.sourceSiteCityZipCode = new DevExpress.XtraReports.UI.XRLabel();
            this.sourceSiteAddress = new DevExpress.XtraReports.UI.XRLabel();
            this.documentCodeLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.documentCode = new DevExpress.XtraReports.UI.XRLabel();
            this.refTransaction = new DevExpress.XtraReports.UI.XRLabel();
            this.refTransactionLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.sourceWarehouseSite = new DevExpress.XtraReports.UI.XRLabel();
            this.sourceCompany = new DevExpress.XtraReports.UI.XRLabel();
            this.destinationWarehouseSite = new DevExpress.XtraReports.UI.XRLabel();
            this.recipientLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.lblTitle = new DevExpress.XtraReports.UI.XRLabel();
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            this.receiverSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.receiverLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.driverLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.driverSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.approverSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.approverLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.warehousePICSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.warehousePICLabel = new DevExpress.XtraReports.UI.XRLabel();
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
            this.tableData.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableData.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.tableData.Name = "tableData";
            this.tableData.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.tableDataRow});
            this.tableData.SizeF = new System.Drawing.SizeF(720F, 20F);
            this.tableData.StylePriority.UseBorderColor = false;
            this.tableData.StylePriority.UseBorders = false;
            this.tableData.StylePriority.UseFont = false;
            this.tableData.StylePriority.UseTextAlignment = false;
            this.tableData.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // tableDataRow
            // 
            this.tableDataRow.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.tableDataProduct,
            this.tableDataProductLotCode,
            this.tableDataQtyOrderConvGood,
            this.tableDataQtyOrderConvHold,
            this.tableDataQtyOrderConvBad});
            this.tableDataRow.Name = "tableDataRow";
            this.tableDataRow.Weight = 1D;
            // 
            // tableDataProduct
            // 
            this.tableDataProduct.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataProduct.Name = "tableDataProduct";
            this.tableDataProduct.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataProduct.ProcessDuplicatesMode = DevExpress.XtraReports.UI.ProcessDuplicatesMode.Merge;
            this.tableDataProduct.StylePriority.UseFont = false;
            this.tableDataProduct.StylePriority.UsePadding = false;
            this.tableDataProduct.Text = "tableDataProduct";
            this.tableDataProduct.Weight = 1.9129362697439927D;
            // 
            // tableDataProductLotCode
            // 
            this.tableDataProductLotCode.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataProductLotCode.Name = "tableDataProductLotCode";
            this.tableDataProductLotCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataProductLotCode.StylePriority.UseFont = false;
            this.tableDataProductLotCode.StylePriority.UsePadding = false;
            this.tableDataProductLotCode.StylePriority.UseTextAlignment = false;
            this.tableDataProductLotCode.Text = "tableDataProductLotCode";
            this.tableDataProductLotCode.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataProductLotCode.Weight = 0.69351165648772906D;
            // 
            // tableDataQtyOrderConvGood
            // 
            this.tableDataQtyOrderConvGood.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataQtyOrderConvGood.Name = "tableDataQtyOrderConvGood";
            this.tableDataQtyOrderConvGood.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOrderConvGood.StylePriority.UseFont = false;
            this.tableDataQtyOrderConvGood.StylePriority.UsePadding = false;
            this.tableDataQtyOrderConvGood.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOrderConvGood.Text = "tableDataQtyOrderConvGood";
            this.tableDataQtyOrderConvGood.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOrderConvGood.Weight = 0.52013374836835358D;
            // 
            // tableDataQtyOrderConvHold
            // 
            this.tableDataQtyOrderConvHold.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataQtyOrderConvHold.Name = "tableDataQtyOrderConvHold";
            this.tableDataQtyOrderConvHold.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOrderConvHold.StylePriority.UseFont = false;
            this.tableDataQtyOrderConvHold.StylePriority.UsePadding = false;
            this.tableDataQtyOrderConvHold.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOrderConvHold.Text = "tableDataQtyOrderConvHold";
            this.tableDataQtyOrderConvHold.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOrderConvHold.Weight = 0.52013374836832182D;
            // 
            // tableDataQtyOrderConvBad
            // 
            this.tableDataQtyOrderConvBad.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataQtyOrderConvBad.Name = "tableDataQtyOrderConvBad";
            this.tableDataQtyOrderConvBad.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOrderConvBad.StylePriority.UseFont = false;
            this.tableDataQtyOrderConvBad.StylePriority.UsePadding = false;
            this.tableDataQtyOrderConvBad.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOrderConvBad.Text = "tableDataQtyOrderConvBad";
            this.tableDataQtyOrderConvBad.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOrderConvBad.Weight = 0.51435439575760489D;
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
            this.PageHeader.HeightF = 0F;
            this.PageHeader.Name = "PageHeader";
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
            this.pageInfoLeft.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pageInfoLeft.ForeColor = System.Drawing.Color.Gray;
            this.pageInfoLeft.LocationFloat = new DevExpress.Utils.PointFloat(6.00001F, 6.00001F);
            this.pageInfoLeft.Name = "pageInfoLeft";
            this.pageInfoLeft.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.pageInfoLeft.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime;
            this.pageInfoLeft.SizeF = new System.Drawing.SizeF(218.2083F, 23F);
            this.pageInfoLeft.StyleName = "PageInfo";
            this.pageInfoLeft.StylePriority.UseFont = false;
            this.pageInfoLeft.StylePriority.UseForeColor = false;
            // 
            // pageInfoRight
            // 
            this.pageInfoRight.AnchorHorizontal = DevExpress.XtraReports.UI.HorizontalAnchorStyles.Right;
            this.pageInfoRight.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pageInfoRight.ForeColor = System.Drawing.Color.Gray;
            this.pageInfoRight.Format = "Page {0} of {1}";
            this.pageInfoRight.LocationFloat = new DevExpress.Utils.PointFloat(591.3333F, 6.00001F);
            this.pageInfoRight.Name = "pageInfoRight";
            this.pageInfoRight.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.pageInfoRight.SizeF = new System.Drawing.SizeF(129.6667F, 23F);
            this.pageInfoRight.StyleName = "PageInfo";
            this.pageInfoRight.StylePriority.UseFont = false;
            this.pageInfoRight.StylePriority.UseForeColor = false;
            this.pageInfoRight.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // ReportHeader
            // 
            this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.tableHeaderProduct,
            this.tableHeaderQtyOrderConv,
            this.tableHeaderQtyOrderConvGood,
            this.tableHeaderQtyOrderConvHold,
            this.tableHeaderQtyOrderConvBad,
            this.productLotCode,
            this.shipmentDateLabel,
            this.shipmentDate,
            this.siteTaxNumberLabel,
            this.sourceSiteTaxNumber,
            this.sourceSiteCityZipCode,
            this.sourceSiteAddress,
            this.documentCodeLabel,
            this.documentCode,
            this.refTransaction,
            this.refTransactionLabel,
            this.sourceWarehouseSite,
            this.sourceCompany,
            this.destinationWarehouseSite,
            this.recipientLabel,
            this.lblTitle});
            this.ReportHeader.HeightF = 225F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // tableHeaderProduct
            // 
            this.tableHeaderProduct.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderProduct.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderProduct.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderProduct.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderProduct.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderProduct.LocationFloat = new DevExpress.Utils.PointFloat(0F, 186F);
            this.tableHeaderProduct.Name = "tableHeaderProduct";
            this.tableHeaderProduct.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderProduct.SizeF = new System.Drawing.SizeF(330F, 39F);
            this.tableHeaderProduct.StylePriority.UseBackColor = false;
            this.tableHeaderProduct.StylePriority.UseBorderColor = false;
            this.tableHeaderProduct.StylePriority.UseBorders = false;
            this.tableHeaderProduct.StylePriority.UseFont = false;
            this.tableHeaderProduct.StylePriority.UseForeColor = false;
            this.tableHeaderProduct.StylePriority.UseTextAlignment = false;
            this.tableHeaderProduct.Text = "Product";
            this.tableHeaderProduct.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOrderConv
            // 
            this.tableHeaderQtyOrderConv.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOrderConv.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOrderConv.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right)));
            this.tableHeaderQtyOrderConv.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOrderConv.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOrderConv.LocationFloat = new DevExpress.Utils.PointFloat(450F, 186F);
            this.tableHeaderQtyOrderConv.Name = "tableHeaderQtyOrderConv";
            this.tableHeaderQtyOrderConv.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOrderConv.SizeF = new System.Drawing.SizeF(270F, 18F);
            this.tableHeaderQtyOrderConv.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseBorders = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseFont = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOrderConv.Text = "Qty (L/M/S)";
            this.tableHeaderQtyOrderConv.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOrderConvGood
            // 
            this.tableHeaderQtyOrderConvGood.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOrderConvGood.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOrderConvGood.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOrderConvGood.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOrderConvGood.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOrderConvGood.LocationFloat = new DevExpress.Utils.PointFloat(450F, 204F);
            this.tableHeaderQtyOrderConvGood.Name = "tableHeaderQtyOrderConvGood";
            this.tableHeaderQtyOrderConvGood.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOrderConvGood.SizeF = new System.Drawing.SizeF(90F, 18F);
            this.tableHeaderQtyOrderConvGood.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOrderConvGood.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOrderConvGood.StylePriority.UseBorders = false;
            this.tableHeaderQtyOrderConvGood.StylePriority.UseFont = false;
            this.tableHeaderQtyOrderConvGood.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOrderConvGood.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOrderConvGood.Text = "Good";
            this.tableHeaderQtyOrderConvGood.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOrderConvHold
            // 
            this.tableHeaderQtyOrderConvHold.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOrderConvHold.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOrderConvHold.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOrderConvHold.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOrderConvHold.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOrderConvHold.LocationFloat = new DevExpress.Utils.PointFloat(540F, 204F);
            this.tableHeaderQtyOrderConvHold.Name = "tableHeaderQtyOrderConvHold";
            this.tableHeaderQtyOrderConvHold.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOrderConvHold.SizeF = new System.Drawing.SizeF(90F, 18F);
            this.tableHeaderQtyOrderConvHold.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOrderConvHold.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOrderConvHold.StylePriority.UseBorders = false;
            this.tableHeaderQtyOrderConvHold.StylePriority.UseFont = false;
            this.tableHeaderQtyOrderConvHold.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOrderConvHold.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOrderConvHold.Text = "Hold";
            this.tableHeaderQtyOrderConvHold.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOrderConvBad
            // 
            this.tableHeaderQtyOrderConvBad.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOrderConvBad.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOrderConvBad.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOrderConvBad.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOrderConvBad.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOrderConvBad.LocationFloat = new DevExpress.Utils.PointFloat(630F, 204F);
            this.tableHeaderQtyOrderConvBad.Name = "tableHeaderQtyOrderConvBad";
            this.tableHeaderQtyOrderConvBad.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOrderConvBad.SizeF = new System.Drawing.SizeF(90F, 18F);
            this.tableHeaderQtyOrderConvBad.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOrderConvBad.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOrderConvBad.StylePriority.UseBorders = false;
            this.tableHeaderQtyOrderConvBad.StylePriority.UseFont = false;
            this.tableHeaderQtyOrderConvBad.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOrderConvBad.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOrderConvBad.Text = "Bad";
            this.tableHeaderQtyOrderConvBad.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // productLotCode
            // 
            this.productLotCode.BackColor = System.Drawing.Color.LightGray;
            this.productLotCode.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.productLotCode.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.productLotCode.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.productLotCode.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.productLotCode.LocationFloat = new DevExpress.Utils.PointFloat(330F, 186F);
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
            // shipmentDateLabel
            // 
            this.shipmentDateLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.shipmentDateLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.shipmentDateLabel.LocationFloat = new DevExpress.Utils.PointFloat(400F, 60.00001F);
            this.shipmentDateLabel.Name = "shipmentDateLabel";
            this.shipmentDateLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.shipmentDateLabel.SizeF = new System.Drawing.SizeF(110F, 20F);
            this.shipmentDateLabel.StylePriority.UseFont = false;
            this.shipmentDateLabel.StylePriority.UseForeColor = false;
            this.shipmentDateLabel.Text = "Shipment Date:";
            // 
            // shipmentDate
            // 
            this.shipmentDate.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.shipmentDate.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.shipmentDate.LocationFloat = new DevExpress.Utils.PointFloat(514F, 60.00001F);
            this.shipmentDate.Name = "shipmentDate";
            this.shipmentDate.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.shipmentDate.SizeF = new System.Drawing.SizeF(206F, 20F);
            this.shipmentDate.StylePriority.UseFont = false;
            this.shipmentDate.StylePriority.UseForeColor = false;
            this.shipmentDate.Text = "[ShipmentDate]";
            // 
            // siteTaxNumberLabel
            // 
            this.siteTaxNumberLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.siteTaxNumberLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.siteTaxNumberLabel.LocationFloat = new DevExpress.Utils.PointFloat(6.000001F, 120F);
            this.siteTaxNumberLabel.Name = "siteTaxNumberLabel";
            this.siteTaxNumberLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.siteTaxNumberLabel.SizeF = new System.Drawing.SizeF(80F, 20F);
            this.siteTaxNumberLabel.StylePriority.UseFont = false;
            this.siteTaxNumberLabel.StylePriority.UseForeColor = false;
            this.siteTaxNumberLabel.Text = "Tax Number:";
            // 
            // sourceSiteTaxNumber
            // 
            this.sourceSiteTaxNumber.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.sourceSiteTaxNumber.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.sourceSiteTaxNumber.LocationFloat = new DevExpress.Utils.PointFloat(90.00002F, 120F);
            this.sourceSiteTaxNumber.Name = "sourceSiteTaxNumber";
            this.sourceSiteTaxNumber.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.sourceSiteTaxNumber.SizeF = new System.Drawing.SizeF(306F, 20F);
            this.sourceSiteTaxNumber.StylePriority.UseFont = false;
            this.sourceSiteTaxNumber.StylePriority.UseForeColor = false;
            this.sourceSiteTaxNumber.Text = "[SourceSiteTaxNumber]";
            // 
            // sourceSiteCityZipCode
            // 
            this.sourceSiteCityZipCode.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.sourceSiteCityZipCode.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.sourceSiteCityZipCode.LocationFloat = new DevExpress.Utils.PointFloat(6F, 100F);
            this.sourceSiteCityZipCode.Name = "sourceSiteCityZipCode";
            this.sourceSiteCityZipCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.sourceSiteCityZipCode.SizeF = new System.Drawing.SizeF(390F, 20F);
            this.sourceSiteCityZipCode.StylePriority.UseFont = false;
            this.sourceSiteCityZipCode.StylePriority.UseForeColor = false;
            this.sourceSiteCityZipCode.Text = "[SourceSiteCityZipCode]";
            // 
            // sourceSiteAddress
            // 
            this.sourceSiteAddress.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.sourceSiteAddress.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.sourceSiteAddress.LocationFloat = new DevExpress.Utils.PointFloat(6F, 80F);
            this.sourceSiteAddress.Name = "sourceSiteAddress";
            this.sourceSiteAddress.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.sourceSiteAddress.SizeF = new System.Drawing.SizeF(390F, 20F);
            this.sourceSiteAddress.StylePriority.UseFont = false;
            this.sourceSiteAddress.StylePriority.UseForeColor = false;
            this.sourceSiteAddress.Text = "[SourceSiteAddress]";
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
            this.documentCode.LocationFloat = new DevExpress.Utils.PointFloat(513.9999F, 39.99999F);
            this.documentCode.Name = "documentCode";
            this.documentCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.documentCode.SizeF = new System.Drawing.SizeF(206F, 20F);
            this.documentCode.StylePriority.UseFont = false;
            this.documentCode.StylePriority.UseForeColor = false;
            this.documentCode.Text = "[DocumentCode]";
            // 
            // refTransaction
            // 
            this.refTransaction.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.refTransaction.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.refTransaction.LocationFloat = new DevExpress.Utils.PointFloat(514F, 80F);
            this.refTransaction.Name = "refTransaction";
            this.refTransaction.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.refTransaction.SizeF = new System.Drawing.SizeF(206F, 20F);
            this.refTransaction.StylePriority.UseFont = false;
            this.refTransaction.StylePriority.UseForeColor = false;
            this.refTransaction.Text = "[RefTransaction]";
            // 
            // refTransactionLabel
            // 
            this.refTransactionLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.refTransactionLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.refTransactionLabel.LocationFloat = new DevExpress.Utils.PointFloat(400F, 80F);
            this.refTransactionLabel.Name = "refTransactionLabel";
            this.refTransactionLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.refTransactionLabel.SizeF = new System.Drawing.SizeF(110F, 20F);
            this.refTransactionLabel.StylePriority.UseFont = false;
            this.refTransactionLabel.StylePriority.UseForeColor = false;
            this.refTransactionLabel.Text = "Ref. Transaction:";
            // 
            // sourceWarehouseSite
            // 
            this.sourceWarehouseSite.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.sourceWarehouseSite.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.sourceWarehouseSite.LocationFloat = new DevExpress.Utils.PointFloat(6.000001F, 60.00002F);
            this.sourceWarehouseSite.Name = "sourceWarehouseSite";
            this.sourceWarehouseSite.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.sourceWarehouseSite.SizeF = new System.Drawing.SizeF(390F, 20F);
            this.sourceWarehouseSite.StylePriority.UseFont = false;
            this.sourceWarehouseSite.StylePriority.UseForeColor = false;
            this.sourceWarehouseSite.Text = "[SourceWarehouseSite]";
            // 
            // sourceCompany
            // 
            this.sourceCompany.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.sourceCompany.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.sourceCompany.LocationFloat = new DevExpress.Utils.PointFloat(6.000001F, 35.99999F);
            this.sourceCompany.Name = "sourceCompany";
            this.sourceCompany.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.sourceCompany.SizeF = new System.Drawing.SizeF(390F, 24F);
            this.sourceCompany.StylePriority.UseFont = false;
            this.sourceCompany.StylePriority.UseForeColor = false;
            this.sourceCompany.Text = "[SourceCompany]";
            // 
            // destinationWarehouseSite
            // 
            this.destinationWarehouseSite.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.destinationWarehouseSite.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.destinationWarehouseSite.LocationFloat = new DevExpress.Utils.PointFloat(90F, 150F);
            this.destinationWarehouseSite.Name = "destinationWarehouseSite";
            this.destinationWarehouseSite.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.destinationWarehouseSite.SizeF = new System.Drawing.SizeF(306F, 20F);
            this.destinationWarehouseSite.StylePriority.UseFont = false;
            this.destinationWarehouseSite.StylePriority.UseForeColor = false;
            this.destinationWarehouseSite.Text = "[DestinationWarehouseSite]";
            // 
            // recipientLabel
            // 
            this.recipientLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.recipientLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.recipientLabel.LocationFloat = new DevExpress.Utils.PointFloat(6F, 150F);
            this.recipientLabel.Name = "recipientLabel";
            this.recipientLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.recipientLabel.SizeF = new System.Drawing.SizeF(80F, 20F);
            this.recipientLabel.StylePriority.UseFont = false;
            this.recipientLabel.StylePriority.UseForeColor = false;
            this.recipientLabel.Text = "Recipient:";
            // 
            // lblTitle
            // 
            this.lblTitle.Font = new System.Drawing.Font("Calibri", 16F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTitle.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.lblTitle.LocationFloat = new DevExpress.Utils.PointFloat(6.00001F, 0F);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblTitle.SizeF = new System.Drawing.SizeF(715F, 33F);
            this.lblTitle.StylePriority.UseFont = false;
            this.lblTitle.StylePriority.UseForeColor = false;
            this.lblTitle.StylePriority.UseTextAlignment = false;
            this.lblTitle.Text = "DELIVERY ORDER";
            this.lblTitle.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
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
            this.receiverSignatureLabel,
            this.receiverLabel,
            this.driverLabel,
            this.driverSignatureLabel,
            this.approverSignatureLabel,
            this.approverLabel,
            this.warehousePICSignatureLabel,
            this.warehousePICLabel});
            this.ReportFooter.HeightF = 108F;
            this.ReportFooter.KeepTogether = true;
            this.ReportFooter.Name = "ReportFooter";
            // 
            // receiverSignatureLabel
            // 
            this.receiverSignatureLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.receiverSignatureLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.receiverSignatureLabel.LocationFloat = new DevExpress.Utils.PointFloat(570F, 84F);
            this.receiverSignatureLabel.Name = "receiverSignatureLabel";
            this.receiverSignatureLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.receiverSignatureLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.receiverSignatureLabel.StylePriority.UseFont = false;
            this.receiverSignatureLabel.StylePriority.UseForeColor = false;
            this.receiverSignatureLabel.StylePriority.UseTextAlignment = false;
            this.receiverSignatureLabel.Text = "(                                    )";
            this.receiverSignatureLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // receiverLabel
            // 
            this.receiverLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.receiverLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.receiverLabel.LocationFloat = new DevExpress.Utils.PointFloat(570F, 16F);
            this.receiverLabel.Name = "receiverLabel";
            this.receiverLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.receiverLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.receiverLabel.StylePriority.UseFont = false;
            this.receiverLabel.StylePriority.UseForeColor = false;
            this.receiverLabel.StylePriority.UseTextAlignment = false;
            this.receiverLabel.Text = "Received by,";
            this.receiverLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // driverLabel
            // 
            this.driverLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.driverLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.driverLabel.LocationFloat = new DevExpress.Utils.PointFloat(380F, 14F);
            this.driverLabel.Name = "driverLabel";
            this.driverLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.driverLabel.SizeF = new System.Drawing.SizeF(150F, 24F);
            this.driverLabel.StylePriority.UseFont = false;
            this.driverLabel.StylePriority.UseForeColor = false;
            this.driverLabel.StylePriority.UseTextAlignment = false;
            this.driverLabel.Text = "Driver,";
            this.driverLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
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
            // DeliveryOrderReportControl
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
            this.PageHeight = 583;
            this.PageWidth = 827;
            this.PaperKind = System.Drawing.Printing.PaperKind.A5;
            this.StyleSheet.AddRange(new DevExpress.XtraReports.UI.XRControlStyle[] {
            this.PageInfo});
            this.Version = "15.2";
            ((System.ComponentModel.ISupportInitialize)(this.tableData)).EndInit();
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
        public DevExpress.XtraReports.UI.XRLabel sourceWarehouseSite;
        public DevExpress.XtraReports.UI.XRLabel sourceCompany;
        public DevExpress.XtraReports.UI.XRLabel destinationWarehouseSite;
        private DevExpress.XtraReports.UI.XRLabel recipientLabel;
        public DevExpress.XtraReports.UI.XRTable tableData;
        private DevExpress.XtraReports.UI.XRTableRow tableDataRow;
        public DevExpress.XtraReports.UI.XRTableCell tableDataProduct;
        private DevExpress.XtraReports.UI.DetailBand Detail;
        public DevExpress.XtraReports.UI.XRTableCell tableDataProductLotCode;
        public DevExpress.XtraReports.UI.XRLabel lblTitle;
        private DevExpress.XtraReports.UI.XRLabel documentCodeLabel;
        public DevExpress.XtraReports.UI.XRLabel documentCode;
        public DevExpress.XtraReports.UI.XRLabel refTransaction;
        private DevExpress.XtraReports.UI.XRLabel refTransactionLabel;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOrderConvGood;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOrderConvHold;
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOrderConvBad;
        public DevExpress.XtraReports.UI.XRLabel sourceSiteAddress;
        private DevExpress.XtraReports.UI.XRLabel siteTaxNumberLabel;
        public DevExpress.XtraReports.UI.XRLabel sourceSiteTaxNumber;
        public DevExpress.XtraReports.UI.XRLabel sourceSiteCityZipCode;
        private DevExpress.XtraReports.UI.ReportFooterBand ReportFooter;
        public DevExpress.XtraReports.UI.XRLabel receiverSignatureLabel;
        public DevExpress.XtraReports.UI.XRLabel receiverLabel;
        public DevExpress.XtraReports.UI.XRLabel driverLabel;
        public DevExpress.XtraReports.UI.XRLabel driverSignatureLabel;
        public DevExpress.XtraReports.UI.XRLabel approverSignatureLabel;
        public DevExpress.XtraReports.UI.XRLabel approverLabel;
        public DevExpress.XtraReports.UI.XRLabel warehousePICSignatureLabel;
        public DevExpress.XtraReports.UI.XRLabel warehousePICLabel;
        private DevExpress.XtraReports.UI.XRLabel shipmentDateLabel;
        public DevExpress.XtraReports.UI.XRLabel shipmentDate;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderProduct;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOrderConv;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOrderConvGood;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOrderConvHold;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOrderConvBad;
        private DevExpress.XtraReports.UI.XRLabel productLotCode;
    }
}
