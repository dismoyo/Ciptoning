﻿// ===================================================================================
// Author        : System
// Created date  : 2014-05-23 00:00:00 
// Description   : IvUserDataProvider partial interface.
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

    public partial interface IvUserDataProvider : IDataProvider<vUser>
    {

        #region Methods

        vUser GetDataByName(string name);

        #endregion

    }

}
