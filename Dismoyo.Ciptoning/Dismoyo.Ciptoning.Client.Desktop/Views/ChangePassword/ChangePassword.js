
Dismoyo_Ciptoning_Client.ChangePassword = function () {
    var intrvl;

    var events = {
        performSave: function () {
            var editForm = form();
                        
            var isValid = editForm.validate().isValid;
            var errorMsg = (isValid) ? '' : 'Please specify the required fields.';

            var user = Dismoyo_Ciptoning_Client.app.CurrentUser;
            var oldPassword = editForm.getEditor('OldPassword').option('value');
            if (isValid) {
                if (oldPassword != user.Password()) {
                    errorMsg = 'Old Password is incorrect.';
                    isValid = false;
                }
            }

            if (isValid) {
                var changePassword = {
                    ID: user.ID(),
                    Password: editForm.getEditor('NewPassword').option('value')
                };

                Dismoyo_Ciptoning_Client.DB.ChangePasswords.update(changePassword.ID, changePassword)
                    .done(function (result) {
                        DevExpress.ui.dialog.alert('Password has been successfully changed. System will navigate to the Sign In page.',
                            'Change Password Succeed');
                        popupOptions.visible(false);

                        CommonUtility.clearCookie('CurrentUser');
                        Dismoyo_Ciptoning_Client.app.navigate(Dismoyo_Ciptoning_Client.app.router.format({ view: 'Login' }));
                    }).fail(function (error) {
                        DevExpress.ui.dialog.alert(error.message, 'Change Password Failed');
                    });
            }

            if (errorMsg != '') {
                DevExpress.ui.dialog.alert(HtmlUtility.htmlEncode(errorMsg), 'Change Password Failed');
            }
        },
        performCancel: function () {
            popupOptions.visible(false);
        }
    };

    var popup = function () { return DXUtility.getDXInstance(null, '#ChangePassword_popup', 'dxPopup'); }

    var popupOptions = {
        showTitle: true,
        width: 400,
        height: 230,
        title: 'Change Password',
        visible: ko.observable(false)
    };

    var popupContent = function () { return DXUtility.getDXInstance(null, '#ChangePassword_popupContent', 'dxScrollView'); }

    var popupContentOptions = {
        scrollByContent: true,
        scrollByThumb: true
    };

    var form = function () { return DXUtility.getDXInstance(null, '#ChangePassword_form', 'dxForm'); }

    var formOptions = {
        colCount: 3,
        showColonAfterLabel: false,
        labelLocation: 'left',
        onEnterKey: function () { events.performSearch(); },
        items: [
            {
                dataField: 'OldPassword',
                validationRules: [{ type: 'required' }],
                label: { text: 'Old Password' },
                colSpan: 3,
                editorOptions: {
                    mode: 'password',
                    maxLength: 64,
                    onEnterKey: function () { events.performSave(); }
                }
            }, {
                dataField: 'NewPassword',
                validationRules: [{ type: 'required' }],
                label: { text: 'NewPassword' },
                colSpan: 3,
                editorOptions: {
                    mode: 'password',
                    maxLength: 64,
                    onEnterKey: function () { events.performSave(); }
                }
            }, {
                dataField: 'ConfirmNewPassword',
                validationRules: [{
                    type: 'required'
                }, {
                    type: 'custom',
                    validationCallback: function (options) {
                        var newPassword = form().getEditor('NewPassword').option('value');
                        if (options.value != newPassword) {
                            options.rule.message = 'Confirm New Password is not match with New Password.';
                            return false;
                        }
                        
                        return true;
                    }
                }],
                label: { text: 'Confirm New Password' },
                colSpan: 3,
                editorOptions: {
                    mode: 'password',
                    maxLength: 64,
                    onEnterKey: function () { events.performSave(); }
                }
            }
        ]
    };

    var save = function () { return DXUtility.getDXInstance(null, '#ChangePassword_save', 'dxButton'); }

    var saveOptions = {
        text: 'Save', type: 'apply',
        onClick: function () { events.performSave(); }
    };

    var cancel = function () { return DXUtility.getDXInstance(null, '#ChangePassword_cancel', 'dxButton'); }

    var cancelOptions = {
        text: 'Cancel',
        onClick: function () { events.performCancel(); }
    };

    return {
        events: events,

        popup: popup,
        popupOptions: popupOptions,

        popupData: ko.observable(),

        popupContent: popupContent,
        popupContentOptions: popupContentOptions,

        form: form,
        formOptions: formOptions,

        save: save,
        saveOptions: saveOptions,

        cancel: cancel,
        cancelOptions: cancelOptions,
    };
};
