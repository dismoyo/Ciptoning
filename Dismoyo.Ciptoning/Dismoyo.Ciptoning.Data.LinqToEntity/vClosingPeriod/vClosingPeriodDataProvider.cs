﻿// ===================================================================================
// Author        : System
// Created date  : 11 Mar 2016 18:13:53
// Description   : vClosingPeriodDataProvider partial class.
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

    public partial class vClosingPeriodDataProvider : DefaultViewDataProvider<vClosingPeriod>, IvClosingPeriodDataProvider
    {
        
        #region Methods

        protected override void OnInsertData(vClosingPeriod obj)
        {
            var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();
            
            var closingPeriod = new ClosingPeriod();

            closingPeriod.SiteID = obj.SiteID;
            closingPeriod.YearID = obj.YearID;
            closingPeriod.Jan = obj.Jan;
            closingPeriod.Feb = obj.Feb;
            closingPeriod.Mar = obj.Mar;
            closingPeriod.Apr = obj.Apr;
            closingPeriod.May = obj.May;
            closingPeriod.Jun = obj.Jun;
            closingPeriod.Jul = obj.Jul;
            closingPeriod.Aug = obj.Aug;
            closingPeriod.Sep = obj.Sep;
            closingPeriod.Oct = obj.Oct;
            closingPeriod.Nov = obj.Nov;
            closingPeriod.Dec = obj.Dec;

            closingPeriodDataProvider.InsertData(closingPeriod);
        }

        protected override void OnUpdateData(vClosingPeriod obj)
        {
            var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();

            var closingPeriod = closingPeriodDataProvider.GetData(obj.SiteID, obj.YearID);

            closingPeriod.Jan = obj.Jan;
            closingPeriod.Feb = obj.Feb;
            closingPeriod.Mar = obj.Mar;
            closingPeriod.Apr = obj.Apr;
            closingPeriod.May = obj.May;
            closingPeriod.Jun = obj.Jun;
            closingPeriod.Jul = obj.Jul;
            closingPeriod.Aug = obj.Aug;
            closingPeriod.Sep = obj.Sep;
            closingPeriod.Oct = obj.Oct;
            closingPeriod.Nov = obj.Nov;
            closingPeriod.Dec = obj.Dec;

            closingPeriodDataProvider.UpdateData(closingPeriod);
        }

        protected override void OnDeleteData(vClosingPeriod obj)
        {
            var closingPeriodDataProvider = DataConfiguration.GetDefaultDataProvider<IClosingPeriodDataProvider>();

            var closingPeriod = closingPeriodDataProvider.GetData(obj.SiteID, obj.YearID);

            closingPeriodDataProvider.DeleteData(closingPeriod);
        }

        #endregion
        
    }

}