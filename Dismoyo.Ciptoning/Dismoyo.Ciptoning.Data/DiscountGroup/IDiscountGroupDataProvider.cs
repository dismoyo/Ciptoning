﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:27:21
// Description   : IDiscountGroupDataProvider partial interface.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Data;

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IDiscountGroupDataProvider : IDataProvider<DiscountGroup>
    {

        #region Methods

        DiscountGroup GetDataByCode(string code);

        #endregion

    }

}
