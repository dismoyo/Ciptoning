using Dismoyo.Ciptoning.Data;
using Dismoyo.Ciptoning.Web.Reports.ReportControls;
using DevExpress.XtraPivotGrid;
using DevExpress.XtraPrinting;
using DevExpress.XtraReports.UI;
using DevExpress.XtraReports.UI.PivotGrid;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dismoyo.Ciptoning.Web.Reports
{

    public partial class DeliveryOrderReport : System.Web.UI.Page
    {

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            var report = new DeliveryOrderReportControl();
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IDeliveryOrderDataProvider>();
            var siteDataProvider = DataConfiguration.GetDefaultDataProvider<IvSiteDataProvider>();

            Guid guid;
            
            Guid? documentID = null;
            if (Guid.TryParse(Request.QueryString["DocumentID"], out guid))
                documentID = guid;

            object dataSource = null;
            List<object> summaryDataSource = null;
            List<object> detailsDataSource = null;

            report.sourceCompany.Text = "";
            report.sourceWarehouseSite.Text = "";
            report.sourceSiteAddress.Text = "";
            report.sourceSiteCityZipCode.Text = "";
            report.sourceSiteTaxNumber.Text = "";

            report.destinationWarehouseSite.Text = "";

            report.documentCode.Text = "";
            report.shipmentDate.Text = "";
            report.refTransaction.Text = "";
            
            string colQtyOrderConvGood = "";
            string colQtyOrderConvHold = "";
            string colQtyOrderConvBad = "";

            vSite sourceSite;

            if (documentID != null)
            {
                var deliveryOrder = dataProvider.GetData(documentID);
                switch (deliveryOrder.RefTransactionTypeID)
                {
                    case 8: // Stock Transfer
                        var stockTransferDataProvider = DataConfiguration.GetDefaultDataProvider<IvStockTransferDataProvider>();
                        var stockTransferSummaryDataProvider = DataConfiguration.GetDefaultDataProvider<IvStockTransferSummaryDataProvider>();
                        var stockTransferDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<IvStockTransferDetailsDataProvider>();

                        dataSource = stockTransferDataProvider.GetData(deliveryOrder.RefDocumentID);
                        summaryDataSource = stockTransferSummaryDataProvider.GetData()
                            .Where(p => p.DocumentID.Equals(deliveryOrder.RefDocumentID)).OrderBy(p => p.ProductID).ToList<object>();
                        detailsDataSource = stockTransferDetailsDataProvider.GetData()
                            .Where(p => p.DocumentID.Equals(deliveryOrder.RefDocumentID))
                            .OrderBy(p => p.ProductID).ThenBy(p => p.ProductLotCode).ToList<object>();

                        var stockTransfer = (vStockTransfer)dataSource;
                        sourceSite = siteDataProvider.GetData(stockTransfer.SourceSiteID);
                        
                        vStockTransferSummary summary = null;
                        foreach (var c in detailsDataSource)
                        {
                            var details = (vStockTransferDetails)c;

                            if ((summary == null) || (summary.ProductID != details.ProductID))
                                summary = Enumerable.Cast<vStockTransferSummary>(summaryDataSource)
                                    .SingleOrDefault(p => p.ProductID == details.ProductID);

                            details.Parent = summary;
                        }
                        
                        report.sourceCompany.Text = stockTransfer.SourceCompany;
                        report.sourceWarehouseSite.Text = stockTransfer.SourceWarehouse;
                        report.sourceSiteAddress.Text = sourceSite.Address;
                        report.sourceSiteCityZipCode.Text = string.Format("{0} {1}", sourceSite.City,
                            sourceSite.ZipCode);
                        report.sourceSiteTaxNumber.Text = sourceSite.TaxNumber;

                        report.destinationWarehouseSite.Text = stockTransfer.DestinationWarehouse;

                        report.documentCode.Text = stockTransfer.DODocumentCode;
                        report.shipmentDate.Text = stockTransfer.DOShipmentDate.Value.ToString("dd MMM yyyy");
                        report.refTransaction.Text = string.Format("Stock Transfer ({0})",
                            stockTransfer.DocumentCode);
                        
                        colQtyOrderConvGood = "QtyTransferConvGood";
                        colQtyOrderConvHold = "QtyTransferConvHold";
                        colQtyOrderConvBad = "QtyTransferConvBad";
                        break;
                }   
            }

            report.DataSource = detailsDataSource;
            
            report.tableDataProduct.DataBindings.Add(new XRBinding("Text", detailsDataSource, "Product"));
            report.tableDataProductLotCode.DataBindings.Add(new XRBinding("Text", detailsDataSource, "ProductLotCode"));
            report.tableDataQtyOrderConvGood.DataBindings.Add(new XRBinding("Text", detailsDataSource, colQtyOrderConvGood));
            report.tableDataQtyOrderConvHold.DataBindings.Add(new XRBinding("Text", detailsDataSource, colQtyOrderConvHold));
            report.tableDataQtyOrderConvBad.DataBindings.Add(new XRBinding("Text", detailsDataSource, colQtyOrderConvBad));

            documentViewer.OpenReport(report);
        }

        #endregion

    }

}
