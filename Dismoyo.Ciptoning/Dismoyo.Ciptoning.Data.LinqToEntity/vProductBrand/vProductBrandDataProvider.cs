﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vProductBrandDataProvider partial class.
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

    public partial class vProductBrandDataProvider : DefaultViewDataProvider<vProductBrand>, IvProductBrandDataProvider
    {

        #region Methods

        protected override void OnInsertData(vProductBrand obj)
        {
            var productBrandDataProvider = DataConfiguration.GetDefaultDataProvider<IProductBrandDataProvider>();

            var productBrand = new ProductBrand();

            productBrand.Code = obj.Code;
            productBrand.Name = obj.Name;

            productBrandDataProvider.InsertData(productBrand);
        }

        protected override void OnUpdateData(vProductBrand obj)
        {
            var productBrandDataProvider = DataConfiguration.GetDefaultDataProvider<IProductBrandDataProvider>();

            var productBrand = productBrandDataProvider.GetData(obj.ID);

            productBrand.Code = obj.Code;
            productBrand.Name = obj.Name;

            productBrandDataProvider.UpdateData(productBrand);
        }

        protected override void OnDeleteData(vProductBrand obj)
        {
            var productBrandDataProvider = DataConfiguration.GetDefaultDataProvider<IProductBrandDataProvider>();

            var productBrand = productBrandDataProvider.GetData(obj.ID);

            productBrand.IsDeleted = true;

            productBrandDataProvider.UpdateData(productBrand);
        }

        #endregion

    }

}
