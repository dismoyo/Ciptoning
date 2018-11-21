
function documentViewer_initViewer(s, e) {
    var reportPreview = s.GetPreviewModel().reportPreview;
    var currentExportOptions = reportPreview.exportOptionsModel;
    var optionsUpdating = false;
    var fixExportOptions = function (options) {
        try {
            optionsUpdating = true;
            if (!options)
                currentExportOptions(null);
            else {
                delete options["xls"];
                delete options["rtf"];
                delete options["mht"];
                delete options["html"];
                delete options["textExportOptions"];
                delete options["image"];
                currentExportOptions(options);
            }
        } finally {
            optionsUpdating = false;
        }
    };

    currentExportOptions.subscribe(function (newValue) { !optionsUpdating && fixExportOptions(newValue); });
    fixExportOptions(currentExportOptions());
}
