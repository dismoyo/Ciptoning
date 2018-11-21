using System.Drawing;

namespace Dismoyo.Utilities
{
    
    public class ImageUtility
    {

        #region Methods

        public static Image ResizeImageZoom(Image image, int width, int height)
        {
            double factor = (double)width / (double)image.Width;
            if ((image.Height * factor) > (double)height)
                factor = (double)height / (double)image.Height;

            Size size = new Size((int)((double)image.Width * factor), (int)((double)image.Height * factor));
            return new Bitmap(image, size.Width, size.Height);
        }

        #endregion

    }

}
