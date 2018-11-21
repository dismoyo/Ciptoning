namespace Dismoyo.Ciptoning.Web.Reports.ReportControls
{
    partial class ExtDeliveryOrderReportControl
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
            this.tableDataQtyOrderConv = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataUnitPrice = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataSubtotalDiscount = new DevExpress.XtraReports.UI.XRTableCell();
            this.tableDataSubtotal = new DevExpress.XtraReports.UI.XRTableCell();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.pageInfoLeft = new DevExpress.XtraReports.UI.XRPageInfo();
            this.pageInfoRight = new DevExpress.XtraReports.UI.XRPageInfo();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.tableHeaderProduct = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderUnitPrice = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderSubtotalDiscount = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderSubtotal = new DevExpress.XtraReports.UI.XRLabel();
            this.productLotCode = new DevExpress.XtraReports.UI.XRLabel();
            this.tableHeaderQtyOrderConv = new DevExpress.XtraReports.UI.XRLabel();
            this.customerTaxNumberLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.customerTaxNumber = new DevExpress.XtraReports.UI.XRLabel();
            this.customerCityZipCode = new DevExpress.XtraReports.UI.XRLabel();
            this.customer = new DevExpress.XtraReports.UI.XRLabel();
            this.customerAddress = new DevExpress.XtraReports.UI.XRLabel();
            this.shipmentDateLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.shipmentDate = new DevExpress.XtraReports.UI.XRLabel();
            this.siteTaxNumberLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.siteTaxNumber = new DevExpress.XtraReports.UI.XRLabel();
            this.siteCityZipCode = new DevExpress.XtraReports.UI.XRLabel();
            this.siteAddress = new DevExpress.XtraReports.UI.XRLabel();
            this.documentCodeLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.documentCode = new DevExpress.XtraReports.UI.XRLabel();
            this.refTransaction = new DevExpress.XtraReports.UI.XRLabel();
            this.refTransactionLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.warehouseSite = new DevExpress.XtraReports.UI.XRLabel();
            this.company = new DevExpress.XtraReports.UI.XRLabel();
            this.recipientLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.lblTitle = new DevExpress.XtraReports.UI.XRLabel();
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            this.note = new DevExpress.XtraReports.UI.XRLabel();
            this.noteLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.total = new DevExpress.XtraReports.UI.XRLabel();
            this.totalLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.receiverSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.receiverLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.driverLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.driverSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.approverSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.approverLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.warehousePICSignatureLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.warehousePICLabel = new DevExpress.XtraReports.UI.XRLabel();
            this.GroupFooter = new DevExpress.XtraReports.UI.GroupFooterBand();
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
            this.tableDataRow});
            this.tableData.SizeF = new System.Drawing.SizeF(719F, 20F);
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
            this.tableDataQtyOrderConv,
            this.tableDataUnitPrice,
            this.tableDataSubtotalDiscount,
            this.tableDataSubtotal});
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
            this.tableDataProduct.Weight = 1.6181938242509009D;
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
            this.tableDataProductLotCode.Weight = 0.57792638374534011D;
            // 
            // tableDataQtyOrderConv
            // 
            this.tableDataQtyOrderConv.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataQtyOrderConv.Name = "tableDataQtyOrderConv";
            this.tableDataQtyOrderConv.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataQtyOrderConv.StylePriority.UseFont = false;
            this.tableDataQtyOrderConv.StylePriority.UsePadding = false;
            this.tableDataQtyOrderConv.StylePriority.UseTextAlignment = false;
            this.tableDataQtyOrderConv.Text = "tableDataQtyOrderConv";
            this.tableDataQtyOrderConv.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataQtyOrderConv.Weight = 0.40454847562596463D;
            // 
            // tableDataUnitPrice
            // 
            this.tableDataUnitPrice.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataUnitPrice.Name = "tableDataUnitPrice";
            this.tableDataUnitPrice.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataUnitPrice.StylePriority.UseFont = false;
            this.tableDataUnitPrice.StylePriority.UsePadding = false;
            this.tableDataUnitPrice.StylePriority.UseTextAlignment = false;
            this.tableDataUnitPrice.Text = "tableDataUnitPrice";
            this.tableDataUnitPrice.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataUnitPrice.Weight = 0.52013374836832171D;
            // 
            // tableDataSubtotalDiscount
            // 
            this.tableDataSubtotalDiscount.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataSubtotalDiscount.Name = "tableDataSubtotalDiscount";
            this.tableDataSubtotalDiscount.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataSubtotalDiscount.StylePriority.UseFont = false;
            this.tableDataSubtotalDiscount.StylePriority.UsePadding = false;
            this.tableDataSubtotalDiscount.StylePriority.UseTextAlignment = false;
            this.tableDataSubtotalDiscount.Text = "tableDataSubtotalDiscount";
            this.tableDataSubtotalDiscount.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataSubtotalDiscount.Weight = 0.52013365939472433D;
            // 
            // tableDataSubtotal
            // 
            this.tableDataSubtotal.Font = new System.Drawing.Font("Calibri", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableDataSubtotal.Name = "tableDataSubtotal";
            this.tableDataSubtotal.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 3, 0, 0, 100F);
            this.tableDataSubtotal.StylePriority.UseFont = false;
            this.tableDataSubtotal.StylePriority.UsePadding = false;
            this.tableDataSubtotal.StylePriority.UseTextAlignment = false;
            this.tableDataSubtotal.Text = "tableDataSubtotal";
            this.tableDataSubtotal.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.tableDataSubtotal.Weight = 0.5143543958519744D;
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
            this.tableHeaderUnitPrice,
            this.tableHeaderSubtotalDiscount,
            this.tableHeaderSubtotal,
            this.productLotCode,
            this.tableHeaderQtyOrderConv,
            this.customerTaxNumberLabel,
            this.customerTaxNumber,
            this.customerCityZipCode,
            this.customer,
            this.customerAddress,
            this.shipmentDateLabel,
            this.shipmentDate,
            this.siteTaxNumberLabel,
            this.siteTaxNumber,
            this.siteCityZipCode,
            this.siteAddress,
            this.documentCodeLabel,
            this.documentCode,
            this.refTransaction,
            this.refTransactionLabel,
            this.warehouseSite,
            this.company,
            this.recipientLabel,
            this.lblTitle});
            this.ReportHeader.HeightF = 264F;
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
            this.tableHeaderProduct.LocationFloat = new DevExpress.Utils.PointFloat(0F, 246F);
            this.tableHeaderProduct.Name = "tableHeaderProduct";
            this.tableHeaderProduct.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderProduct.SizeF = new System.Drawing.SizeF(280F, 18F);
            this.tableHeaderProduct.StylePriority.UseBackColor = false;
            this.tableHeaderProduct.StylePriority.UseBorderColor = false;
            this.tableHeaderProduct.StylePriority.UseBorders = false;
            this.tableHeaderProduct.StylePriority.UseFont = false;
            this.tableHeaderProduct.StylePriority.UseForeColor = false;
            this.tableHeaderProduct.StylePriority.UseTextAlignment = false;
            this.tableHeaderProduct.Text = "Product";
            this.tableHeaderProduct.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderUnitPrice
            // 
            this.tableHeaderUnitPrice.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderUnitPrice.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderUnitPrice.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderUnitPrice.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderUnitPrice.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderUnitPrice.LocationFloat = new DevExpress.Utils.PointFloat(450F, 246F);
            this.tableHeaderUnitPrice.Name = "tableHeaderUnitPrice";
            this.tableHeaderUnitPrice.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderUnitPrice.SizeF = new System.Drawing.SizeF(90F, 18F);
            this.tableHeaderUnitPrice.StylePriority.UseBackColor = false;
            this.tableHeaderUnitPrice.StylePriority.UseBorderColor = false;
            this.tableHeaderUnitPrice.StylePriority.UseBorders = false;
            this.tableHeaderUnitPrice.StylePriority.UseFont = false;
            this.tableHeaderUnitPrice.StylePriority.UseForeColor = false;
            this.tableHeaderUnitPrice.StylePriority.UseTextAlignment = false;
            this.tableHeaderUnitPrice.Text = "Unit Price";
            this.tableHeaderUnitPrice.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderSubtotalDiscount
            // 
            this.tableHeaderSubtotalDiscount.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderSubtotalDiscount.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderSubtotalDiscount.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderSubtotalDiscount.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderSubtotalDiscount.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderSubtotalDiscount.LocationFloat = new DevExpress.Utils.PointFloat(540F, 246F);
            this.tableHeaderSubtotalDiscount.Name = "tableHeaderSubtotalDiscount";
            this.tableHeaderSubtotalDiscount.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderSubtotalDiscount.SizeF = new System.Drawing.SizeF(90F, 18F);
            this.tableHeaderSubtotalDiscount.StylePriority.UseBackColor = false;
            this.tableHeaderSubtotalDiscount.StylePriority.UseBorderColor = false;
            this.tableHeaderSubtotalDiscount.StylePriority.UseBorders = false;
            this.tableHeaderSubtotalDiscount.StylePriority.UseFont = false;
            this.tableHeaderSubtotalDiscount.StylePriority.UseForeColor = false;
            this.tableHeaderSubtotalDiscount.StylePriority.UseTextAlignment = false;
            this.tableHeaderSubtotalDiscount.Text = "Disc";
            this.tableHeaderSubtotalDiscount.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderSubtotal
            // 
            this.tableHeaderSubtotal.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderSubtotal.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderSubtotal.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderSubtotal.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderSubtotal.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderSubtotal.LocationFloat = new DevExpress.Utils.PointFloat(630F, 246F);
            this.tableHeaderSubtotal.Name = "tableHeaderSubtotal";
            this.tableHeaderSubtotal.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderSubtotal.SizeF = new System.Drawing.SizeF(90F, 18F);
            this.tableHeaderSubtotal.StylePriority.UseBackColor = false;
            this.tableHeaderSubtotal.StylePriority.UseBorderColor = false;
            this.tableHeaderSubtotal.StylePriority.UseBorders = false;
            this.tableHeaderSubtotal.StylePriority.UseFont = false;
            this.tableHeaderSubtotal.StylePriority.UseForeColor = false;
            this.tableHeaderSubtotal.StylePriority.UseTextAlignment = false;
            this.tableHeaderSubtotal.Text = "Subtotal";
            this.tableHeaderSubtotal.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // productLotCode
            // 
            this.productLotCode.BackColor = System.Drawing.Color.LightGray;
            this.productLotCode.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.productLotCode.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.productLotCode.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.productLotCode.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.productLotCode.LocationFloat = new DevExpress.Utils.PointFloat(280F, 246F);
            this.productLotCode.Name = "productLotCode";
            this.productLotCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.productLotCode.SizeF = new System.Drawing.SizeF(100F, 18F);
            this.productLotCode.StylePriority.UseBackColor = false;
            this.productLotCode.StylePriority.UseBorderColor = false;
            this.productLotCode.StylePriority.UseBorders = false;
            this.productLotCode.StylePriority.UseFont = false;
            this.productLotCode.StylePriority.UseForeColor = false;
            this.productLotCode.StylePriority.UseTextAlignment = false;
            this.productLotCode.Text = "Lot Number";
            this.productLotCode.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // tableHeaderQtyOrderConv
            // 
            this.tableHeaderQtyOrderConv.BackColor = System.Drawing.Color.LightGray;
            this.tableHeaderQtyOrderConv.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(159)))), ((int)(((byte)(159)))), ((int)(((byte)(159)))));
            this.tableHeaderQtyOrderConv.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.tableHeaderQtyOrderConv.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tableHeaderQtyOrderConv.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.tableHeaderQtyOrderConv.LocationFloat = new DevExpress.Utils.PointFloat(380F, 246F);
            this.tableHeaderQtyOrderConv.Name = "tableHeaderQtyOrderConv";
            this.tableHeaderQtyOrderConv.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.tableHeaderQtyOrderConv.SizeF = new System.Drawing.SizeF(70F, 18F);
            this.tableHeaderQtyOrderConv.StylePriority.UseBackColor = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseBorderColor = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseBorders = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseFont = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseForeColor = false;
            this.tableHeaderQtyOrderConv.StylePriority.UseTextAlignment = false;
            this.tableHeaderQtyOrderConv.Text = "Qty";
            this.tableHeaderQtyOrderConv.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // customerTaxNumberLabel
            // 
            this.customerTaxNumberLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.customerTaxNumberLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.customerTaxNumberLabel.LocationFloat = new DevExpress.Utils.PointFloat(90.00001F, 210F);
            this.customerTaxNumberLabel.Name = "customerTaxNumberLabel";
            this.customerTaxNumberLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.customerTaxNumberLabel.SizeF = new System.Drawing.SizeF(80F, 20F);
            this.customerTaxNumberLabel.StylePriority.UseFont = false;
            this.customerTaxNumberLabel.StylePriority.UseForeColor = false;
            this.customerTaxNumberLabel.Text = "Tax Number:";
            // 
            // customerTaxNumber
            // 
            this.customerTaxNumber.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.customerTaxNumber.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.customerTaxNumber.LocationFloat = new DevExpress.Utils.PointFloat(174F, 210F);
            this.customerTaxNumber.Name = "customerTaxNumber";
            this.customerTaxNumber.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.customerTaxNumber.SizeF = new System.Drawing.SizeF(222F, 20F);
            this.customerTaxNumber.StylePriority.UseFont = false;
            this.customerTaxNumber.StylePriority.UseForeColor = false;
            this.customerTaxNumber.Text = "[CustomerTaxNumber]";
            // 
            // customerCityZipCode
            // 
            this.customerCityZipCode.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.customerCityZipCode.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.customerCityZipCode.LocationFloat = new DevExpress.Utils.PointFloat(90.00001F, 190F);
            this.customerCityZipCode.Name = "customerCityZipCode";
            this.customerCityZipCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.customerCityZipCode.SizeF = new System.Drawing.SizeF(306F, 20.00002F);
            this.customerCityZipCode.StylePriority.UseFont = false;
            this.customerCityZipCode.StylePriority.UseForeColor = false;
            this.customerCityZipCode.Text = "[CustomerCityZipCode]";
            // 
            // customer
            // 
            this.customer.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.customer.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.customer.LocationFloat = new DevExpress.Utils.PointFloat(90.00002F, 150F);
            this.customer.Name = "customer";
            this.customer.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.customer.SizeF = new System.Drawing.SizeF(629.9998F, 20F);
            this.customer.StylePriority.UseFont = false;
            this.customer.StylePriority.UseForeColor = false;
            this.customer.Text = "[Customer]";
            // 
            // customerAddress
            // 
            this.customerAddress.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.customerAddress.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.customerAddress.LocationFloat = new DevExpress.Utils.PointFloat(90.00006F, 170F);
            this.customerAddress.Name = "customerAddress";
            this.customerAddress.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.customerAddress.SizeF = new System.Drawing.SizeF(629.9998F, 20F);
            this.customerAddress.StylePriority.UseFont = false;
            this.customerAddress.StylePriority.UseForeColor = false;
            this.customerAddress.Text = "[CustomerAddress]";
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
            // siteTaxNumber
            // 
            this.siteTaxNumber.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.siteTaxNumber.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.siteTaxNumber.LocationFloat = new DevExpress.Utils.PointFloat(90.00002F, 120F);
            this.siteTaxNumber.Name = "siteTaxNumber";
            this.siteTaxNumber.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.siteTaxNumber.SizeF = new System.Drawing.SizeF(306F, 20F);
            this.siteTaxNumber.StylePriority.UseFont = false;
            this.siteTaxNumber.StylePriority.UseForeColor = false;
            this.siteTaxNumber.Text = "[SiteTaxNumber]";
            // 
            // siteCityZipCode
            // 
            this.siteCityZipCode.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.siteCityZipCode.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.siteCityZipCode.LocationFloat = new DevExpress.Utils.PointFloat(6F, 100F);
            this.siteCityZipCode.Name = "siteCityZipCode";
            this.siteCityZipCode.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.siteCityZipCode.SizeF = new System.Drawing.SizeF(390F, 20F);
            this.siteCityZipCode.StylePriority.UseFont = false;
            this.siteCityZipCode.StylePriority.UseForeColor = false;
            this.siteCityZipCode.Text = "[SiteCityZipCode]";
            // 
            // siteAddress
            // 
            this.siteAddress.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.siteAddress.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.siteAddress.LocationFloat = new DevExpress.Utils.PointFloat(6F, 80F);
            this.siteAddress.Name = "siteAddress";
            this.siteAddress.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.siteAddress.SizeF = new System.Drawing.SizeF(390F, 20F);
            this.siteAddress.StylePriority.UseFont = false;
            this.siteAddress.StylePriority.UseForeColor = false;
            this.siteAddress.Text = "[SiteAddress]";
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
            // warehouseSite
            // 
            this.warehouseSite.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.warehouseSite.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.warehouseSite.LocationFloat = new DevExpress.Utils.PointFloat(6.000001F, 60.00002F);
            this.warehouseSite.Name = "warehouseSite";
            this.warehouseSite.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.warehouseSite.SizeF = new System.Drawing.SizeF(390F, 20F);
            this.warehouseSite.StylePriority.UseFont = false;
            this.warehouseSite.StylePriority.UseForeColor = false;
            this.warehouseSite.Text = "[WarehouseSite]";
            // 
            // company
            // 
            this.company.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.company.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.company.LocationFloat = new DevExpress.Utils.PointFloat(6.000001F, 35.99999F);
            this.company.Name = "company";
            this.company.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.company.SizeF = new System.Drawing.SizeF(390F, 24F);
            this.company.StylePriority.UseFont = false;
            this.company.StylePriority.UseForeColor = false;
            this.company.Text = "[Company]";
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
            // note
            // 
            this.note.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.note.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.note.LocationFloat = new DevExpress.Utils.PointFloat(42.00001F, 9.000015F);
            this.note.Multiline = true;
            this.note.Name = "note";
            this.note.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.note.SizeF = new System.Drawing.SizeF(390F, 20F);
            this.note.StylePriority.UseFont = false;
            this.note.StylePriority.UseForeColor = false;
            this.note.Text = "All price are VAT included. This invoice is not as proof of payment.";
            // 
            // noteLabel
            // 
            this.noteLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.noteLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.noteLabel.LocationFloat = new DevExpress.Utils.PointFloat(6F, 9F);
            this.noteLabel.Name = "noteLabel";
            this.noteLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.noteLabel.SizeF = new System.Drawing.SizeF(36F, 20F);
            this.noteLabel.StylePriority.UseFont = false;
            this.noteLabel.StylePriority.UseForeColor = false;
            this.noteLabel.Text = "Note:";
            // 
            // total
            // 
            this.total.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.total.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(32)))), ((int)(((byte)(32)))), ((int)(((byte)(32)))));
            this.total.LocationFloat = new DevExpress.Utils.PointFloat(610F, 9F);
            this.total.Name = "total";
            this.total.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.total.SizeF = new System.Drawing.SizeF(110F, 20F);
            this.total.StylePriority.UseFont = false;
            this.total.StylePriority.UseForeColor = false;
            this.total.StylePriority.UseTextAlignment = false;
            this.total.Text = "[Total]";
            this.total.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
            // 
            // totalLabel
            // 
            this.totalLabel.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalLabel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.totalLabel.LocationFloat = new DevExpress.Utils.PointFloat(526F, 9F);
            this.totalLabel.Name = "totalLabel";
            this.totalLabel.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.totalLabel.SizeF = new System.Drawing.SizeF(80F, 20F);
            this.totalLabel.StylePriority.UseFont = false;
            this.totalLabel.StylePriority.UseForeColor = false;
            this.totalLabel.StylePriority.UseTextAlignment = false;
            this.totalLabel.Text = "Total:";
            this.totalLabel.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
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
            this.driverLabel.LocationFloat = new DevExpress.Utils.PointFloat(380F, 16F);
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
            // GroupFooter
            // 
            this.GroupFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.totalLabel,
            this.total,
            this.noteLabel,
            this.note});
            this.GroupFooter.HeightF = 35F;
            this.GroupFooter.Name = "GroupFooter";
            // 
            // ExtDeliveryOrderReportControl
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.PageHeader,
            this.PageFooter,
            this.ReportHeader,
            this.ReportFooter,
            this.GroupFooter});
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
        public DevExpress.XtraReports.UI.XRLabel warehouseSite;
        public DevExpress.XtraReports.UI.XRLabel company;
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
        public DevExpress.XtraReports.UI.XRTableCell tableDataQtyOrderConv;
        public DevExpress.XtraReports.UI.XRTableCell tableDataUnitPrice;
        public DevExpress.XtraReports.UI.XRTableCell tableDataSubtotalDiscount;
        public DevExpress.XtraReports.UI.XRLabel siteAddress;
        private DevExpress.XtraReports.UI.XRLabel siteTaxNumberLabel;
        public DevExpress.XtraReports.UI.XRLabel siteTaxNumber;
        public DevExpress.XtraReports.UI.XRLabel siteCityZipCode;
        private DevExpress.XtraReports.UI.ReportFooterBand ReportFooter;
        private DevExpress.XtraReports.UI.XRLabel shipmentDateLabel;
        public DevExpress.XtraReports.UI.XRLabel shipmentDate;
        public DevExpress.XtraReports.UI.XRLabel customer;
        public DevExpress.XtraReports.UI.XRLabel customerAddress;
        public DevExpress.XtraReports.UI.XRLabel customerCityZipCode;
        private DevExpress.XtraReports.UI.XRLabel customerTaxNumberLabel;
        public DevExpress.XtraReports.UI.XRLabel customerTaxNumber;
        private DevExpress.XtraReports.UI.XRLabel noteLabel;
        public DevExpress.XtraReports.UI.XRLabel total;
        private DevExpress.XtraReports.UI.XRLabel totalLabel;
        private DevExpress.XtraReports.UI.XRLabel receiverSignatureLabel;
        private DevExpress.XtraReports.UI.XRLabel receiverLabel;
        private DevExpress.XtraReports.UI.XRLabel driverLabel;
        private DevExpress.XtraReports.UI.XRLabel driverSignatureLabel;
        private DevExpress.XtraReports.UI.XRLabel approverSignatureLabel;
        private DevExpress.XtraReports.UI.XRLabel approverLabel;
        private DevExpress.XtraReports.UI.XRLabel warehousePICSignatureLabel;
        private DevExpress.XtraReports.UI.XRLabel warehousePICLabel;
        public DevExpress.XtraReports.UI.XRLabel note;
        public DevExpress.XtraReports.UI.XRTableCell tableDataSubtotal;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderProduct;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderUnitPrice;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderSubtotalDiscount;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderSubtotal;
        private DevExpress.XtraReports.UI.XRLabel productLotCode;
        private DevExpress.XtraReports.UI.XRLabel tableHeaderQtyOrderConv;
        private DevExpress.XtraReports.UI.GroupFooterBand GroupFooter;
    }
}
