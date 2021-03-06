﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vStockReceiveDataProvider partial class.
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

    public partial class vStockReceiveDataProvider : DefaultViewDataProvider<vStockReceive>, IvStockReceiveDataProvider
    {

        #region Methods

        protected override void OnInsertData(vStockReceive obj, bool useTransaction)
        {
            var stockReceiveDataProvider = DataConfiguration.GetDefaultDataProvider<IStockReceiveDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();

            var stockReceive = new StockReceive();
            var vWarehouse = vWarehouseDataProvider.GetData(obj.WarehouseID);

            stockReceive.DocumentID = (obj.DocumentID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.DocumentID);
            stockReceive.DocumentCode = string.Format("{0}-{1}-12-{2}", vWarehouse.SiteCode,
                DateTime.Today.ToString("yy"),
                DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 12).ToString().PadLeft(7, '0'));
            stockReceive.TransactionDate = obj.TransactionDate;
            stockReceive.WarehouseID = obj.WarehouseID;
            stockReceive.PIC = obj.PIC;
            stockReceive.ReferenceNumber = obj.ReferenceNumber;
            stockReceive.AttachmentFile = obj.AttachmentFile;
            stockReceive.DocumentStatusID = 1; // Draft

            stockReceiveDataProvider.InsertData(stockReceive, useTransaction);
            if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
            {
                // Insert new child data.
                var vStockReceiveSummaryDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvStockReceiveSummaryDataProvider>();
                foreach (var summary in obj.ChildSummaries)
                {
                    summary.DocumentID = stockReceive.DocumentID;
                    vStockReceiveSummaryDataProvider.InsertData(summary, useTransaction);
                }
            }
        }

        protected override void OnUpdateData(vStockReceive obj, bool useTransaction)
        {
            var stockReceiveDataProvider = DataConfiguration.GetDefaultDataProvider<IStockReceiveDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();

            var stockReceive = stockReceiveDataProvider.GetData(obj.DocumentID);
            var vWarehouse = vWarehouseDataProvider.GetData(obj.WarehouseID);

            var stockReceiveSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<IStockReceiveSummaryDataProvider>();
            var vStockReceiveSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<IvStockReceiveSummaryDataProvider>();

            if (stockReceive.DocumentStatusID == 1) // Draft
            {
                stockReceive.TransactionDate = obj.TransactionDate;
                stockReceive.PIC = obj.PIC;
                stockReceive.ReferenceNumber = obj.ReferenceNumber;
                if (obj.AttachmentFile != null)
                    stockReceive.AttachmentFile = obj.AttachmentFile;

                if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                {
                    var insertChilds = obj.ChildSummaries.ToList();
                    var deleteChilds = stockReceiveSummaryDataProvider.GetDataByDocumentID(stockReceive.DocumentID);
                    var updateChilds = new List<vStockReceiveSummary>();
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
                        stockReceiveSummaryDataProvider.DeleteData(summary, useTransaction);

                    // Update existing child data.
                    foreach (var summary in updateChilds)
                        vStockReceiveSummaryDataProvider.UpdateData(summary, useTransaction);

                    // Insert new child data.
                    foreach (var summary in insertChilds)
                    {
                        summary.DocumentID = stockReceive.DocumentID;
                        vStockReceiveSummaryDataProvider.InsertData(summary, useTransaction);
                    }
                }
            }

            if (stockReceive.DocumentStatusID != obj.DocumentStatusID)
            {
                if ((stockReceive.DocumentStatusID == 1) && (obj.DocumentStatusID == 2)) // Draft to Posted
                {
                    var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();

                    if (!closingPeriodDataProvider.IsOpenPeriod(vWarehouse.SiteID.Value, obj.TransactionDate.Year,
                        obj.TransactionDate.Month))
                        throw new Exception(string.Format("This Site for {0:MMM} {0:yyyy} period is already Closed.",
                            obj.TransactionDate));

                    stockReceive.PostedDate = DefaultDataContext.GetDBServerUtcDateTime();

                    // Insert data to Stock Transaction.
                    var stockTransactionDataProvider = DataConfiguration.GetDefaultDataProvider<IStockTransactionDataProvider>();
                    var stockOnHandCurrentDataProvider = DataConfiguration.GetDefaultDataProvider<IStockOnHandCurrentDataProvider>();

                    if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                    {
                        foreach (var summary in obj.ChildSummaries)
                        {
                            if ((summary.ChildDetails != null) && (summary.ChildDetails.Count > 0))
                            {
                                int qtyOnHand = stockOnHandCurrentDataProvider.GetProductSummaryStockOnHand(
                                    stockReceive.WarehouseID, summary.ProductID, 1);

                                foreach (var details in summary.ChildDetails)
                                {
                                    var stockTransaction = new StockTransaction();

                                    stockTransaction.DocumentID = stockReceive.DocumentID;
                                    stockTransaction.TransactionDate = stockReceive.TransactionDate;
                                    stockTransaction.TransactionTypeID = 12; // Stock Receive
                                    stockTransaction.DocumentCode = stockReceive.DocumentCode;
                                    stockTransaction.SourceID = Guid.Empty;
                                    stockTransaction.DestinationID = stockReceive.WarehouseID;

                                    stockTransaction.ProductID = summary.ProductID;

                                    stockTransaction.ProductLotID = details.ProductLotID;
                                    stockTransaction.QtyGood = details.Qty;
                                    stockTransaction.QtyHold = 0;
                                    stockTransaction.QtyBad = 0;

                                    var stockOnHandCurrent = stockOnHandCurrentDataProvider.GetData(stockReceive.WarehouseID,
                                        summary.ProductID, details.ProductLotID);

                                    details.QtyOnHand = 0;

                                    if (stockOnHandCurrent == null)
                                    {
                                        stockOnHandCurrent = new StockOnHandCurrent();
                                        stockOnHandCurrent.WarehouseID = stockReceive.WarehouseID;
                                        stockOnHandCurrent.ProductID = summary.ProductID;
                                        stockOnHandCurrent.ProductLotID = details.ProductLotID;
                                        stockOnHandCurrent.QtyOnHandGood = details.Qty * -1;
                                        stockOnHandCurrent.QtyOnHandHold = 0;
                                        stockOnHandCurrent.QtyOnHandBad = 0;

                                        stockOnHandCurrentDataProvider.InsertData(stockOnHandCurrent, useTransaction);
                                    }
                                    else
                                    {
                                        details.QtyOnHand = stockOnHandCurrent.QtyOnHandGood;

                                        stockOnHandCurrent.QtyOnHandGood += details.Qty * -1;
                                        stockOnHandCurrent.QtyOnHandHold += 0;
                                        stockOnHandCurrent.QtyOnHandBad += 0;

                                        stockOnHandCurrentDataProvider.UpdateData(stockOnHandCurrent, useTransaction);
                                    }

                                    stockTransactionDataProvider.InsertData(stockTransaction, useTransaction);
                                }

                                if (summary.QtyOnHand != qtyOnHand)
                                {
                                    summary.QtyOnHand = qtyOnHand;
                                    vStockReceiveSummaryDataProvider.UpdateData(summary, useTransaction);
                                }
                            }
                        }
                    }

                    stockReceive.DocumentStatusID = 2; // Posted
                }
                else if ((stockReceive.DocumentStatusID == 1) && (obj.DocumentStatusID == 3)) // Draft to Discarded
                {
                    stockReceive.DocumentStatusID = 3; // Discarded
                }
            }

            stockReceiveDataProvider.UpdateData(stockReceive);
        }

        #endregion

    }

}
