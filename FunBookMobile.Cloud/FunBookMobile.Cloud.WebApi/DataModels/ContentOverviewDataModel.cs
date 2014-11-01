namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.Linq;
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
                    Views = j.Views.Count(),
                    Date = j.Created.ToString(),
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
                    Views = l.Views.Count(),
                    Date = l.Created.ToString(),
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
                    Views = p.Views.Count(),
                    Date = p.Created.ToString()
                };
            }
        }

        public string Id { get; set; }

        public string Title { get; set; }

        public int Views { get; set; }

        public string Content { get; set; }

        public string Date { get; set; }
    }
}