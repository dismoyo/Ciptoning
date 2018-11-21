$(document).ready(function () {
    $('body').layout({ applyDefaultStyles: true });// define a handler
});

DevExpress.data.utils.odata.keyConverters.DateTime = function (value) {
    var str = '';
    if (value instanceof Date)
        str = value.getFullYear() + '-' +
             ('0' + (value.getMonth() + 1)).slice(-2) + '-' +
             ('0' + value.getDate()).slice(-2);

    return new DevExpress.data.EdmLiteral('datetime\'' + str + '\'');
}

function keyboardShortcut(e) {
    if (e.altKey && e.ctrlKey && e.which == 78) {
        // Alt + Ctrl + n : new row
        if ($("#commonGridView_newRow").length > 0) {
            if ($("#commonGridView_newRow").attr("aria-disabled") != "true" && !$("#commonGridView_newRow").hasClass("dx-state-invisible"))
                $("#commonGridView_newRow").trigger("click");
        }
    } else if (e.altKey && e.ctrlKey && e.which == 83) {
        // Alt + Ctrl + s : Save
        if ($("#commonPopupEdit_ok").length > 0) {
            if ($("#commonPopupEdit_ok").attr("aria-disabled") != "true" && !$("#commonPopupEdit_popupEdit").hasClass("dx-state-invisible"))
                $("#commonPopupEdit_ok").trigger("click");
        }
    } else if (e.altKey && e.ctrlKey && e.which == 80) {
        // Alt + Ctrl + p : Post
        if ($("[id$=Post]").length > 0) {
            if ($("[id$=Post]").attr("aria-disabled") != "true" && !$("#commonPopupEdit_popupEdit").hasClass("dx-state-invisible"))
                $("[id$=Post]").trigger("click");
        }
    } else if (e.altKey && e.ctrlKey && e.which == 68) {
        // Alt + Ctrl + d : Discard
        if ($("[id$=Discard]").length > 0) {
            if ($("[id$=Discard]").attr("aria-disabled") != "true" && !$("#commonPopupEdit_popupEdit").hasClass("dx-state-invisible"))
                $("[id$=Discard]").trigger("click");
        }
    } else if (e.altKey && e.ctrlKey && e.which == 86) {
        // Alt + Ctrl + v : Void
        if ($("[id$=Void]").length > 0) {
            if ($("[id$=Void]").attr("aria-disabled") != "true" && !$("#commonPopupEdit_popupEdit").hasClass("dx-state-invisible"))
                $("[id$=Void]").trigger("click");
        }
    } else if (e.altKey && e.ctrlKey && e.which == 65) {
        // Alt + Ctrl + a : New
        if ($("[id$=NewRow]").length > 0) {
            if ($("[id$=NewRow]").attr("aria-disabled") != "true" && !$("#commonPopupEdit_popupEdit").hasClass("dx-state-invisible")) {
                $("input", "#commonPopupEdit_form").first().focus();
                $("[id$=NewRow]").trigger("click");
            }
        }
    }
}
// register the handler 
document.addEventListener('keyup', keyboardShortcut, false);

$(function () {
    var startupView = 'Login';
    DevExpress.devices.current('desktop');

    Dismoyo_Ciptoning_Client.app = new DevExpress.framework.html.HtmlApplication({
        namespace: Dismoyo_Ciptoning_Client,
        layoutSet: DevExpress.framework.html.layoutSets[Dismoyo_Ciptoning_Client.config.layoutSet],
        animationSet: DevExpress.framework.html.animationSets[Dismoyo_Ciptoning_Client.config.animationSet],
        mode: 'webSite',
        navigation: Dismoyo_Ciptoning_Client.config.navigation,
        commandMapping: Dismoyo_Ciptoning_Client.config.commandMapping,
        navigateToRootViewMode: 'keepHistory',
        disableViewCache: true,
        useViewTitleAsBackText: true
    });

    Dismoyo_Ciptoning_Client.app.on('navigating', function (args) {
        if (!Dismoyo_Ciptoning_Client.app.getViewTemplateInfo(args.uri))
            args.uri = 'Home';
    });

    Dismoyo_Ciptoning_Client.app.on('viewShown', function (args) {
        document.title = ko.unwrap(args.viewInfo.model.title) || 'IDOS 2.0';
    });

    $(window).unload(function () {
        Dismoyo_Ciptoning_Client.app.saveState();
    });

    Dismoyo_Ciptoning_Client.app.router.register(':view/:id', { view: startupView, id: undefined });
    Dismoyo_Ciptoning_Client.app.navigate();
});
