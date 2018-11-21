﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:14
// Description   : StockOnHandCurrentDataProvider partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Data;
using Dismoyo.Web.Security;
using System;
using System.Linq;
using System.Web;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StockOnHandCurrentDataProvider : DefaultTableDataProvider<StockOnHandCurrent>, IStockOnHandCurrentDataProvider
    {

        #region Methods

        public int GetProductSummaryStockOnHand(Guid warehouseID, int productID, int productStatusID)
        {
            var list = GetData().Where(p => p.WarehouseID.Equals(warehouseID) && (p.ProductID == productID)).ToList();

            int qtyOnHand = 0;

            if (list.Count > 0)
            {
                switch (productStatusID)
                {
                    case 1: qtyOnHand = list.Sum(p => p.QtyOnHandGood); break;
                    case 2: qtyOnHand = list.Sum(p => p.QtyOnHandHold); break;
                    case 3: qtyOnHand = list.Sum(p => p.QtyOnHandBad); break;
                }
            }

            return qtyOnHand;
        }

        #endregion

    }

}
