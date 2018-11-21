
Dismoyo_Ciptoning_Client.CommonTreeView = function () {
    var events = {
        performSearchItem: function (value) { },
        itemClick: function (e) { }
    };

    var commonTreeView_loadingPanel = function () { return DXUtility.getDXInstance(null, '#commonTreeView_loadingPanel', 'dxLoadPanel'); }

    var commonTreeView_loadingPanelOptions = {
        showIndicator: true,
        showPane: true,
        shading: false,
        closeOnOutsideClick: false
    };

    var search = function () { return DXUtility.getDXInstance(null, '#commonTreeView_search', 'dxTextBox'); }

    var searchOptions = {
        placeholder: 'Search',
        mode: 'search',
        valueChangeEvent: 'keyup',
        onValueChanged: function (e) {
            treeView().option('searchValue', e.value);
            events.performSearchItem(e.value);
        }
    };

    var treeView = function () { return DXUtility.getDXInstance(null, '#commonTreeView_treeView', 'dxTreeView'); }

    var treeViewOptions = {
        onItemClick: function (e) {
            $(".dx-treeview-item").removeClass("desktop-commonTreeView-focusedItem");
            $(e.itemElement).addClass("desktop-commonTreeView-focusedItem");

            e.component.selectedItem = e.itemData;
            events.itemClick(e);
        }
    };



    var commonTreeView_showLoadingPanel = function () {
        var panel = commonTreeView_loadingPanel();
        if (panel)
            panel.option('visible', true);
    };

    var commonTreeView_hideLoadingPanel = function () {
        var panel = commonTreeView_loadingPanel();
        if (panel)
            panel.option('visible', false);
    };



    return {
        events: events,

        loadingPanel: commonTreeView_loadingPanel,
        showLoadingPanel: commonTreeView_showLoadingPanel,
        hideLoadingPanel: commonTreeView_hideLoadingPanel,
        loadingPanelOptions: commonTreeView_loadingPanelOptions,

        search: search,
        searchOptions: searchOptions,

        treeView: treeView,
        treeViewOptions: treeViewOptions
    };
};
