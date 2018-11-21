﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vSalesOrderReturnDetailsDataProvider partial class.
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

    public partial class vSalesOrderReturnDetailsDataProvider : DefaultViewDataProvider<vSalesOrderReturnDetails>, IvSalesOrderReturnDetailsDataProvider
    {

        #region Methods

        protected override void OnInsertData(vSalesOrderReturnDetails obj, bool useTransaction)
        {
            var salesOrderReturnDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesOrderReturnDetailsDataProvider>();

            var salesOrderReturnDetails = new SalesOrderReturnDetails();

            salesOrderReturnDetails.DocumentID = obj.DocumentID;
            salesOrderReturnDetails.ProductID = obj.ProductID;
            salesOrderReturnDetails.ProductLotID = obj.ProductLotID;

            salesOrderReturnDetails.QtyOnHand = obj.QtyOnHand;
            
            salesOrderReturnDetails.QtyConvL = obj.QtyConvL;
            salesOrderReturnDetails.QtyConvM = obj.QtyConvM;
            salesOrderReturnDetails.QtyConvS = obj.QtyConvS;
            
            salesOrderReturnDetails.Qty = obj.Qty;

            salesOrderReturnDetailsDataProvider.InsertData(salesOrderReturnDetails, useTransaction);
        }

        protected override void OnUpdateData(vSalesOrderReturnDetails obj, bool useTransaction)
        {
            var salesOrderReturnDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesOrderReturnDetailsDataProvider>();

            var salesOrderReturnDetails = salesOrderReturnDetailsDataProvider.GetData(obj.DocumentID, obj.ProductID,
                obj.ProductLotID);

            salesOrderReturnDetails.QtyOnHand = obj.QtyOnHand;
            
            salesOrderReturnDetails.QtyConvL = obj.QtyConvL;
            salesOrderReturnDetails.QtyConvM = obj.QtyConvM;
            salesOrderReturnDetails.QtyConvS = obj.QtyConvS;
            
            salesOrderReturnDetails.Qty = obj.Qty;
            
            salesOrderReturnDetailsDataProvider.UpdateData(salesOrderReturnDetails, useTransaction);
        }

        #endregion

    }

}
