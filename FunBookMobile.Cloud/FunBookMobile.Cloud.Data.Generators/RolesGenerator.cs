namespace FunBook.WebForms.DataGenerators
{
    using System;
    using System.Linq;

    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;

    using FunBook.Data;
    using FunBook.Models;

    public class RolesGenerator : IDataGenerator
    {
        public void Generate(FunBookDbContext context)
        {
            const string roleName = "admin";

            var userStore = new UserStore<User>(context);
            var userManager = new UserManager<User>(userStore);

            var roleStore = new RoleStore<IdentityRole>(context);
            var roleManager = new RoleManager<IdentityRole>(roleStore);

            var userIds = context.Users.Select(u => u.Id).ToList();

            roleManager.Create(new Microsoft.AspNet.Identity.EntityFramework.IdentityRole() { Name = roleName });

            foreach (var userId in userIds)
            {
                userManager.AddToRole(userId, roleName);
            }
        }
    }
}
