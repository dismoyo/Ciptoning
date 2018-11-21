using System;

namespace Dismoyo.Data
{
    
    public class EndOperationDataEventArgs<TClass> : EventArgs
        where TClass : class, new()
    {

        #region Constructors

        public EndOperationDataEventArgs(TClass data, Exception error)
        {
            Data = data;
            Error = error;
        }

        #endregion

        #region Properties

        public TClass Data { get; private set; }
        public Exception Error { get; private set; }

        public bool IsError
        {
            get { return (Error != null); }
        }

        #endregion
        
    }

}
