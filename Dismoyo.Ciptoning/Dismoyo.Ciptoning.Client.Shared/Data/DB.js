
(function () {
    var isWinJS = 'WinJS' in window;
    var endpointSelector = new DevExpress.EndpointSelector(Dismoyo_Ciptoning_Client.config.endpoints);
    var serviceConfig = $.extend(true, {}, Dismoyo_Ciptoning_Client.config.services, {
        CommonService: {
            url: endpointSelector.urlFor('CommonService'),

            // To enable JSONP support, uncomment the following line
            //jsonp: !isWinJS,

            // To allow cookies and HTTP authentication with CORS, uncomment the following line
            //withCredentials: true,

            errorHandler: handleServiceError,
            beforeSend: handleServiceRequest
        },
        FileService: {
            url: endpointSelector.urlFor('FileService'),

            // To enable JSONP support, uncomment the following line
            //jsonp: !isWinJS,

            // To allow cookies and HTTP authentication with CORS, uncomment the following line
            //withCredentials: true,

            errorHandler: handleServiceError,
            beforeSend: handleServiceRequest
        },
        DataService: {
            url: endpointSelector.urlFor('DataService'),

            // To enable JSONP support, uncomment the following line
            //jsonp: !isWinJS,

            // To allow cookies and HTTP authentication with CORS, uncomment the following line
            //withCredentials: true,

            errorHandler: handleServiceError,
            beforeSend: handleServiceRequest
        },
        ReportWebsite: {
            url: endpointSelector.urlFor('ReportWebsite')
        }
    });

    function handleServiceError(error) {
        var isHandled = false;
        if (!isHandled) {
            switch (error.httpStatus) {
                case 0:                    
                    DevExpress.ui.dialog.alert('Failed to connect to the server. Please check your internet connection.\n' +
                        'If the problems still exists, please contact your administrator.',
                        'Connection Failed')
                        .done(function (dialogResult) {
                            lastErrorMessage = '';
                        });
                    isHandled = true;
                    break;
                case 401:                    
                    Dismoyo_Ciptoning_Client.app.navigate(Dismoyo_Ciptoning_Client.app.router.format({ view: 'Login' }));
                    return;
            }
        }

        if (!isHandled) {
            if (isWinJS) {
                try {
                    new Windows.UI.Popups.MessageDialog(error.message).showAsync();
                } catch (e) {
                    // Another dialog is shown
                }
            } else {
                // added by Asep
                // show message error as dialog when screen has a popup
                var popup = $('.dx-popup-fullscreen');
                if (popup.length > 0) {
                    DevExpress.ui.dialog.alert(error.message, 'Operation Failed')
                        .done(function (dialogResult) {
                            //-----------------
                        });
                    return;
                }
                //alert(error.message);
            }
        }

        hideLoadingPanel();        
    }

    function handleServiceRequest(options) {
        options.timeout = 300000; // milliseconds

        if (options.method == 'MERGE' || options.method == 'DELETE') {
            options.headers['X-HTTP-Method'] = options.method;
            options.method = 'POST';
        }

        var userName = '';
        var password = '';

        if (CommonUtility.validateLoggedInUser()) {
            var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
            userName = user.Name();
            password = user.Password();
        }

        if (options.params && !options.params.$inlinecount)
            options.headers['Accept'] = 'application/json;odata=minimalmetadata;';

        options.headers['Authorization'] = 'Basic ' + DevExpress.data.base64_encode([userName, password].join(':'));
    }

    // Enable partial CORS support for IE < 10    
    $.support.cors = true;

    Dismoyo_Ciptoning_Client.CommonService = serviceConfig.CommonService;
    Dismoyo_Ciptoning_Client.FileService = serviceConfig.FileService;
    Dismoyo_Ciptoning_Client.DB = new DevExpress.data.ODataContext(serviceConfig.DataService);
    Dismoyo_Ciptoning_Client.ReportWebsite = serviceConfig.ReportWebsite;
}());
