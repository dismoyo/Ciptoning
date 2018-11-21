﻿// ===================================================================================
// Author        : System
// Created date  : 11 Mar 2016 18:13:47
// Description   : ClosingPeriodDataProvider partial class.
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
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Dismoyo.Ciptoning.Data
{

    public partial class ClosingPeriodDataProvider : DefaultTableDataProvider<ClosingPeriod>, IClosingPeriodDataProvider
    {
        
        #region Methods

        public List<ClosingPeriod> GetDataByYearID(int yearID)
        {
            var closingPeriods = GetData().Where(p => p.YearID == yearID).ToList();

            return closingPeriods;
        }

        public bool IsOpenPeriod(Guid siteID, int yearID, int month)
        {
            var closingPeriod = GetData().SingleOrDefault(p => p.SiteID.Equals(siteID) && (p.YearID == yearID));

            if (closingPeriod != null)
            {
                switch (month)
                {
                    case 1: return !closingPeriod.Jan;
                    case 2: return !closingPeriod.Feb;
                    case 3: return !closingPeriod.Mar;
                    case 4: return !closingPeriod.Apr;
                    case 5: return !closingPeriod.May;
                    case 6: return !closingPeriod.Jun;
                    case 7: return !closingPeriod.Jul;
                    case 8: return !closingPeriod.Aug;
                    case 9: return !closingPeriod.Sep;
                    case 10: return !closingPeriod.Oct;
                    case 11: return !closingPeriod.Nov;
                    case 12: return !closingPeriod.Dec;
                }
            }

            return true;
        }


        protected override void OnBeginInsertData(BeginOperationDataEventArgs<ClosingPeriod> e)
        {
            e.Data.CreatedDate = DefaultDataContext.GetDBServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.CreatedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginInsertData(e);
        }

        protected override void OnBeginUpdateData(BeginOperationDataEventArgs<ClosingPeriod> e)
        {
            e.Data.ModifiedDate = DefaultDataContext.GetDBServerUtcDateTime();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                e.Data.ModifiedByUserID = ((BasicGenericIdentity<IvUser>)HttpContext.Current.User.Identity).UserData.ID;

            base.OnBeginUpdateData(e);
        }

        #endregion

    }

}