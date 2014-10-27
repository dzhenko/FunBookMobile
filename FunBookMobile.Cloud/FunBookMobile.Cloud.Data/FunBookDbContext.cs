namespace FunBookMobile.Cloud.Data
{
    using System;
    using System.Data.Entity;
    using System.Linq;

    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;

    using FunBookMobile.Cloud.Models;
    using FunBookMobile.Cloud.Data.Migrations;

    public class FunBookDbContext : IdentityDbContext<User>
    {
        public FunBookDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
            Database.SetInitializer<FunBookDbContext>(new MigrateDatabaseToLatestVersion<FunBookDbContext, Configuration>());
        }

        public static FunBookDbContext Create()
        {
            return new FunBookDbContext();
        }

        public IDbSet<Joke> Jokes { get; set; }

        public IDbSet<Picture> Pictures { get; set; }

        public IDbSet<Link> Links { get; set; }

        public IDbSet<View> Views { get; set; }

        public IDbSet<Tag> Tags { get; set; }

        public IDbSet<Comment> Comments { get; set; }

        public IDbSet<Category> Categories { get; set; }
    }
}
