using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dismoyo.Ciptoning.Web.Reports
{

    public partial class Error : System.Web.UI.Page
    {

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            ViewState["ErrorID"] = Request.QueryString["ErrorID"];
            ViewState["ErrorMessage"] = Request.QueryString["ErrorMessage"];
        }

        #endregion

    }

}
