using System;

namespace Dismoyo.Utilities
{

    public static class ExceptionUtility
    {

        #region Methods

        public static Exception InnermostException(Exception ex)
        {
            return (ex.InnerException == null) ? ex : InnermostException(ex.InnerException);
        }
        
        #endregion

    }

}
