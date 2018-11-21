
Dismoyo_Ciptoning_Client.CommonPopupIFrame = function () {
    var events = {
        performOK: function (rootView) {
            rootView.commonPopupIFrame.popupEditOptions.visible(false);
        },
        performCancel: function (rootView) {
            rootView.commonPopupIFrame.popupEditOptions.visible(false);
        }
    };

    var popupEdit = function () { return DXUtility.getDXInstance(null, '#commonPopupIFrame_popupEdit', 'dxPopup'); }

    var popupEditOptions = {
        deferRendering: false,
        showTitle: true,
        title: 'Title',
        fullScreen: true,
        disabled: ko.observable(false),
        visible: ko.observable(false)
    };

    var validationGroup = function () { return DXUtility.getDXInstance(null, '#commonPopupIFrame_validationGroup', 'dxValidationGroup'); }

    var iframe = function () { return $('#commonPopupIFrame_iframe'); }

    var loadingPanel = function () { return DXUtility.getDXInstance(null, '#commonPopupIFrame_loadingPanel', 'dxLoadPanel'); }

    var showLoadingPanel = function () {
        var panel = loadingPanel();
        if (panel)
            panel.option('visible', true);
    };

    var hideLoadingPanel = function () {
        var panel = loadingPanel();
        if (panel)
            panel.option('visible', false);
    };

    var ok = function () { return DXUtility.getDXInstance(null, '#commonPopupIFrame_ok', 'dxButton'); }

    var okOptions = {
        text: 'OK', type: 'apply',
        onClick: function () { events.performOK(this); }
    };

    var cancel = function () { return DXUtility.getDXInstance(null, '#commonPopupIFrame_cancel', 'dxButton'); }

    var cancelOptions = {
        text: 'Cancel',
        onClick: function () { events.performCancel(this); }
    };

    return {
        events: events,

        popupEdit: popupEdit,
        popupEditOptions: popupEditOptions,

        popupEditData: ko.observable(),

        validationGroup: validationGroup,

        showLoadingPanel: showLoadingPanel,
        hideLoadingPanel: hideLoadingPanel,

        loadingPanel: loadingPanel,
        iframe: iframe,
                
        ok: ok,
        okOptions: okOptions,

        cancel: cancel,
        cancelOptions: cancelOptions
    };
};
