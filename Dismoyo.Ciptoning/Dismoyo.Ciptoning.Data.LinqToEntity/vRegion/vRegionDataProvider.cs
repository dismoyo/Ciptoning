﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12::45:53
// Description   : vRegionDataProvider partial class.
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

    public partial class vRegionDataProvider : DefaultViewDataProvider<vRegion>, IvRegionDataProvider
    {

        #region Methods
        public IEnumerable<Area> GetAreaByRegionID(int regionid)
        {
            IQueryable<Area> query = (from obj in DataContext.Set<Area>()
                                        where obj.RegionID == regionid
                                        select obj);
            return query;
        }
        protected override void OnInsertData(vRegion obj)
        {
            var regionDataProvider = DataConfiguration.GetDefaultDataProvider<IRegionDataProvider>();

            var region = new Region();

            region.Code = obj.Code;
            region.Name = obj.Name;
            region.TerritoryID = obj.TerritoryID.Value;

            regionDataProvider.InsertData(region);
        }

        protected override void OnUpdateData(vRegion obj)
        {
            var regionDataProvider = DataConfiguration.GetDefaultDataProvider<IRegionDataProvider>();

            var region = regionDataProvider.GetData(obj.ID);

            region.Code = obj.Code;
            region.Name = obj.Name;
            region.TerritoryID = obj.TerritoryID.Value;

            regionDataProvider.UpdateData(region);
        }

        protected override void OnDeleteData(vRegion obj)
        {
            var regionDataProvider = DataConfiguration.GetDefaultDataProvider<IRegionDataProvider>();

            var region = regionDataProvider.GetData(obj.ID);
            var area = GetAreaByRegionID(obj.ID);
            if (area.Count() > 0)
            {
                Exception ex = new Exception("Cannot Delete,This Region Is Already used");
                throw ex;
            }
            region.IsDeleted = true;

            regionDataProvider.UpdateData(region);
        }

        #endregion

    }

}
