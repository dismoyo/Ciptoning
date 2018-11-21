﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vDiscountStrataDetailsDataProvider partial class.
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

    public partial class vDiscountStrataDetailsDataProvider : DefaultViewDataProvider<vDiscountStrataDetails>, IvDiscountStrataDetailsDataProvider
    {

        #region Methods

        protected override void OnInsertData(vDiscountStrataDetails obj, bool useTransaction)
        {
            var discountStrataDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<IDiscountStrataDetailsDataProvider>();

            var discountStrataDetails = new DiscountStrataDetails();

            discountStrataDetails.StrataID = obj.StrataID;
            discountStrataDetails.Minimum = obj.Minimum;
            discountStrataDetails.Maximum = obj.Maximum;
            discountStrataDetails.DiscountPercentage = obj.DiscountPercentage;

            discountStrataDetailsDataProvider.InsertData(discountStrataDetails, useTransaction);
        }

        protected override void OnUpdateData(vDiscountStrataDetails obj, bool useTransaction)
        {
            var discountStrataDetailsDataProvider = DataConfiguration.GetDefaultDataProvider<IDiscountStrataDetailsDataProvider>();

            var discountStrataDetails = discountStrataDetailsDataProvider.GetData(obj.ID);

            discountStrataDetails.StrataID = obj.StrataID;
            discountStrataDetails.Minimum = obj.Minimum;
            discountStrataDetails.Maximum = obj.Maximum;
            discountStrataDetails.DiscountPercentage = obj.DiscountPercentage;

            discountStrataDetailsDataProvider.UpdateData(discountStrataDetails, useTransaction);
        }

        #endregion

    }

}
