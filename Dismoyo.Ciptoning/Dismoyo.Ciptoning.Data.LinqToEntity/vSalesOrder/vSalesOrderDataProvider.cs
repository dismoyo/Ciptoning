﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vSalesOrderDataProvider partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
//using WebMatrix.WebData;

namespace Dismoyo.Ciptoning.Data
{

    public partial class vSalesOrderDataProvider : DefaultViewDataProvider<vSalesOrder>, IvSalesOrderDataProvider
    {

        #region Methods

        public override IQueryable<vSalesOrder> GetData()
        {
            return base.GetData();
        }


        protected override void OnInsertData(vSalesOrder obj, bool useTransaction)
        {
            var salesOrderDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesOrderDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();
            var purchaseOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IPurchaseOrderDataProvider>();
            var deliveryOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IDeliveryOrderDataProvider>();

            var salesOrder = new SalesOrder();
            var vWarehouse = vWarehouseDataProvider.GetData(obj.WarehouseID);
            PurchaseOrder purchaseOrder = null;
            var deliveryOrder = new DeliveryOrder();

            salesOrder.DocumentID = (obj.DocumentID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.DocumentID);
            salesOrder.DocumentCode = string.Format("{0}-{1}-01-{2}", vWarehouse.SiteCode,
                DateTime.Today.ToString("yy"),
                DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 1).ToString().PadLeft(7, '0'));
            salesOrder.TransactionDate = obj.TransactionDate;

            if (!string.IsNullOrEmpty(obj.PODocumentCode))
            {
                purchaseOrder = new PurchaseOrder();

                purchaseOrder.DocumentID = (!obj.PODocumentID.HasValue || obj.PODocumentID.Value.Equals(Guid.Empty)) ?
                    Guid.NewGuid() : obj.PODocumentID.Value;
                purchaseOrder.DocumentCode = obj.PODocumentCode;
                purchaseOrder.SODocumentID = salesOrder.DocumentID;
                purchaseOrder.SOTransactionTypeID = 1; // Sales Order
                purchaseOrder.TransactionDate = obj.POTransactionDate;
            }

            salesOrder.ReferenceNumber = obj.ReferenceNumber;
            salesOrder.DocumentStatusReason = obj.DocumentStatusReason;
            salesOrder.SalesmanID = obj.SalesmanID;
            salesOrder.WarehouseID = obj.WarehouseID;
            salesOrder.CustomerID = obj.CustomerID;
            salesOrder.PriceGroupID = obj.PriceGroupID;
            salesOrder.DiscountGroupID = obj.DiscountGroupID;
            salesOrder.TermOfPaymentID = obj.TermOfPaymentID;
            salesOrder.AddDiscountStrataReason = obj.AddDiscountStrataReason;
            salesOrder.SFAInvoiceDocumentCode = obj.SFAInvoiceDocumentCode;

            deliveryOrder.DocumentID = (obj.DODocumentID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.DODocumentID);
            deliveryOrder.DocumentCode = string.Format("{0}-{1}-10-{2}", vWarehouse.SiteCode,
                DateTime.Today.ToString("yy"),
                DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 10).ToString().PadLeft(7, '0'));
            deliveryOrder.TransactionDate = salesOrder.TransactionDate;
            deliveryOrder.RefDocumentID = salesOrder.DocumentID;
            deliveryOrder.RefTransactionTypeID = 1; // Sales Order
            deliveryOrder.ShipmentDate = obj.DOShipmentDate;
            deliveryOrder.ReceivedDate = obj.DOReceivedDate;
            deliveryOrder.PrintedCount = 0;

            if (purchaseOrder != null)
            {
                salesOrder.PODocumentID = purchaseOrder.DocumentID;
                purchaseOrder.DocumentStatusID = 2;
            }

            salesOrder.DODocumentID = deliveryOrder.DocumentID;

            salesOrder.DocumentStatusID = 1; // Draft
            deliveryOrder.DocumentStatusID = salesOrder.DocumentStatusID;

