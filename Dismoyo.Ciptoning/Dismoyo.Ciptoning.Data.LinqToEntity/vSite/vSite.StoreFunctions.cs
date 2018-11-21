using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fSite

        [DbFunction("StoreFunctionsDataContext", "fSite")]
        public IQueryable<vSite> fSite(
            Guid? p_ID,
            string p_Code,
            string p_Name,
            int? p_AreaID,
            string p_AreaCode,
            string p_AreaName,
            int? p_RegionID,
            string p_RegionCode,
            string p_RegionName,
            int? p_TerritoryID,
            string p_TerritoryCode,
            string p_TerritoryName,
            int? p_CompanyID,
            string p_CompanyCode,
            string p_CompanyName,
            int? p_DistributionTypeID,
            bool? p_IsLotNumberEntryRequired,
            string p_Address,
            string p_City,
            string p_StateProvince,
            int? p_CountryID,
            string p_CountryName,
            string p_ZipCode,
            string p_Phone1,
            string p_Phone2,
            string p_Fax,
            string p_Email,
            string p_TaxNumber,
            int? p_StatusID,
            string p_AdditionalInfo,
            bool? p_IsDeleted)
        {
            return OrderQuery<vSite>(((IObjectContextAdapter)this).ObjectContext
                .CreateQuery<vSite>(string.Format(@"
                [{0}].[fSite]
                ( 
                    @ID,
                    @Code,
                    @Name,
                    @AreaID,
                    @AreaCode,
                    @AreaName,
                    @RegionID,
                    @RegionCode,
                    @RegionName,
                    @TerritoryID,
                    @TerritoryCode,
                    @TerritoryName,
                    @CompanyID,
                    @CompanyCode,
                    @CompanyName,
                    @DistributionTypeID,
                    @IsLotNumberEntryRequired,
                    @Address,
                    @City,
                    @StateProvince,
                    @CountryID,
                    @CountryName,
                    @ZipCode,
                    @Phone1,
                    @Phone2,
                    @Fax,
                    @Email,
                    @TaxNumber,
                    @StatusID,
                    @AdditionalInfo,
                    @IsDeleted
                )", GetType().Name),

                DefaultDataContext.CreateParameter("ID", typeof(Guid?), p_ID),
                DefaultDataContext.CreateParameter("Code", typeof(string), p_Code),
                DefaultDataContext.CreateParameter("Name", typeof(string), p_Name),
                DefaultDataContext.CreateParameter("AreaID", typeof(int?), p_AreaID),
                DefaultDataContext.CreateParameter("AreaCode", typeof(string), p_AreaCode),
                DefaultDataContext.CreateParameter("AreaName", typeof(string), p_AreaName),
                DefaultDataContext.CreateParameter("RegionID", typeof(int?), p_RegionID),
                DefaultDataContext.CreateParameter("RegionCode", typeof(string), p_RegionCode),
                DefaultDataContext.CreateParameter("RegionName", typeof(string), p_RegionName),
                DefaultDataContext.CreateParameter("TerritoryID", typeof(int?), p_TerritoryID),
                DefaultDataContext.CreateParameter("TerritoryCode", typeof(string), p_TerritoryCode),
                DefaultDataContext.CreateParameter("TerritoryName", typeof(string), p_TerritoryName),
                DefaultDataContext.CreateParameter("CompanyID", typeof(int?), p_CompanyID),
                DefaultDataContext.CreateParameter("CompanyCode", typeof(string), p_CompanyCode),
                DefaultDataContext.CreateParameter("CompanyName", typeof(string), p_CompanyName),
                DefaultDataContext.CreateParameter("DistributionTypeID", typeof(int?), p_DistributionTypeID),
                DefaultDataContext.CreateParameter("IsLotNumberEntryRequired", typeof(bool?), p_IsLotNumberEntryRequired),
                DefaultDataContext.CreateParameter("Address", typeof(string), p_Address),
                DefaultDataContext.CreateParameter("City", typeof(string), p_City),
                DefaultDataContext.CreateParameter("StateProvince", typeof(string), p_StateProvince),
                DefaultDataContext.CreateParameter("CountryID", typeof(int?), p_CountryID),
                DefaultDataContext.CreateParameter("CountryName", typeof(string), p_CountryName),
                DefaultDataContext.CreateParameter("ZipCode", typeof(string), p_ZipCode),
                DefaultDataContext.CreateParameter("Phone1", typeof(string), p_Phone1),
                DefaultDataContext.CreateParameter("Phone2", typeof(string), p_Phone2),
                DefaultDataContext.CreateParameter("Fax", typeof(string), p_Fax),
                DefaultDataContext.CreateParameter("Email", typeof(string), p_Email),
                DefaultDataContext.CreateParameter("TaxNumber", typeof(string), p_TaxNumber),
                DefaultDataContext.CreateParameter("StatusID", typeof(int?), p_StatusID),
                DefaultDataContext.CreateParameter("AdditionalInfo", typeof(string), p_AdditionalInfo),
                DefaultDataContext.CreateParameter("IsDeleted", typeof(bool?), p_IsDeleted)));
        }

        #endregion

    }

};
