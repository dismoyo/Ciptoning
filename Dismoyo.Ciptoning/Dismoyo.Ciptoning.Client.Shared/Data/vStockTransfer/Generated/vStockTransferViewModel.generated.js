// ===================================================================================
// Author        : System
// Created date  : 22 Mar 2016 12:46:21
// Description   : vStockTransferViewModel javascript.
//
// NOTE: This file is generated by system. Please do not modify this file.
//       Consider regenerate this file.
// ===================================================================================

(function () {
    Dismoyo_Ciptoning_Client.vStockTransferViewModel = function (data) {
        this.DocumentID = ko.observable();
        this.DocumentCode = ko.observable();
        this.TransactionDate = ko.observable();
        this.SourceWarehouseID = ko.observable();
        this.SourceWarehouseCode = ko.observable();
        this.SourceWarehouseName = ko.observable();
        this.SourceWarehouse = ko.observable();
        this.SourceSiteID = ko.observable();
        this.SourceSiteCode = ko.observable();
        this.SourceSiteName = ko.observable();
        this.SourceSite = ko.observable();
        this.SourceCompanyID = ko.observable();
        this.SourceCompanyCode = ko.observable();
        this.SourceCompanyName = ko.observable();
        this.SourceCompany = ko.observable();
        this.SourceAreaID = ko.observable();
        this.SourceAreaCode = ko.observable();
        this.SourceAreaName = ko.observable();
        this.SourceArea = ko.observable();
        this.SourceRegionID = ko.observable();
        this.SourceRegionCode = ko.observable();
        this.SourceRegionName = ko.observable();
        this.SourceRegion = ko.observable();
        this.SourceTerritoryID = ko.observable();
        this.SourceTerritoryCode = ko.observable();
        this.SourceTerritoryName = ko.observable();
        this.SourceTerritory = ko.observable();
        this.SourceSiteDistributionTypeID = ko.observable();
        this.SourceSiteDistributionTypeName = ko.observable();
        this.SourceWarehouseTypeID = ko.observable();
        this.SourceWarehouseTypeName = ko.observable();
        this.IsSourceSiteLotNumberEntryRequired = ko.observable();
        this.SourcePIC = ko.observable();
        this.DestinationWarehouseID = ko.observable();
        this.DestinationWarehouseCode = ko.observable();
        this.DestinationWarehouseName = ko.observable();
        this.DestinationWarehouse = ko.observable();
        this.DestinationSiteID = ko.observable();
        this.DestinationSiteCode = ko.observable();
        this.DestinationSiteName = ko.observable();
        this.DestinationSite = ko.observable();
        this.DestinationCompanyID = ko.observable();
        this.DestinationCompanyCode = ko.observable();
        this.DestinationCompanyName = ko.observable();
        this.DestinationCompany = ko.observable();
        this.DestinationAreaID = ko.observable();
        this.DestinationAreaCode = ko.observable();
        this.DestinationAreaName = ko.observable();
        this.DestinationArea = ko.observable();
        this.DestinationRegionID = ko.observable();
        this.DestinationRegionCode = ko.observable();
        this.DestinationRegionName = ko.observable();
        this.DestinationRegion = ko.observable();
        this.DestinationTerritoryID = ko.observable();
        this.DestinationTerritoryCode = ko.observable();
        this.DestinationTerritoryName = ko.observable();
        this.DestinationTerritory = ko.observable();
        this.DestinationSiteDistributionTypeID = ko.observable();
        this.DestinationSiteDistributionTypeName = ko.observable();
        this.IsDestinationSiteLotNumberEntryRequired = ko.observable();
        this.DestinationWarehouseTypeID = ko.observable();
        this.DestinationWarehouseTypeName = ko.observable();
        this.DestinationPIC = ko.observable();
        this.ReferenceNumber = ko.observable();
        this.AttachmentFile = ko.observable();
        this.DODocumentID = ko.observable();
        this.DODocumentCode = ko.observable();
        this.DOShipmentDate = ko.observable();
        this.DOReceivedDate = ko.observable();
        this.DOPrintedCount = ko.observable();
        this.DOLastPrintedDate = ko.observable();
        this.DocumentStatusID = ko.observable();
        this.DocumentStatusName = ko.observable();
        this.PrintCount = ko.observable();
        this.PostedDate = ko.observable();
        this.CreatedDate = ko.observable();
        this.CreatedByUserID = ko.observable();
        this.CreatedByUserName = ko.observable();
        this.ModifiedDate = ko.observable();
        this.ModifiedByUserID = ko.observable();
        this.ModifiedByUserName = ko.observable();

        this.ChildSummaries = ko.observableArray([]);

        if (data)
            this.fromJS(data);
    };

    $.extend(Dismoyo_Ciptoning_Client.vStockTransferViewModel.prototype, {
        toJS: function () {
            return {
                DocumentID: this.DocumentID(),
                DocumentCode: this.DocumentCode(),
                TransactionDate: this.TransactionDate(),
                SourceWarehouseID: this.SourceWarehouseID(),
                SourceWarehouseCode: this.SourceWarehouseCode(),
                SourceWarehouseName: this.SourceWarehouseName(),
                SourceWarehouse: this.SourceWarehouse(),
                SourceSiteID: this.SourceSiteID(),
                SourceSiteCode: this.SourceSiteCode(),
                SourceSiteName: this.SourceSiteName(),
                SourceSite: this.SourceSite(),
                SourceCompanyID: this.SourceCompanyID(),
                SourceCompanyCode: this.SourceCompanyCode(),
                SourceCompanyName: this.SourceCompanyName(),
                SourceCompany: this.SourceCompany(),
                SourceAreaID: this.SourceAreaID(),
                SourceAreaCode: this.SourceAreaCode(),
                SourceAreaName: this.SourceAreaName(),
                SourceArea: this.SourceArea(),
                SourceRegionID: this.SourceRegionID(),
                SourceRegionCode: this.SourceRegionCode(),
                SourceRegionName: this.SourceRegionName(),
                SourceRegion: this.SourceRegion(),
                SourceTerritoryID: this.SourceTerritoryID(),
                SourceTerritoryCode: this.SourceTerritoryCode(),
                SourceTerritoryName: this.SourceTerritoryName(),
                SourceTerritory: this.SourceTerritory(),
                SourceSiteDistributionTypeID: this.SourceSiteDistributionTypeID(),
                SourceSiteDistributionTypeName: this.SourceSiteDistributionTypeName(),
                SourceWarehouseTypeID: this.SourceWarehouseTypeID(),
                SourceWarehouseTypeName: this.SourceWarehouseTypeName(),
                IsSourceSiteLotNumberEntryRequired: this.IsSourceSiteLotNumberEntryRequired(),
                SourcePIC: this.SourcePIC(),
                DestinationWarehouseID: this.DestinationWarehouseID(),
                DestinationWarehouseCode: this.DestinationWarehouseCode(),
                DestinationWarehouseName: this.DestinationWarehouseName(),
                DestinationWarehouse: this.DestinationWarehouse(),
                DestinationSiteID: this.DestinationSiteID(),
                DestinationSiteCode: this.DestinationSiteCode(),
                DestinationSiteName: this.DestinationSiteName(),
                DestinationSite: this.DestinationSite(),
                DestinationCompanyID: this.DestinationCompanyID(),
                DestinationCompanyCode: this.DestinationCompanyCode(),
                DestinationCompanyName: this.DestinationCompanyName(),
                DestinationCompany: this.DestinationCompany(),
                DestinationAreaID: this.DestinationAreaID(),
                DestinationAreaCode: this.DestinationAreaCode(),
                DestinationAreaName: this.DestinationAreaName(),
                DestinationArea: this.DestinationArea(),
                DestinationRegionID: this.DestinationRegionID(),
                DestinationRegionCode: this.DestinationRegionCode(),
                DestinationRegionName: this.DestinationRegionName(),
                DestinationRegion: this.DestinationRegion(),
                DestinationTerritoryID: this.DestinationTerritoryID(),
                DestinationTerritoryCode: this.DestinationTerritoryCode(),
                DestinationTerritoryName: this.DestinationTerritoryName(),
                DestinationTerritory: this.DestinationTerritory(),
                DestinationSiteDistributionTypeID: this.DestinationSiteDistributionTypeID(),
                DestinationSiteDistributionTypeName: this.DestinationSiteDistributionTypeName(),
                DestinationWarehouseTypeID: this.DestinationWarehouseTypeID(),
                DestinationWarehouseTypeName: this.DestinationWarehouseTypeName(),
                IsDestinationSiteLotNumberEntryRequired: this.IsDestinationSiteLotNumberEntryRequired(),
                DestinationPIC: this.DestinationPIC(),
                ReferenceNumber: this.ReferenceNumber(),
                AttachmentFile: this.AttachmentFile(),
                DODocumentID: this.DODocumentID(),
                DODocumentCode: this.DODocumentCode(),
                DOShipmentDate: this.DOShipmentDate(),
                DOReceivedDate: this.DOReceivedDate(),
                DOPrintedCount: this.DOPrintedCount(),
                DOLastPrintedDate: this.DOLastPrintedDate(),
                DocumentStatusID: this.DocumentStatusID(),
                DocumentStatusName: this.DocumentStatusName(),
                PrintCount: this.PrintCount(),
                PostedDate: this.PostedDate(),
                CreatedDate: this.CreatedDate(),
                CreatedByUserID: this.CreatedByUserID(),
                CreatedByUserName: this.CreatedByUserName(),
                ModifiedDate: this.ModifiedDate(),
                ModifiedByUserID: this.ModifiedByUserID(),
                ModifiedByUserName: this.ModifiedByUserName(),

                ChildSummaries: ko.toJS(this.ChildSummaries())
            };
        },

        fromJS: function (data) {
            if (data) {
                this.DocumentID(data.DocumentID);
                this.DocumentCode(data.DocumentCode);
                this.TransactionDate(data.TransactionDate);
                this.SourceWarehouseID(data.SourceWarehouseID);
                this.SourceWarehouseCode(data.SourceWarehouseCode);
                this.SourceWarehouseName(data.SourceWarehouseName);
                this.SourceWarehouse(data.SourceWarehouse);
                this.SourceSiteID(data.SourceSiteID);
                this.SourceSiteCode(data.SourceSiteCode);
                this.SourceSiteName(data.SourceSiteName);
                this.SourceSite(data.SourceSite);
                this.SourceCompanyID(data.SourceCompanyID);
                this.SourceCompanyCode(data.SourceCompanyCode);
                this.SourceCompanyName(data.SourceCompanyName);
                this.SourceCompany(data.SourceCompany);
                this.SourceAreaID(data.SourceAreaID);
                this.SourceAreaCode(data.SourceAreaCode);
                this.SourceAreaName(data.SourceAreaName);
                this.SourceArea(data.SourceArea);
                this.SourceRegionID(data.SourceRegionID);
                this.SourceRegionCode(data.SourceRegionCode);
                this.SourceRegionName(data.SourceRegionName);
                this.SourceRegion(data.SourceRegion);
                this.SourceTerritoryID(data.SourceTerritoryID);
                this.SourceTerritoryCode(data.SourceTerritoryCode);
                this.SourceTerritoryName(data.SourceTerritoryName);
                this.SourceTerritory(data.SourceTerritory);
                this.SourceSiteDistributionTypeID(data.SourceSiteDistributionTypeID);
                this.SourceSiteDistributionTypeName(data.SourceSiteDistributionTypeName);
                this.SourceWarehouseTypeID(data.SourceWarehouseTypeID);
                this.SourceWarehouseTypeName(data.SourceWarehouseTypeName);
                this.IsSourceSiteLotNumberEntryRequired(data.IsSourceSiteLotNumberEntryRequired);
                this.SourcePIC(data.SourcePIC);
                this.DestinationWarehouseID(data.DestinationWarehouseID);
                this.DestinationWarehouseCode(data.DestinationWarehouseCode);
                this.DestinationWarehouseName(data.DestinationWarehouseName);
                this.DestinationWarehouse(data.DestinationWarehouse);
                this.DestinationSiteID(data.DestinationSiteID);
                this.DestinationSiteCode(data.DestinationSiteCode);
                this.DestinationSiteName(data.DestinationSiteName);
                this.DestinationSite(data.DestinationSite);
                this.DestinationCompanyID(data.DestinationCompanyID);
                this.DestinationCompanyCode(data.DestinationCompanyCode);
                this.DestinationCompanyName(data.DestinationCompanyName);
                this.DestinationCompany(data.DestinationCompany);
                this.DestinationAreaID(data.DestinationAreaID);
                this.DestinationAreaCode(data.DestinationAreaCode);
                this.DestinationAreaName(data.DestinationAreaName);
                this.DestinationArea(data.DestinationArea);
                this.DestinationRegionID(data.DestinationRegionID);
                this.DestinationRegionCode(data.DestinationRegionCode);
                this.DestinationRegionName(data.DestinationRegionName);
                this.DestinationRegion(data.DestinationRegion);
                this.DestinationTerritoryID(data.DestinationTerritoryID);
                this.DestinationTerritoryCode(data.DestinationTerritoryCode);
                this.DestinationTerritoryName(data.DestinationTerritoryName);
                this.DestinationTerritory(data.DestinationTerritory);
                this.DestinationSiteDistributionTypeID(data.DestinationSiteDistributionTypeID);
                this.DestinationSiteDistributionTypeName(data.DestinationSiteDistributionTypeName);
                this.DestinationWarehouseTypeID(data.DestinationWarehouseTypeID);
                this.DestinationWarehouseTypeName(data.DestinationWarehouseTypeName);
                this.IsDestinationSiteLotNumberEntryRequired(data.IsDestinationSiteLotNumberEntryRequired);
                this.DestinationPIC(data.DestinationPIC);
                this.ReferenceNumber(data.ReferenceNumber);
                this.AttachmentFile(data.AttachmentFile);
                this.DODocumentID(data.DODocumentID);
                this.DODocumentCode(data.DODocumentCode);
                this.DOShipmentDate(data.DOShipmentDate);
                this.DOReceivedDate(data.DOReceivedDate);
                this.DOPrintedCount(data.DOPrintedCount);
                this.DOLastPrintedDate(data.DOLastPrintedDate);
                this.DocumentStatusID(data.DocumentStatusID);
                this.DocumentStatusName(data.DocumentStatusName);
                this.PrintCount(data.PrintCount);
                this.PostedDate(data.PostedDate);
                this.CreatedDate(data.CreatedDate);
                this.CreatedByUserID(data.CreatedByUserID);
                this.CreatedByUserName(data.CreatedByUserName);
                this.ModifiedDate(data.ModifiedDate);
                this.ModifiedByUserID(data.ModifiedByUserID);
                this.ModifiedByUserName(data.ModifiedByUserName);

                if (data.ChildSummaries) {
                    for (var i = 0; i < data.ChildSummaries.length; i++)
                        this.ChildSummaries.push(new Dismoyo_Ciptoning_Client.vStockTransferSummaryViewModel(
                            data.ChildSummaries[i]));
                }
            }
        },

        clear: function () {
            this.DocumentID(undefined);
            this.DocumentCode(undefined);
            this.TransactionDate(undefined);
            this.SourceWarehouseID(undefined);
            this.SourceWarehouseCode(undefined);
            this.SourceWarehouseName(undefined);
            this.SourceWarehouse(undefined);
            this.SourceSiteID(undefined);
            this.SourceSiteCode(undefined);
            this.SourceSiteName(undefined);
            this.SourceSite(undefined);
            this.SourceCompanyID(undefined);
            this.SourceCompanyCode(undefined);
            this.SourceCompanyName(undefined);
            this.SourceCompany(undefined);
            this.SourceAreaID(undefined);
            this.SourceAreaCode(undefined);
            this.SourceAreaName(undefined);
            this.SourceArea(undefined);
            this.SourceRegionID(undefined);
            this.SourceRegionCode(undefined);
            this.SourceRegionName(undefined);
            this.SourceRegion(undefined);
            this.SourceTerritoryID(undefined);
            this.SourceTerritoryCode(undefined);
            this.SourceTerritoryName(undefined);
            this.SourceTerritory(undefined);
            this.SourceSiteDistributionTypeID(undefined);
            this.SourceSiteDistributionTypeName(undefined);
            this.SourceWarehouseTypeID(undefined);
            this.SourceWarehouseTypeName(undefined);
            this.IsSourceSiteLotNumberEntryRequired(undefined);
            this.SourcePIC(undefined);
            this.DestinationWarehouseID(undefined);
            this.DestinationWarehouseCode(undefined);
            this.DestinationWarehouseName(undefined);
            this.DestinationWarehouse(undefined);
            this.DestinationSiteID(undefined);
            this.DestinationSiteCode(undefined);
            this.DestinationSiteName(undefined);
            this.DestinationSite(undefined);
            this.DestinationCompanyID(undefined);
            this.DestinationCompanyCode(undefined);
            this.DestinationCompanyName(undefined);
            this.DestinationCompany(undefined);
            this.DestinationAreaID(undefined);
            this.DestinationAreaCode(undefined);
            this.DestinationAreaName(undefined);
            this.DestinationArea(undefined);
            this.DestinationRegionID(undefined);
            this.DestinationRegionCode(undefined);
            this.DestinationRegionName(undefined);
            this.DestinationRegion(undefined);
            this.DestinationTerritoryID(undefined);
            this.DestinationTerritoryCode(undefined);
            this.DestinationTerritoryName(undefined);
            this.DestinationTerritory(undefined);
            this.DestinationSiteDistributionTypeID(undefined);
            this.DestinationSiteDistributionTypeName(undefined);
            this.DestinationWarehouseTypeID(undefined);
            this.DestinationWarehouseTypeName(undefined);
            this.IsDestinationSiteLotNumberEntryRequired(undefined);
            this.DestinationPIC(undefined);
            this.ReferenceNumber(undefined);
            this.AttachmentFile(undefined);
            this.DODocumentID(undefined);
            this.DODocumentCode(undefined);
            this.DOShipmentDate(undefined);
            this.DOReceivedDate(undefined);
            this.DOPrintedCount(undefined);
            this.DOLastPrintedDate(undefined);
            this.DocumentStatusID(undefined);
            this.DocumentStatusName(undefined);
            this.PrintCount(undefined);
            this.PostedDate(undefined);
            this.CreatedDate(undefined);
            this.CreatedByUserID(undefined);
            this.CreatedByUserName(undefined);
            this.ModifiedDate(undefined);
            this.ModifiedByUserID(undefined);
            this.ModifiedByUserName(undefined);

            this.ChildSummaries(undefined);
        }
    });
})();
