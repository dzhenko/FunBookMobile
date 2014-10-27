namespace FunBookMobile.Cloud.Data
{
    using System;
    using System.Linq;

    using FunBookMobile.Cloud.Data.Repositories;
    using FunBookMobile.Cloud.Models;

    public interface IFunBookData
    {
        IRepository<Joke> Jokes { get; }

        IRepository<Picture> Pictures { get; }

        IRepository<Link> Links { get; }

        IRepository<Tag> Tags { get; }

        IRepository<Comment> Comments { get; }

        IRepository<View> Views { get; }

        IRepository<Category> Categories { get; }

        IRepository<User> Users { get; }

        void SaveChanges();
    }
}
