Dismoyo_Ciptoning_Client.vSalesByChannelReports = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();

    function handlevSalesByChannelReportsModification() { shouldReload = true; }

    var pane;
    var _reportDateFrom = null;
    var _reportDateTo = null;

    function checkContainer() {
        pane = CommonUtility.configureCommonIFrameLayout('vSalesByChannelReports');
        if (!pane)
            setTimeout(checkContainer, 50);
        else {
            var form = collapsibleFilter.form();
            form.getEditor('ReportGroupBy').option('value', 1);
            form.getEditor('ReportPeriod').option('value', 2);
            form.getEditor('ReportDateFrom').option('value', DateTimeUtility.getFirstDayOfMonth(new Date()));
        }
    }

    function handleViewShowing() {
        checkContainer();

        isReady.resolve();
    }

    function refreshIFrame(filter) {
        var iframe = commonIFrame.iframe();

        commonIFrame.showLoadingPanel();
        iframe.attr('src', Dismoyo_Ciptoning_Client.ReportWebsite.SalesByChannelReport.url(filter));
    }





    // ------------------------------------------------------------------------------------------------
    // collapsibleFilter
    // ------------------------------------------------------------------------------------------------
    var collapsibleFilter = new Dismoyo_Ciptoning_Client.CollapsibleFilter();

    collapsibleFilter.filterOptions.onInitialized = function () {
        collapsibleFilter.filter().element().resize(function () {
            if (pane)
                pane.resizeAll();
        });
    };

    // ------------------------------------------------------------------------------------------------
    // Filter Items: Specify items of the filter here.
    // ------------------------------------------------------------------------------------------------    
    collapsibleFilter.formOptions.items = [{
        itemType: 'group',
        caption: 'Organization',
        colCount: 3,
        colSpan: 3,
        visible: Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice(),
        items: [{
            dataField: 'TerritoryID',
            label: { text: 'Territory' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupTerritoryDataSource(null),
                displayExpr: 'Territory',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Territory',
                        [],
                        ['Region']);
                }
            }
        }, {
            dataField: 'RegionID',
            label: { text: 'Region' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupRegionDataSource(null),
                displayExpr: 'Region',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Region',
                        ['Territory'],
                        ['Area', 'Site']);
                }
            }
        }, {
            dataField: 'AreaID',
            label: { text: 'Area' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupAreaDataSource(null),
                displayExpr: 'Area',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Area',
                        ['Region', 'Territory'],
                        ['Company', 'Site']);
                }
            }
        }, {
            dataField: 'CompanyID',
            label: { text: 'Company' },
            colSpan: 2,
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupCompanyDataSource(null),
                displayExpr: 'Company',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                }
            }
        }, {
            dataField: 'SiteID',
            label: { text: 'Site' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSiteDataSource(null),
                displayExpr: 'Site',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],
                placeholder: '(All)',
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    CommonUtility.cascadeValueChanged(collapsibleFilter.form(), e.selectedItem, e.value, 'Site',
                        ['Company', 'Area', 'Region', 'Territory'],
                        []);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Sales by Channel Report',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'ReportPeriod',
            label: { text: 'Period' },
            editorType: 'dxRadioGroup',
            editorOptions: {
                width: '100%',
                displayExpr: 'Name',
                valueExpr: 'ID',
                items: [
                    { ID: 1, Name: 'Daily' },
                    { ID: 2, Name: 'Monthly' }
                ],
                layout: 'horizontal',
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    var form = collapsibleFilter.form();

                    CommonUtility.reportPeriodValueChanged(e, form, true);
                    _reportDateFrom = null;
                    _reportDateTo = null;
                }
            }
        }, {
            dataField: 'ReportDateFrom',
            label: { text: 'Report Date From' },
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                min: new Date(2016, 6, 1),
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    var form = collapsibleFilter.form();

                    _reportDateFrom = e.value;
                    if (form.itemOption('SalesByChannelReports.ReportDateTo').visible) {
                        CommonUtility.reportDateFromValueChanged(e, form);

                        _reportDateTo = form.getEditor('ReportDateTo').option('value');                        
                    } else
                        _reportDateTo = (e.value) ? new Date(e.value.getFullYear(), e.value.getMonth() + 1, 0) : null;

                    if (_reportDateFrom instanceof Date)
                        _reportDateFrom = DateTimeUtility.getFirstTimeOfDay(_reportDateFrom);

                    if (_reportDateTo instanceof Date)
                        _reportDateTo = DateTimeUtility.getLastTimeOfDay(_reportDateTo);
                }
            }
        }, {
            dataField: 'ReportDateTo',
            label: { text: 'Report Date To' },
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); },
                onValueChanged: function (e) {
                    var form = collapsibleFilter.form();

                    CommonUtility.reportDateToValueChanged(e, form);

                    _reportDateFrom = form.getEditor('ReportDateFrom').option('value');
                    _reportDateTo = e.value;

                    if (_reportDateFrom instanceof Date)
                        _reportDateFrom = DateTimeUtility.getFirstTimeOfDay(_reportDateFrom);

                    if (_reportDateTo instanceof Date)
                        _reportDateTo = DateTimeUtility.getLastTimeOfDay(_reportDateTo);
                }
            }
        }, {
            dataField: 'ReportGroupBy',
            label: { text: 'Group by' },
            editorType: 'dxRadioGroup',
            editorOptions: {
                width: '100%',
                displayExpr: 'Name',
                valueExpr: 'ID',
                items: [
                    { ID: 1, Name: 'Product' },
                    { ID: 2, Name: 'Brand' }
                ],
                layout: 'horizontal',
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }]
    }];



    // ------------------------------------------------------------------------------------------------
    // Perform search by specified criteria (filter).
    // ------------------------------------------------------------------------------------------------
    collapsibleFilter.events.performSearch = function () {
        var form = collapsibleFilter.form();

        var ctlReportDateFrom = form.getEditor('ReportDateFrom');
        if (ctlReportDateFrom && ctlReportDateFrom.option('visible')) {
            if ((_reportDateFrom == null) || (_reportDateTo == null)) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Please specify Report Date/Month.'), 'Search Failed');
                return;
            }

            if ((_reportDateFrom.getFullYear() != _reportDateTo.getFullYear()) ||
                (_reportDateFrom.getMonth() != _reportDateTo.getMonth())) {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Report Date From and To must be in the same month.'),
                    'Search Failed');
                return;
            }
        }

        var filterExpr = [];
        var value;

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var territoryID = user.TerritoryID();
        var regionID = user.RegionID();
        var areaID = user.AreaID();
        var companyID = user.CompanyID();
        var siteID = user.SiteID();

        if (form.itemOption('Organization').visible) {
            territoryID = form.getEditor('TerritoryID').option('value');
            regionID = form.getEditor('RegionID').option('value');
            areaID = form.getEditor('AreaID').option('value');
            companyID = form.getEditor('CompanyID').option('value');
            siteID = form.getEditor('SiteID').option('value');
        }

        // TerritoryID        
        DXUtility.addFilterExpression(filterExpr, 'TerritoryID', '=', territoryID, 'and');

        // RegionID
        DXUtility.addFilterExpression(filterExpr, 'RegionID', '=', regionID, 'and');

        // AreaID
        DXUtility.addFilterExpression(filterExpr, 'AreaID', '=', areaID, 'and');

        // CompanyID
        DXUtility.addFilterExpression(filterExpr, 'CompanyID', '=', companyID, 'and');

        // SiteID
        DXUtility.addFilterExpression(filterExpr, 'SiteID', '=', siteID, 'and');

        // ReportGroupBy
        value = form.getEditor('ReportGroupBy').option('value');
        DXUtility.addFilterExpression(filterExpr, 'ReportGroupBy', '=', value, 'and');

        // ReportDateFrom
        value = _reportDateFrom;
        DXUtility.addFilterExpression(filterExpr, 'ReportDateFrom', '>=', value, 'and');

        // ReportDateTo
        value = _reportDateTo;
        DXUtility.addFilterExpression(filterExpr, 'ReportDateTo', '<=', value, 'and');

        refreshIFrame(filterExpr);
    };

    // ------------------------------------------------------------------------------------------------
    // Perform clear search criteria (filter).
    // ------------------------------------------------------------------------------------------------
    collapsibleFilter.events.performClear = function () {
        var form = collapsibleFilter.form();

        form.getEditor('ReportDateFrom').option('value', null);
        if (form.itemOption('SalesByChannelReports.ReportDateTo').visible)
            form.getEditor('ReportDateTo').option('value', null);

        _reportDateFrom = null;
        _reportDateTo = null;
    }





    // ------------------------------------------------------------------------------------------------
    // commonIFrame
    // ------------------------------------------------------------------------------------------------
    var commonIFrame = new Dismoyo_Ciptoning_Client.CommonIFrame();





    return {
        isReady: isReady.promise(),
        viewShowing: handleViewShowing,
        openCreateViewAsRoot: openCreateViewAsRoot,


        // ------------------------------------------------------------------------------------------------
        // Register Public Properties/Methods
        // ------------------------------------------------------------------------------------------------

        icon: 'Images/sales_by_channel_report_32px.png',

        collapsibleFilter: collapsibleFilter,

        commonIFrame: commonIFrame
    };
};
