﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:27:21
// Description   : IStockOnHandCurrentDataProvider partial interface.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Data;
using System;

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IStockOnHandCurrentDataProvider : IDataProvider<StockOnHandCurrent>
    {

        #region Methods

        int GetProductSummaryStockOnHand(Guid warehouseID, int productID, int productStatusID);

        #endregion

    }

}
