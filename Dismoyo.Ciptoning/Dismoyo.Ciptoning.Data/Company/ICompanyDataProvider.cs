﻿// ===================================================================================
// Author        : System
// Created date  : 03 Mar 2016 14:58:00
// Description   : ICompanyDataProvider partial interface.
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

    public partial interface ICompanyDataProvider : IDataProvider<Company>
    {

        #region Methods

        Company GetDataByCode(string code);

        #endregion

    }

}
