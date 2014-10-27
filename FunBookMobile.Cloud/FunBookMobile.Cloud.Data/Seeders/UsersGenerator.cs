namespace FunBookMobile.Cloud.Data.Seeders
{
    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;

    using FunBookMobile.Cloud.Models;

    public class UsersGenerator : IDataGenerator
    {
        public void Generate(FunBookDbContext context)
        {
            var userManager = new UserManager<User>(new UserStore<User>(context));

            userManager.Create(new User() { UserName = "admin@admin.com", Email = "admin@admin.com" }, "qwerty");
        }
    }
}
