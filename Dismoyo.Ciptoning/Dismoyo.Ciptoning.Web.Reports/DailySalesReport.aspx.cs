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

    public partial class DailySalesReport : System.Web.UI.Page
    {

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            var report = new DailySalesReportControl();
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvDailySalesReportDataProvider>();

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

            var dataSource = DefaultDataContext.DataContext.fDailySalesReport(
                reportDateFrom,
                reportDateTo,
                territoryID,
                regionID,
                areaID,
                companyID,
                siteID,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null).ToList();

            int tableWidth = 0;

            var summaryCount = dataSource.Where(p => (p.ColumnArea1 == "{1_Summary}") && (p.ColumnArea2 == "{1}") &&
                (p.ColumnArea3 == "{1_ProductBrands}"))
                .Select(p => new { p.ColumnArea1, p.ColumnArea2, p.ColumnArea3, p.ColumnArea4 }).Distinct().Count();
            var detailsCount = dataSource.Where(p => (p.ColumnArea1 == "{2_Details}"))
                .Select(p => new { p.ColumnArea1, p.ColumnArea3 }).Distinct().Count();

            if (summaryCount > 0)
            {
                tableWidth += 154 + 204 + 254;
                tableWidth += (104 + 104 + 104 + 104 + 74) * summaryCount;
                tableWidth += (84 + 84 + 84 + 74 + 84 + 84 + 74 + 84 + 84 + 74);
                tableWidth += (84 + 84 + 74 + 84 + 84 + 74 + 84 + 84 + 84 + 84 + 74 + 84 + 84) * detailsCount;
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

            report.pivotGrid.CustomFieldValueCells += PivotGrid_CustomFieldValueCells;
            report.pivotGrid.CustomColumnWidth += PivotGrid_CustomColumnWidth;
            report.pivotGrid.PrintCell += PivotGrid_PrintCell;
            report.pivotGrid.FieldValueDisplayText += PivotGrid_FieldValueDisplayText;
            report.pivotGrid.CustomFieldSort += PivotGrid_CustomFieldSort;

            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "RowArea1", Area = PivotArea.RowArea, Width = 150, Caption = "Group" });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "RowArea2", Area = PivotArea.RowArea, Width = 200, Caption = "Category" });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "RowArea3", Area = PivotArea.RowArea, Width = 250, Caption = "Salesman" });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "ColumnArea1", Area = PivotArea.ColumnArea });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "ColumnArea2", Area = PivotArea.ColumnArea });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "ColumnArea3", Area = PivotArea.ColumnArea });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "ColumnArea4", Area = PivotArea.ColumnArea });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea1", Area = PivotArea.DataArea, Width = 70 });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea2", Area = PivotArea.DataArea, Width = 70 });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea3", Area = PivotArea.DataArea, Width = 70 });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea4", Area = PivotArea.DataArea, Width = 70 });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea5", Area = PivotArea.DataArea, Width = 70 });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea6", Area = PivotArea.DataArea, Width = 70 });

            report.PaperKind = PaperKind.Custom;
            report.PageWidth = tableWidth + report.Margins.Left + report.Margins.Right;
            
            report.pivotGrid.DataSource = dataSource;

            documentViewer.OpenReport(report);
        }


        private void PivotGrid_CustomFieldValueCells(object sender, DevExpress.XtraReports.UI.PivotGrid.PivotCustomFieldValueCellsEventArgs e)
        {
            var pivotGrid = (XRPivotGrid)sender;

            if (pivotGrid.DataSource == null)
                return;

            for (int i = e.GetCellCount(true) - 1; i >= 0; i--)
            {
                var cell = e.GetCell(true, i);
                if ((cell == null) || (cell.ValueType != PivotGridValueType.Value))
                    continue;

                if (cell.StartLevel == 4)
                {
                    switch (cell.Parent.Value.ToString())
                    {
                        case "{1_TotalCustomer}":
                            switch (cell.Field.FieldName)
                            {
                                case "DataArea2":
                                case "DataArea3":
                                case "DataArea4":
                                case "DataArea5":
                                case "DataArea6":
                                    e.Remove(cell);
                                    break;
                            }
                            break;
                        case "{2_NewCustomer}":
                        case "{3_Call}":
                        case "{4_Visibility}":
                            switch (cell.Field.FieldName)
                            {
                                case "DataArea4":
                                case "DataArea5":
                                case "DataArea6":
                                    e.Remove(cell);
                                    break;
                            }
                            break;
                        case "{1_ProductGroupActivity}":
                            break;
                        case "{3_ProductGroupDropSize}":
                            switch (cell.Field.FieldName)
                            {
                                case "DataArea3":
                                case "DataArea4":
                                case "DataArea5":
                                case "DataArea6":
                                    e.Remove(cell);
                                    break;
                            }
                            break;
                        case "{2_ProductGroupQuantity}":
                        default:
                            switch (cell.Field.FieldName)
                            {
                                case "DataArea6":
                                    e.Remove(cell);
                                    break;
                            }
                            break;
                    }
                }
            }
        }

        private void PivotGrid_CustomColumnWidth(object sender, DevExpress.XtraReports.UI.PivotGrid.PivotCustomColumnWidthEventArgs e)
        {
            var pivotGrid = (XRPivotGrid)sender;

            if (pivotGrid.DataSource == null)
                return;

            switch (e.Field.FieldName)
            {
                case "ColumnArea1":
                case "ColumnArea2":
                case "ColumnArea3":
                case "ColumnArea4":                
                    break;
                default:
                    object obj = null;
                    if ((e.Item.StartLevel == 4) && (e.Item.ColumnField != null))
                        obj = e.GetHigherLevelFieldValue(pivotGrid.Fields[e.Item.ColumnField.FieldName]);

                    if (obj != null)
                    {
                        switch (e.Field.FieldName)
                        {
                            case "DataArea1":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{1_ProductGroupActivity}":
                                    case "{2_ProductGroupQuantity}":
                                    case "{3_ProductGroupDropSize}":
                                        e.ColumnWidth = 80;
                                        break;                                    
                                    default:
                                        e.ColumnWidth = 100;
                                        break;
                                }
                                break;
                            case "DataArea2":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                        break;
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{1_ProductGroupActivity}":
                                    case "{2_ProductGroupQuantity}":
                                    case "{3_ProductGroupDropSize}":
                                        e.ColumnWidth = 80;
                                        break;                                    
                                    default:
                                        e.ColumnWidth = 100;
                                        break;
                                }
                                break;
                            case "DataArea3":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                    case "{3_ProductGroupDropSize}":
                                        break;
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{1_ProductGroupActivity}":
                                        e.ColumnWidth = 70;
                                        break;
                                    case "{2_ProductGroupQuantity}":
                                        e.ColumnWidth = 80;
                                        break;
                                    default:
                                        e.ColumnWidth = 100;
                                        break;
                                }
                                break;
                            case "DataArea4":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{3_ProductGroupDropSize}":
                                        break;
                                    case "{1_ProductGroupActivity}":
                                    case "{2_ProductGroupQuantity}":
                                        e.ColumnWidth = 80;
                                        break;
                                    default:
                                        e.ColumnWidth = 100;
                                        break;
                                }
                                break;
                            case "DataArea5":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{3_ProductGroupDropSize}":
                                        break;
                                    case "{1_ProductGroupActivity}":
                                        e.ColumnWidth = 80;
                                        break;
                                    case "{2_ProductGroupQuantity}":                                        
                                    default:
                                        e.ColumnWidth = 70;
                                        break;
                                }
                                break;
                            case "DataArea6":
                                switch (obj.ToString())
                                {
                                    case "{1_ProductGroupActivity}":
                                        e.ColumnWidth = 70;
                                        break;
                                    case "{1_TotalCustomer}":
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{2_ProductGroupQuantity}":
                                    case "{3_ProductGroupDropSize}":
                                    default:
                                        break;
                                }
                                break;
                        }
                    }
                    break;
            }
        }

        private void PivotGrid_PrintCell(object sender, DevExpress.XtraReports.UI.PivotGrid.CustomExportCellEventArgs e)
        {
            var pivotGrid = (XRPivotGrid)sender;

            if (pivotGrid.DataSource == null)
                return;

            object fieldValue = pivotGrid.GetCellInfo(e.ColumnIndex, e.RowIndex).GetFieldValue(e.ColumnField);
            if (fieldValue != null)
            {
                switch (e.DataField.FieldName)
                {
                    case "DataArea1":
                        switch (fieldValue.ToString())
                        {
                            case "{1_TotalCustomer}":                                                            
                            case "{2_NewCustomer}":
                            case "{3_Call}":
                            case "{4_Visibility}":
                            case "{1_ProductGroupActivity}":
                            case "{2_ProductGroupQuantity}":
                                e.Brick.TextValueFormatString = "{0:N0}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToInt32(e.Value) : 0).ToString("N0");
                                break;
                            default:
                                e.Brick.TextValueFormatString = "{0:N4}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0.0).ToString("N4");
                                break;
                        }
                        break;
                    case "DataArea2":
                        switch (fieldValue.ToString())
                        {
                            case "{1_TotalCustomer}":
                                break;
                            case "{2_NewCustomer}":
                            case "{3_Call}":
                            case "{4_Visibility}":
                            case "{1_ProductGroupActivity}":
                            case "{2_ProductGroupQuantity}":
                                e.Brick.TextValueFormatString = "{0:N0}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToInt32(e.Value) : 0).ToString("N0");
                                break;
                            default:
                                e.Brick.TextValueFormatString = "{0:N4}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0.0).ToString("N4");
                                break;
                        }
                        break;
                    case "DataArea3":
                        switch (fieldValue.ToString())
                        {
                            case "{1_TotalCustomer}":
                            case "{3_ProductGroupDropSize}":
                                break;
                            case "{2_NewCustomer}":
                            case "{3_Call}":
                            case "{4_Visibility}":
                            case "{1_ProductGroupActivity}":
                                e.Brick.TextValueFormatString = "{0:N2}%";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToInt32(e.Value) : 0).ToString("N2") + "%";
                                break;
                            case "{2_ProductGroupQuantity}":
                                e.Brick.TextValueFormatString = "{0:N0}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToInt32(e.Value) : 0).ToString("N0");
                                break;                            
                            default:
                                e.Brick.TextValueFormatString = "{0:N4}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0.0).ToString("N4");
                                break;
                        }
                        break;
                    case "DataArea4":
                        switch (fieldValue.ToString())
                        {
                            case "{1_TotalCustomer}":
                            case "{2_NewCustomer}":
                            case "{3_Call}":
                            case "{4_Visibility}":
                            case "{3_ProductGroupDropSize}":
                                break;
                            case "{1_ProductGroupActivity}":
                            case "{2_ProductGroupQuantity}":
                                e.Brick.TextValueFormatString = "{0:N0}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToInt32(e.Value) : 0).ToString("N0");
                                break;
                            default:
                                e.Brick.TextValueFormatString = "{0:N4}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0.0).ToString("N4");
                                break;
                        }
                        break;
                    case "DataArea5":
                        switch (fieldValue.ToString())
                        {
                            case "{1_TotalCustomer}":
                            case "{2_NewCustomer}":
                            case "{3_Call}":
                            case "{4_Visibility}":
                            case "{3_ProductGroupDropSize}":
                                break;
                            case "{1_ProductGroupActivity}":
                                e.Brick.TextValueFormatString = "{0:N0}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToInt32(e.Value) : 0).ToString("N0");
                                break;
                            default:
                                e.Brick.TextValueFormatString = "{0:N2}%";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0.0).ToString("N2") + "%";
                                break;
                        }
                        break;
                    case "DataArea6":
                        switch (fieldValue.ToString())
                        {
                            case "{1_ProductGroupActivity}":
                                e.Brick.TextValueFormatString = "{0:N2}%";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0.0).ToString("N2") + "%";
                                break;
                            default:
                                break;
                        }
                        break;
                }
            }
        }

        private void PivotGrid_FieldValueDisplayText(object sender, DevExpress.XtraReports.UI.PivotGrid.PivotFieldDisplayTextEventArgs e)
        {
            var pivotGrid = (XRPivotGrid)sender;

            if ((pivotGrid.DataSource == null) || (e.Field == null))
                return;

            switch (e.Field.FieldName)
            {
                case "ColumnArea1":
                    if (e.Value != null)
                    {
                        switch (e.Value.ToString())
                        {
                            case "{1_Summary}": e.DisplayText = "SUMMARY (Eqv)"; break;
                            case "{2_Details}": e.DisplayText = "DETAILS"; break;
                        }
                    }
                    break;
                case "ColumnArea2":
                    if (e.Value != null)
                    {
                        switch (e.Value.ToString())
                        {
                            case "{1}":
                            case "{2}":
                                e.DisplayText = "";
                                break;
                        }
                    }
                    break;
                case "ColumnArea3":
                    if (e.Value != null)
                    {
                        switch (e.Value.ToString())
                        {
                            case "{1}":
                            case "{2}":
                                e.DisplayText = "";
                                break;
                            case "{1_ProductBrands}": e.DisplayText = "Brands"; break;
                        }
                    }
                    break;
                case "ColumnArea4":
                    if (e.Value != null)
                    {
                        switch (e.Value.ToString())
                        {
                            case "{1_TotalCustomer}": e.DisplayText = ""; break;
                            case "{2_NewCustomer}": e.DisplayText = "NOO"; break;
                            case "{3_Call}": e.DisplayText = "Call"; break;
                            case "{4_Visibility}": e.DisplayText = "Visibility"; break;
                            case "{1_ProductGroupActivity}": e.DisplayText = "Activity"; break;
                            case "{2_ProductGroupQuantity}": e.DisplayText = "Quantity"; break;
                            case "{3_ProductGroupDropSize}": e.DisplayText = "Drop Size"; break;
                        }
                    }
                    break;
                default:
                    object obj = null;
                    if ((e.Item.StartLevel == 4) && (e.Item.ColumnField != null))
                        obj = e.GetHigherLevelFieldValue(pivotGrid.Fields[e.Item.ColumnField.FieldName]);

                    if (obj != null)
                    {
                        switch (e.Field.FieldName)
                        {
                            case "DataArea1":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                        e.DisplayText = "Ending RO";
                                        break;
                                    case "{1_ProductGroupActivity}":
                                        e.DisplayText = "Target EC";
                                        break;
                                    case "{3_ProductGroupDropSize}":
                                        e.DisplayText = "Per EC";
                                        break;
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{2_ProductGroupQuantity}":
                                    default:
                                        e.DisplayText = "Target";
                                        break;
                                }
                                break;
                            case "DataArea2":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                        break;
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                        e.DisplayText = "Actual";
                                        break;
                                    case "{1_ProductGroupActivity}":
                                        e.DisplayText = "Actual EC";
                                        break;
                                    case "{3_ProductGroupDropSize}":
                                        e.DisplayText = "Per OT";
                                        break;
                                    case "{2_ProductGroupQuantity}":
                                    default:
                                        e.DisplayText = "Sales";
                                        break;
                                }
                                break;
                            case "DataArea3":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                    case "{3_ProductGroupDropSize}":
                                        break;
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{1_ProductGroupActivity}":
                                        e.DisplayText = "Ach (%)";
                                        break;
                                    case "{2_ProductGroupQuantity}":
                                    default:
                                        e.DisplayText = "Return";
                                        break;
                                }
                                break;
                            case "DataArea4":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{3_ProductGroupDropSize}":
                                        break;
                                    case "{1_ProductGroupActivity}":
                                        e.DisplayText = "Target OT";
                                        break;
                                    case "{2_ProductGroupQuantity}":
                                    default:
                                        e.DisplayText = "Actual";
                                        break;
                                }
                                break;
                            case "DataArea5":
                                switch (obj.ToString())
                                {
                                    case "{1_TotalCustomer}":
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{3_ProductGroupDropSize}":
                                        break;
                                    case "{1_ProductGroupActivity}":
                                        e.DisplayText = "Actual OT";
                                        break;
                                    case "{2_ProductGroupQuantity}":
                                    default:
                                        e.DisplayText = "Ach (%)";
                                        break;
                                }
                                break;
                            case "DataArea6":
                                switch (obj.ToString())
                                {
                                    case "{1_ProductGroupActivity}":
                                        e.DisplayText = "Ach (%)";
                                        break;
                                    case "{1_TotalCustomer}":
                                    case "{2_NewCustomer}":
                                    case "{3_Call}":
                                    case "{4_Visibility}":
                                    case "{2_ProductGroupQuantity}":
                                    case "{3_ProductGroupDropSize}":
                                    default:
                                        break;
                                }
                                break;
                        }
                    }
                    break;
            }
        }

        private void PivotGrid_CustomFieldSort(object sender, DevExpress.XtraReports.UI.PivotGrid.PivotGridCustomFieldSortEventArgs e)
        {
            var pivotGrid = (XRPivotGrid)sender;

            if ((pivotGrid.DataSource == null) || (e.Field == null))
                return;

            switch (e.Field.FieldName)
            {
                case "ColumnArea1":
                case "ColumnArea2":
                case "ColumnArea3":
                case "ColumnArea4":
                    switch (e.Value1.ToString())
                    {
                        case "{1_TotalCustomer}":
                        case "{2_NewCustomer}":
                        case "{3_Call}":
                        case "{4_Visibility}":
                        case "{1_ProductGroupActivity}":
                        case "{2_ProductGroupQuantity}":
                        case "{3_ProductGroupDropSize}":
                            object orderValue1 = e.GetListSourceColumnValue(e.ListSourceRowIndex1, e.Field.FieldName + "Index");
                            object orderValue2 = e.GetListSourceColumnValue(e.ListSourceRowIndex2, e.Field.FieldName + "Index");

                            e.Result = ((int)orderValue1).CompareTo((int)orderValue2);
                            e.Handled = true;
                            break;
                    }
                    break;
            }
        }

        #endregion

    }

}
