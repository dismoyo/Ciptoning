using System;

namespace Dismoyo.Data
{
    
    public class BeginOperationDataEventArgs<TClass> : EventArgs
        where TClass : class, new()
    {

        #region Constructors

        public BeginOperationDataEventArgs(TClass data)
        {
            Data = data;
        }

        #endregion

        #region Properties

        public TClass Data { get; private set; }
        public bool Cancel { get; set; }

        #endregion
        
    }

}
