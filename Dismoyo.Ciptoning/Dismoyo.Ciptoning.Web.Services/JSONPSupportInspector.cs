using System;
using System.Globalization;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.ServiceModel.Dispatcher;
using System.Text;
using System.Xml;

namespace Dismoyo.Ciptoning.Web.Services
{

    public class JSONPSupportInspector : IDispatchMessageInspector
    {

        #region Constants

        private static readonly Encoding encoding = Encoding.UTF8;

        #endregion

        #region Classes

        class Writer : BodyWriter
        {

            #region Fields

            private string content;

            #endregion

            #region Constructors

            public Writer(string content)
                : base(false)
            {
                this.content = content;
            }

            #endregion

            #region Methods

            protected override void OnWriteBodyContents(XmlDictionaryWriter writer)
            {
                writer.WriteStartElement("Binary");

                byte[] buffer = JSONPSupportInspector.encoding.GetBytes(this.content);
                writer.WriteBase64(buffer, 0, buffer.Length);
                writer.WriteEndElement();
            }

            #endregion

        }

        #endregion


        #region IDispatchMessageInspector Members

        public object AfterReceiveRequest(ref Message request, IClientChannel channel, InstanceContext instanceContext)
        {
            if (request.Properties.ContainsKey("UriTemplateMatchResults"))
            {
                HttpRequestMessageProperty httpmsg = (HttpRequestMessageProperty)request.Properties[HttpRequestMessageProperty.Name];
                UriTemplateMatch match = (UriTemplateMatch)request.Properties["UriTemplateMatchResults"];

                string format = match.QueryParameters["$format"];
                if (!string.IsNullOrEmpty(format) && format.Equals("json", StringComparison.OrdinalIgnoreCase))
                {
                    match.QueryParameters.Remove("$format");

                    httpmsg.Headers["Accept"] = "application/json, text/plain; q=0.5, application/json; odata=verbose";
                    httpmsg.Headers["Accept-Charset"] = "utf-8";

                    string callback = match.QueryParameters["$callback"];
                    if (!string.IsNullOrEmpty(callback))
                    {
                        match.QueryParameters.Remove("$callback");
                        return callback;
                    }
                }
            }

            return null;
        }

        public void BeforeSendReply(ref Message reply, object correlationState)
        {
            if ((correlationState != null) && (correlationState is string))
            {
                string callback = (string)correlationState;

                bool bodyIsText = false;
                HttpResponseMessageProperty response = (HttpResponseMessageProperty)reply.Properties[HttpResponseMessageProperty.Name];
                if (response != null)
                {
                    string contentType = response.Headers["Content-Type"];
                    if (contentType != null)
                    {
                        if (contentType.StartsWith("text/plain", StringComparison.OrdinalIgnoreCase))
                        {
                            bodyIsText = true;
                            response.Headers["Content-Type"] = "text/javascript; charset=utf-8";
                        }
                        else if (contentType.StartsWith("application/json", StringComparison.OrdinalIgnoreCase))
                            response.Headers["Content-Type"] = contentType.Replace("application/json", "text/javascript");
                    }
                }

                XmlDictionaryReader reader = reply.GetReaderAtBodyContents();
                reader.ReadStartElement();

                string content = JSONPSupportInspector.encoding.GetString(reader.ReadContentAsBase64());
                if (bodyIsText)
                    content = "\"" + QuoteJScriptString(content) + "\"";

                content = callback + "(" + content + ")";

                Message newreply = Message.CreateMessage(MessageVersion.None, "", new Writer(content));
                newreply.Properties.CopyProperties(reply.Properties);

                reply = newreply;
            }
        }


        private static string QuoteJScriptString(string s)
        {
            if (string.IsNullOrEmpty(s))
                return "";

            StringBuilder builder = null;
            int startIndex = 0;
            int count = 0;
            for (int i = 0; i < s.Length; i++)
            {
                char ch = s[i];
                if (((((ch == '\r') || (ch == '\t')) || ((ch == '"') || (ch == '\\'))) || (((ch == '\n') ||
                    (ch < ' ')) || ((ch > '\x007f') || (ch == '\b')))) || (ch == '\f'))
                {
                    if (builder == null)
                        builder = new StringBuilder(s.Length + 6);

                    if (count > 0)
                        builder.Append(s, startIndex, count);

                    startIndex = i + 1;
                    count = 0;
                }

                switch (ch)
                {
                    case '\b':
                        builder.Append(@"\b");
                        break;
                    case '\t':
                        builder.Append(@"\t");
                        break;
                    case '\n':
                        builder.Append(@"\n");
                        break;
                    case '\f':
                        builder.Append(@"\f");
                        break;
                    case '\r':
                        builder.Append(@"\r");
                        break;
                    case '"':
                        builder.Append("\\\"");
                        break;
                    case '\\':
                        builder.Append(@"\\");
                        break;
                    default:
                        if ((ch < ' ') || (ch > '\x007f'))
                            builder.AppendFormat(CultureInfo.InvariantCulture, @"\u{0:x4}", (int)ch);
                        else
                            count++;

                        break;
                }
            }

            string result;
            if (builder == null)
                result = s;
            else
            {
                if (count > 0)
                    builder.Append(s, startIndex, count);

                result = builder.ToString();
            }

            return result;
        }

        #endregion
        
    }

}
