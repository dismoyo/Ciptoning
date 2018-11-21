$(function() {
    var startupView = "About";

    // Uncomment the line below to disable platform-specific look and feel and to use the Generic theme for all devices
    // DevExpress.devices.current({ platform: "generic" });

    if(DevExpress.devices.real().platform === "win") {
        $("body").css("background-color", "#000");
    }

    var isDeviceReady = false,
        isViewShown = false;

    function hideSplashScreen() {
        if(isDeviceReady && isViewShown) {
            navigator.splashscreen.hide();
        }
    }

    $(document).on("deviceready", function() {
        isDeviceReady = true;
        hideSplashScreen();
        $(document).on("backbutton", function () {
            DevExpress.processHardwareBackButton();
        });
    });

    function onViewShown() {
        isViewShown = true;
        hideSplashScreen();
        Dismoyo_Ciptoning_Client.app.off("viewShown", onViewShown);
    }

    function onNavigatingBack(e) {
        if(e.isHardwareButton && !Dismoyo_Ciptoning_Client.app.canBack()) {
            e.cancel = true;
            exitApp();
        }
    }

    function exitApp() {
        switch (DevExpress.devices.real().platform) {
            case "android":
                navigator.app.exitApp();
                break;
            case "win":
                MSApp.terminateApp('');
                break;
        }
    }

    var layoutSet = DevExpress.framework.html.layoutSets[Dismoyo_Ciptoning_Client.config.layoutSet],
        navigation = Dismoyo_Ciptoning_Client.config.navigation;


    Dismoyo_Ciptoning_Client.app = new DevExpress.framework.html.HtmlApplication({
        namespace: Dismoyo_Ciptoning_Client,
        layoutSet: layoutSet,
        animationSet: DevExpress.framework.html.animationSets[Dismoyo_Ciptoning_Client.config.animationSet],
        navigation: navigation,
        commandMapping: Dismoyo_Ciptoning_Client.config.commandMapping,
        navigateToRootViewMode: "keepHistory",
        useViewTitleAsBackText: true
    });

    $(window).on("unload", function() {
        Dismoyo_Ciptoning_Client.app.saveState();
    });

    Dismoyo_Ciptoning_Client.app.router.register(":view/:id", { view: startupView, id: undefined });
    Dismoyo_Ciptoning_Client.app.on("viewShown", onViewShown);
    Dismoyo_Ciptoning_Client.app.on("navigatingBack", onNavigatingBack);
    Dismoyo_Ciptoning_Client.app.navigate();
});