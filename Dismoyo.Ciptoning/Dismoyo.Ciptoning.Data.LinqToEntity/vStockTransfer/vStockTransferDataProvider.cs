﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vStockTransferDataProvider partial class.
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

    public partial class vStockTransferDataProvider : DefaultViewDataProvider<vStockTransfer>, IvStockTransferDataProvider
    {

        #region Methods

        protected override void OnInsertData(vStockTransfer obj, bool useTransaction)
        {
            ////////////////////////////////////
            if (obj.SourcePIC == null) obj.SourcePIC = "";
            ////////////////////////////////////

            var stockTransferDataProvider = DataConfiguration.GetDefaultDataProvider<IStockTransferDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();
            var deliveryOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IDeliveryOrderDataProvider>();

            var stockTransfer = new StockTransfer();
            var vWarehouse = vWarehouseDataProvider.GetData(obj.SourceWarehouseID);
            var deliveryOrder = new DeliveryOrder();

            stockTransfer.DocumentID = (obj.DocumentID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.DocumentID);
            stockTransfer.DocumentCode = string.Format("{0}-{1}-08-{2}", vWarehouse.SiteCode,
                DateTime.Today.ToString("yy"),
                DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 8).ToString().PadLeft(7, '0'));
            stockTransfer.TransactionDate = obj.TransactionDate;
            stockTransfer.SourceWarehouseID = obj.SourceWarehouseID;
            stockTransfer.SourcePIC = obj.SourcePIC;
            stockTransfer.DestinationWarehouseID = obj.DestinationWarehouseID;
            stockTransfer.DestinationPIC = obj.DestinationPIC;
            stockTransfer.ReferenceNumber = obj.ReferenceNumber;
            stockTransfer.AttachmentFile = obj.AttachmentFile;
            
            deliveryOrder.DocumentID = (obj.DODocumentID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.DODocumentID);
            deliveryOrder.DocumentCode = string.Format("{0}-{1}-10-{2}", vWarehouse.SiteCode,
                DateTime.Today.ToString("yy"),
                DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 10).ToString().PadLeft(7, '0'));
            deliveryOrder.TransactionDate = stockTransfer.TransactionDate;
            deliveryOrder.RefDocumentID = stockTransfer.DocumentID;
            deliveryOrder.RefTransactionTypeID = 8; // Stock Transfer
            deliveryOrder.ShipmentDate = obj.DOShipmentDate;
            deliveryOrder.ReceivedDate = obj.DOReceivedDate;
            deliveryOrder.PrintedCount = 0;

            stockTransfer.DODocumentID = deliveryOrder.DocumentID;

            stockTransfer.DocumentStatusID = 1; // Draft
            deliveryOrder.DocumentStatusID = stockTransfer.DocumentStatusID;

            stockTransfer.PrintCount = obj.PrintCount;

            stockTransferDataProvider.InsertData(stockTransfer, useTransaction);
            deliveryOrderDataProvider.InsertData(deliveryOrder, useTransaction);
            if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
            {
                // Insert new child data.
                var vStockTransferSummaryDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvStockTransferSummaryDataProvider>();
                foreach (var summary in obj.ChildSummaries)
                {
                    summary.DocumentID = stockTransfer.DocumentID;
                    vStockTransferSummaryDataProvider.InsertData(summary, useTransaction);
                }
            }
        }

        protected override void OnUpdateData(vStockTransfer obj, bool useTransaction)
        {
            ////////////////////////////////////
            if (obj.SourcePIC == null) obj.SourcePIC = "";
            ////////////////////////////////////

            var stockTransferDataProvider = DataConfiguration.GetDefaultDataProvider<IStockTransferDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();
            var deliveryOrderDataProvider = DataConfiguration.GetDefaultDataProvider<IDeliveryOrderDataProvider>();

            var stockTransfer = stockTransferDataProvider.GetData(obj.DocumentID);
            var vSourceWarehouse = vWarehouseDataProvider.GetData(obj.SourceWarehouseID);
            var vDestinationWarehouse = vWarehouseDataProvider.GetData(obj.DestinationWarehouseID);
            var deliveryOrder = deliveryOrderDataProvider.GetData(obj.DODocumentID);

            var stockTransferSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<IStockTransferSummaryDataProvider>();
            var vStockTransferSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<IvStockTransferSummaryDataProvider>();
            
            if (stockTransfer.DocumentStatusID == 1) // Draft
            {
                stockTransfer.TransactionDate = obj.TransactionDate;
                stockTransfer.SourcePIC = obj.SourcePIC;
                stockTransfer.DestinationPIC = obj.DestinationPIC;
                stockTransfer.ReferenceNumber = obj.ReferenceNumber;
                if (obj.AttachmentFile != null)
                    stockTransfer.AttachmentFile = obj.AttachmentFile;

                deliveryOrder.ShipmentDate = obj.DOShipmentDate;
                deliveryOrder.ReceivedDate = obj.DOReceivedDate;
                deliveryOrder.PrintedCount = obj.DOPrintedCount;
                deliveryOrder.LastPrintedDate = obj.DOLastPrintedDate;
                
                if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                {
                    var insertChilds = obj.ChildSummaries.ToList();
                    var deleteChilds = stockTransferSummaryDataProvider.GetDataByDocumentID(stockTransfer.DocumentID);
                    var updateChilds = new List<vStockTransferSummary>();
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
                        stockTransferSummaryDataProvider.DeleteData(summary, useTransaction);

                    // Update existing child data.
                    foreach (var summary in updateChilds)
                        vStockTransferSummaryDataProvider.UpdateData(summary, useTransaction);

                    // Insert new child data.
                    foreach (var summary in insertChilds)
                    {
                        summary.DocumentID = stockTransfer.DocumentID;
                        vStockTransferSummaryDataProvider.InsertData(summary, useTransaction);
                    }
                }
            }

            if (stockTransfer.DocumentStatusID != obj.DocumentStatusID)
            {
                if ((stockTransfer.DocumentStatusID == 1) && (obj.DocumentStatusID == 2)) // Draft to Posted
                {
                    var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();

                    if (!closingPeriodDataProvider.IsOpenPeriod(obj.SourceSiteID.Value, obj.TransactionDate.Year,
                        obj.TransactionDate.Month))
                        throw new Exception(string.Format("This Site for {0:MMM} {0:yyyy} period is already Closed.",
                            obj.TransactionDate));

                    if (!closingPeriodDataProvider.IsOpenPeriod(obj.DestinationSiteID.Value, obj.TransactionDate.Year,
                        obj.TransactionDate.Month))
                        throw new Exception(string.Format("The Destination Site for {0:MMM} {0:yyyy} period is already Closed.",
                            obj.TransactionDate));

                    stockTransfer.PostedDate = DefaultDataContext.GetDBServerUtcDateTime();

                    // Insert data to Stock Transaction.
                    var stockTransactionDataProvider = DataConfiguration.GetDefaultDataProvider<IStockTransactionDataProvider>();
                    var stockOnHandCurrentDataProvider = DataConfiguration.GetDefaultDataProvider<IStockOnHandCurrentDataProvider>();

                    if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                    {
                        foreach (var summary in obj.ChildSummaries)
                        {
                            if ((summary.ChildDetails != null) && (summary.ChildDetails.Count > 0))
                            {
                                int qtyOnHandGood = stockOnHandCurrentDataProvider.GetProductSummaryStockOnHand(
                                    stockTransfer.SourceWarehouseID, summary.ProductID, 1);
                                int qtyOnHandHold = stockOnHandCurrentDataProvider.GetProductSummaryStockOnHand(
                                    stockTransfer.SourceWarehouseID, summary.ProductID, 2);
                                int qtyOnHandBad = stockOnHandCurrentDataProvider.GetProductSummaryStockOnHand(
                                    stockTransfer.SourceWarehouseID, summary.ProductID, 3);

                                foreach (var details in summary.ChildDetails)
                                {
                                    var stockOnHandCurrent = stockOnHandCurrentDataProvider.GetData(stockTransfer.SourceWarehouseID,
                                        summary.ProductID, details.ProductLotID);
                                    var stockOnHandCurrentDest = stockOnHandCurrentDataProvider.GetData(stockTransfer.DestinationWarehouseID,
                                        summary.ProductID, details.ProductLotID);

                                    if ((stockOnHandCurrent == null) ||
                                        ((stockOnHandCurrent.QtyOnHandGood + details.QtyGood) < 0) ||
                                        ((stockOnHandCurrent.QtyOnHandHold + details.QtyHold) < 0) ||
                                        ((stockOnHandCurrent.QtyOnHandBad + details.QtyBad) < 0))
                                        throw new Exception("There is not enough stock for Product '" + summary.Product +
                                            "', Lot Number '" + details.ProductLotCode + "'.");

                                    details.QtyOnHandGood = stockOnHandCurrent.QtyOnHandGood;
                                    details.QtyOnHandHold = stockOnHandCurrent.QtyOnHandHold;
                                    details.QtyOnHandBad = stockOnHandCurrent.QtyOnHandBad;

                                    var stockTransaction = new StockTransaction();

                                    stockTransaction.DocumentID = stockTransfer.DocumentID;
                                    stockTransaction.TransactionDate = stockTransfer.TransactionDate;
                                    stockTransaction.TransactionTypeID = 8; // Stock Transfer
                                    stockTransaction.DocumentCode = stockTransfer.DocumentCode;
                                    stockTransaction.SourceID = stockTransfer.SourceWarehouseID;
                                    stockTransaction.DestinationID = stockTransfer.DestinationWarehouseID;

                                    stockTransaction.ProductID = summary.ProductID;

                                    stockTransaction.ProductLotID = details.ProductLotID;

                                    stockTransaction.QtyGood = details.QtyGood;
                                    stockTransaction.QtyHold = details.QtyHold;
                                    stockTransaction.QtyBad = details.QtyBad;

                                    stockOnHandCurrent.QtyOnHandGood += details.QtyGood;
                                    stockOnHandCurrent.QtyOnHandHold += details.QtyHold;
                                    stockOnHandCurrent.QtyOnHandBad += details.QtyBad;

                                    stockOnHandCurrentDataProvider.UpdateData(stockOnHandCurrent, useTransaction);

                                    if (stockOnHandCurrentDest == null)
                                    {
                                        stockOnHandCurrentDest = new StockOnHandCurrent();
                                        stockOnHandCurrentDest.WarehouseID = stockTransfer.DestinationWarehouseID;
                                        stockOnHandCurrentDest.ProductID = summary.ProductID;
                                        stockOnHandCurrentDest.ProductLotID = details.ProductLotID;
                                        stockOnHandCurrentDest.QtyOnHandGood = details.QtyGood * -1;
                                        stockOnHandCurrentDest.QtyOnHandHold = details.QtyHold * -1;
                                        stockOnHandCurrentDest.QtyOnHandBad = details.QtyBad * -1;

                                        stockOnHandCurrentDataProvider.InsertData(stockOnHandCurrentDest, useTransaction);
                                    }
                                    else
                                    {
                                        stockOnHandCurrentDest.QtyOnHandGood += details.QtyGood * -1;
                                        stockOnHandCurrentDest.QtyOnHandHold += details.QtyHold * -1;
                                        stockOnHandCurrentDest.QtyOnHandBad += details.QtyBad * -1;

                                        stockOnHandCurrentDataProvider.UpdateData(stockOnHandCurrentDest, useTransaction);
                                    }

                                    stockTransactionDataProvider.InsertData(stockTransaction, useTransaction);
                                }

                                if ((summary.QtyOnHandGood != qtyOnHandGood) ||
                                    (summary.QtyOnHandHold != qtyOnHandHold) ||
                                    (summary.QtyOnHandBad != qtyOnHandBad))
                                {
                                    summary.QtyOnHandGood = qtyOnHandGood;
                                    summary.QtyOnHandHold = qtyOnHandHold;
                                    summary.QtyOnHandBad = qtyOnHandBad;
                                    vStockTransferSummaryDataProvider.UpdateData(summary, useTransaction);
                                }
                            }
                        }
                    }

                    stockTransfer.DocumentStatusID = 2; // Posted

                    var userDataProvider = DataConfiguration.GetDefaultDataProvider<IUserDataProvider>();
                    var userNotificationDataProvider = DataConfiguration.GetDefaultDataProvider<IUserNotificationDataProvider>();

                    var users = userDataProvider.GetDataBySiteID(vDestinationWarehouse.SiteID.Value);
                    foreach (var u in users)
                    {
                        var userNotification = new UserNotification();

                        userNotification.ID = Guid.NewGuid();
                        userNotification.RaisedDate = DefaultDataContext.GetDBServerUtcDateTime();
                        userNotification.UserID = u.ID;
                        userNotification.CategoryID = 8; // Stock Transfer
                        userNotification.HtmlMessage =
                            string.Format("A new Stock Transfer (<b>{0}</b>) has been Posted by <b>{1}</b> to <b>{2}</b>.",
                             obj.DocumentCode, vSourceWarehouse.Warehouse, vDestinationWarehouse.Warehouse);
                        userNotification.IsRead = false;

                        userNotificationDataProvider.InsertData(userNotification, useTransaction);
                    }
                }
                else if ((stockTransfer.DocumentStatusID == 1) && (obj.DocumentStatusID == 3)) // Draft to Discarded
                {
                    stockTransfer.DocumentStatusID = 3; // Discarded
                }
            }

            stockTransfer.PrintCount = obj.PrintCount;

            stockTransferDataProvider.UpdateData(stockTransfer, useTransaction);
        }

        #endregion

    }

}
