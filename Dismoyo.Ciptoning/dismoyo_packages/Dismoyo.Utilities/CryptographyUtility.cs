using System;
using System.Security.Cryptography;
using System.Text;

namespace Dismoyo.Utilities
{

    public static class CryptographyUtility
    {

        #region Constants

        public const string Salt = "Jakarta02Apr2009";

        #endregion

        #region Methods

        public static string GetSaltedHash(string code)
        {
            HashAlgorithm hasher = new SHA1CryptoServiceProvider();
            return Convert.ToBase64String(hasher.ComputeHash(Encoding.UTF8.GetBytes(code + Salt)));
        }

        #endregion

    }

}
