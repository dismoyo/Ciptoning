﻿// ===================================================================================
// Author        : System
// Created date  : 19 Oct 2016 20:29:51
// Description   : vSalesmanCallDataProvider partial class.
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

namespace AIO.IDOS2.Data
{

    public partial class vSalesmanCallDataProvider : DefaultViewDataProvider<vSalesmanCall>, IvSalesmanCallDataProvider
    {
        
        #region Methods

        protected override void OnInsertData(vSalesmanCall obj, bool useTransaction)
        {
            var salesmanCallDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesmanCallDataProvider>();
            
            var salesmanCall = new SalesmanCall();

            salesmanCall.ID = (obj.ID.Equals(Guid.Empty) ? Guid.NewGuid() : obj.ID);
            salesmanCall.SalesmanID = obj.SalesmanID;
            salesmanCall.CallDate = obj.CallDate;
            salesmanCall.CustomerID = obj.CustomerID;
            salesmanCall.IsInRoute = obj.IsInRoute;
            salesmanCall.MerchandiseDisplayActivityNote = obj.MerchandiseDisplayActivityNote;
            salesmanCall.PromoMaterialActivityNote = obj.PromoMaterialActivityNote;
            salesmanCall.StatusID = obj.StatusID;
            salesmanCall.IsTransactionPaid = obj.IsTransactionPaid;
            salesmanCall.NoTransactionReasonID = obj.NoTransactionReasonID;

            salesmanCallDataProvider.InsertData(salesmanCall, useTransaction);
            if ((obj.ChildLogs != null) && (obj.ChildLogs.Count > 0))
            {
                // Insert new child data.
                var vSalesmanCallLogDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvSalesmanCallLogDataProvider>();
                foreach (var log in obj.ChildLogs)
                {
                    log.SalesmanCallID = salesmanCall.ID;
                    vSalesmanCallLogDataProvider.InsertData(log, useTransaction);
                }
            }
        }

        protected override void OnUpdateData(vSalesmanCall obj, bool useTransaction)
        {
            var salesmanCallDataProvider = DataConfiguration.GetDefaultDataProvider<ISalesmanCallDataProvider>();

            var salesmanCall = salesmanCallDataProvider.GetData(obj.ID);

            salesmanCall.SalesmanID = obj.SalesmanID;
            salesmanCall.CallDate = obj.CallDate;
            salesmanCall.CustomerID = obj.CustomerID;
            salesmanCall.IsInRoute = obj.IsInRoute;
            salesmanCall.MerchandiseDisplayActivityNote = obj.MerchandiseDisplayActivityNote;
            salesmanCall.PromoMaterialActivityNote = obj.PromoMaterialActivityNote;
            salesmanCall.StatusID = obj.StatusID;
            salesmanCall.IsTransactionPaid = obj.IsTransactionPaid;
            salesmanCall.NoTransactionReasonID = obj.NoTransactionReasonID;

            salesmanCallDataProvider.UpdateData(salesmanCall, useTransaction);
            if ((obj.ChildLogs != null) && (obj.ChildLogs.Count > 0))
            {
                var salesmanCallLogDataProvider =
                    DataConfiguration.GetDefaultDataProvider<ISalesmanCallLogDataProvider>();
                var vSalesmanCallLogDataProvider =
                    DataConfiguration.GetDefaultDataProvider<IvSalesmanCallLogDataProvider>();

                var insertChilds = obj.ChildLogs.ToList();
                var deleteChilds = salesmanCallLogDataProvider.GetDataBySalesmanCallID(salesmanCall.ID);
                var updateChilds = new List<vSalesmanCallLog>();
                int i = 0;
                while (i < deleteChilds.Count)
                {
                    var data = insertChilds.SingleOrDefault(p => (p.ID.Equals(deleteChilds[i].ID)));
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
                foreach (var child in deleteChilds)
                    salesmanCallLogDataProvider.DeleteData(child, useTransaction);

                // Update existing child data.
                foreach (var child in updateChilds)
                    vSalesmanCallLogDataProvider.UpdateData(child, useTransaction);

                // Insert new child data.
                foreach (var log in insertChilds)
                {
                    log.SalesmanCallID = salesmanCall.ID;
                    vSalesmanCallLogDataProvider.InsertData(log, useTransaction);
                }
            }
        }

        #endregion
        
    }

}
