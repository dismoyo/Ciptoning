Dismoyo_Ciptoning_Client.Login = function (params, viewInfo) {
    'use strict';

    var shouldReload = false;
    var openCreateViewAsRoot = viewInfo.layoutController.name === 'split';
    var isReady = $.Deferred();

    function checkContainer() {
        if ($('#Login_controls').is(':visible')) {
            var pane = $('#Login_viewContent').layout({
                name: 'LoginViewContent',
                center: {
                    paneSelector: '#Login_viewSubContent',
                    spacing_open: 0,
                    spacing_closed: 0,
                    onresize: function (pane, $Pane, state) {
                        var gallery = DXUtility.getDXInstance($Pane, '#Login_gallery', 'dxGallery');
                        if (gallery) {
                            gallery.option('width', $Pane.width());
                            gallery.option('height', $Pane.height());
                        }
                    }
                },
                east: {
                    paneSelector: '#Login_controls',
                    size: 350,
                    resizable: false,
                    spacing_open: 0,
                    spacing_closed: 0
                }
            });

            pane.resizeAll();
        }
        else
            setTimeout(Login_checkContainer, 50);
    }

    function handleViewShowing() {
        checkContainer();
                
        $('#headerWelcome').text('');
        headerMenu().option('visible', false);

        desktopPane().hide('west');
    }



    function performLogin() {
        var form = loginForm();
        var isValid = form.validate().isValid;

        if (isValid) {
            showLoadingPanel();

            var user = new Dismoyo_Ciptoning_Client.vUserViewModel();
            user.Name(form.getEditor('UserName').option('value'));
            user.Password(form.getEditor('Password').option('value'));

            var dataSource = new DevExpress.data.DataSource({
                store: Dismoyo_Ciptoning_Client.DB.vUsers,
                filter: ['Name', '=', user.Name()],
                expand: 'ChildPermissions',
                map: function (item) { return new Dismoyo_Ciptoning_Client.vUserViewModel(item); }
            });

            CommonUtility.setJsonCookie('CurrentUser', user.toJS(), 7);
            dataSource.load()
                .done(function (result) {
                    if (result.length > 0) {
                        var data = result[0];
                        var childPermissions = data.toJS().ChildPermissions;

                        data.Password(user.Password());                        
                        data.ChildPermissions(undefined);

                        CommonUtility.setJsonCookie('CurrentUser', data.toJS(), 7);

                        var currentPermissionsJS = JSON.stringify(childPermissions);
                        if ((currentPermissionsJS == undefined) || (currentPermissionsJS == null))
                            currentPermissionsJS = '';

                        var currentPermissionsJSLength = Math.ceil(currentPermissionsJS.length / 2048);
                        
                        CommonUtility.setCookie('CurrentUserPermissionsLength', currentPermissionsJSLength, 7);
                        for (var i = 0; i < currentPermissionsJSLength; i++) {
                            var start = i * 2048;
                            var end = start + 2048;
                            if (end >= currentPermissionsJS.length)
                                end = currentPermissionsJS.length;

                            var value = currentPermissionsJS.substring(start, end);
                            CommonUtility.setCookie('CurrentUserPermissions' + (i + 1).toString(), value, 7);
                        }
                        
                        var menu = headerMenu();
                        var menuItems = menu.option('items');
                        menuItems[0].iconSrc = 'Images/user_notification_empty_32px.png';
                        menu.option('items', menuItems);

                        // Load system data to local store.
                        Dismoyo_Ciptoning_Client.LocalStore.loadAllData();                        
                        Dismoyo_Ciptoning_Client.app.navigate(Dismoyo_Ciptoning_Client.app.router.format({ view: 'Home' }));
                    } else {
                        DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode('Invalid user name or password'), 'Login Failed');
                        CommonUtility.clearCookie('CurrentUser');
                    }

                    hideLoadingPanel();
                })
                .fail(function (error) {
                    DevExpress.ui.dialog.alert(error.message, 'Login Failed');
                    CommonUtility.clearCookie('CurrentUser');

                    hideLoadingPanel();
                });
        }
    };





    var gallery = function () { return DXUtility.getDXInstance(null, '#Login_gallery', 'dxGallery'); }

    var galleryOptions = {
        //dataSource: Dismoyo_Ciptoning_Client.LocalStore.vSystemParameters.galleryImages(),
        dataSource: ['Galleries/1.jpg', 'Galleries/2.jpg', 'Galleries/3.jpg'],
        height: '100%',
        stretchImages: true,
        slideshowDelay: 3000,
        loop: true,
        showNavButtons: true,
        showIndicator: true
    };

    var loginForm = function () { return DXUtility.getDXInstance(null, '#Login_form', 'dxForm'); }

    var loginFormOptions = {
        colCount: 1,
        showColonAfterLabel: false,
        labelLocation: 'left',
        onEnterKey: function () {
            performLogin();
        },
        items: [{
            itemType: 'group',
            caption: 'Sign In',
            colCount: 3,
            items: [{
                dataField: 'UserName',
                validationRules: [{ type: 'required' }],
                label: { text: 'User Name' },
                colSpan: 3,
                editorOptions: {
                    maxLength: 256,
                    onEnterKey: function () { performLogin(); }
                }
            }, {
                dataField: 'Password',
                validationRules: [{ type: 'required' }],
                label: { text: 'Password' },
                colSpan: 3,
                editorOptions: {
                    mode: 'password',
                    maxLength: 64,
                    onEnterKey: function () { performLogin(); }
                }
            }]
        }]
    };

    var submit = function () {
        return DXUtility.getDXInstance(null, '#Login_submit', 'dxButton');
    }

    var submitOptions = {
        text: 'Sign In', width: '120px', type: 'default',
        onClick: function () { performLogin(); }
    };



    return {
        isReady: isReady.promise(),
        viewShowing: handleViewShowing,
        openCreateViewAsRoot: openCreateViewAsRoot,


        // ------------------------------------------------------------------------------------------------
        // Register Public Properties/Methods
        // ------------------------------------------------------------------------------------------------

        icon: 'Images/territory_32px.png',

        gallery: gallery,
        galleryOptions: galleryOptions,
        loginForm: loginForm,
        loginFormOptions: loginFormOptions,
        submit: submit,
        submitOptions: submitOptions
    };
};
