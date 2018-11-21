﻿// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 13:52:51
// Description   : IStockTransfer partial interface.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate or modify through partial interface. If required,
//       a partial interface should be created as 'IStockTransfer.cs'
//       up to one level of this file location inside 'StockTransfer' folder.
// ===================================================================================

namespace Dismoyo.Ciptoning.Data
{

    public partial interface IStockTransfer
    {

        #region Properties

        System.Guid DocumentID { get; set; }
        string DocumentCode { get; set; }
        System.DateTime TransactionDate { get; set; }
        System.Guid SourceWarehouseID { get; set; }
        string SourcePIC { get; set; }
        System.Guid DestinationWarehouseID { get; set; }
        string DestinationPIC { get; set; }
        string ReferenceNumber { get; set; }
        string AttachmentFile { get; set; }
        System.Guid DODocumentID { get; set; }
        int DocumentStatusID { get; set; }
        int PrintCount { get; set; }
        System.DateTime? PostedDate { get; set; }
        System.DateTime CreatedDate { get; set; }
        int? CreatedByUserID { get; set; }
        System.DateTime? ModifiedDate { get; set; }
        int? ModifiedByUserID { get; set; }

        #endregion

    }

}