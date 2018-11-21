
Dismoyo_Ciptoning_Client.CommonIFrame = function () {
    var events = {        
    };

    var iframe = function () { return $('#commonIFrame_iframe'); }

    var loadingPanel = function () { return DXUtility.getDXInstance(null, '#commonIFrame_loadingPanel', 'dxLoadPanel'); }

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

    return {
        events: events,

        showLoadingPanel: showLoadingPanel,
        hideLoadingPanel: hideLoadingPanel,

        loadingPanel: loadingPanel,
        iframe: iframe
    };
};
