function Home_checkContainer() {
    if (!CommonUtility.validateLoggedInUser())
        return;

    if ($('#Home_viewSubContent').is(':visible')) {
        var pane = $('#Home_viewContent').layout({
            name: 'HomeViewContent',
            north: {
                paneSelector: '#Home_viewContentHeader',
                resizable: false,
                spacing_open: 0,
                spacing_closed: 0
            },
            center: {
                paneSelector: '#Home_viewSubContent',
                children: {
                    west: {
                        paneSelector: '#Home_leftChartContent',
                        resizable: false,
                        width: '300px',
                        spacing_open: 0,
                        spacing_closed: 0
                    },
                    center: {
                        paneSelector: '#Home_centerChartContent',
                        onresize: $.layout.callbacks.resizeTabLayout,
                        //onresize: function (pane, $Pane, state) {
                            //var dataGrid = DXUtility.getDXInstance($Pane, '#commonGridView_dataGrid', 'dxDataGrid');
                            //if (dataGrid)
                            //    dataGrid.option('height', $Pane.height() - 40);
                        //}
                    },
                    east: {
                        paneSelector: '#Home_rightChartContent',
                        resizable: false,
                        spacing_open: 0,
                        spacing_closed: 0
                    }
                }
            }
        });

        //pane.resizeAll();
        desktopPane().show('west');
    }
    else
        setTimeout(vSalesmanTargets_checkContainer, 50);
}


Dismoyo_Ciptoning_Client.Home = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();
    
    function handleViewShowing() {
        Home_checkContainer();

        var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
        var filters = [];
        if (!user.IsHeadOffice()) {
            filters = [
                ['TerritoryID', '=', user.TerritoryID()], 'and',
                ['RegionID', '=', user.RegionID()], 'and',
                ['AreaID', '=', user.AreaID()], 'and',
                ['CompanyID', '=', user.CompanyID()], 'and',
                ['SiteID', '=', user.SiteID()]
            ];
        }

        var today = new Date();
        if (filters.length > 0) {
            filters.push('and');
        }

        filters.push(['TransactionDate', '>=', DateTimeUtility.getFirstDayOfMonth(today)]);
        filters.push('and');
        filters.push(['TransactionDate', '<=', DateTimeUtility.getLastDayOfMonth(today)]);

        if (filters.length > 0)
            filters = [filters];

        //var leftChartDataSource = new DevExpress.data.DataSource({
        //    store: Dismoyo_Ciptoning_Client.DB.vSalesOrders,
        //    select: [
        //        'DocumentStatusID',
        //        'DocumentStatusName'
        //    ],
        //    filter: filters,
        //    group: 'DocumentStatusID'
        //}).load()        
        //    .done(function (result) {
        //        var ds = [];
        //        for (var i = 0; i < result.length; i++) {
        //            ds.push({
        //                arg: result[0].items[0].DocumentStatusName,
        //                val: result[0].items.length
        //            });
        //        }

        //        //centerChart().option('dataSource', ds);
        //    })
        //    .fail(function (error) {
        //        alert(error);
        //    });
    }



    

    var leftChart = function () { return DXUtility.getDXInstance(null, '#Home_leftChart', 'dxChart'); };

    var leftChartOptions = {
        dataSource: [{
            arg: 'A',
            val: 24
        }, {
            arg: 'B',
            val: 120
        }, {
            arg: 'C',
            val: 32
        }, {
            arg: 'D',
            val: 3
        }],
        legend: {
            visible: false
        },
        series: {
            type: 'bar'
        },
        argumentAxis: {
            tickInterval: 10
        },
        valueAxis: {
            label: {
                format: {
                    //type: 'millions'
                }
            }
        },
        title: 'Current Sales Order'
    }

    var centerChart = function () { return DXUtility.getDXInstance(null, '#Home_centerChart', 'dxChart'); };

    var centerChartOptions = {
        dataSource: [],
        legend: {
            visible: false
        },
        series: {
            type: 'bar'
        },
        argumentAxis: {
            tickInterval: 10
        },
        valueAxis: {
            label: {
                format: {
                    //type: 'millions'
                }
            }
        },
        title: 'This Month Sales Order'
    }

    var rightChart = function () { return DXUtility.getDXInstance(null, '#Home_rightChart', 'dxChart'); };

    var rightChartOptions = {
        dataSource: [{
            arg: 'AA',
            val: 24
        }, {
            arg: 'BB',
            val: 120
        }, {
            arg: 'CC',
            val: 32
        }, {
            arg: 'DD',
            val: 3
        }],
        legend: {
            visible: false
        },
        series: {
            type: 'bar'
        },
        argumentAxis: {
            tickInterval: 10
        },
        valueAxis: {
            label: {
                format: {
                    //type: 'millions'
                }
            }
        },
        title: 'Current Sales Order'
    }




    
    return {
        isReady: isReady.promise(),
        viewShowing: handleViewShowing,
        openCreateViewAsRoot: openCreateViewAsRoot,


        // ------------------------------------------------------------------------------------------------
        // Register Public Properties/Methods
        // ------------------------------------------------------------------------------------------------

        icon: 'Images/home_32px.png',

        leftChartOptions: leftChartOptions,
        centerChartOptions: centerChartOptions,
        rightChartOptions: rightChartOptions
    };
};
