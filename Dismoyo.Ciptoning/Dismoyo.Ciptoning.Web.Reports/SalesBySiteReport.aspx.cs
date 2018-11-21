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

    public partial class SalesBySiteReport : System.Web.UI.Page
    {

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            var report = new SalesBySiteReportControl();
            
            Guid guid;
            int int32;
            DateTime date;

            DateTime? reportDateFrom = null;
            if (DateTime.TryParse(Request.QueryString["ReportDateFrom"], out date))
                reportDateFrom = date;

            DateTime? reportDateTo = null;
            if (DateTime.TryParse(Request.QueryString["ReportDateTo"], out date))
                reportDateTo = date;

            int? reportGroupBy = null;
            if (int.TryParse(Request.QueryString["ReportGroupBy"], out int32))
                reportGroupBy = int32;

            int? territoryID = null;
            if (int.TryParse(Request.QueryString["TerritoryID"], out int32))
                territoryID = int32;

            int? regionID = null;
            if (int.TryParse(Request.QueryString["RegionID"], out int32))
                regionID = int32;

            int? areaID = null;
            if (int.TryParse(Request.QueryString["AreaID"], out int32))
                areaID = int32;

            int? companyID = null;
            if (int.TryParse(Request.QueryString["CompanyID"], out int32))
                companyID = int32;

            Guid? siteID = null;
            if (Guid.TryParse(Request.QueryString["SiteID"], out guid))
                siteID = guid;

            object dataSource = null;
            string formatString = "";

            if ((reportGroupBy.HasValue) && (reportGroupBy.Value == 2))
            {
                report.lblTitle.Text = string.Format(report.lblTitle.Text, "BY BRAND (Eqv) ");
                formatString = "{0:N4}";

                dataSource = DefaultDataContext.DataContext.fSalesBySiteByBrandReport(
                    reportDateFrom,
                    reportDateTo,
                    null,
                    territoryID,
                    regionID,
                    areaID,
                    companyID,
                    siteID,
                    null,
                    null,
                    null)
                    .OrderBy(p => p.SiteID)
                    .ThenBy(p => p.ProductBrandID).ToList();

                report.tableHeader.DeleteColumn(report.tableHeaderProductGroup, true);
                report.tableData.DeleteColumn(report.tableDataProductGroup, true);
            }
            else
            {
                report.lblTitle.Text = string.Format(report.lblTitle.Text, "");
                formatString = "{0:N0}";

                dataSource = DefaultDataContext.DataContext.fSalesBySiteReport(
                    reportDateFrom,
                    reportDateTo,
                    null,
                    territoryID,
                    regionID,
                    areaID,
                    companyID,
                    siteID,
                    null,
                    null,
                    null)
                    .OrderBy(p => p.SiteID)
                    .ThenBy(p => p.ProductBrandID)
                    .ThenBy(p => p.ProductGroup).ToList();
                                
                report.tableDataProductGroup.DataBindings.Add(new XRBinding("Text", dataSource, "ProductGroup"));
            }

            report.period.Text = (!reportDateFrom.HasValue && !reportDateTo.HasValue) ? "All" : (string.Format("{0} - {1}",
                ((reportDateFrom.HasValue) ? reportDateFrom.Value : new DateTime(1900, 1, 1)).ToString("dd MMM yyyy"),
                ((reportDateTo.HasValue) ? reportDateTo.Value : DateTime.Today).ToString("dd MMM yyyy")));

            report.site.Text = "All";
            report.company.Text = "All";
            report.area.Text = "All";
            report.region.Text = "All";
            report.territory.Text = "All";

            if (siteID != null)
            {
                var site = DataConfiguration.GetDefaultDataProvider<IvSiteDataProvider>().GetData(siteID);
                if (site != null)
                {
                    report.site.Text = site.Site;
                    report.company.Text = site.Company;
                    report.area.Text = site.Area;
                    report.region.Text = site.Region;
                    report.territory.Text = site.Territory;
                }
            }
            else
            {
                if (companyID != null)
                {
                    var company = DataConfiguration.GetDefaultDataProvider<IvCompanyDataProvider>().GetData(companyID);
                    if (company != null)
                        report.company.Text = company.Company;
                }

                if (areaID != null)
                {
                    var area = DataConfiguration.GetDefaultDataProvider<IvAreaDataProvider>().GetData(areaID);
                    if (area != null)
                    {
                        report.area.Text = area.Area;
                        report.region.Text = area.Region;
                        report.territory.Text = area.Territory;
                    }
                }
                else if (regionID != null)
                {
                    var region = DataConfiguration.GetDefaultDataProvider<IvRegionDataProvider>().GetData(regionID);
                    if (region != null)
                    {
                        report.region.Text = region.Region;
                        report.territory.Text = region.Territory;
                    }
                }
                else if (territoryID != null)
                {
                    var territory = DataConfiguration.GetDefaultDataProvider<IvTerritoryDataProvider>().GetData(territoryID);
                    if (territory != null)
                        report.territory.Text = territory.Territory;
                }
            }

            report.DataSource = dataSource;

            report.tableDataSite.DataBindings.Add(new XRBinding("Text", dataSource, "Site"));
            report.tableDataProductBrand.DataBindings.Add(new XRBinding("Text", dataSource, "ProductBrand"));            
            report.tableDataLYActualSalesOrder.DataBindings.Add(new XRBinding("Text", dataSource, "LYActualSalesOrderQty", formatString));
            report.tableDataLMActualSalesOrder.DataBindings.Add(new XRBinding("Text", dataSource, "LMActualSalesOrderQty", formatString));
            report.tableDataTargetSalesOrder.DataBindings.Add(new XRBinding("Text", dataSource, "TargetSalesOrderQty", formatString));
            report.tableDataActualSalesOrder.DataBindings.Add(new XRBinding("Text", dataSource, "ActualSalesOrderQty", formatString));
            report.tableDataAchActualSalesOrder.DataBindings.Add(new XRBinding("Text", dataSource, "AchActualSalesOrderQty", "{0:N2}%"));
            report.tableDataGrowthLYActualSalesOrder.DataBindings.Add(new XRBinding("Text", dataSource, "GrowthLYActualSalesOrderQty", "{0:N2}%"));
            report.tableDataGrowthLMActualSalesOrder.DataBindings.Add(new XRBinding("Text", dataSource, "GrowthLMActualSalesOrderQty", "{0:N2}%"));
            report.tableDataGapTargetVsActualSalesOrder.DataBindings.Add(new XRBinding("Text", dataSource, "GapTargetVsActualSalesOrderQty", formatString));

            documentViewer.OpenReport(report);
        }

        #endregion

    }

}
