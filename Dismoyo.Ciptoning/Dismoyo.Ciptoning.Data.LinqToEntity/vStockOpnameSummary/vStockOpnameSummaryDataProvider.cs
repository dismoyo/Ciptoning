﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vStockOpnameSummaryDataProvider partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using System;
using System.Collections.Generic;
using System.Linq;
//using WebMatrix.WebData;

namespace Dismoyo.Ciptoning.Data
{

    public partial class vStockOpnameSummaryDataProvider : DefaultViewDataProvider<vStockOpnameSummary>, IvStockOpnameSummaryDataProvider
    {

        #region Methods

        protected override void OnInsertData(vStockOpnameSummary obj, bool useTransaction)
        {
            var stockOpnameSummaryDataProvider = DataConfiguration.GetDefaultDataProvider<IStockOpnameSummaryDataProvider>();

            var stockOpnameSummary = new StockOpnameSummary();

            stockOpnameSummary.DocumentID = obj.DocumentID;
            stockOpnameSummary.ProductID = obj.ProductID;

            stockOpnameSummary.QtyOnHandGood = obj.QtyOnHandGood;
            stockOpnameSummary.QtyOnHandHold = obj.QtyOnHandHold;
            stockOpnameSummary.QtyOnHandBad = obj.QtyOnHandBad;

            stockOpnameSummary.QtyConvLGood = obj.QtyConvLGood;
            stockOpnameSummary.QtyConvMGood = obj.QtyConvMGood;
            stockOpnameSummary.QtyConvSGood = obj.QtyConvSGood;
            stockOpnameSummary.QtyConvLHold = obj.QtyConvLHold;
            stockOpnameSummary.QtyConvMHold = obj.QtyConvMHold;
            stockOpnameSummary.QtyConvSHold = obj.QtyConvSHold;
            stockOpnameSummary.QtyConvLBad = obj.QtyConvLBad;
            stockOpnameSummary.QtyConvMBad = obj.QtyConvMBad;
            stockOpnameSummary.QtyConvSBad = obj.QtyConvSBad;

            stockOpnameSummary.QtyGood = obj.QtyGood;
            stockOpnameSummary.QtyHold = obj.QtyHold;
            stockOpnameSummary.QtyBad = obj.QtyBad;

            stockOpnameSummaryDataProvider.InsertData(stockOpnameSummary, useTransaction);
            if ((obj.ChildDetails != null) && (obj.ChildDetails.Count > 0))
            {
                // Insert new child data.
                var vStockOpnameDetailsDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvStockOpnameDetailsDataProvider>();
                foreach (var details in obj.ChildDetails)
                {
                    details.DocumentID = stockOpnameSummary.DocumentID;
                    details.ProductID = stockOpnameSummary.ProductID;
                    vStockOpnameDetailsDataProvider.InsertData(details, useTransaction);
                }
            }
        }

        protected override void OnUpdateData(vStockOpnameSummary obj, bool useTransaction)
        {
            var stockOpnameSummaryDataProvider = DataConfiguration.GetDefaultDataProvider<IStockOpnameSummaryDataProvider>();

            var stockOpnameSummary = stockOpnameSummaryDataProvider.GetData(obj.DocumentID, obj.ProductID);

            stockOpnameSummary.QtyOnHandGood = obj.QtyOnHandGood;
            stockOpnameSummary.QtyOnHandHold = obj.QtyOnHandHold;
            stockOpnameSummary.QtyOnHandBad = obj.QtyOnHandBad;

            stockOpnameSummary.QtyConvLGood = obj.QtyConvLGood;
            stockOpnameSummary.QtyConvMGood = obj.QtyConvMGood;
            stockOpnameSummary.QtyConvSGood = obj.QtyConvSGood;
            stockOpnameSummary.QtyConvLHold = obj.QtyConvLHold;
            stockOpnameSummary.QtyConvMHold = obj.QtyConvMHold;
            stockOpnameSummary.QtyConvSHold = obj.QtyConvSHold;
            stockOpnameSummary.QtyConvLBad = obj.QtyConvLBad;
            stockOpnameSummary.QtyConvMBad = obj.QtyConvMBad;
            stockOpnameSummary.QtyConvSBad = obj.QtyConvSBad;

            stockOpnameSummary.QtyGood = obj.QtyGood;
            stockOpnameSummary.QtyHold = obj.QtyHold;
            stockOpnameSummary.QtyBad = obj.QtyBad;

            stockOpnameSummaryDataProvider.UpdateData(stockOpnameSummary, useTransaction);
            if ((obj.ChildDetails != null) && (obj.ChildDetails.Count > 0))
            {
                var stockOpnameDetailsDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IStockOpnameDetailsDataProvider>();
                var vStockOpnameDetailsDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvStockOpnameDetailsDataProvider>();

                var insertChilds = obj.ChildDetails.ToList();
                var deleteChilds = stockOpnameDetailsDataProvider.GetDataByDocumentIDAndProductID(
                    stockOpnameSummary.DocumentID, stockOpnameSummary.ProductID);
                var updateChilds = new List<vStockOpnameDetails>();
                int i = 0;
                while (i < deleteChilds.Count)
                {
                    var data = insertChilds.SingleOrDefault(p => (p.ProductLotID == deleteChilds[i].ProductLotID));
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
                foreach (var child in deleteChilds)
                    stockOpnameDetailsDataProvider.DeleteData(child, useTransaction);

                // Update existing child data.
                foreach (var child in updateChilds)
                    vStockOpnameDetailsDataProvider.UpdateData(child, useTransaction);

                // Insert new child data.
                foreach (var child in insertChilds)
                {
                    child.DocumentID = stockOpnameSummary.DocumentID;
                    child.ProductID = stockOpnameSummary.ProductID;
                    vStockOpnameDetailsDataProvider.InsertData(child, useTransaction);
                }
            }
        }

        #endregion

    }

}
