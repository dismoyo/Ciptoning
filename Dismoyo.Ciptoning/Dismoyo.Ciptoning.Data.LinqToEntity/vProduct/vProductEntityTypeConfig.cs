﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vProductEntityTypeConfig partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using System;
using System.Data.Entity.ModelConfiguration;

namespace Dismoyo.Ciptoning.Data
{

    public partial class vProductEntityTypeConfig : EntityTypeConfiguration<vProduct>
    {

        #region Constructors

        public vProductEntityTypeConfig()
        {
            HasRequired(p => p.Parent)
                .WithMany(q => q.ChildProducts)
                .HasForeignKey(p => p.BrandID)
                .WillCascadeOnDelete(false);
        }

        #endregion

    }

}