            salesOrder.RawTotalGrossPrice = obj.RawTotalGrossPrice;
            salesOrder.RawTotalPrice = obj.RawTotalPrice;
            salesOrder.RawTotalDiscountStrata1Amount = obj.RawTotalDiscountStrata1Amount;
            salesOrder.RawTotalDiscountStrata2Amount = obj.RawTotalDiscountStrata2Amount;
            salesOrder.RawTotalDiscountStrata3Amount = obj.RawTotalDiscountStrata3Amount;
            salesOrder.RawTotalDiscountStrata4Amount = obj.RawTotalDiscountStrata4Amount;
            salesOrder.RawTotalDiscountStrata5Amount = obj.RawTotalDiscountStrata5Amount;
            salesOrder.RawTotalAddDiscountStrataAmount = obj.RawTotalAddDiscountStrataAmount;
            salesOrder.RawTotalGross = obj.RawTotalGross;
            salesOrder.RawTotalTax = obj.RawTotalTax;
            salesOrder.RawTotal = obj.RawTotal;
            salesOrder.TotalGrossPrice = obj.TotalGrossPrice;
            salesOrder.TotalPrice = obj.TotalPrice;
            salesOrder.TotalDiscountStrata1Amount = obj.TotalDiscountStrata1Amount;
            salesOrder.TotalDiscountStrata2Amount = obj.TotalDiscountStrata2Amount;
            salesOrder.TotalDiscountStrata3Amount = obj.TotalDiscountStrata3Amount;
            salesOrder.TotalDiscountStrata4Amount = obj.TotalDiscountStrata4Amount;
            salesOrder.TotalDiscountStrata5Amount = obj.TotalDiscountStrata5Amount;
            salesOrder.TotalAddDiscountStrataAmount = obj.TotalAddDiscountStrataAmount;
            salesOrder.TotalGross = obj.TotalGross;
            salesOrder.TotalTax = obj.TotalTax;
            salesOrder.Total = obj.Total;
            salesOrder.TotalWeight = obj.TotalWeight;
            salesOrder.TotalDimension = obj.TotalDimension;
            salesOrder.PrintCount = obj.PrintCount;

            salesOrderDataProvider.InsertData(salesOrder, useTransaction);
            deliveryOrderDataProvider.InsertData(deliveryOrder, useTransaction);

            if (purchaseOrder != null)
                purchaseOrderDataProvider.InsertData(purchaseOrder, useTransaction);

