namespace FunBook.WebForms.DataGenerators
{
    using System;
    using System.Linq;

    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;

    using FunBook.Data;
    using FunBook.Models;
    using FunBook.WebForms.Account;

    using System;
    using System.Linq;
    using System.Web;
    using System.Web.UI;
    using FunBook.Models;
    using FunBook.WebForms.Providers;
    using Microsoft.Owin;
    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.Owin;
    using System.IO;

    public class UsersGenerator : IDataGenerator
    {
        public void Generate(FunBookDbContext context)
        {
            var userManager = new UserManager(new UserStore<User>(context));

            userManager.Create(new User() { UserName = "admin@admin.com", Email = "admin@admin.com" }, "qwerty");

            userManager.Create(new User() { UserName = "qwe@qwe.com", Email = "qwe@qwe.com" }, "qweqwe");

            // add users like that .. min password length = 6 !
        }
    }
}
