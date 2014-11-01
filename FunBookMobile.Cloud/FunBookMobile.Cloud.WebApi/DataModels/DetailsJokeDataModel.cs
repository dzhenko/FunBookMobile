namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Linq.Expressions;

    using FunBookMobile.Cloud.Models;

    public class DetailsJokeDataModel
    {
        public static Expression<Func<Joke, DetailsJokeDataModel>> FromJoke
        {
            get
            {
                return j => new DetailsJokeDataModel()
                {
                    Id = j.Id.ToString(),
                    Text = j.Text,
                    Title = j.Title,
                    Created = j.Created.ToString(),
                    Creator = j.IsAnonymous ? "Anonymous" : j.User.UserName,
                    Likes = j.Views.Count(v => v.Liked == true),
                    Hates = j.Views.Count(v => v.Liked == false),
                    Views = j.Views.Count(),
                    Comments = j.Comments.AsQueryable().Select(CommentDataModel.FromComment)
                };
            }
        }

        public string Id { get; set; }

        public string Text { get; set; }

        public string Title { get; set; }

        public string Created { get; set; }

        public string Creator { get; set; }

        public int Likes { get; set; }

        public int Hates { get; set; }

        public int Views { get; set; }

        public IEnumerable<CommentDataModel> Comments { get; set; }
    }
}