            if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
            {
                // Insert new child data.
                var vSalesOrderSummaryDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvSalesOrderSummaryDataProvider>();
                foreach (var summary in obj.ChildSummaries)
                {
                    summary.DocumentID = salesOrder.DocumentID;
                    vSalesOrderSummaryDataProvider.InsertData(summary, useTransaction);
                }
            }
        }

        protected override void OnUpdateData(vSalesOrder obj, bool useTransaction)
        {
            var salesOrderDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesOrderDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();
            var purchaseOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IPurchaseOrderDataProvider>();
            var deliveryOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IDeliveryOrderDataProvider>();
            
            var salesOrder = salesOrderDataProvider.GetData(obj.DocumentID);
            var vWarehouse = vWarehouseDataProvider.GetData(obj.WarehouseID);

            PurchaseOrder purchaseOrder = null;
            if (salesOrder.PODocumentID.HasValue)
                purchaseOrder = purchaseOrderDataProvider.GetData(salesOrder.PODocumentID.Value);

            var deliveryOrder = deliveryOrderDataProvider.GetData(obj.DODocumentID);

            var salesOrderSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<ISalesOrderSummaryDataProvider>();
            var vSalesOrderSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<IvSalesOrderSummaryDataProvider>();

            bool insertPO = false;
            bool deletePO = false;
            if (salesOrder.DocumentStatusID == 1) // Draft
            {
                if (!string.IsNullOrEmpty(obj.PODocumentCode))
                {
                    if (purchaseOrder == null)
                    {
                        purchaseOrder = new PurchaseOrder();

                        purchaseOrder.DocumentID = (!obj.PODocumentID.HasValue || obj.PODocumentID.Value.Equals(Guid.Empty)) ?
                            Guid.NewGuid() : obj.PODocumentID.Value;
                        purchaseOrder.SODocumentID = salesOrder.DocumentID;
                        purchaseOrder.SOTransactionTypeID = 1; // Sales Order

                        salesOrder.PODocumentID = purchaseOrder.DocumentID;

                        insertPO = true;
                    }

                    purchaseOrder.DocumentCode = obj.PODocumentCode;
                    purchaseOrder.TransactionDate = obj.POTransactionDate;
                }
                else
                {
                    if (purchaseOrder != null)
                    {
                        salesOrder.PODocumentID = null;

                        deletePO = true;
                    }
                }

                salesOrder.TransactionDate = obj.TransactionDate;
                salesOrder.ReferenceNumber = obj.ReferenceNumber;
                salesOrder.DocumentStatusReason = obj.DocumentStatusReason;
                salesOrder.SalesmanID = obj.SalesmanID;
                salesOrder.WarehouseID = obj.WarehouseID;
                salesOrder.CustomerID = obj.CustomerID;
                salesOrder.PriceGroupID = obj.PriceGroupID;
                salesOrder.DiscountGroupID = obj.DiscountGroupID;
                salesOrder.TermOfPaymentID = obj.TermOfPaymentID;
                salesOrder.AddDiscountStrataReason = obj.AddDiscountStrataReason;
                salesOrder.SFAInvoiceDocumentCode = obj.SFAInvoiceDocumentCode;

                deliveryOrder.ShipmentDate = obj.DOShipmentDate;
                deliveryOrder.ReceivedDate = obj.DOReceivedDate;
                deliveryOrder.PrintedCount = obj.DOPrintedCount;
                deliveryOrder.LastPrintedDate = obj.DOLastPrintedDate;

                salesOrder.RawTotalGrossPrice = obj.RawTotalGrossPrice;
                salesOrder.RawTotalPrice = obj.RawTotalPrice;
                salesOrder.RawTotalDiscountStrata1Amount = obj.RawTotalDiscountStrata1Amount;
                salesOrder.RawTotalDiscountStrata2Amount = obj.RawTotalDiscountStrata2Amount;
                salesOrder.RawTotalDiscountStrata3Amount = obj.RawTotalDiscountStrata3Amount;
                salesOrder.RawTotalDiscountStrata4Amount = obj.RawTotalDiscountStrata4Amount;
                salesOrder.RawTotalDiscountStrata5Amount = obj.RawTotalDiscountStrata5Amount;
                salesOrder.RawTotalAddDiscountStrataAmount = obj.RawTotalAddDiscountStrataAmount;
                salesOrder.RawTotalGross = obj.RawTotalGross;
                salesOrder.RawTotalTax = obj.RawTotalTax;
                salesOrder.RawTotal = obj.RawTotal;
                salesOrder.TotalGrossPrice = obj.TotalGrossPrice;
                salesOrder.TotalPrice = obj.TotalPrice;
                salesOrder.TotalDiscountStrata1Amount = obj.TotalDiscountStrata1Amount;
                salesOrder.TotalDiscountStrata2Amount = obj.TotalDiscountStrata2Amount;
                salesOrder.TotalDiscountStrata3Amount = obj.TotalDiscountStrata3Amount;
                salesOrder.TotalDiscountStrata4Amount = obj.TotalDiscountStrata4Amount;
                salesOrder.TotalDiscountStrata5Amount = obj.TotalDiscountStrata5Amount;
                salesOrder.TotalAddDiscountStrataAmount = obj.TotalAddDiscountStrataAmount;
                salesOrder.TotalGross = obj.TotalGross;
                salesOrder.TotalTax = obj.TotalTax;
                salesOrder.Total = obj.Total;
                salesOrder.TotalWeight = obj.TotalWeight;
                salesOrder.TotalDimension = obj.TotalDimension;

                if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                {
                    var insertChilds = obj.ChildSummaries.ToList();
                    var deleteChilds = salesOrderSummaryDataProvider.GetDataByDocumentID(salesOrder.DocumentID);
                    var updateChilds = new List<vSalesOrderSummary>();
                    int i = 0;
                    while (i < deleteChilds.Count)
                    {
                        var data = insertChilds.SingleOrDefault(p => (p.ProductID == deleteChilds[i].ProductID));
                        if (data != null)
                        {
                            insertChilds.Remove(data);
                            deleteChilds.RemoveAt(i);
                            updateChilds.Add(data);
                            continue;
                        }

                        i++;
                    }

                    // Removes existing and unused child data.
                    foreach (var summary in deleteChilds)
                        salesOrderSummaryDataProvider.DeleteData(summary, useTransaction);

                    // Update existing child data.
                    foreach (var summary in updateChilds)
                        vSalesOrderSummaryDataProvider.UpdateData(summary, useTransaction);

                    // Insert new child data.
                    foreach (var summary in insertChilds)
                    {
                        summary.DocumentID = salesOrder.DocumentID;
                        vSalesOrderSummaryDataProvider.InsertData(summary, useTransaction);
                    }
                }
            }

            if (salesOrder.DocumentStatusID != obj.DocumentStatusID)
            {
                var stockTransactionDataProvider = DataConfiguration.GetDefaultDataProvider<IStockTransactionDataProvider>();
                var stockOnHandCurrentDataProvider = DataConfiguration.GetDefaultDataProvider<IStockOnHandCurrentDataProvider>();

                if ((salesOrder.DocumentStatusID == 1) && (obj.DocumentStatusID == 2)) // Draft to Posted
                {
                    var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();

                    if (!closingPeriodDataProvider.IsOpenPeriod(vWarehouse.SiteID.Value, obj.TransactionDate.Year,
                        obj.TransactionDate.Month))
                        throw new Exception(string.Format("This Site for {0:MMM} {0:yyyy} period is already Closed.",
                            obj.TransactionDate));

                    salesOrder.PostedDate = DefaultDataContext.GetDBServerUtcDateTime();

                    // Insert data to Stock Transaction.                    
                    if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                    {
                        foreach (var summary in obj.ChildSummaries)
                        {
                            if ((summary.ChildDetails != null) && (summary.ChildDetails.Count > 0))
                            {
                                int qtyOnHand = stockOnHandCurrentDataProvider.GetProductSummaryStockOnHand(
                                    salesOrder.WarehouseID, summary.ProductID, 1);

                                foreach (var details in summary.ChildDetails)
                                {
                                    var stockOnHandCurrent = stockOnHandCurrentDataProvider.GetData(salesOrder.WarehouseID,
                                        summary.ProductID, details.ProductLotID);

                                    if ((stockOnHandCurrent == null) || ((stockOnHandCurrent.QtyOnHandGood + details.Qty) < 0))
                                        throw new Exception("There is not enough stock for Product '" + summary.Product +
                                            "', Lot Number '" + details.ProductLotCode + "'.");

                                    details.QtyOnHand = stockOnHandCurrent.QtyOnHandGood;

                                    var stockTransaction = new StockTransaction();

                                    stockTransaction.DocumentID = salesOrder.DocumentID;
                                    stockTransaction.TransactionDate = salesOrder.TransactionDate;
                                    stockTransaction.TransactionTypeID = 1; // Sales Order
                                    stockTransaction.DocumentCode = salesOrder.DocumentCode;

                                    stockTransaction.SourceID = salesOrder.WarehouseID;
                                    stockTransaction.DestinationID = salesOrder.CustomerID;

                                    stockTransaction.ProductID = summary.ProductID;

                                    stockTransaction.ProductLotID = details.ProductLotID;

                                    stockTransaction.QtyGood = details.Qty;
                                    stockTransaction.QtyHold = 0;
                                    stockTransaction.QtyBad = 0;

                                    stockOnHandCurrent.QtyOnHandGood += details.Qty;
                                    stockOnHandCurrent.QtyOnHandHold += 0;
                                    stockOnHandCurrent.QtyOnHandBad += 0;

                                    stockOnHandCurrentDataProvider.UpdateData(stockOnHandCurrent, useTransaction);

                                    stockTransactionDataProvider.InsertData(stockTransaction, useTransaction);
                                }

                                if (summary.QtyOnHand != qtyOnHand)
                                {
                                    summary.QtyOnHand = qtyOnHand;
                                    vSalesOrderSummaryDataProvider.UpdateData(summary, useTransaction);
                                }
                            }
                        }
                    }

                    var invoiceDataProvider = DataConfiguration.GetDefaultDataProvider<IInvoiceDataProvider>();

                    var invoice = new Invoice();

                    invoice.DocumentID = Guid.NewGuid();
                    invoice.DocumentCode = string.Format("{0}-{1}-11-{2}", vWarehouse.SiteCode,
                        DateTime.Today.ToString("yy"),
                        DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 11).ToString().PadLeft(7, '0'));
                    invoice.TransactionDate = salesOrder.TransactionDate;
                    invoice.RefDocumentID = salesOrder.DocumentID;
                    invoice.RefTransactionTypeID = 1; // Sales Order
                    invoice.DocumentStatusID = 1; // Draft

                    salesOrder.InvoiceDocumentID = invoice.DocumentID;

                    invoiceDataProvider.InsertData(invoice, useTransaction);

                    salesOrder.DocumentStatusID = 2; // Posted
                }
                else if ((salesOrder.DocumentStatusID == 1) && (obj.DocumentStatusID == 3)) // Draft to Discarded
                {
                    salesOrder.DocumentStatusID = 3; // Discarded
                }
                else if ((salesOrder.DocumentStatusID == 2) && (obj.DocumentStatusID == 4)) // Posted to Voided
                {
                    // Insert data to Stock Transaction.
                    if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                    {
                        foreach (var summary in obj.ChildSummaries)
                        {
                            if ((summary.ChildDetails != null) && (summary.ChildDetails.Count > 0))
                            {
                                foreach (var details in summary.ChildDetails)
                                {
                                    var stockTransaction = new StockTransaction();

                                    stockTransaction.DocumentID = Guid.NewGuid();
                                    stockTransaction.RefVoidedDocumentID = salesOrder.DocumentID;
                                    stockTransaction.TransactionDate = DefaultDataContext.GetDBServerUtcDateTime();
                                    stockTransaction.TransactionTypeID = 1; // Sales Order
                                    stockTransaction.DocumentCode = salesOrder.DocumentCode;

                                    stockTransaction.SourceID = salesOrder.WarehouseID;
                                    stockTransaction.DestinationID = salesOrder.CustomerID;

                                    stockTransaction.QtyGood = details.Qty * -1;
                                    stockTransaction.QtyHold = 0;
                                    stockTransaction.QtyBad = 0;

                                    stockTransaction.ProductID = summary.ProductID;

                                    stockTransaction.ProductLotID = details.ProductLotID;

                                    var stockOnHandCurrent = stockOnHandCurrentDataProvider.GetData(salesOrder.WarehouseID,
                                        summary.ProductID, details.ProductLotID);
                                                                        
                                    stockOnHandCurrent.QtyOnHandGood += details.Qty * -1;
                                    stockOnHandCurrent.QtyOnHandHold += 0;
                                    stockOnHandCurrent.QtyOnHandBad += 0;

                                    stockOnHandCurrentDataProvider.UpdateData(stockOnHandCurrent, useTransaction);

                                    stockTransactionDataProvider.InsertData(stockTransaction, useTransaction);
                                }
                            }
                        }
                    }

                    salesOrder.DocumentStatusID = 4; // Voided
                }
            }

            salesOrder.PrintCount = obj.PrintCount;

            salesOrderDataProvider.UpdateData(salesOrder, useTransaction);
            deliveryOrderDataProvider.UpdateData(deliveryOrder, useTransaction);

            if (insertPO)
                purchaseOrderDataProvider.InsertData(purchaseOrder, useTransaction);
            else if (deletePO)
                purchaseOrderDataProvider.DeleteData(purchaseOrder, useTransaction);
            else if (purchaseOrder != null)
                purchaseOrderDataProvider.UpdateData(purchaseOrder, useTransaction);
        }



        public bool IsSiteOpenPeriod(Guid siteID, DateTime transactionDate)
        {
            var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();

            bool ret = closingPeriodDataProvider.IsOpenPeriod(siteID, transactionDate.Year, transactionDate.Month);
            if (!ret)
                throw new Exception(string.Format("This Site for {0:MMM} {0:yyyy} period is already Closed.",
                    transactionDate));

            return ret;
        }

        #endregion

    }

}
