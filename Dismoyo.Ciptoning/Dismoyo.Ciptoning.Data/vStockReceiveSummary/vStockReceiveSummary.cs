﻿// ===================================================================================
// Author        : System
// Created date  : 29 Feb 2016 12:50:57
// Description   : vStockReceiveSummary partial class.
//
// Modified date :
// Modified by   :
// Comments      :
//
// NOTE: This file is initially generated by system and can be modified following
//       the requirement.
// ===================================================================================

using System.Collections.Generic;

namespace Dismoyo.Ciptoning.Data
{

    public partial class vStockReceiveSummary
    {

        #region Properties

        public virtual vStockReceive Parent { get; set; }

        public virtual ICollection<vStockReceiveDetails> ChildDetails { get; set; }

        #endregion

    }

}
