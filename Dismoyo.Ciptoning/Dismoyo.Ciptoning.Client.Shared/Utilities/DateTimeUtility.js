// ------------------------------------------------------------------------------------------------
// DateTimeUtility: A class for supporting the DateTime programming.
// ------------------------------------------------------------------------------------------------


// DateTimeUtility class definition.
var DateTimeUtility = function () {
}

// Get minimum date.
DateTimeUtility.minDate = function () {
    return Date.UTC(1900, 1, 1, 0, 0, 0, 0);
}

// Get maximum date.
DateTimeUtility.maxDate = function () {
    return Date.UTC(9999, 12, 31, 23, 59, 59, 999);
}

// Function to convert from UTC date to local date.
DateTimeUtility.convertToLocal = function (utcDate) {
    try {
        //var localDate = moment(utcDate);

        //return moment.toDate();
        //return utcDate;
        return new Date(utcDate.toLocaleString() + " UTC");
    } catch (e) {
        return utcDate;
    }
}

DateTimeUtility.getFormatedDate = function (value) {
    var formattedDate = new Date(value);
    var d = formattedDate.getDate();
    var m = formattedDate.getMonth();
    m += 1;  // JavaScript months are 0-11
    var y = formattedDate.getFullYear();

    return (d + "/" + m + "/" + y);
}

// Function to get first time of day of the specified date.
DateTimeUtility.getFirstTimeOfDay = function (date) {
    var d = new Date(date);
    d.setHours(0, 0, 0, 0);

    return d;
}

// Function to get last time of day of the specified date.
DateTimeUtility.getLastTimeOfDay = function (date) {
    var d = new Date(date);
    d.setHours(23, 59, 59, 999);

    return d;
}

// Function to get first day of month of the specified date.
DateTimeUtility.getFirstDayOfMonth = function (date) {
    return new Date(date.getFullYear(), date.getMonth(), 1);
}

// Function to get last day of month of the specified date.
DateTimeUtility.getLastDayOfMonth = function (date) {
    return DateTimeUtility.getLastTimeOfDay(
        new Date(date.getFullYear(), date.getMonth() + 1, 0));
}

DateTimeUtility.getISODateString = function (date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();

    return year + '-' + ((month < 10) ? '0' : '') + month + '-' + ((day < 10) ? '0' : '') + day;
}
