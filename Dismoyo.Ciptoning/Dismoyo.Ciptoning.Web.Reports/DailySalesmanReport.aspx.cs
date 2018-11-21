using Dismoyo.Ciptoning.Data;
using Dismoyo.Ciptoning.Web.Reports.ReportControls;
using DevExpress.Utils;
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

    public partial class DailySalesmanReport : System.Web.UI.Page
    {

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            var report = new DailySalesmanReportControl();
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvDailySalesmanReportDataProvider>();

            Guid guid;
            DateTime date;

            DateTime? reportDateFrom = null;
            if (DateTime.TryParse(Request.QueryString["ReportDateFrom"], out date))
                reportDateFrom = date;

            DateTime? reportDateTo = null;
            if (DateTime.TryParse(Request.QueryString["ReportDateTo"], out date))
                reportDateTo = date;

            Guid? salesmanID = null;
            if (Guid.TryParse(Request.QueryString["SalesmanID"], out guid))
                salesmanID = guid;

            var dataSource = DefaultDataContext.DataContext.fDailySalesmanReport(
                reportDateFrom,
                reportDateTo,
                salesmanID).ToList();

            var inventoryDataSource = DefaultDataContext.DataContext.fDailySalesmanInventoryReport(
                reportDateFrom,
                reportDateTo,
                salesmanID).ToList();

            int tableWidth = 0;

            var detailsCount = dataSource.Where(p => (p.ColumnArea1 != "{1_Sales}") && (p.ColumnArea1 != "{2_Payments}") &&
                (p.ColumnArea1 != "{3}"))
                .Select(p => new { p.ColumnArea1, p.ColumnArea2 }).Distinct().Count();

            if (detailsCount > 0)
            {
                tableWidth += 54 + 304 + 254;
                tableWidth += (154 + 224 + 104 + 104 + 104 + 104 + 204 + 154 + 104 + 104 + 104 + 104);                
                tableWidth += (110) * detailsCount;
            }

            report.date.Text = reportDateFrom.Value.ToString("dd MMM yyyy");

            if (salesmanID != null)
            {
                var salesman = DataConfiguration.GetDefaultDataProvider<IvSalesmanDataProvider>().GetData(salesmanID);
                if (salesman != null)
                {
                    report.salesman.Text = salesman.Salesman;
                    report.site.Text = salesman.Site;
                    report.company.Text = salesman.Company;
                    report.area.Text = salesman.Area;
                    report.region.Text = salesman.Region;
                    report.territory.Text = salesman.Territory;
                }
            }

            double totalSales = dataSource.Where(p => (p.ColumnArea2 == "{1_SalesFields}"))
                .Sum(p => (p.DataArea3 == null) ? double.Parse(p.DataArea4) : double.Parse(p.DataArea3));
            double totalCashSales = dataSource.Where(p => (p.ColumnArea2 == "{1_SalesFields}"))
                .Sum(p => (p.DataArea3 == null) ? 0 : double.Parse(p.DataArea3));
            double totalAdditionalCost = dataSource.Where(p => (p.ColumnArea2 == "{3_AdditionalCost}"))
                .Sum(p => (p.DataArea1 == null) ? 0 : double.Parse(p.DataArea1));
            double totalCreditBalance = dataSource.Where(p => (p.ColumnArea2 == "{1_CreditBalance}"))
                .Sum(p => (p.DataArea1 == null) ? 0 : double.Parse(p.DataArea1));
            double totalCashSalesTaken = totalSales - (totalCashSales + totalAdditionalCost);
            
            double totalCashCollection = dataSource.Where(p => (p.ColumnArea2 == "{1_PaymentCash}"))
                .Sum(p => (p.DataArea1 == null) ? 0 : double.Parse(p.DataArea1));
            double totalNonCashCollection = 0; /////////////////////////////////////////////////////
            double totalCollectionAdditionalCost = 0; /////////////////////////////////////////////////////
            double totalCashCollectionTaken = totalCashCollection - totalAdditionalCost;

            double totalCashTaken = totalCashSalesTaken + totalCashCollectionTaken;

            report.totalSales.Text = totalSales.ToString("N2");
            report.totalCashSales.Text = totalCashSales.ToString("N2");
            report.totalAdditionalCost.Text = totalAdditionalCost.ToString("N2");
            report.totalCreditBalance.Text = totalCreditBalance.ToString("N2");
            report.totalCashSalesTaken.Text = totalCashSalesTaken.ToString("N2");

            report.totalCashPayment.Text = totalCashCollection.ToString("N2");
            report.totalNonCashPayment.Text = totalNonCashCollection.ToString("N2");
            report.totalCollectionAdditionalCost.Text = totalCollectionAdditionalCost.ToString("N2");
            report.totalCashCollectionTaken.Text = totalCashCollectionTaken.ToString("N2");

            report.totalCashTaken.Text = totalCashTaken.ToString("N2");

            report.pivotGrid.CustomFieldValueCells += PivotGrid_CustomFieldValueCells;
            report.pivotGrid.CustomColumnWidth += PivotGrid_CustomColumnWidth;
            report.pivotGrid.PrintCell += PivotGrid_PrintCell;
            report.pivotGrid.FieldValueDisplayText += PivotGrid_FieldValueDisplayText;
            report.pivotGrid.CustomFieldSort += PivotGrid_CustomFieldSort;

            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "RowNumber", Area = PivotArea.RowArea, Width = 50, Caption = "#" });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "RowArea1", Area = PivotArea.RowArea, Width = 300, Caption = "Customer" });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "RowArea2", Area = PivotArea.RowArea, Width = 250, Caption = "Customer Type" });            
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "ColumnArea1", Area = PivotArea.ColumnArea });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "ColumnArea2", Area = PivotArea.ColumnArea });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea1", Area = PivotArea.DataArea, Width = 120, SummaryType = DevExpress.Data.PivotGrid.PivotSummaryType.Max });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea2", Area = PivotArea.DataArea, Width = 120, SummaryType = DevExpress.Data.PivotGrid.PivotSummaryType.Max });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea3", Area = PivotArea.DataArea, Width = 120, SummaryType = DevExpress.Data.PivotGrid.PivotSummaryType.Max });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea4", Area = PivotArea.DataArea, Width = 120, SummaryType = DevExpress.Data.PivotGrid.PivotSummaryType.Max });
            report.pivotGrid.Fields.Add(new XRPivotGridField { FieldName = "DataArea5", Area = PivotArea.DataArea, Width = 120, SummaryType = DevExpress.Data.PivotGrid.PivotSummaryType.Max });

            report.tableData.Rows.Clear();
            foreach (var item in inventoryDataSource)
            {
                var row = new XRTableRow();

                var cell = new XRTableCell();
                cell.TextAlignment = report.tableDataProduct.TextAlignment;
                cell.Padding = report.tableDataProduct.Padding;
                cell.Font = report.tableDataProduct.Font;
                cell.Width = report.tableDataProduct.Width;
                cell.Text = item.Product;
                
                row.Cells.Add(cell);

                cell = new XRTableCell();
                cell.TextAlignment = report.tableDataQtyOnHandGood.TextAlignment;                
                cell.Padding = report.tableDataQtyOnHandGood.Padding;
                cell.Font = new Font(report.tableDataQtyOnHandGood.Font, report.tableDataQtyOnHandGood.Font.Style);
                cell.StylePriority.UseFont = report.tableDataQtyOnHandGood.StylePriority.UseFont;
                cell.StylePriority.UseTextAlignment = report.tableDataQtyOnHandGood.StylePriority.UseTextAlignment;
                cell.Width = report.tableDataQtyOnHandGood.Width;
                cell.Text = item.QtyOnHandGood.ToString("N0");

                row.Cells.Add(cell);

                cell = new XRTableCell();
                cell.TextAlignment = report.tableDataQtyOnHandHold.TextAlignment;
                cell.Padding = report.tableDataQtyOnHandHold.Padding;
                cell.Font = new Font(report.tableDataQtyOnHandHold.Font, report.tableDataQtyOnHandHold.Font.Style);
                cell.StylePriority.UseFont = report.tableDataQtyOnHandHold.StylePriority.UseFont;
                cell.StylePriority.UseTextAlignment = report.tableDataQtyOnHandHold.StylePriority.UseTextAlignment;
                cell.Width = report.tableDataQtyOnHandHold.Width;
                cell.Text = item.QtyOnHandHold.ToString("N0");

                row.Cells.Add(cell);

                cell = new XRTableCell();
                cell.TextAlignment = report.tableDataQtyOnHandBad.TextAlignment;
                cell.Padding = report.tableDataQtyOnHandBad.Padding;
                cell.Font = new Font(report.tableDataQtyOnHandBad.Font, report.tableDataQtyOnHandBad.Font.Style);
                cell.StylePriority.UseFont = report.tableDataQtyOnHandBad.StylePriority.UseFont;
                cell.StylePriority.UseTextAlignment = report.tableDataQtyOnHandBad.StylePriority.UseTextAlignment;
                cell.Width = report.tableDataQtyOnHandBad.Width;
                cell.Text = item.QtyOnHandBad.ToString("N0");

                row.Cells.Add(cell);

                report.tableData.Rows.Add(row);
            }
            
            report.pivotGrid.OptionsView.ShowColumnGrandTotals = false;
            report.pivotGrid.OptionsView.ShowRowGrandTotals = false;

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

                if (cell.StartLevel == 2)
                {
                    switch (cell.Parent.Value.ToString())
                    {
                        case "{1_SalesFields}":
                            break;
                        case "{2_PaymentTransferForm}":
                            switch (cell.Field.FieldName)
                            {
                                case "DataArea5":
                                    e.Remove(cell);
                                    break;
                            }
                            break;                            
                        default:
                            switch (cell.Field.FieldName)
                            {
                                case "DataArea2":
                                case "DataArea3":
                                case "DataArea4":
                                case "DataArea5":
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
                    break;
                default:
                    object obj = null;
                    if ((e.Item.StartLevel == 2) && (e.Item.ColumnField != null))
                        obj = e.GetHigherLevelFieldValue(pivotGrid.Fields[e.Item.ColumnField.FieldName]);

                    if (obj != null)
                    {
                        switch (e.Field.FieldName)
                        {
                            case "DataArea1":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}":
                                        e.ColumnWidth = 150;
                                        break;
                                    case "{1_PaymentCash}":
                                    case "{3_AdditionalCost}":
                                    case "{1_CreditBalance}":
                                        e.ColumnWidth = 100;
                                        break;
                                    case "{2_PaymentTransferForm}":
                                        e.ColumnWidth = 200;
                                        break;
                                    default:
                                        e.ColumnWidth = 80;
                                        break;
                                }
                                break;
                            case "DataArea2":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}":
                                    case "{2_PaymentTransferForm}":
                                        e.ColumnWidth = 220;
                                        break;
                                    default:
                                        break;
                                }
                                break;
                            case "DataArea3":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}":
                                    case "{2_PaymentTransferForm}":
                                        e.ColumnWidth = 100;
                                        break;
                                    default:
                                        break;
                                }
                                break;
                            case "DataArea4":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}":
                                    case "{2_PaymentTransferForm}":
                                        e.ColumnWidth = 100;
                                        break;
                                    default:
                                        break;
                                }
                                break;
                            case "DataArea5":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}":
                                        e.ColumnWidth = 100;
                                        break;
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
                            case "{1_SalesFields}":
                                e.Appearance.TextHorizontalAlignment = HorzAlignment.Center;
                                break;
                            case "{2_PaymentTransferForm}":
                                e.Appearance.TextHorizontalAlignment = HorzAlignment.Near;
                                break;
                            case "{1_PaymentCash}":
                            case "{3_AdditionalCost}":
                            case "{1_CreditBalance}":
                                e.Brick.TextValueFormatString = "{0:N2}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0.0).ToString("N2");
                                break;
                            default:
                                e.Brick.TextValueFormatString = "{0:N0}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToInt32(e.Value) : 0).ToString("N0");
                                break;
                        }
                        break;
                    case "DataArea2":
                        switch (fieldValue.ToString())
                        {
                            case "{1_SalesFields}":
                                e.Appearance.TextHorizontalAlignment = HorzAlignment.Center;
                                break;
                            case "{2_PaymentTransferForm}":
                                e.Appearance.TextHorizontalAlignment = HorzAlignment.Near;
                                break;
                            case "{1_PaymentCash}":
                            case "{3_AdditionalCost}":
                            case "{1_CreditBalance}":
                                break;
                            default:
                                e.Brick.TextValueFormatString = "{0:N0}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToInt32(e.Value) : 0).ToString("N0");
                                break;
                        }
                        break;
                    case "DataArea3":
                        switch (fieldValue.ToString())
                        {
                            case "{1_SalesFields}":
                                e.Brick.TextValueFormatString = "{0:N2}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0).ToString("N2");
                                break;
                            case "{2_PaymentTransferForm}":
                                e.Appearance.TextHorizontalAlignment = HorzAlignment.Center;
                                e.Brick.TextValueFormatString = "{0:dd MMM yyyy}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDateTime(e.Value).ToString("dd MMM yyyy") : null);
                                break;
                            default:                                
                                break;
                        }
                        break;
                    case "DataArea4":
                        switch (fieldValue.ToString())
                        {
                            case "{1_SalesFields}":
                            case "{2_PaymentTransferForm}":
                                e.Brick.TextValueFormatString = "{0:N2}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDouble(e.Value) : 0).ToString("N2");
                                break;
                            default:
                                break;
                        }
                        break;
                    case "DataArea5":
                        switch (fieldValue.ToString())
                        {
                            case "{1_SalesFields}":
                                e.Appearance.TextHorizontalAlignment = HorzAlignment.Center;
                                e.Brick.TextValueFormatString = "{0:dd MMM yyyy}";
                                e.Brick.Text = ((e.Value != null) ? Convert.ToDateTime(e.Value).ToString("dd MMM yyyy") : null);
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
                            case "{1_Sales}": e.DisplayText = "Sales"; break;
                            case "{2_Payments}": e.DisplayText = "Payments"; break;
                            case "{3}": e.DisplayText = ""; break;
                        }
                    }
                    break;
                case "ColumnArea2":
                    if (e.Value != null)
                    {
                        switch (e.Value.ToString())
                        {
                            case "{2_PaymentTransferForm}": e.DisplayText = "Cheque/Bilyet Giro"; break;
                            case "{1_SalesFields}":
                            case "{1_PaymentCash}":
                            case "{3_AdditionalCost}":
                            case "{1_CreditBalance}":
                                e.DisplayText = "";
                                break;
                        }
                    }
                    break;                
                default:
                    object obj = null;
                    if ((e.Item.StartLevel == 2) && (e.Item.ColumnField != null))
                        obj = e.GetHigherLevelFieldValue(pivotGrid.Fields[e.Item.ColumnField.FieldName]);

                    if (obj != null)
                    {
                        switch (e.Field.FieldName)
                        {
                            case "DataArea1":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}": e.DisplayText = "SO Document Number"; break;
                                    case "{1_PaymentCash}": e.DisplayText = "Cash"; break;
                                    case "{2_PaymentTransferForm}": e.DisplayText = "Bank"; break;
                                    case "{3_AdditionalCost}": e.DisplayText = "Additional Cost"; break;
                                    case "{1_CreditBalance}": e.DisplayText = "Credit Balance"; break;
                                    default:
                                        e.DisplayText = "Qty";
                                        break;
                                }
                                break;
                            case "DataArea2":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}": e.DisplayText = "SFA Document Number"; break;
                                    case "{2_PaymentTransferForm}": e.DisplayText = "No."; break;
                                }
                                break;
                            case "DataArea3":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}": e.DisplayText = "Cash"; break;
                                    case "{2_PaymentTransferForm}": e.DisplayText = "Due Date"; break;
                                }
                                break;
                            case "DataArea4":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}": e.DisplayText = "Credit"; break;
                                    case "{2_PaymentTransferForm}": e.DisplayText = "Amount"; break;
                                }
                                break;
                            case "DataArea5":
                                switch (obj.ToString())
                                {
                                    case "{1_SalesFields}": e.DisplayText = "Credit Due Date"; break;                                    
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
                    switch (e.Value1.ToString())
                    {
                        case "{1_SalesFields}":
                        case "{2_PaymentTransferForm}":                        
                        case "{1_PaymentCash}":
                        case "{3_AdditionalCost}":
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
