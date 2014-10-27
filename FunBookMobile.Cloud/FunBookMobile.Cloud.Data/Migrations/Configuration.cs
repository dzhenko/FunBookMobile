namespace FunBookMobile.Cloud.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    using System.Linq;

    using FunBookMobile.Cloud.Data.Seeders;

    internal sealed class Configuration : DbMigrationsConfiguration<FunBookDbContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.AutomaticMigrationDataLossAllowed = true;
        }

        protected override void Seed(FunBookDbContext context)
        {
            if (!context.Users.Any())
            {
                (new UsersGenerator()).Generate(context);
            }

            if (!context.Jokes.Any())
            {
                (new JokesGenerator()).Generate(context);
            }

            if (!context.Links.Any())
            {
                (new LinksGenerator()).Generate(context);
            }

            if (!context.Pictures.Any())
            {
                (new PicturesGenerator()).Generate(context);
            }
        }
    }
}
