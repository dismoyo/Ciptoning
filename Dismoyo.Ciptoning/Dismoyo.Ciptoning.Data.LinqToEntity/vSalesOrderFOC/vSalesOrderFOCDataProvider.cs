﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vSalesOrderFOCDataProvider partial class.
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

    public partial class vSalesOrderFOCDataProvider : DefaultViewDataProvider<vSalesOrderFOC>, IvSalesOrderFOCDataProvider
    {

        #region Methods

        protected override void OnInsertData(vSalesOrderFOC obj, bool useTransaction)
        {
            var salesOrderFOCDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesOrderFOCDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();
            var purchaseOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IPurchaseOrderDataProvider>();
            var deliveryOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IDeliveryOrderDataProvider>();

            var salesOrderFOC = new SalesOrderFOC();
            var vWarehouse = vWarehouseDataProvider.GetData(obj.WarehouseID);
            PurchaseOrder purchaseOrder = null;
            var deliveryOrder = new DeliveryOrder();

            salesOrderFOC.DocumentID = (obj.DocumentID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.DocumentID);
            salesOrderFOC.DocumentCode = string.Format("{0}-{1}-05-{2}", vWarehouse.SiteCode,
                DateTime.Today.ToString("yy"),
                DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 5).ToString().PadLeft(7, '0'));
            salesOrderFOC.TransactionDate = obj.TransactionDate;

            if (!string.IsNullOrEmpty(obj.PODocumentCode))
            {
                purchaseOrder = new PurchaseOrder();

                purchaseOrder.DocumentID = (!obj.PODocumentID.HasValue || obj.PODocumentID.Value.Equals(Guid.Empty)) ?
                    Guid.NewGuid() : obj.PODocumentID.Value;
                purchaseOrder.DocumentCode = obj.PODocumentCode;
                purchaseOrder.SODocumentID = salesOrderFOC.DocumentID;
                purchaseOrder.SOTransactionTypeID = 5; // Sales Order FOC
                purchaseOrder.TransactionDate = obj.POTransactionDate;
            }

            salesOrderFOC.ReferenceNumber = obj.ReferenceNumber;
            salesOrderFOC.DocumentStatusReason = obj.DocumentStatusReason;
            salesOrderFOC.SalesmanID = obj.SalesmanID;
            salesOrderFOC.WarehouseID = obj.WarehouseID;
            salesOrderFOC.CustomerID = obj.CustomerID;
            salesOrderFOC.PriceGroupID = obj.PriceGroupID;
            salesOrderFOC.DiscountGroupID = obj.DiscountGroupID;
            salesOrderFOC.TermOfPaymentID = obj.TermOfPaymentID;
            salesOrderFOC.AddDiscountStrataReason = obj.AddDiscountStrataReason;
            salesOrderFOC.SFAInvoiceDocumentCode = obj.SFAInvoiceDocumentCode;

            deliveryOrder.DocumentID = (obj.DODocumentID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.DODocumentID);
            deliveryOrder.DocumentCode = string.Format("{0}-{1}-10-{2}", vWarehouse.SiteCode,
                DateTime.Today.ToString("yy"),
                DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 10).ToString().PadLeft(7, '0'));
            deliveryOrder.TransactionDate = salesOrderFOC.TransactionDate;
            deliveryOrder.RefDocumentID = salesOrderFOC.DocumentID;
            deliveryOrder.RefTransactionTypeID = 5; // Sales Order FOC
            deliveryOrder.ShipmentDate = obj.DOShipmentDate;
            deliveryOrder.ReceivedDate = obj.DOReceivedDate;
            deliveryOrder.PrintedCount = 0;

            if (purchaseOrder != null)
            {
                salesOrderFOC.PODocumentID = purchaseOrder.DocumentID;
                purchaseOrder.DocumentStatusID = 2;
            }
            
            salesOrderFOC.DODocumentID = deliveryOrder.DocumentID;

            salesOrderFOC.DocumentStatusID = 1; // Draft
            deliveryOrder.DocumentStatusID = salesOrderFOC.DocumentStatusID;

            salesOrderFOC.RawTotalGrossPrice = obj.RawTotalGrossPrice;
            salesOrderFOC.RawTotalPrice = obj.RawTotalPrice;
            salesOrderFOC.RawTotalDiscountStrata1Amount = obj.RawTotalDiscountStrata1Amount;
            salesOrderFOC.RawTotalDiscountStrata2Amount = obj.RawTotalDiscountStrata2Amount;
            salesOrderFOC.RawTotalDiscountStrata3Amount = obj.RawTotalDiscountStrata3Amount;
            salesOrderFOC.RawTotalDiscountStrata4Amount = obj.RawTotalDiscountStrata4Amount;
            salesOrderFOC.RawTotalDiscountStrata5Amount = obj.RawTotalDiscountStrata5Amount;
            salesOrderFOC.RawTotalAddDiscountStrataAmount = obj.RawTotalAddDiscountStrataAmount;
            salesOrderFOC.RawTotalGross = obj.RawTotalGross;
            salesOrderFOC.RawTotalTax = obj.RawTotalTax;
            salesOrderFOC.RawTotal = obj.RawTotal;
            salesOrderFOC.TotalGrossPrice = obj.TotalGrossPrice;
            salesOrderFOC.TotalPrice = obj.TotalPrice;
            salesOrderFOC.TotalDiscountStrata1Amount = obj.TotalDiscountStrata1Amount;
            salesOrderFOC.TotalDiscountStrata2Amount = obj.TotalDiscountStrata2Amount;
            salesOrderFOC.TotalDiscountStrata3Amount = obj.TotalDiscountStrata3Amount;
            salesOrderFOC.TotalDiscountStrata4Amount = obj.TotalDiscountStrata4Amount;
            salesOrderFOC.TotalDiscountStrata5Amount = obj.TotalDiscountStrata5Amount;
            salesOrderFOC.TotalAddDiscountStrataAmount = obj.TotalAddDiscountStrataAmount;
            salesOrderFOC.TotalGross = obj.TotalGross;
            salesOrderFOC.TotalTax = obj.TotalTax;
            salesOrderFOC.Total = obj.Total;
            salesOrderFOC.TotalWeight = obj.TotalWeight;
            salesOrderFOC.TotalDimension = obj.TotalDimension;
            salesOrderFOC.PrintCount = obj.PrintCount;

            salesOrderFOCDataProvider.InsertData(salesOrderFOC, useTransaction);
            deliveryOrderDataProvider.InsertData(deliveryOrder, useTransaction);

            if (purchaseOrder != null)
                purchaseOrderDataProvider.InsertData(purchaseOrder, useTransaction);

            if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
            {
                // Insert new child data.
                var vSalesOrderFOCSummaryDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvSalesOrderFOCSummaryDataProvider>();
                foreach (var summary in obj.ChildSummaries)
                {
                    summary.DocumentID = salesOrderFOC.DocumentID;
                    vSalesOrderFOCSummaryDataProvider.InsertData(summary, useTransaction);
                }
            }
        }

        protected override void OnUpdateData(vSalesOrderFOC obj, bool useTransaction)
        {
            var salesOrderFOCDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesOrderFOCDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();
            var purchaseOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IPurchaseOrderDataProvider>();
            var deliveryOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IDeliveryOrderDataProvider>();

            var salesOrderFOC = salesOrderFOCDataProvider.GetData(obj.DocumentID);
            var vWarehouse = vWarehouseDataProvider.GetData(obj.WarehouseID);

            PurchaseOrder purchaseOrder = null;
            if (salesOrderFOC.PODocumentID.HasValue)
                purchaseOrder = purchaseOrderDataProvider.GetData(salesOrderFOC.PODocumentID.Value);

            var deliveryOrder = deliveryOrderDataProvider.GetData(obj.DODocumentID);

            var salesOrderFOCSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<ISalesOrderFOCSummaryDataProvider>();
            var vSalesOrderFOCSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<IvSalesOrderFOCSummaryDataProvider>();

            bool insertPO = false;
            bool deletePO = false;
            if (salesOrderFOC.DocumentStatusID == 1) // Draft
            {
                if (!string.IsNullOrEmpty(obj.PODocumentCode))
                {
                    if (purchaseOrder == null)
                    {
                        purchaseOrder = new PurchaseOrder();

                        purchaseOrder.DocumentID = (!obj.PODocumentID.HasValue || obj.PODocumentID.Value.Equals(Guid.Empty)) ?
                            Guid.NewGuid() : obj.PODocumentID.Value;
                        purchaseOrder.SODocumentID = salesOrderFOC.DocumentID;
                        purchaseOrder.SOTransactionTypeID = 5; // Sales Order FOC

                        salesOrderFOC.PODocumentID = purchaseOrder.DocumentID;

                        insertPO = true;
                    }

                    purchaseOrder.DocumentCode = obj.PODocumentCode;
                    purchaseOrder.TransactionDate = obj.POTransactionDate;
                }
                else
                {
                    if (purchaseOrder != null)
                    {
                        salesOrderFOC.PODocumentID = null;

                        deletePO = true;
                    }
                }

                salesOrderFOC.TransactionDate = obj.TransactionDate;
                salesOrderFOC.ReferenceNumber = obj.ReferenceNumber;
                salesOrderFOC.DocumentStatusReason = obj.DocumentStatusReason;
                salesOrderFOC.SalesmanID = obj.SalesmanID;
                salesOrderFOC.WarehouseID = obj.WarehouseID;
                salesOrderFOC.CustomerID = obj.CustomerID;
                salesOrderFOC.PriceGroupID = obj.PriceGroupID;
                salesOrderFOC.DiscountGroupID = obj.DiscountGroupID;
                salesOrderFOC.TermOfPaymentID = obj.TermOfPaymentID;
                salesOrderFOC.AddDiscountStrataReason = obj.AddDiscountStrataReason;
                salesOrderFOC.SFAInvoiceDocumentCode = obj.SFAInvoiceDocumentCode;

                deliveryOrder.ShipmentDate = obj.DOShipmentDate;
                deliveryOrder.ReceivedDate = obj.DOReceivedDate;
                deliveryOrder.PrintedCount = obj.DOPrintedCount;
                deliveryOrder.LastPrintedDate = obj.DOLastPrintedDate;

                salesOrderFOC.RawTotalGrossPrice = obj.RawTotalGrossPrice;
                salesOrderFOC.RawTotalPrice = obj.RawTotalPrice;
                salesOrderFOC.RawTotalDiscountStrata1Amount = obj.RawTotalDiscountStrata1Amount;
                salesOrderFOC.RawTotalDiscountStrata2Amount = obj.RawTotalDiscountStrata2Amount;
                salesOrderFOC.RawTotalDiscountStrata3Amount = obj.RawTotalDiscountStrata3Amount;
                salesOrderFOC.RawTotalDiscountStrata4Amount = obj.RawTotalDiscountStrata4Amount;
                salesOrderFOC.RawTotalDiscountStrata5Amount = obj.RawTotalDiscountStrata5Amount;
                salesOrderFOC.RawTotalAddDiscountStrataAmount = obj.RawTotalAddDiscountStrataAmount;
                salesOrderFOC.RawTotalGross = obj.RawTotalGross;
                salesOrderFOC.RawTotalTax = obj.RawTotalTax;
                salesOrderFOC.RawTotal = obj.RawTotal;
                salesOrderFOC.TotalGrossPrice = obj.TotalGrossPrice;
                salesOrderFOC.TotalPrice = obj.TotalPrice;
                salesOrderFOC.TotalDiscountStrata1Amount = obj.TotalDiscountStrata1Amount;
                salesOrderFOC.TotalDiscountStrata2Amount = obj.TotalDiscountStrata2Amount;
                salesOrderFOC.TotalDiscountStrata3Amount = obj.TotalDiscountStrata3Amount;
                salesOrderFOC.TotalDiscountStrata4Amount = obj.TotalDiscountStrata4Amount;
                salesOrderFOC.TotalDiscountStrata5Amount = obj.TotalDiscountStrata5Amount;
                salesOrderFOC.TotalAddDiscountStrataAmount = obj.TotalAddDiscountStrataAmount;
                salesOrderFOC.TotalGross = obj.TotalGross;
                salesOrderFOC.TotalTax = obj.TotalTax;
                salesOrderFOC.Total = obj.Total;
                salesOrderFOC.TotalWeight = obj.TotalWeight;
                salesOrderFOC.TotalDimension = obj.TotalDimension;
                
                if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                {
                    var insertChilds = obj.ChildSummaries.ToList();
                    var deleteChilds = salesOrderFOCSummaryDataProvider.GetDataByDocumentID(salesOrderFOC.DocumentID);
                    var updateChilds = new List<vSalesOrderFOCSummary>();
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
                        salesOrderFOCSummaryDataProvider.DeleteData(summary, useTransaction);

                    // Update existing child data.
                    foreach (var summary in updateChilds)
                        vSalesOrderFOCSummaryDataProvider.UpdateData(summary, useTransaction);

                    // Insert new child data.
                    foreach (var summary in insertChilds)
                    {
                        summary.DocumentID = salesOrderFOC.DocumentID;
                        vSalesOrderFOCSummaryDataProvider.InsertData(summary, useTransaction);
                    }
                }
            }

            if (salesOrderFOC.DocumentStatusID != obj.DocumentStatusID)
            {
                var stockTransactionDataProvider = DataConfiguration.GetDefaultDataProvider<IStockTransactionDataProvider>();
                var stockOnHandCurrentDataProvider = DataConfiguration.GetDefaultDataProvider<IStockOnHandCurrentDataProvider>();

                if ((salesOrderFOC.DocumentStatusID == 1) && (obj.DocumentStatusID == 2)) // Draft to Posted
                {
                    var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();

                    if (!closingPeriodDataProvider.IsOpenPeriod(vWarehouse.SiteID.Value, obj.TransactionDate.Year,
                        obj.TransactionDate.Month))
                        throw new Exception(string.Format("This Site for {0:MMM} {0:yyyy} period is already Closed.",
                            obj.TransactionDate));

                    salesOrderFOC.PostedDate = DefaultDataContext.GetDBServerUtcDateTime();

                    // Insert data to Stock Transaction.
                    if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                    {
                        foreach (var summary in obj.ChildSummaries)
                        {
                            if ((summary.ChildDetails != null) && (summary.ChildDetails.Count > 0))
                            {
                                int qtyOnHand = stockOnHandCurrentDataProvider.GetProductSummaryStockOnHand(
                                    salesOrderFOC.WarehouseID, summary.ProductID, 1);

                                foreach (var details in summary.ChildDetails)
                                {
                                    var stockOnHandCurrent = stockOnHandCurrentDataProvider.GetData(salesOrderFOC.WarehouseID,
                                        summary.ProductID, details.ProductLotID);

                                    if ((stockOnHandCurrent == null) || ((stockOnHandCurrent.QtyOnHandGood + details.Qty) < 0))
                                        throw new Exception("There is not enough stock for Product '" + summary.Product +
                                            "', Lot Number '" + details.ProductLotCode + "'.");

                                    details.QtyOnHand = stockOnHandCurrent.QtyOnHandGood;

                                    var stockTransaction = new StockTransaction();

                                    stockTransaction.DocumentID = salesOrderFOC.DocumentID;
                                    stockTransaction.TransactionDate = DefaultDataContext.GetDBServerUtcDateTime();
                                    stockTransaction.TransactionTypeID = 5; // Sales Order FOC
                                    stockTransaction.DocumentCode = salesOrderFOC.DocumentCode;

                                    stockTransaction.SourceID = salesOrderFOC.WarehouseID;
                                    stockTransaction.DestinationID = salesOrderFOC.CustomerID;

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
                                    vSalesOrderFOCSummaryDataProvider.UpdateData(summary, useTransaction);
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
                    invoice.TransactionDate = salesOrderFOC.TransactionDate;
                    invoice.RefDocumentID = salesOrderFOC.DocumentID;
                    invoice.RefTransactionTypeID = 5; // Sales Order FOC
                    invoice.DocumentStatusID = 1; // Draft

                    salesOrderFOC.InvoiceDocumentID = invoice.DocumentID;

                    invoiceDataProvider.InsertData(invoice, useTransaction);

                    salesOrderFOC.DocumentStatusID = 2; // Posted
                }
                else if ((salesOrderFOC.DocumentStatusID == 1) && (obj.DocumentStatusID == 3)) // Draft to Discarded
                {
                    salesOrderFOC.DocumentStatusID = 3; // Discarded
                }
                else if ((salesOrderFOC.DocumentStatusID == 2) && (obj.DocumentStatusID == 4)) // Posted to Voided
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
                                    stockTransaction.RefVoidedDocumentID = salesOrderFOC.DocumentID;
                                    stockTransaction.TransactionDate = salesOrderFOC.TransactionDate;
                                    stockTransaction.TransactionTypeID = 5; // Sales Order FOC
                                    stockTransaction.DocumentCode = salesOrderFOC.DocumentCode;

                                    stockTransaction.SourceID = salesOrderFOC.WarehouseID;
                                    stockTransaction.DestinationID = salesOrderFOC.CustomerID;

                                    stockTransaction.QtyGood = details.Qty * -1;
                                    stockTransaction.QtyHold = 0;
                                    stockTransaction.QtyBad = 0;

                                    stockTransaction.ProductID = summary.ProductID;

                                    stockTransaction.ProductLotID = details.ProductLotID;

                                    var stockOnHandCurrent = stockOnHandCurrentDataProvider.GetData(salesOrderFOC.WarehouseID,
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

                    salesOrderFOC.DocumentStatusID = 4; // Voided
                }
            }

            salesOrderFOC.PrintCount = obj.PrintCount;

            salesOrderFOCDataProvider.UpdateData(salesOrderFOC, useTransaction);
            deliveryOrderDataProvider.UpdateData(deliveryOrder, useTransaction);

            if (insertPO)
                purchaseOrderDataProvider.InsertData(purchaseOrder, useTransaction);
            else if (deletePO)
                purchaseOrderDataProvider.DeleteData(purchaseOrder, useTransaction);
            else if (purchaseOrder != null)
                purchaseOrderDataProvider.UpdateData(purchaseOrder, useTransaction);
        }

        #endregion

    }

}
