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

    public partial class ExtDeliveryOrderReport : System.Web.UI.Page
    {

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            var report = new ExtDeliveryOrderReportControl();
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IDeliveryOrderDataProvider>();
            var siteDataProvider = DataConfiguration.GetDefaultDataProvider<IvSiteDataProvider>();
            var customerDataProvider = DataConfiguration.GetDefaultDataProvider<IvCustomerDataProvider>();

            Guid guid;
            
            Guid? documentID = null;
            if (Guid.TryParse(Request.QueryString["DocumentID"], out guid))
                documentID = guid;

            object dataSource = null;
            List<object> summaryDataSource = null;
            List<object> detailsDataSource = null;
                        
            report.company.Text = "";
            report.warehouseSite.Text = "";
            report.siteAddress.Text = "";
            report.siteCityZipCode.Text = "";
            report.siteTaxNumber.Text = "";

            report.customer.Text = "";
            report.customerAddress.Text = "";
            report.customerCityZipCode.Text = "";
            report.customerTaxNumber.Text = "";

            report.documentCode.Text = "";
            report.shipmentDate.Text = "";
            report.refTransaction.Text = "";

            report.total.Text = "";
            
            string colQtyOrderConv = "";
            string colUnitPrice = "";
            string colSubtotalDiscount = "";
            string colSubtotal = "";

            vSite site;
            vCustomer customer;

            if (documentID != null)
            {
                var deliveryOrder = dataProvider.GetData(documentID);
                switch (deliveryOrder.RefTransactionTypeID)
                {
                    case 1: // Sales Order
                        var salesOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IvSalesOrderDataProvider>();
                        var salesOrderSummaryDataProvider = DataConfiguration.GetDefaultDataProvider<IvSalesOrderSummaryDataProvider>();
                        var salesOrderDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<IvSalesOrderDetailsDataProvider>();

                        dataSource = salesOrderDataProvider.GetData(deliveryOrder.RefDocumentID);
                        summaryDataSource = salesOrderSummaryDataProvider.GetData()
                            .Where(p => p.DocumentID.Equals(deliveryOrder.RefDocumentID)).OrderBy(p => p.ProductID).ToList<object>();
                        detailsDataSource = salesOrderDetailsDataProvider.GetData()
                            .Where(p => p.DocumentID.Equals(deliveryOrder.RefDocumentID))
                            .OrderBy(p => p.ProductID).ThenBy(p => p.ProductLotCode).ToList<object>();

                        var salesOrder = (vSalesOrder)dataSource;
                        site = siteDataProvider.GetData(salesOrder.SiteID);
                        customer = customerDataProvider.GetData(salesOrder.CustomerID);

                        vSalesOrderSummary summary = null;
                        foreach (var c in detailsDataSource)
                        {
                            var details = (vSalesOrderDetails)c;

                            if ((summary == null) || (summary.ProductID != details.ProductID))
                                summary = Enumerable.Cast<vSalesOrderSummary>(summaryDataSource)
                                    .SingleOrDefault(p => p.ProductID == details.ProductID);

                            details.Parent = summary;
                            details.Parent.SubtotalGross = summary.DiscountStrata1Amount +
                                summary.DiscountStrata2Amount + summary.DiscountStrata3Amount +
                                summary.DiscountStrata4Amount + summary.DiscountStrata5Amount +
                                summary.AddDiscountStrataAmount;                            
                        }

                        report.company.Text = salesOrder.Company;
                        report.warehouseSite.Text = salesOrder.Warehouse;
                        report.siteAddress.Text = site.Address;
                        report.siteCityZipCode.Text = string.Format("{0} {1}", site.City,
                            site.ZipCode);
                        report.siteTaxNumber.Text = site.TaxNumber;

                        report.customer.Text = salesOrder.Customer;
                        report.customerAddress.Text = customer.Address;
                        report.customerCityZipCode.Text = string.Format("{0} {1}", customer.City,
                            customer.ZipCode);
                        report.customerTaxNumber.Text = (customer.IsTaxNumberAvailable) ? customer.TaxNumber : "";

                        report.documentCode.Text = salesOrder.DODocumentCode;
                        report.shipmentDate.Text = salesOrder.DOShipmentDate.Value.ToString("dd MMM yyyy");
                        report.refTransaction.Text = string.Format("Sales Order ({0})",
                            salesOrder.DocumentCode);

                        report.total.Text = salesOrder.Total.ToString("N2");

                        colQtyOrderConv = "QtyOrderConv";
                        colUnitPrice = "Parent.UnitPrice";
                        colSubtotalDiscount = "Parent.SubtotalGross";
                        colSubtotal = "Parent.Subtotal";
                        break;
                    case 2: // Sales Order Return
                        var salesOrderReturnDataProvider = DataConfiguration.GetDefaultDataProvider<IvSalesOrderReturnDataProvider>();
                        var salesOrderReturnSummaryDataProvider = DataConfiguration.GetDefaultDataProvider<IvSalesOrderReturnSummaryDataProvider>();
                        var salesOrderReturnDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<IvSalesOrderReturnDetailsDataProvider>();

                        dataSource = salesOrderReturnDataProvider.GetData(deliveryOrder.RefDocumentID);
                        summaryDataSource = salesOrderReturnSummaryDataProvider.GetData()
                            .Where(p => p.DocumentID.Equals(deliveryOrder.RefDocumentID)).OrderBy(p => p.ProductID).ToList<object>();
                        detailsDataSource = salesOrderReturnDetailsDataProvider.GetData()
                            .Where(p => p.DocumentID.Equals(deliveryOrder.RefDocumentID))
                            .OrderBy(p => p.ProductID).ThenBy(p => p.ProductLotCode).ToList<object>();

                        var salesOrderReturn = (vSalesOrderReturn)dataSource;
                        site = siteDataProvider.GetData(salesOrderReturn.SiteID);
                        customer = customerDataProvider.GetData(salesOrderReturn.CustomerID);

                        vSalesOrderReturnSummary summaryReturn = null;
                        foreach (var c in detailsDataSource)
                        {
                            var details = (vSalesOrderReturnDetails)c;

                            if ((summaryReturn == null) || (summaryReturn.ProductID != details.ProductID))
                                summaryReturn = Enumerable.Cast<vSalesOrderReturnSummary>(summaryDataSource)
                                    .SingleOrDefault(p => p.ProductID == details.ProductID);

                            details.Parent = summaryReturn;
                            details.Parent.SubtotalGross = summaryReturn.DiscountStrata1Amount +
                                summaryReturn.DiscountStrata2Amount + summaryReturn.DiscountStrata3Amount +
                                summaryReturn.DiscountStrata4Amount + summaryReturn.DiscountStrata5Amount +
                                summaryReturn.AddDiscountStrataAmount;
                        }

                        report.company.Text = salesOrderReturn.Company;
                        report.warehouseSite.Text = salesOrderReturn.Warehouse;
                        report.siteAddress.Text = site.Address;
                        report.siteCityZipCode.Text = string.Format("{0} {1}", site.City,
                            site.ZipCode);
                        report.siteTaxNumber.Text = site.TaxNumber;

                        report.customer.Text = salesOrderReturn.Customer;
                        report.customerAddress.Text = customer.Address;
                        report.customerCityZipCode.Text = string.Format("{0} {1}", customer.City,
                            customer.ZipCode);
                        report.customerTaxNumber.Text = (customer.IsTaxNumberAvailable) ? customer.TaxNumber : "";

                        report.documentCode.Text = salesOrderReturn.DODocumentCode;
                        report.shipmentDate.Text = salesOrderReturn.DOShipmentDate.Value.ToString("dd MMM yyyy");
                        report.refTransaction.Text = string.Format("Sales Order Return ({0})",
                            salesOrderReturn.DocumentCode);

                        report.total.Text = salesOrderReturn.Total.ToString("N2");

                        colQtyOrderConv = "QtyOrderConv";
                        colUnitPrice = "Parent.UnitPrice";
                        colSubtotalDiscount = "Parent.SubtotalGross";
                        colSubtotal = "Parent.Subtotal";
                        break;
                }   
            }

            report.DataSource = detailsDataSource;
            
            report.tableDataProduct.DataBindings.Add(new XRBinding("Text", detailsDataSource, "Product"));
            report.tableDataProductLotCode.DataBindings.Add(new XRBinding("Text", detailsDataSource, "ProductLotCode"));
            report.tableDataQtyOrderConv.DataBindings.Add(new XRBinding("Text", detailsDataSource, colQtyOrderConv));
            report.tableDataUnitPrice.DataBindings.Add(new XRBinding("Text", detailsDataSource, colUnitPrice, "{0:N2}"));
            report.tableDataSubtotalDiscount.DataBindings.Add(new XRBinding("Text", detailsDataSource, colSubtotalDiscount, "{0:N2}"));
            report.tableDataSubtotal.DataBindings.Add(new XRBinding("Text", detailsDataSource, colSubtotal, "{0:N2}"));

            documentViewer.OpenReport(report);
        }

        #endregion

    }

}
