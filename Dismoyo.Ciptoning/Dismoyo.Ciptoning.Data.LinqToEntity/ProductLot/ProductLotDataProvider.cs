﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:14
// Description   : ProductLotDataProvider partial class.
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

    public partial class ProductLotDataProvider : DefaultTableDataProvider<ProductLot>, IProductLotDataProvider
    {

        #region Methods

        public ProductLot GetDataDummyByProductID(int productID)
        {
            var productLot = GetData().FirstOrDefault(p => (p.ProductID == productID) && p.Code.Contains("DUMMY"));

            return productLot;
        }


        protected override void OnBeginInsertData(BeginOperationDataEventArgs<ProductLot> e)
        {
            e.Data.CreatedDate = DefaultDataContext.GetDBServerUtcDateTime();
            //if (WebSecurity.IsAuthenticated)
            //    e.Data.CreatedByUserID = WebSecurity.CurrentUserId;
            e.Data.CreatedByUserID = 1; //////////////////////////////////////////////////////

            base.OnBeginInsertData(e);
        }

        protected override void OnBeginUpdateData(BeginOperationDataEventArgs<ProductLot> e)
        {
            e.Data.ModifiedDate = DefaultDataContext.GetDBServerUtcDateTime();
            //if (WebSecurity.IsAuthenticated)
            //    e.Data.ModifiedByUserID = WebSecurity.CurrentUserId;
            e.Data.ModifiedByUserID = 1; //////////////////////////////////////////////////////

            base.OnBeginUpdateData(e);
        }

        #endregion

    }

}
