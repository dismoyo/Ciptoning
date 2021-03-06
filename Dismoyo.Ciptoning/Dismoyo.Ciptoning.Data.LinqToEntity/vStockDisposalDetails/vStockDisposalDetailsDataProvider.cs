﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vStockDisposalDetailsDataProvider partial class.
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

    public partial class vStockDisposalDetailsDataProvider : DefaultViewDataProvider<vStockDisposalDetails>, IvStockDisposalDetailsDataProvider
    {

        #region Methods

        protected override void OnInsertData(vStockDisposalDetails obj, bool useTransaction)
        {
            var stockDisposalDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<IStockDisposalDetailsDataProvider>();

            var stockDisposalDetails = new StockDisposalDetails();

            stockDisposalDetails.DocumentID = obj.DocumentID;
            stockDisposalDetails.ProductID = obj.ProductID;
            stockDisposalDetails.ProductLotID = obj.ProductLotID;

            stockDisposalDetails.QtyOnHand = obj.QtyOnHand;
            
            stockDisposalDetails.QtyConvL = obj.QtyConvL;
            stockDisposalDetails.QtyConvM = obj.QtyConvM;
            stockDisposalDetails.QtyConvS = obj.QtyConvS;
            
            stockDisposalDetails.Qty = obj.Qty;

            stockDisposalDetailsDataProvider.InsertData(stockDisposalDetails, useTransaction);
        }

        protected override void OnUpdateData(vStockDisposalDetails obj, bool useTransaction)
        {
            var stockDisposalDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<IStockDisposalDetailsDataProvider>();

            var stockDisposalDetails = stockDisposalDetailsDataProvider.GetData(obj.DocumentID, obj.ProductID,
                obj.ProductLotID);

            stockDisposalDetails.QtyOnHand = obj.QtyOnHand;

            stockDisposalDetails.QtyConvL = obj.QtyConvL;
            stockDisposalDetails.QtyConvM = obj.QtyConvM;
            stockDisposalDetails.QtyConvS = obj.QtyConvS;

            stockDisposalDetails.Qty = obj.Qty;

            stockDisposalDetailsDataProvider.UpdateData(stockDisposalDetails, useTransaction);
        }

        #endregion

    }

}
