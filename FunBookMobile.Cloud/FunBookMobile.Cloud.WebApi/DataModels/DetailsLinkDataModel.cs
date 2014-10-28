namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Linq.Expressions;

    using FunBookMobile.Cloud.Models;

    public class DetailsLinkDataModel
    {
        public static Expression<Func<Link, DetailsLinkDataModel>> FromLink
        {
            get
            {
                return l => new DetailsLinkDataModel()
                {
                    Id = l.Id.ToString(),
                    Url = l.URL,
                    Title = l.Title,
                    Created = l.Created,
                    Creator = l.IsAnonymous ? "Anonymous" : l.User.UserName,
                    Likes = l.Views.Count(v => v.Liked == true),
                    Hates = l.Views.Count(v => v.Liked == false),
                    Views = l.Views.Count(),
                    Comments = l.Comments.AsQueryable().Select(CommentDataModel.FromComment)
                };
            }
        }

        public string Id { get; set; }

        public string Url { get; set; }

        public string Title { get; set; }

        public DateTime Created { get; set; }

        public string Creator { get; set; }

        public int Likes { get; set; }

        public int Hates { get; set; }

        public int Views { get; set; }

        public IEnumerable<CommentDataModel> Comments { get; set; }
    }
}