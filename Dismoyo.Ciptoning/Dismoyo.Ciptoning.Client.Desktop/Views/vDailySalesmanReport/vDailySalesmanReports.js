Dismoyo_Ciptoning_Client.vDailySalesmanReports = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();

    function handlevDailySalesmanReportsModification() { shouldReload = true; }

    var pane;
    
    function checkContainer() {
        pane = CommonUtility.configureCommonIFrameLayout('vDailySalesmanReports');
        if (!pane)
            setTimeout(checkContainer, 50);
        else {
            var form = collapsibleFilter.form();
            form.getEditor('ReportDate').option('value', DateTimeUtility.getFirstTimeOfDay(new Date()));
        }
    }

    function handleViewShowing() {
        checkContainer();
                
        isReady.resolve();
    }

    function refreshIFrame(filter) {
        var iframe = commonIFrame.iframe();

        commonIFrame.showLoadingPanel();
        iframe.attr('src', Dismoyo_Ciptoning_Client.ReportWebsite.DailySalesmanReport.url(filter));
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
                        ['Salesman']);
                }
            }
        }]
    }, {
        itemType: 'group',
        caption: 'Daily Salesman Report',
        colCount: 3,
        colSpan: 3,
        items: [{
            dataField: 'ReportDate',
            label: { text: 'Report Date' },
            editorType: 'dxDateBox',
            editorOptions: {
                width: '100%',
                placeholder: 'mm/dd/yyyy',
                formatString: 'MM/dd/yyyy',
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }, {
            dataField: 'SalesmanID',
            label: { text: 'Salesman' },
            editorType: 'dxSelectBox',
            editorOptions: {
                dataSource: DataUtility.GetLookupSalesmanDataSource(
                    (Dismoyo_Ciptoning_Client.app.CurrentUser.IsHeadOffice()) ? null : ['SiteID', '=', Dismoyo_Ciptoning_Client.app.CurrentUser.SiteID()]
                ),
                displayExpr: 'Salesman',
                valueExpr: 'ID',
                searchExpr: ['Code', 'Name'],                
                searchEnabled: true,
                showClearButton: true,
                onEnterKey: function () { collapsibleFilter.events.performSearch(this); }
            }
        }]
    }];



    // ------------------------------------------------------------------------------------------------
    // Perform search by specified criteria (filter).
    // ------------------------------------------------------------------------------------------------
    collapsibleFilter.events.performSearch = function () {
        var form = collapsibleFilter.form();

        if ((form.getEditor('ReportDate').option('value') == null) ||
            (form.getEditor('SalesmanID').option('value') == null)) {
            DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Please specify Report Date and Salesman.'), 'Search Failed');
            return;
        }

        var filterExpr = [];
        var value;

        // ReportDateFrom & ReportDateTo
        value = form.getEditor('ReportDate').option('value');
        DXUtility.addFilterExpression(filterExpr, 'ReportDateFrom', '>=', value, 'and');
        DXUtility.addFilterExpression(filterExpr, 'ReportDateTo', '<=', value, 'and');

        // SalesmanID
        value = form.getEditor('SalesmanID').option('value');
        DXUtility.addFilterExpression(filterExpr, 'SalesmanID', '=', value, 'and');

        refreshIFrame(filterExpr);
    };





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

        icon: 'Images/daily_salesman_report_32px.png',

        collapsibleFilter: collapsibleFilter,

        commonIFrame: commonIFrame
    };
};
