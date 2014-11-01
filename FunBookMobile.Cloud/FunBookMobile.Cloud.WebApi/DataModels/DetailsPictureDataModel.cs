namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Linq.Expressions;

    using FunBookMobile.Cloud.Models;

    public class DetailsPictureDataModel
    {
        public static Expression<Func<Picture, DetailsPictureDataModel>> FromPicture
        {
            get
            {
                return p => new DetailsPictureDataModel()
                {
                    Id = p.Id.ToString(),
                    Url = p.UrlPath,
                    Title = p.Title,
                    Created = p.Created.ToString(),
                    Creator = p.IsAnonymous ? "Anonymous" : p.User.UserName,
                    Likes = p.Views.Count(v => v.Liked == true),
                    Hates = p.Views.Count(v => v.Liked == false),
                    Views = p.Views.Count(),
                    Comments = p.Comments.AsQueryable().Select(CommentDataModel.FromComment)
                };
            }
        }

        public string Id { get; set; }

        public string Url { get; set; }

        public string Title { get; set; }

        public string Created { get; set; }

        public string Creator { get; set; }

        public int Likes { get; set; }

        public int Hates { get; set; }

        public int Views { get; set; }

        public IEnumerable<CommentDataModel> Comments { get; set; }
    }
}