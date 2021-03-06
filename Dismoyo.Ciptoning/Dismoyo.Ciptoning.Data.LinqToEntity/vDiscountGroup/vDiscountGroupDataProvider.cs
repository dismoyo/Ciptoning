﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vDiscountGroupDataProvider partial class.
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

    public partial class vDiscountGroupDataProvider : DefaultViewDataProvider<vDiscountGroup>, IvDiscountGroupDataProvider
    {

        #region Methods

        protected override void OnInsertData(vDiscountGroup obj, bool useTransaction)
        {
            var discountGroupDataProvider = DataConfiguration.GetDefaultDataProvider<IDiscountGroupDataProvider>();

            var discountGroup = new DiscountGroup();

            var existingCode = GetByCode(obj.Code);
            if (existingCode.Count() > 0)
            {
                Exception ex = new Exception("Code value '" + obj.Code + "' is already exist.");
                throw ex;
            }

            discountGroup.Code = obj.Code;
            discountGroup.Name = obj.Name;
            discountGroup.Description = obj.Description;
            discountGroup.StatusID = obj.StatusID;

            discountGroupDataProvider.InsertData(discountGroup);
            if ((obj.ChildProducts != null) && (obj.ChildProducts.Count > 0))
            {
                // Insert new child data.
                var vDiscountGroupProductDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvDiscountGroupProductDataProvider>();
                foreach (var discountGroupProduct in obj.ChildProducts)
                {
                    discountGroupProduct.DiscountGroupID = discountGroup.ID;
                    vDiscountGroupProductDataProvider.InsertData(discountGroupProduct, useTransaction);
                }
            }
        }

        protected override void OnUpdateData(vDiscountGroup obj, bool useTransaction)
        {
            var discountGroupDataProvider = DataConfiguration.GetDefaultDataProvider<IDiscountGroupDataProvider>();

            var discountGroup = discountGroupDataProvider.GetData(obj.ID);

            discountGroup.Code = obj.Code;
            discountGroup.Name = obj.Name;
            discountGroup.Description = obj.Description;
            discountGroup.StatusID = obj.StatusID;

            if ((obj.ChildProducts != null) && (obj.ChildProducts.Count > 0))
            {
                var discountGroupProductDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IDiscountGroupProductDataProvider>();
                var vDiscountGroupProductDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvDiscountGroupProductDataProvider>();

                var insertChilds = obj.ChildProducts.ToList();
                var deleteChilds = discountGroupProductDataProvider.GetDataByDiscountGroupID(discountGroup.ID);
                var updateChilds = new List<vDiscountGroupProduct>();
                int i = 0;
                while (i < deleteChilds.Count)
                {
                    var data = insertChilds.SingleOrDefault(p => (p.ProductID == deleteChilds[i].ProductID));
                    if (data != null)
                    {
                        insertChilds.Remove(data);
                        deleteChilds.RemoveAt(i);
                        updateChilds.Add(data);
                        continue;
                    }

                    i++;
                }

                // Removes existing and unused child data.
                foreach (var discountGroupProduct in deleteChilds)
                    discountGroupProductDataProvider.DeleteData(discountGroupProduct, useTransaction);

                // Update existing child data.
                foreach (var discountGroupProduct in updateChilds)
                    vDiscountGroupProductDataProvider.UpdateData(discountGroupProduct, useTransaction);

                // Insert new child data.
                foreach (var discountGroupProduct in insertChilds)
                {
                    discountGroupProduct.DiscountGroupID = discountGroup.ID;
                    vDiscountGroupProductDataProvider.InsertData(discountGroupProduct, useTransaction);
                }
            }

            discountGroupDataProvider.UpdateData(discountGroup);
        }

        protected override void OnDeleteData(vDiscountGroup obj, bool useTransaction)
        {
            var discountGroupDataProvider = DataConfiguration.GetDefaultDataProvider<IDiscountGroupDataProvider>();

            var discountGroup = discountGroupDataProvider.GetData(obj.ID);

            discountGroup.IsDeleted = true;

            discountGroupDataProvider.UpdateData(discountGroup);
        }

        public IEnumerable<DiscountGroup> GetByCode(string code)
        {
            IQueryable<DiscountGroup> query = (from obj in DataContext.Set<DiscountGroup>()
                                                where obj.Code == code
                                                  && !obj.IsDeleted
                                               select obj);
            return query;
        }

        #endregion

    }

}
