﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vSalesOrderDetailsDataProvider partial class.
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

    public partial class vSalesOrderDetailsDataProvider : DefaultViewDataProvider<vSalesOrderDetails>, IvSalesOrderDetailsDataProvider
    {

        #region Methods

        protected override void OnInsertData(vSalesOrderDetails obj, bool useTransaction)
        {
            var salesOrderDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesOrderDetailsDataProvider>();

            var salesOrderDetails = new SalesOrderDetails();

            salesOrderDetails.DocumentID = obj.DocumentID;
            salesOrderDetails.ProductID = obj.ProductID;
            salesOrderDetails.ProductLotID = obj.ProductLotID;

            salesOrderDetails.QtyOnHand = obj.QtyOnHand;
            
            salesOrderDetails.QtyConvL = obj.QtyConvL;
            salesOrderDetails.QtyConvM = obj.QtyConvM;
            salesOrderDetails.QtyConvS = obj.QtyConvS;
            
            salesOrderDetails.Qty = obj.Qty;

            salesOrderDetailsDataProvider.InsertData(salesOrderDetails, useTransaction);
        }

        protected override void OnUpdateData(vSalesOrderDetails obj, bool useTransaction)
        {
            var salesOrderDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesOrderDetailsDataProvider>();

            var salesOrderDetails = salesOrderDetailsDataProvider.GetData(obj.DocumentID, obj.ProductID,
                obj.ProductLotID);

            salesOrderDetails.QtyOnHand = obj.QtyOnHand;
            
            salesOrderDetails.QtyConvL = obj.QtyConvL;
            salesOrderDetails.QtyConvM = obj.QtyConvM;
            salesOrderDetails.QtyConvS = obj.QtyConvS;
            
            salesOrderDetails.Qty = obj.Qty;
            
            salesOrderDetailsDataProvider.UpdateData(salesOrderDetails, useTransaction);
        }

        #endregion

    }

}
