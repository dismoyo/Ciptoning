using System;
using System.Globalization;

namespace Dismoyo.Utilities
{

    public static class ConversionUtility
    {

        #region Methods

        public static DateTime? ToLocalNullableDateTime(DateTime? value)
        {
            return ToLocalNullableDateTime(value, null);
        }

        public static DateTime ToLocalDateTime(DateTime value)
        {
            return ToLocalDateTime(value, null);
        }

        public static DateTime? ToLocalNullableDateTime(DateTime? value, double? timeZoneOffset)
        {
            if (value.HasValue)
                return ToLocalDateTime(value.Value, timeZoneOffset);

            return null;
        }

        public static DateTime ToLocalDateTime(DateTime value, double? timeZoneOffset)
        {
            if (!timeZoneOffset.HasValue)
                timeZoneOffset = TimeZoneInfo.Local.BaseUtcOffset.TotalMinutes;

            if (value.Kind != DateTimeKind.Local)
                return DateTime.SpecifyKind(value.AddMinutes(timeZoneOffset.Value * -1d), DateTimeKind.Local);

            return value;
        }


        public static DateTime? ToUtcNullableDateTime(DateTime? value)
        {
            return ToUtcNullableDateTime(value, null);
        }

        public static DateTime ToUtcDateTime(DateTime value)
        {
            return ToUtcDateTime(value, null);
        }

        public static DateTime? ToUtcNullableDateTime(DateTime? value, double? timeZoneOffset)
        {
            if (value.HasValue)
                return ToUtcDateTime(value.Value, timeZoneOffset);

            return null;
        }

        public static DateTime ToUtcDateTime(DateTime value, double? timeZoneOffset)
        {
            if (!timeZoneOffset.HasValue)
                timeZoneOffset = TimeZoneInfo.Local.BaseUtcOffset.TotalMinutes;

            if (value.Kind != DateTimeKind.Utc)
                return DateTime.SpecifyKind(value.AddMinutes(timeZoneOffset.Value), DateTimeKind.Utc);

            return value;
        }


        public static DateTime ToFirstTimeOfDay(DateTime value)
        {
            return new DateTime(new DateTime(value.Year, value.Month, value.Day).Ticks, value.Kind);
        }

        public static DateTime ToLastTimeOfDay(DateTime value)
        {
            return new DateTime(new DateTime(value.Year, value.Month, value.Day).AddDays(1).AddMilliseconds(-3).Ticks,
                value.Kind);
        }

        public static DateTime ToFirstDayOfMonth(DateTime value)
        {
            return new DateTime(new DateTime(value.Year, value.Month, 1).Ticks, value.Kind);
        }

        public static DateTime ToLastDayOfMonth(DateTime value)
        {
            return ToLastTimeOfDay(new DateTime(new DateTime(value.Year, value.Month, DateTime.DaysInMonth(value.Year,
                value.Month)).Ticks, value.Kind));
        }


        public static string ToString(object value)
        {
            if (value == null)
                return null;

            if (value is DateTime)
                return ((DateTime)value).ToString("o");
            else if (value is DateTime?)
                return ((DateTime?)value).Value.ToString("o");
            else if (value is DateTimeOffset)
                return ((DateTimeOffset)value).ToString("o");
            else if (value is DateTimeOffset?)
                return ((DateTimeOffset?)value).Value.ToString("o");
            else if (value is TimeSpan)
                return ((TimeSpan)value).ToString("c");
            else if (value is TimeSpan?)
                return ((TimeSpan?)value).Value.ToString("c");

            return value.ToString();
        }

        public static object FromString(Type valueType, string value)
        {
            if (valueType == typeof(string))
                return value;

            if (string.IsNullOrEmpty(value))
            {
                if (valueType == typeof(bool?)) return (bool?)null;
                if (valueType == typeof(byte?)) return (byte?)null;
                if (valueType == typeof(short?)) return (short?)null;
                if (valueType == typeof(int?)) return (int?)null;
                if (valueType == typeof(long?)) return (long?)null;
                if (valueType == typeof(float?)) return (float?)null;
                if (valueType == typeof(double?)) return (double?)null;
                if (valueType == typeof(decimal?)) return (decimal?)null;
                if (valueType == typeof(DateTime?)) return (DateTime?)null;
                if (valueType == typeof(DateTimeOffset?)) return (DateTimeOffset?)null;
                if (valueType == typeof(TimeSpan?)) return (TimeSpan?)null;
                if (valueType == typeof(Guid?)) return (Guid?)null;
            }

            object val = null;

            if ((valueType == typeof(bool)) || (valueType == typeof(bool?))) val = bool.Parse(value);
            if ((valueType == typeof(byte)) || (valueType == typeof(byte?))) val = byte.Parse(value);
            if ((valueType == typeof(short)) || (valueType == typeof(short?))) val = short.Parse(value);
            if ((valueType == typeof(int)) || (valueType == typeof(int?))) val = int.Parse(value);
            if ((valueType == typeof(long)) || (valueType == typeof(long?))) val = long.Parse(value);
            if ((valueType == typeof(float)) || (valueType == typeof(float?))) val = float.Parse(value);
            if ((valueType == typeof(double)) || (valueType == typeof(double?))) val = double.Parse(value);
            if ((valueType == typeof(decimal)) || (valueType == typeof(decimal?))) val = decimal.Parse(value);
            if ((valueType == typeof(DateTime)) || (valueType == typeof(DateTime?))) val = DateTime.Parse(value, null, DateTimeStyles.RoundtripKind);
            if ((valueType == typeof(DateTimeOffset)) || (valueType == typeof(DateTimeOffset?))) val = DateTimeOffset.Parse(value, null, DateTimeStyles.RoundtripKind);
            if ((valueType == typeof(TimeSpan)) || (valueType == typeof(TimeSpan?))) val = TimeSpan.Parse(value);
            if ((valueType == typeof(Guid)) || (valueType == typeof(Guid?))) val = Guid.Parse(value);

            if (valueType == typeof(bool?)) val = (bool?)val;
            if (valueType == typeof(byte?)) val = (byte?)val;
            if (valueType == typeof(short?)) val = (short?)val;
            if (valueType == typeof(int?)) val = (int?)val;
            if (valueType == typeof(long?)) val = (long?)val;
            if (valueType == typeof(float?)) val = (float?)val;
            if (valueType == typeof(double?)) val = (double?)val;
            if (valueType == typeof(decimal?)) val = (decimal?)val;
            if (valueType == typeof(DateTime?)) val = (DateTime?)val;
            if (valueType == typeof(DateTimeOffset?)) val = (DateTimeOffset?)val;
            if (valueType == typeof(TimeSpan?)) val = (TimeSpan?)val;
            if (valueType == typeof(Guid?)) val = (Guid?)val;

            return val;
        }

        #endregion

    }

}
