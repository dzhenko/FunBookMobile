namespace FunBookMobile.Cloud.Data
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    using FunBookMobile.Cloud.Data.Repositories;
    using FunBookMobile.Cloud.Models;

    public class FunBookData : IFunBookData
    {
        private FunBookDbContext context;
        private IDictionary<Type, object> repositories;

        public static FunBookData Create()
        {
            return new FunBookData();
        }

        public FunBookData(FunBookDbContext context)
        {
            this.context = context;
            this.repositories = new Dictionary<Type, object>();
        }

        public FunBookData()
            : this(new FunBookDbContext())
        {
        }

        public IRepository<Joke> Jokes
        {
            get
            {
                return this.GetRepository<Joke>();
            }
        }

        public IRepository<Picture> Pictures
        {
            get
            {
                return this.GetRepository<Picture>();
            }
        }

        public IRepository<Link> Links
        {
            get
            {
                return this.GetRepository<Link>();
            }
        }

        public IRepository<Tag> Tags
        {
            get
            {
                return this.GetRepository<Tag>();
            }
        }

        public IRepository<Comment> Comments
        {
            get
            {
                return this.GetRepository<Comment>();
            }
        }

        public IRepository<View> Views
        {
            get
            {
                return this.GetRepository<View>();
            }
        }

        public IRepository<Category> Categories
        {
            get
            {
                return this.GetRepository<Category>();
            }
        }

        public IRepository<User> Users
        {
            get
            {
                return this.GetRepository<User>();
            }
        }

        public void SaveChanges()
        {
            try
            {
                this.context.SaveChanges();
            }
            catch (Exception)
            {

            }
        }

        private IRepository<T> GetRepository<T>() where T : class
        {
            var typeOfModel = typeof(T);

            if (!this.repositories.ContainsKey(typeOfModel))
            {
                this.repositories.Add(typeOfModel, Activator.CreateInstance(typeof(EFRepository<T>), this.context));
            }

            return (IRepository<T>)this.repositories[typeOfModel];
        }
    }
}
