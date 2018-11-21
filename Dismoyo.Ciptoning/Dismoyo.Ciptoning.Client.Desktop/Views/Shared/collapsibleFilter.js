
Dismoyo_Ciptoning_Client.CollapsibleFilter = function () {
    var events = {
        performSearch: function () { },
        performClear: function () {
            var items = form().option('items');
            for (var i in items) {
                if (items[i].itemType) {
                    if (items[i].itemType == "group") {
                        var subItems = items[i].items;
                        for (var j in subItems) {
                            var editor = form().getEditor(subItems[j].dataField);
                            if (editor)
                                editor.option('value', null);
                        }
                    }
                } else {
                    var editor = form().getEditor(items[i].dataField);
                    if (editor)
                        editor.option('value', null);
                }
            }

            events.performSearch();
        }
    };

    var filter = function () { return DXUtility.getDXInstance(null, '#collapsibleFilter_filter', 'dxAccordion'); }

    var filterOptions = {
        dataSource: [{ title: 'Filter' }],
        itemTemplate: 'content',
        collapsible: true,
        multiple: true,
        focusStateEnabled: false,
        onItemTitleClick: DXUtility.fixAccordionItemTitleClick,
        onItemClick: DXUtility.fixAccordionItemClick
    };

    var form = function () { return DXUtility.getDXInstance(null, '#collapsibleFilter_form', 'dxForm'); }

    var formOptions = {
        colCount: 3,
        showColonAfterLabel: false,
        labelLocation: 'top',
        onEnterKey: function () { events.performSearch(); }
    };

    var search = function () { return DXUtility.getDXInstance(null, '#collapsibleFilter_search', 'dxButton'); }

    var searchOptions = {
        text: 'Search', icon: 'search', type: 'apply',
        onClick: function () { events.performSearch(); }
    };

    var clear = function () { return DXUtility.getDXInstance(null, '#collapsibleFilter_clear', 'dxButton'); }

    var clearOptions = {
        text: 'Clear',
        onClick: function () { events.performClear(); }
    };

    return {
        events: events,

        filter: filter,
        filterOptions: filterOptions,

        form: form,
        formOptions: formOptions,

        search: search,
        searchOptions: searchOptions,

        clear: clear,
        clearOptions: clearOptions
    };
};
