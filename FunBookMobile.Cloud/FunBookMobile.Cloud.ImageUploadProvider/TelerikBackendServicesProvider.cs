namespace FunBookMobile.Cloud.ImageUploadProvider
{
    using System;
    using System.Collections.Generic;
    using System.IO;

    using Telerik.Everlive.Sdk.Core;
    using Telerik.Everlive.Sdk.Core.Query.Definition.FormData;

    public class TelerikBackendServicesProvider
    {
        private const string EverliveAppKey = "yTpcS8cIlRXlVS2a";
        
        private EverliveApp app;

        public TelerikBackendServicesProvider()
        {
            app = new EverliveApp(EverliveAppKey);
        }

        public static string DefaultUrl
        {
            get
            {
                return "http://api.everlive.com/v1/yTpcS8cIlRXlVS2a/Files/730fbdc0-53f2-11e4-b2b7-0f2a33946566/Download";
            }
        }

        public string UrlFromBase64Image(string base64, string category, string[] tags)
        {
            var filename = string.Format("{0}#{1}#{2}", category, string.Join(" ", tags), Guid.NewGuid());

            var stream = new MemoryStream(Convert.FromBase64String(base64));

            var uploadResult = app.WorkWith().Files().Upload(new FileField("fieldName", filename, "image/jpeg", stream)).ExecuteSync();

            var url = app.WorkWith().Files().GetFileDownloadUrl(uploadResult.Id);

            return url;
        }

        public string UrlFromBase64Image(MemoryStream stream, string category, string[] tags)
        {
            var filename = string.Format("{0}#{1}#{2}", category, string.Join(" ", tags), Guid.NewGuid());

            var uploadResult = app.WorkWith().Files().Upload(new FileField("fieldName", filename, "image/jpeg", stream)).ExecuteSync();

            var url = app.WorkWith().Files().GetFileDownloadUrl(uploadResult.Id);

            return url;
        }

        public List<Tuple<string, string>> GetUploadedFiles()
        {
            var allFiles = app.WorkWith().Files().GetAll().ExecuteSync();

            var list = new List<Tuple<string, string>>();

            foreach (var file in allFiles)
            {
                list.Add(new Tuple<string, string>(file.Filename, app.WorkWith().Files().GetFileDownloadUrl(file.Id)));
            }

            return list;
        }
    }
}
