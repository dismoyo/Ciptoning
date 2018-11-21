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

    public partial class StockOpnameReport : System.Web.UI.Page
    {

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            var report = new StockOpnameReportControl();
            var siteDataProvider = DataConfiguration.GetDefaultDataProvider<IvSiteDataProvider>();

            Guid guid;

            Guid? documentID = null;
            if (Guid.TryParse(Request.QueryString["DocumentID"], out guid))
                documentID = guid;

            vStockOpname dataSource = null;
            List<object> summaryDataSource = null;
            List<object> detailsDataSource = null;

            report.company.Text = "";
            report.warehouseSite.Text = "";
            report.pic.Text = "";

            report.documentCode.Text = "";
            report.transactionDate.Text = "";
            report.referenceNumber.Text = "";

            report.documentStatusName.Text = "";
            report.totalProducts.Text = "";

            vSite site;

            if (documentID != null)
            {
                var stockOpnameDataProvider = DataConfiguration.GetDefaultDataProvider<IvStockOpnameDataProvider>();
                var stockOpnameSummaryDataProvider = DataConfiguration.GetDefaultDataProvider<IvStockOpnameSummaryDataProvider>();
                var stockOpnameDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<IvStockOpnameDetailsDataProvider>();

                dataSource = stockOpnameDataProvider.GetData(documentID.Value);
                summaryDataSource = stockOpnameSummaryDataProvider.GetData()
                    .Where(p => p.DocumentID.Equals(documentID.Value)).OrderBy(p => p.ProductID).ToList<object>();
                detailsDataSource = stockOpnameDetailsDataProvider.GetData()
                    .Where(p => p.DocumentID.Equals(documentID.Value))
                    .OrderBy(p => p.ProductID).ThenBy(p => p.ProductLotCode).ToList<object>();

                var stockOpname = (vStockOpname)dataSource;
                site = siteDataProvider.GetData(stockOpname.SiteID);

                vStockOpnameSummary summary = null;
                foreach (var c in detailsDataSource)
                {
                    var details = (vStockOpnameDetails)c;

                    if ((summary == null) || (summary.ProductID != details.ProductID))
                        summary = Enumerable.Cast<vStockOpnameSummary>(summaryDataSource)
                            .SingleOrDefault(p => p.ProductID == details.ProductID);

                    details.Parent = summary;
                }

                report.company.Text = stockOpname.Company;
                report.warehouseSite.Text = stockOpname.Warehouse;
                report.pic.Text = stockOpname.PIC;
                
                report.documentCode.Text = stockOpname.DocumentCode;
                report.transactionDate.Text = stockOpname.TransactionDate.ToString("dd MMM yyyy");
                report.referenceNumber.Text = stockOpname.ReferenceNumber;

                report.documentStatusName.Text = stockOpname.DocumentStatusName;
                report.totalProducts.Text = summaryDataSource.Count.ToString();
            }

            report.DataSource = detailsDataSource;

            report.tableDataProduct.DataBindings.Add(new XRBinding("Text", detailsDataSource, "Product"));
            report.tableDataProductLotCode.DataBindings.Add(new XRBinding("Text", detailsDataSource, "ProductLotCode"));
            report.tableDataQtyOnHandGood.DataBindings.Add(new XRBinding("Text", detailsDataSource, "QtyOnHandGood", "{0:N0}"));
            report.tableDataQtyOnHandHold.DataBindings.Add(new XRBinding("Text", detailsDataSource, "QtyOnHandHold", "{0:N0}"));
            report.tableDataQtyOnHandBad.DataBindings.Add(new XRBinding("Text", detailsDataSource, "QtyOnHandBad", "{0:N0}"));
            report.tableDataQtyOpnameConvGood.DataBindings.Add(new XRBinding("Text", detailsDataSource, "QtyOpnameConvGood"));
            report.tableDataQtyOpnameConvHold.DataBindings.Add(new XRBinding("Text", detailsDataSource, "QtyOpnameConvHold"));
            report.tableDataQtyOpnameConvBad.DataBindings.Add(new XRBinding("Text", detailsDataSource, "QtyOpnameConvBad"));

            documentViewer.OpenReport(report);
        }

        #endregion

    }

}
