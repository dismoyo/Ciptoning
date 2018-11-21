﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vPromoProductDataProvider partial class.
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

    public partial class vPromoProductDataProvider : DefaultViewDataProvider<vPromoProduct>, IvPromoProductDataProvider
    {

        #region Methods

        public void validatePromoProduct(vPromoProduct obj)
        {
            var promoProductDataProvider = DataConfiguration.GetDefaultDataProvider<IPromoProductDataProvider>();
            List<PromoProduct> listPromoProduct = new List<PromoProduct>();

            // update data yang valiDateFrom dan validDateTo nya outerjoin
            var promoProduct1 = GetDataOuterjoint(obj.ProductID, (DateTime)obj.ValidDateFrom, (DateTime)obj.ValidDateTo);
            foreach (var data in promoProduct1)
            {
                if (data.ID != obj.ID)
                {
                    data.IsDeleted = true;
                    listPromoProduct.Add(data);
                }
            }

            foreach (PromoProduct p in listPromoProduct)
            {
                promoProductDataProvider.UpdateData(p);
            }

            // update data yang valiDateFrom nya berisisan
            promoProduct1 = GetDataDisjoint(obj.ProductID, (DateTime)obj.ValidDateFrom);
            foreach (var data in promoProduct1)
            {
                if (data.ID != obj.ID)
                {
                    data.ValidDateTo = ((DateTime)obj.ValidDateFrom).AddDays(-1);
                    listPromoProduct.Add(data);
                }
            }

            foreach (PromoProduct p in listPromoProduct)
            {
                promoProductDataProvider.UpdateData(p);
            }

            // update data yang valiDateTo nya berisisan
            promoProduct1 = GetDataDisjoint(obj.ProductID, (DateTime)obj.ValidDateTo);
            foreach (var data in promoProduct1)
            {
                if (data.ID != obj.ID)
                {
                    data.ValidDateFrom = ((DateTime)obj.ValidDateTo).AddDays(+1);
                    listPromoProduct.Add(data);
                }
            }

            foreach (PromoProduct p in listPromoProduct)
            {
                promoProductDataProvider.UpdateData(p);
            }
        }


        protected override void OnInsertData(vPromoProduct obj)
        {
            var promoProductDataProvider = DataConfiguration.GetDefaultDataProvider<IPromoProductDataProvider>();

            var promoProduct = new PromoProduct();

            var existingCode = GetByCode(obj.Code);
            if (existingCode.Count() > 0)
            {
                Exception ex = new Exception("Code value '" + obj.Code + "' is already exist.");
                throw ex;
            }

            // get maximum value of validDateFrom
            PromoProduct maxValidFromData = GetMaxValidFromData(0, obj.ProductID, "add");
            if (maxValidFromData != null)
            {
                if (obj.ValidDateFrom <= maxValidFromData.ValidDateFrom)
                {
                    DateTime mustBeValidFrom = (DateTime)maxValidFromData.ValidDateFrom;
                    throw (new Exception("Valid Date From must be greater than '" + mustBeValidFrom.ToString("d") + "'"));
                }
            }

            validatePromoProduct(obj);

            promoProduct.Code = obj.Code;
            promoProduct.ProductID = obj.ProductID;
            promoProduct.ValidDateFrom = obj.ValidDateFrom;
            promoProduct.ValidDateTo = obj.ValidDateTo;
            promoProduct.TermOfPaymentID = obj.TermOfPaymentID;
            promoProduct.StatusID = obj.StatusID;

            promoProductDataProvider.InsertData(promoProduct);
        }

        protected override void OnUpdateData(vPromoProduct obj)
        {
            var promoProductDataProvider = DataConfiguration.GetDefaultDataProvider<IPromoProductDataProvider>();

            var promoProduct = promoProductDataProvider.GetData(obj.ID);
            
            // get maximum value of validDateFrom
            PromoProduct maxValidFromData = GetMaxValidFromData(obj.ID, obj.ProductID, "edit");
            if (maxValidFromData != null)
            {
                if (obj.ValidDateFrom <= maxValidFromData.ValidDateFrom)
                {
                    DateTime mustBeValidFrom = (DateTime)maxValidFromData.ValidDateFrom;
                    throw (new Exception("Valid Date From must be greater than '" + mustBeValidFrom.ToString("d") + "'"));
                }
            }

            validatePromoProduct(obj);
            
            promoProduct.ValidDateFrom = obj.ValidDateFrom;
            promoProduct.ValidDateTo = obj.ValidDateTo;
            promoProduct.TermOfPaymentID = obj.TermOfPaymentID;
            promoProduct.StatusID = obj.StatusID;

            promoProductDataProvider.UpdateData(promoProduct);
        }

        protected override void OnDeleteData(vPromoProduct obj)
        {
            var promoProductDataProvider = DataConfiguration.GetDefaultDataProvider<IPromoProductDataProvider>();

            var promoProduct = promoProductDataProvider.GetData(obj.ID);

            promoProduct.IsDeleted = true;
            promoProductDataProvider.UpdateData(promoProduct);
        }

        public IEnumerable<PromoProduct> GetByCode(string code)
        {
            IQueryable<PromoProduct> query = (from obj in DataContext.Set<PromoProduct>()
                                              where obj.Code == code
                                              && !obj.IsDeleted
                                              select obj);
            return query;
        }

        public IEnumerable<PromoProduct> GetDataDisjoint(int productID, DateTime validDate)
        {
            IQueryable<PromoProduct> query = (from obj in DataContext.Set<PromoProduct>()
                                              where obj.ProductID == productID
                                              && obj.ValidDateFrom <= validDate
                                              && obj.ValidDateTo >= validDate
                                              && !obj.IsDeleted
                                              select obj);
            return query;
        }

        public IEnumerable<PromoProduct> GetDataOuterjoint(int productID, DateTime validDateFrom, DateTime validDateTo)
        {
            IQueryable<PromoProduct> query = (from obj in DataContext.Set<PromoProduct>()
                                              where obj.ProductID == productID
                                              && obj.ValidDateFrom >= validDateFrom
                                              && obj.ValidDateTo <= validDateTo
                                              && !obj.IsDeleted
                                              select obj);
            return query;
        }

        public PromoProduct GetMaxValidFromData(int ID, int productID, string mode)
        {
            var promoProduct = DataContext.Set<PromoProduct>();
            IQueryable<PromoProduct> query;
            PromoProduct obj = null;
            if (mode.Equals("add"))
            {
                query = promoProduct.Where(x => !x.IsDeleted && x.ProductID == productID)
                    .OrderByDescending(x => x.ValidDateFrom);
                if (query.Count() > 0)
                {
                    obj = new PromoProduct();
                    obj = query.First();
                }
            }
            else if (mode.Equals("edit"))
            {
                query = promoProduct.Where(x => !x.IsDeleted && x.ProductID == productID && x.ID < ID)
                    .OrderByDescending(x => x.ValidDateFrom);
                if (query.Count() > 0)
                {
                    obj = new PromoProduct();
                    obj = query.First();
                }
            }
            return obj;
        }

        #endregion

    }

}
