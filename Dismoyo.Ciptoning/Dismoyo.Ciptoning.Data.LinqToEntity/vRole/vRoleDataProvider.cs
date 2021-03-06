﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vRoleDataProvider partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using Dismoyo.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
//using WebMatrix.WebData;

namespace Dismoyo.Ciptoning.Data
{

    public partial class vRoleDataProvider : DefaultViewDataProvider<vRole>, IvRoleDataProvider
    {

        #region Methods

        public vRole GetDataByName(string name)
        {
            var role = GetData().SingleOrDefault(p => p.Name.Equals(name, StringComparison.OrdinalIgnoreCase));

            return role;
        }


        protected override void OnInsertData(vRole obj)
        {
            var roleDataProvider = DataConfiguration.GetDefaultDataProvider<IRoleDataProvider>();

            var role = new Role();

            role.Name = obj.Name;
            role.Description = obj.Description;

            roleDataProvider.InsertData(role);
        }

        protected override void OnUpdateData(vRole obj)
        {
            var roleDataProvider = DataConfiguration.GetDefaultDataProvider<IRoleDataProvider>();

            var role = roleDataProvider.GetData(obj.ID);

            role.Name = obj.Name;
            role.Description = obj.Description;

            roleDataProvider.UpdateData(role);
        }

        protected override void OnDeleteData(vRole obj)
        {
            var roleDataProvider = DataConfiguration.GetDefaultDataProvider<IRoleDataProvider>();

            var role = roleDataProvider.GetData(obj.ID);
            //var region = GetRegionByUserID(obj.ID);
            //if (region.Count() > 0)
            //{
            //    Exception ex = new Exception("Cannot Delete,This Role Is Already used");
            //    throw ex;
            //}

            role.IsDeleted = true;

            roleDataProvider.UpdateData(role);
        }

        #endregion

    }

}
