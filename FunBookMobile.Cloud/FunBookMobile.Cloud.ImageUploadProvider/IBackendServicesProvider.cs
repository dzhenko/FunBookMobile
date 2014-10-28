namespace FunBookMobile.Cloud.ImageUploadProvider
{
    using System.IO;

    public interface IBackendServicesProvider
    {
        string UrlFromBase64Image(string base64, string category, string[] tags);

        string UrlFromBase64Image(MemoryStream stream, string category, string[] tags);
    }
}
