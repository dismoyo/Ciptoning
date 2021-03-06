﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:14
// Description   : SalesOrderSummaryDataProvider partial class.
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

    public partial class SalesOrderSummaryDataProvider : DefaultTableDataProvider<SalesOrderSummary>, ISalesOrderSummaryDataProvider
    {

        #region Methods

        public IList<SalesOrderSummary> GetDataByDocumentID(Guid documentID)
        {
            var salesOrderSummaries = GetData().Where(p => p.DocumentID.Equals(documentID)).ToList();

            return salesOrderSummaries;
        }


        public override void DeleteData(SalesOrderSummary obj, bool useTransaction)
        {
            var salesOrderDetailsDataProvider =
                DataConfiguration.GetDefaultDataProvider<ISalesOrderDetailsDataProvider>();

            var deleteChilds = salesOrderDetailsDataProvider.GetDataByDocumentIDAndProductID(
                obj.DocumentID, obj.ProductID);
            foreach (var child in deleteChilds)
                salesOrderDetailsDataProvider.DeleteData(child, useTransaction);

            base.DeleteData(obj, useTransaction);
        }

        #endregion

    }

}
