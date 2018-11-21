﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:14
// Description   : StockTransferSummaryDataProvider partial class.
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
using Dismoyo.Data;
//using WebMatrix.WebData;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StockTransferSummaryDataProvider : DefaultTableDataProvider<StockTransferSummary>, IStockTransferSummaryDataProvider
    {

        #region Methods

        public IList<StockTransferSummary> GetDataByDocumentID(Guid documentID)
        {
            var stockTransferSummaries = GetData().Where(p => p.DocumentID.Equals(documentID)).ToList();

            return stockTransferSummaries;
        }


        public override void DeleteData(StockTransferSummary obj, bool useTransaction)
        {
            var stockTransferDetailsDataProvider =
                DataConfiguration.GetDefaultDataProvider<IStockTransferDetailsDataProvider>();

            var deleteChilds = stockTransferDetailsDataProvider.GetDataByDocumentIDAndProductID(
                obj.DocumentID, obj.ProductID);
            foreach (var child in deleteChilds)
                stockTransferDetailsDataProvider.DeleteData(child, useTransaction);

            base.DeleteData(obj, useTransaction);
        }

        #endregion

    }

}