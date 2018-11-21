using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace Dismoyo.Ciptoning.Web.Services
{

    public class MultipartParser
    {

        #region Properties

        public bool Success { get; private set; }
        public string ContentType { get; private set; }
        public string Filename { get; private set; }
        public byte[] FileContents { get; private set; }

        #endregion

        #region Methods

        public MultipartParser(Stream stream)
        {
            Parse(stream, Encoding.UTF8);
        }

        public MultipartParser(Stream stream, Encoding encoding)
        {
            Parse(stream, encoding);
        }

        private void Parse(Stream stream, Encoding encoding)
        {
            Success = false;

            byte[] data = ToByteArray(stream);
            string content = encoding.GetString(data);
            int delimiterEndIndex = content.IndexOf("\r\n");

            if (delimiterEndIndex > -1)
            {
                string delimiter = content.Substring(0, content.IndexOf("\r\n"));
                Regex regex = new Regex(@"(?<=Content\-Type:)(.*?)(?=\r\n\r\n)");
                Match contentTypeMatch = regex.Match(content);

                regex = new Regex(@"(?<=filename\=\"")(.*?)(?=\"")");
                Match fileNameMatch = regex.Match(content);

                if (contentTypeMatch.Success && fileNameMatch.Success)
                {
                    ContentType = contentTypeMatch.Value.Trim();
                    Filename = fileNameMatch.Value.Trim();
                    int startIndex = contentTypeMatch.Index + contentTypeMatch.Length + "\r\n\r\n".Length;

                    byte[] delimiterBytes = encoding.GetBytes("\r\n" + delimiter);
                    int endIndex = IndexOf(data, delimiterBytes, startIndex);

                    int contentLength = endIndex - startIndex;
                    byte[] fileData = new byte[contentLength];

                    Buffer.BlockCopy(data, startIndex, fileData, 0, contentLength);

                    FileContents = fileData;
                    Success = true;
                }
            }
        }

        private int IndexOf(byte[] searchWithin, byte[] serachFor, int startIndex)
        {
            int index = 0;
            int startPos = Array.IndexOf(searchWithin, serachFor[0], startIndex);

            if (startPos != -1)
            {
                while ((startPos + index) < searchWithin.Length)
                {
                    if (searchWithin[startPos + index] == serachFor[index])
                    {
                        index++;
                        if (index == serachFor.Length)
                            return startPos;
                    }
                    else
                    {
                        startPos = Array.IndexOf<byte>(searchWithin, serachFor[0], startPos + index);
                        if (startPos == -1)
                            return -1;

                        index = 0;
                    }
                }
            }

            return -1;
        }

        private byte[] ToByteArray(Stream stream)
        {
            byte[] buffer = new byte[32768];
            using (MemoryStream ms = new MemoryStream())
            {
                while (true)
                {
                    int read = stream.Read(buffer, 0, buffer.Length);
                    if (read <= 0)
                        return ms.ToArray();

                    ms.Write(buffer, 0, read);
                }
            }
        }

        #endregion

    }

}
