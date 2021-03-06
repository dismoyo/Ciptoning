﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vStockDisposalDataProvider partial class.
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

    public partial class vStockDisposalDataProvider : DefaultViewDataProvider<vStockDisposal>, IvStockDisposalDataProvider
    {

        #region Methods

        protected override void OnInsertData(vStockDisposal obj, bool useTransaction)
        {
            var stockDisposalDataProvider = DataConfiguration.GetDefaultDataProvider<IStockDisposalDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();

            var stockDisposal = new StockDisposal();
            var vWarehouse = vWarehouseDataProvider.GetData(obj.WarehouseID);

            stockDisposal.DocumentID = (obj.DocumentID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.DocumentID);
            stockDisposal.DocumentCode = string.Format("{0}-{1}-09-{2}", vWarehouse.SiteCode,
                DateTime.Today.ToString("yy"),
                DefaultDataContext.GetAutoNumberCounter(vWarehouse.SiteID.Value, 9).ToString().PadLeft(7, '0'));
            stockDisposal.TransactionDate = obj.TransactionDate;
            stockDisposal.WarehouseID = obj.WarehouseID;
            stockDisposal.PIC = obj.PIC;
            stockDisposal.ReferenceNumber = obj.ReferenceNumber;
            stockDisposal.AttachmentFile = obj.AttachmentFile;
            stockDisposal.DocumentStatusID = 1; // Draft

            stockDisposalDataProvider.InsertData(stockDisposal, useTransaction);
            if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
            {
                // Insert new child data.
                var vStockDisposalSummaryDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvStockDisposalSummaryDataProvider>();
                foreach (var summary in obj.ChildSummaries)
                {
                    summary.DocumentID = stockDisposal.DocumentID;
                    vStockDisposalSummaryDataProvider.InsertData(summary, useTransaction);
                }
            }
        }

        protected override void OnUpdateData(vStockDisposal obj, bool useTransaction)
        {
            var stockDisposalDataProvider = DataConfiguration.GetDefaultDataProvider<IStockDisposalDataProvider>();
            var vWarehouseDataProvider = DataConfiguration.GetDefaultDataProvider<IvWarehouseDataProvider>();

            var stockDisposal = stockDisposalDataProvider.GetData(obj.DocumentID);
            var vWarehouse = vWarehouseDataProvider.GetData(obj.WarehouseID);

            var stockDisposalSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<IStockDisposalSummaryDataProvider>();
            var vStockDisposalSummaryDataProvider =
                DataConfiguration.GetDefaultDataProvider<IvStockDisposalSummaryDataProvider>();
            
            if (stockDisposal.DocumentStatusID == 1) // Draft
            {
                stockDisposal.TransactionDate = obj.TransactionDate;
                stockDisposal.PIC = obj.PIC;
                stockDisposal.ReferenceNumber = obj.ReferenceNumber;
                if (obj.AttachmentFile != null)
                    stockDisposal.AttachmentFile = obj.AttachmentFile;

                if ((obj.ChildSummaries != null) && (obj.ChildSummaries.Count > 0))
                {
                    var insertChilds = obj.ChildSummaries.ToList();
                    var deleteChilds = stockDisposalSummaryDataProvider.GetDataByDocumentID(stockDisposal.DocumentID);
                    var updateChilds = new List<vStockDisposalSummary>();
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
                        stockDisposalSummaryDataProvider.DeleteData(summary, useTransaction);

                    // Update existing child data.
                    foreach (var summary in updateChilds)
                        vStockDisposalSummaryDataProvider.UpdateData(summary, useTransaction);

                    // Insert new child data.
                    foreach (var summary in insertChilds)
                    {
                        summary.DocumentID = stockDisposal.DocumentID;
                        vStockDisposalSummaryDataProvider.InsertData(summary, useTransaction);
                    }
                }
            }

            if (stockDisposal.DocumentStatusID != obj.DocumentStatusID)
            {
                if ((stockDisposal.DocumentStatusID == 1) && (obj.DocumentStatusID == 2)) // Draft to Posted
                {
                    var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();

                    if (!closingPeriodDataProvider.IsOpenPeriod(vWarehouse.SiteID.Value, obj.TransactionDate.Year,
                        obj.TransactionDate.Month))
                        throw new Exception(string.Format("This Site for {0:MMM} {0:yyyy} period is already Closed.",
                            obj.TransactionDate));

                    stockDisposal.PostedDate = DefaultDataContext.GetDBServerUtcDateTime();

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
                                    stockDisposal.WarehouseID, summary.ProductID, 3);

                                foreach (var details in summary.ChildDetails)
                                {
                                    var stockOnHandCurrent = stockOnHandCurrentDataProvider.GetData(stockDisposal.WarehouseID,
                                        summary.ProductID, details.ProductLotID);

                                    if ((stockOnHandCurrent == null) || ((stockOnHandCurrent.QtyOnHandBad + details.Qty) < 0))
                                        throw new Exception("There is not enough stock for Product '" + summary.Product +
                                            "', Lot Number '" + details.ProductLotCode + "'.");

                                    details.QtyOnHand = stockOnHandCurrent.QtyOnHandBad;

                                    var stockTransaction = new StockTransaction();

                                    stockTransaction.DocumentID = stockDisposal.DocumentID;
                                    stockTransaction.TransactionDate = stockDisposal.TransactionDate;
                                    stockTransaction.TransactionTypeID = 9; // Stock Disposal
                                    stockTransaction.DocumentCode = stockDisposal.DocumentCode;
                                    stockTransaction.SourceID = stockDisposal.WarehouseID;
                                    stockTransaction.DestinationID = null;

                                    stockTransaction.ProductID = summary.ProductID;

                                    stockTransaction.ProductLotID = details.ProductLotID;

                                    stockTransaction.QtyGood = 0;
                                    stockTransaction.QtyHold = 0;
                                    stockTransaction.QtyBad = details.Qty;

                                    stockOnHandCurrent.QtyOnHandGood += 0;
                                    stockOnHandCurrent.QtyOnHandHold += 0;
                                    stockOnHandCurrent.QtyOnHandBad += details.Qty;

                                    stockOnHandCurrentDataProvider.UpdateData(stockOnHandCurrent, useTransaction);

                                    stockTransactionDataProvider.InsertData(stockTransaction, useTransaction);
                                }

                                if (summary.QtyOnHand != qtyOnHand)
                                {
                                    summary.QtyOnHand = qtyOnHand;
                                    vStockDisposalSummaryDataProvider.UpdateData(summary, useTransaction);
                                }
                            }
                        }
                    }

                    stockDisposal.DocumentStatusID = 2; // Posted
                }
                else if ((stockDisposal.DocumentStatusID == 1) && (obj.DocumentStatusID == 3)) // Draft to Discarded
                {
                    stockDisposal.DocumentStatusID = 3; // Discarded
                }
            }

            stockDisposalDataProvider.UpdateData(stockDisposal);
        }

        #endregion

    }

}
