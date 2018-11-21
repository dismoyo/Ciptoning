
Dismoyo_Ciptoning_Client.CommonPopupEdit = function () {
    var events = {
        performOK: function (rootView) {
            rootView.commonPopupEdit.popupEditOptions.visible(false);
        },
        performCancel: function (rootView) {
            rootView.commonPopupEdit.popupEditOptions.visible(false);
        }
    };

    var popupEdit = function () { return DXUtility.getDXInstance(null, '#commonPopupEdit_popupEdit', 'dxPopup'); }

    var popupEditOptions = {
        deferRendering: false,
        editingKey: null,
        showTitle: true,
        title: 'Title',
        fullScreen: true,
        disabled: ko.observable(false),
        visible: ko.observable(false)
    };

    var validationGroup = function () { return DXUtility.getDXInstance(null, '#commonPopupEdit_validationGroup', 'dxValidationGroup'); }

    var popupContent = function () { return DXUtility.getDXInstance(null, '#commonPopupEdit_popupContent', 'dxScrollView'); }

    var popupContentOptions = {
        scrollByContent: true,
        scrollByThumb: true
    };

    var form = function () { return DXUtility.getDXInstance(null, '#commonPopupEdit_form', 'dxForm'); }

    var formOptions = {
        colCount: 3,
        showColonAfterLabel: false,
        labelLocation: 'left',
        onEnterKey: function () { events.performSearch(); }
    };

    var extContent = function () { return $('#commonPopupEdit_extContent'); }

    var ok = function () { return DXUtility.getDXInstance(null, '#commonPopupEdit_ok', 'dxButton'); }

    var okOptions = {
        text: 'OK', type: 'apply',
        onClick: function () { events.performOK(this); }
    };

    var cancel = function () { return DXUtility.getDXInstance(null, '#commonPopupEdit_cancel', 'dxButton'); }

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

        popupContent: popupContent,
        popupContentOptions: popupContentOptions,

        form: form,
        formOptions: formOptions,

        extContent: extContent,

        ok: ok,
        okOptions: okOptions,

        cancel: cancel,
        cancelOptions: cancelOptions
    };
};
