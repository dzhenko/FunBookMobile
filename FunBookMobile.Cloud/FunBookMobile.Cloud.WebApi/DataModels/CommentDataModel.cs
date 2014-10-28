namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.Linq.Expressions;

    using FunBookMobile.Cloud.Models;

    public class CommentDataModel
    {
        public static Expression<Func<Comment, CommentDataModel>> FromComment
        {
            get
            {
                return c => new CommentDataModel()
                {
                    Text = c.Text,
                    Created = c.Created,
                    User = c.User.UserName
                };
            }
        }

        public string User { get; set; }

        public string Text { get; set; }

        public DateTime Created { get; set; }
    }
}