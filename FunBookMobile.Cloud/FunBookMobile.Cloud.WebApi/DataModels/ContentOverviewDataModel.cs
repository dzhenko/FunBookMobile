namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.Linq.Expressions;
    using FunBookMobile.Cloud.Models;

    public class ContentOverviewDataModel
    {
        public static Expression<Func<Joke, ContentOverviewDataModel>> FromJoke
        {
            get
            {
                return j => new ContentOverviewDataModel()
                {
                    Id = j.Id.ToString(),
                    Title = j.Title,
                    Content = j.Text,
                    Date = j.Created
                };
            }
        }

        public static Expression<Func<Link, ContentOverviewDataModel>> FromLink
        {
            get
            {
                return l => new ContentOverviewDataModel()
                {
                    Id = l.Id.ToString(),
                    Title = l.Title,
                    Content = l.URL,
                    Date = l.Created
                };
            }
        }

        public static Expression<Func<Picture, ContentOverviewDataModel>> FromPicture
        {
            get
            {
                return p => new ContentOverviewDataModel()
                {
                    Id = p.Id.ToString(),
                    Title = p.Title,
                    Content = p.UrlPath,
                    Date = p.Created
                };
            }
        }

        public string Id { get; set; }

        public string Title { get; set; }

        public string Content { get; set; }

        public DateTime Date { get; set; }
    }
}