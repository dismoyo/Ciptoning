using Dismoyo.Data.LinqToEntity;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;

namespace Dismoyo.Ciptoning.Data
{

    public partial class StoreFunctionsDataContext : DataContext
    {

        #region fTerritory

        //    [DbFunction("StoreFunctionsDataContext", "fTerritory")]
        //    public IQueryable<vTerritory> fTerritory(
        //        int? p_ID,
        //        string p_Code,
        //        string p_Name,
        //        bool? p_IsDeleted)
        //    {
        //        return OrderQuery<vTerritory>(((IObjectContextAdapter)this).ObjectContext
        //            .CreateQuery<vTerritory>(string.Format(@"
        //            [{0}].[fTerritory]
        //            (
        //             @ID,
        //                @Code,
        //                @Name,
        //                @IsDeleted
        //            )", GetType().Name),
        //            DefaultDataContext.CreateParameter("ID", typeof(int?), p_ID),
        //            DefaultDataContext.CreateParameter("Code", typeof(string), p_Code),
        //            DefaultDataContext.CreateParameter("Name", typeof(string), p_Name),
        //            DefaultDataContext.CreateParameter("IsDeleted", typeof(bool), p_IsDeleted)));
        //    }

        #endregion

    }

}
