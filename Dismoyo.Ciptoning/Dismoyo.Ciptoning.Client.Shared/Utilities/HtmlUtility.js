// ------------------------------------------------------------------------------------------------
// HtmlUtility: A class for supporting the Html programming.
// ------------------------------------------------------------------------------------------------


// HtmlUtility class definition.
var HtmlUtility = function () {
}


// Dynamic load scripts.
HtmlUtility.loadScriptFile = function (fileName, filetype) {
    var scripts = document.getElementsByTagName('script');
    for (var i = scripts.length - 1; i >= 0; i--) {
        if (scripts[i].src.indexOf(fileName) >= 0)
            return;
    }

    var fileref = undefined;

    switch (filetype) {
        case 'js':
            fileref = document.createElement('script');
            fileref.setAttribute('type', 'text/javascript');
            fileref.setAttribute('src', fileName);
            break;
        case 'css':
            fileref = document.createElement('link');
            fileref.setAttribute('rel', 'stylesheet');
            fileref.setAttribute('type', 'text/css');
            fileref.setAttribute('href', fileName);
            break;
    }

    if (typeof fileref != undefined)
        document.getElementsByTagName('head')[0].appendChild(fileref)
}

// Function to encode string to html.
HtmlUtility.htmlEncode = function (value) {
    return $('<div/>').text(value).html()
        .replace(new RegExp('"', 'g'), '&quot;')
        .replace(new RegExp('\'', 'g'), '&#39;');
}

// Function to decode html to string.
HtmlUtility.htmlDecode = function (value) {
    return $('<div/>').html(value).text()
        .replace(new RegExp('&quot;', 'g'), '"')
        .replace(new RegExp('&#39;', 'g'), '\'');
}
