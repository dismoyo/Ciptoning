﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:14
// Description   : SalesOrderFOCDetailsDataProvider partial class.
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

    public partial class SalesOrderFOCDetailsDataProvider : DefaultTableDataProvider<SalesOrderFOCDetails>, ISalesOrderFOCDetailsDataProvider
    {

        #region Methods

        public IList<SalesOrderFOCDetails> GetDataByDocumentIDAndProductID(Guid documentID, int productID)
        {
            var SalesOrderFOCDetails = GetData().Where(p => p.DocumentID.Equals(documentID) &&
                (p.ProductID == productID)).ToList();

            return SalesOrderFOCDetails;
        }
        
        #endregion

    }

}
