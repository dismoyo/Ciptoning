﻿// ===================================================================================
// Author        : System
// Created date  : 18 Mar 2016 00:00:00
// Description   : DataService partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Ciptoning.Data;
using System;
using System.Data;
using System.Data.Services;
using System.Data.Services.Providers;
using System.Linq;
using System.Linq.Expressions;
using System.ServiceModel.Web;

namespace Dismoyo.Ciptoning.Web.Services
{

    public partial class DataService : EntityFrameworkDataService<StoreFunctionsDataContext>, IServiceProvider
    {

        #region Methods

        [QueryInterceptor("vSalesOrderFOCs")]
        public Expression<Func<vSalesOrderFOC, bool>> OnQueryvSalesOrderFOCs()
        {
            return (p => true);
        }

        [ChangeInterceptor("vSalesOrderFOCs")]
        public void OnChangevSalesOrderFOCs(vSalesOrderFOC data, UpdateOperations operations)
        {
            var dataProvider = DataConfiguration.GetDefaultDataProvider<IvSalesOrderFOCDataProvider>();

            switch (operations)
            {
                case UpdateOperations.Add:
                    using (var transaction = DefaultDataContext.DataContext.Database.BeginTransaction())
                    {
                        try
                        {
                            var directPost = false;
                            int prevDocumentStatusID = data.DocumentStatusID;

                            while (!directPost)
                            {
                                var serverData = (data.DocumentID.Equals(Guid.Empty)) ? null :
                                    dataProvider.GetData(data.DocumentID);

                                directPost = true;
                                if ((serverData == null) && string.IsNullOrEmpty(data.DocumentCode))
                                {
                                    dataProvider.InsertData(data, true);

                                    if (data.DocumentStatusID == 2)
                                        directPost = false;
                                }
                                else
                                {
                                    prevDocumentStatusID = serverData.DocumentStatusID;
                                    data.DODocumentID = serverData.DODocumentID;

                                    dataProvider.UpdateData(data, true);
                                }
                            }

                            DefaultDataContext.DataContext.SaveChanges();
                            transaction.Commit();

                            if ((prevDocumentStatusID != data.DocumentStatusID) && (data.DocumentStatusID == 2)) // Posted
                                DefaultDataContext.SalesOrderFOCExt(data.DocumentID);
                        }
                        catch (Exception ex)
                        {
                            if (transaction.UnderlyingTransaction.Connection != null)
                                transaction.Rollback();

                            throw ex;
                        }
                    }

                    operations = UpdateOperations.None;
                    break;
                case UpdateOperations.Change:
                    using (var transaction = DefaultDataContext.DataContext.Database.BeginTransaction())
                    {
                        try
                        {
                            dataProvider.UpdateData(data, true);
                            DefaultDataContext.DataContext.SaveChanges();
                            transaction.Commit();
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            throw ex;
                        }
                    }

                    operations = UpdateOperations.None;
                    break;
                case UpdateOperations.Delete:
                    dataProvider.DeleteData(data);
                    operations = UpdateOperations.None;
                    break;
            }

            if (operations == UpdateOperations.None)
                CancelChanges();
        }

        #endregion
        
        #region Custom Methods

        [WebGet]
        public IQueryable<vSalesOrderFOC> fSalesOrderFOCs()
        {
            return CurrentDataSource.fSalesOrderFOC(
                (Guid?)GetQueryFilterParameterValue("DocumentID"),
                (string)GetQueryFilterParameterValue("DocumentCode"),
                (DateTime?)GetQueryFilterParameterValue("TransactionDateFrom"),
                (DateTime?)GetQueryFilterParameterValue("TransactionDateTo"),
                (Guid?)GetQueryFilterParameterValue("PODocumentID"),
                (string)GetQueryFilterParameterValue("PODocumentCode"),
                (Guid?)GetQueryFilterParameterValue("SalesmanID"),
                (string)GetQueryFilterParameterValue("SalesmanCode"),
                (string)GetQueryFilterParameterValue("SalesmanName"),
                (Guid?)GetQueryFilterParameterValue("WarehouseID"),
                (string)GetQueryFilterParameterValue("WarehouseCode"),
                (string)GetQueryFilterParameterValue("WarehouseName"),
                (Guid?)GetQueryFilterParameterValue("SiteID"),
                (string)GetQueryFilterParameterValue("SiteCode"),
                (string)GetQueryFilterParameterValue("SiteName"),
                (int?)GetQueryFilterParameterValue("CompanyID"),
                (string)GetQueryFilterParameterValue("CompanyCode"),
                (string)GetQueryFilterParameterValue("CompanyName"),
                (int?)GetQueryFilterParameterValue("AreaID"),
                (string)GetQueryFilterParameterValue("AreaCode"),
                (string)GetQueryFilterParameterValue("AreaName"),
                (int?)GetQueryFilterParameterValue("RegionID"),
                (string)GetQueryFilterParameterValue("RegionCode"),
                (string)GetQueryFilterParameterValue("RegionName"),
                (int?)GetQueryFilterParameterValue("TerritoryID"),
                (string)GetQueryFilterParameterValue("TerritoryCode"),
                (string)GetQueryFilterParameterValue("TerritoryName"),
                (int?)GetQueryFilterParameterValue("SiteDistributionTypeID"),
                (int?)GetQueryFilterParameterValue("WarehouseTypeID"),
                (bool?)GetQueryFilterParameterValue("IsSiteLotNumberEntryRequired"),
                (Guid?)GetQueryFilterParameterValue("CustomerID"),
                (string)GetQueryFilterParameterValue("CustomerCode"),
                (string)GetQueryFilterParameterValue("CustomerName"),
                (int?)GetQueryFilterParameterValue("PriceGroupID"),
                (int?)GetQueryFilterParameterValue("DiscountGroupID"),
                (string)GetQueryFilterParameterValue("DiscountGroupCode"),
                (string)GetQueryFilterParameterValue("DiscountGroupName"),
                (int?)GetQueryFilterParameterValue("TermOfPaymentID"),
                (string)GetQueryFilterParameterValue("ReferenceNumber"),
                (Guid?)GetQueryFilterParameterValue("DODocumentID"),
                (string)GetQueryFilterParameterValue("DODocumentCode"),
                (DateTime?)GetQueryFilterParameterValue("DOShipmentDateFrom"),
                (DateTime?)GetQueryFilterParameterValue("DOShipmentDateTo"),
                (DateTime?)GetQueryFilterParameterValue("DOReceivedDateFrom"),
                (DateTime?)GetQueryFilterParameterValue("DOReceivedDateTo"),
                (DateTime?)GetQueryFilterParameterValue("DOLastPrintedDateFrom"),
                (DateTime?)GetQueryFilterParameterValue("DOLastPrintedDateTo"),
                (Guid?)GetQueryFilterParameterValue("InvoiceDocumentID"),
                (string)GetQueryFilterParameterValue("InvoiceDocumentCode"),
                (int?)GetQueryFilterParameterValue("DocumentStatusID"),
                (string)GetQueryFilterParameterValue("DocumentStatusReason"),
                (string)GetQueryFilterParameterValue("SFAInvoiceDocumentCode"),
                (DateTime?)GetQueryFilterParameterValue("PostedDateFrom"),
                (DateTime?)GetQueryFilterParameterValue("PostedDateTo"));
        }

        #endregion


    }

}
