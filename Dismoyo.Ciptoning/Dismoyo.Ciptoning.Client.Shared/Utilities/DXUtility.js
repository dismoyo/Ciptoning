// ------------------------------------------------------------------------------------------------
// DXUtility: A class for supporting the DevExtreme control programming.
// ------------------------------------------------------------------------------------------------


// DXUtility class definition.
var DXUtility = function () {
}


// Function to retrieve an instance of DevExtreme control.
DXUtility.getDXInstance = function (parent, id, dxType) {
    var instance = null;
    try {
        var ctl = (parent) ? parent.find(id) : $(id);
        instance = ctl[dxType]('instance');
    }
    catch (ex) {
    }

    return instance;
}


// Event handler for fix accordion item title click.
DXUtility.fixAccordionItemTitleClick = function (e) {
    if (e.component.option('selectedIndex') == 0)
        e.component.collapseItem(0);
    else
        e.component.expandItem(0);

    e.jQueryEvent.stopPropagation();
}

// Event handler for fix accordion item click.
DXUtility.fixAccordionItemClick = function (e) {
    e.component.expandItem(0);
    e.jQueryEvent.stopPropagation();
}


// Refresh child items when parent value has changed (will return child zero list if parent value is null).
DXUtility.childSelectBoxCascadeDataSourceRefreshList = function (childSelectBox, childDataSource, parentField, parentValue) {
    childSelectBox.option('value', null);

    childSelectBox.option('dataSource', (parentValue ? childDataSource : []));
    var dataSource = childSelectBox.option('dataSource');
    if (parentValue) {
        dataSource.filter([parentField, '=', parentValue]);
        dataSource.load();
    }
}

// Refresh child items when parent value has changed.
DXUtility.childSelectBoxCascadeRefreshList = function (childSelectBox, parentField, parentValue) {
    childSelectBox.option('value', null);

    var dataSource = childSelectBox.option('dataSource');
    dataSource.filter(parentValue ? [parentField, '=', parentValue] : null);
    dataSource.load();
}

// Get child data grid lookup cascade filter.
DXUtility.getChildDataGridLookupCascadeFilter = function (data, parentField) {
    var filter = null;
    if (data && data[parentField])
        filter = [parentField, '=', DXUtility.getValue(data, parentField)];

    return filter;
}

// Add filter expression by specified group filter.
DXUtility.addGroupFilterExpression = function (filterExpr, groupFiterExpr, groupExpr) {
    if (groupFiterExpr && (groupFiterExpr.length > 0)) {
        if (filterExpr.length > 0)
            filterExpr.push(groupExpr);

        filterExpr.push(groupFiterExpr);
    }
}

// Add filter expression by specified field name, operator, and value.
DXUtility.addFilterExpression = function (filterExpr, fieldName, operator, value, groupExpr) {
    if ((value !== undefined) && (value !== null))
        DXUtility.addNullableFilterExpression(filterExpr, fieldName, operator, value, groupExpr);
}

// Add filter expression by specified field name, operator, and value.
DXUtility.addNullableFilterExpression = function (filterExpr, fieldName, operator, value, groupExpr) {
    if (filterExpr.length > 0)
        filterExpr.push(groupExpr);

    filterExpr.push([fieldName, operator, value]);
}


// Create dxForm item group with caption.
DXUtility.createFormItemGroupWithCaption = function (caption, marginBottom) {
    var style = '';
    if (marginBottom)
        style = ' style="margin-bottom:' + marginBottom + '"';

    var div = $('<div class="dx-form-group-with-caption dx-form-group"' + style + '>');
    if (caption)
        div.append($('<span class="dx-form-group-caption">').append(
            HtmlUtility.htmlEncode(caption)));

    return div;
}

// Create dxForm item group with content.
DXUtility.createFormItemGroupContent = function () {
    return $('<div class="dx-form-group-content">');
}

// Create dxForm item label located on top.
DXUtility.createFormItemLabelTop = function (caption) {
    return $('<label class="dx-field-item-label dx-field-item-label-location-top">').append(
        DXUtility.createFormItemLabelContent(caption));
}

// Create dxForm item label content.
DXUtility.createFormItemLabelContent = function (caption) {
    return $('<span class="dx-field-item-label-content">').append(
        $('<span class="dx-field-item-label-text">').append(
        HtmlUtility.htmlEncode(caption)));
}

// Reset dxForm validation.
DXUtility.resetFormValidation = function (form) {
    $.each(form.element().find('.dx-validator'), function (index, item) {
        $(item).dxValidator('instance').reset();
    });
}

// Get tree view selected items.
DXUtility.getSelectedTreeViewItems = function (items, selectedItems) {
    if (items) {
        for (var i = 0; i < items.length; i++) {
            if (items[i].selected)
                selectedItems.push(items[i]);

            DXUtility.getSelectedTreeViewItems(items[i].items, selectedItems);
        }
    }
}

// Set tree view selected items.
DXUtility.setSelectedTreeViewItems = function (items, selectedItems) {
    if (items) {
        for (var i = 0; i < items.length; i++) {
            var item = $.grep(selectedItems, function (e) {
                return (e.key == items[i].key);
            });

            items[i].selected = (item.length > 0) ? true : false;
            DXUtility.setSelectedTreeViewItems(items[i].items, selectedItems);
        }
    }
}



// Get value from property (direct or function (observable)).
DXUtility.getValue = function (obj, propertyName) {
    if ((obj[propertyName] != undefined) && (obj[propertyName] != null))
        return (typeof (obj[propertyName]) == 'function') ? obj[propertyName]() : obj[propertyName];

    return undefined;
}

// Set value to property (direct or function (observable)).
DXUtility.setValue = function (obj, propertyName, value) {
    if ((obj[propertyName] != undefined) && (obj[propertyName] != null) && (typeof (obj[propertyName]) == 'function')) {
        obj[propertyName](value);
        return;
    }

    obj[propertyName] = value;
}

// Select all text on input element.
DXUtility.selectAllText = function (element, dxType) {
    switch (dxType) {
        case 'dxTextBox':
            element.find('.dx-texteditor-input').select();
            break;
    }
}

DXUtility.preventInputCharacters = function (e) {
    if ((e.jQueryEvent.keyCode >= 48) && (e.jQueryEvent.keyCode <= 57)) {
        // do nothing
    } else if (e.jQueryEvent.keyCode != 8 && e.jQueryEvent.keyCode != 46 && e.jQueryEvent.keyCode != 13 && e.jQueryEvent.keyCode != 9) {
        e.jQueryEvent.preventDefault();
    }
}

DXUtility.deleteSelectedRows = function (dataGrid,parentGrid) {
    var dataSource = dataGrid.option('dataSource');
    var selectedKeys = dataGrid.getSelectedRowKeys();

    for (var i = 0; i < selectedKeys.length; i++) {
        dataSource.store().remove(selectedKeys[i])
            .done(function (result) {
                if (i >= (selectedKeys.length - 1))
                    dataSource.load().done(function (result) {
                        dataGrid.refresh();
                        if (parentGrid)
                            parentGrid.dataGrid().refresh();
                    });
            })
            .fail(function (error) {
                if (i >= (selectedKeys.length - 1))
                    dataSource.load().done(function (result) {
                        dataGrid.refresh();
                        if (parentGrid)
                            parentGrid.dataGrid().refresh();
                    });
            });
    }
}
