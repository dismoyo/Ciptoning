using Dismoyo.Ciptoning.Data;
using Dismoyo.Ciptoning.Web.Reports.ReportControls;
using DevExpress.XtraPivotGrid;
using DevExpress.XtraPrinting;
using DevExpress.XtraReports.UI;
using DevExpress.XtraReports.UI.PivotGrid;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dismoyo.Ciptoning.Web.Reports
{

    public partial class CustomerMasterReport : System.Web.UI.Page
    {

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            var report = new CustomerMasterReportControl();

            Guid guid;
            int int32;
            DateTime date;

            DateTime? reportDateFrom = null;
            if (DateTime.TryParse(Request.QueryString["ReportDateFrom"], out date))
                reportDateFrom = date;

            DateTime? reportDateTo = null;
            if (DateTime.TryParse(Request.QueryString["ReportDateTo"], out date))
                reportDateTo = date;

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

            int? statusID = null;
            if (int.TryParse(Request.QueryString["StatusID"], out int32))
                statusID = int32;

            DataTable dataSource = null;

            report.period.Text = (!reportDateFrom.HasValue && !reportDateTo.HasValue) ? "All" : (string.Format("{0} - {1}",
                ((reportDateFrom.HasValue) ? reportDateFrom.Value : new DateTime(1900, 1, 1)).ToString("dd MMM yyyy"),
                ((reportDateTo.HasValue) ? reportDateTo.Value : DateTime.Today).ToString("dd MMM yyyy")));

            report.site.Text = "All";
            report.company.Text = "All";
            report.area.Text = "All";
            report.region.Text = "All";
            report.territory.Text = "All";
            report.status.Text = "All";

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

            if (statusID != null)
            {
                var status = DataConfiguration.GetDefaultDataProvider<IvSystemLookupDataProvider>().GetData()
                    .SingleOrDefault(p => (p.Group == "CustomerStatus") && (p.Value_Int32 == statusID));
            }

            dataSource = DefaultDataContext.GetDataTable(@"EXEC [dbo].[spCustomerMasterReport]
                @ReportDateFrom,
                @ReportDateTo,
                @TerritoryID,
                @RegionID,
                @AreaID,
                @CompanyID,
                @SiteID,
                @StatusID;",
            new SqlParameter[] {
                    new SqlParameter("@ReportDateFrom", reportDateFrom),
                    new SqlParameter("@ReportDateTo", reportDateTo),
                    new SqlParameter("@TerritoryID", territoryID),
                    new SqlParameter("@RegionID", regionID),
                    new SqlParameter("@AreaID", areaID),
                    new SqlParameter("@CompanyID", companyID),
                    new SqlParameter("@SiteID", siteID),
                    new SqlParameter("@StatusID", statusID)
            });

            float tableWidth = 0;
            var headerRow = new XRTableRow();
            var headerCells = new List<XRTableCell>();
            var dataRow = new XRTableRow();
            var dataCells = new List<XRTableCell>();
            foreach (DataColumn c in dataSource.Columns)
            {
                var headerCell = new XRTableCell();
                headerCell.WidthF = 200;
                headerCell.Padding = new PaddingInfo(3, 3, 0, 0);
                headerCell.Text = c.ColumnName;
                headerCells.Add(headerCell);

                var dataBinding = new XRBinding("Text", dataSource, c.ColumnName);
                var dataCell = new XRTableCell();
                dataCell.WidthF = headerCell.WidthF;
                dataCell.Padding = new PaddingInfo(3, 3, 0, 0);

                if ((c.DataType == typeof(long)) || (c.DataType == typeof(long?)) ||
                    (c.DataType == typeof(int)) || (c.DataType == typeof(int?)) ||
                    (c.DataType == typeof(short)) || (c.DataType == typeof(short?)) ||
                    (c.DataType == typeof(byte)) || (c.DataType == typeof(byte?)) ||
                    (c.DataType == typeof(bool)) || (c.DataType == typeof(bool?)))
                {
                    dataCell.TextAlignment = TextAlignment.MiddleRight;
                    dataBinding.FormatString = "{0:N0}";
                }
                else if ((c.DataType == typeof(double)) || (c.DataType == typeof(double?)) ||
                    (c.DataType == typeof(float)) || (c.DataType == typeof(float?)) ||
                    (c.DataType == typeof(decimal)) || (c.DataType == typeof(decimal?)))
                {
                    dataCell.TextAlignment = TextAlignment.MiddleRight;
                    dataBinding.FormatString = "{0:N2}";
                }
                else if ((c.DataType == typeof(DateTime)) || (c.DataType == typeof(DateTime?)))
                {
                    dataCell.TextAlignment = TextAlignment.MiddleCenter;
                    dataBinding.FormatString = "{0:MM/dd/yyyy HH:mm:ss}";
                }

                dataCell.DataBindings.Add(dataBinding);
                dataCells.Add(dataCell);

                tableWidth += headerCell.WidthF;
            }

            report.tableHeader.WidthF = tableWidth;
            report.tableHeaderRow.Cells.Clear();
            report.tableHeaderRow.Cells.AddRange(headerCells.ToArray());

            report.tableData.WidthF = tableWidth;
            report.tableDataRow.Cells.Clear();
            report.tableDataRow.Cells.AddRange(dataCells.ToArray());

            report.PaperKind = PaperKind.Custom;
            report.PageWidth = (int)Math.Ceiling(tableWidth) + report.Margins.Left + report.Margins.Right;

            report.DataSource = dataSource;

            documentViewer.OpenReport(report);
        }

        #endregion

    }

}
