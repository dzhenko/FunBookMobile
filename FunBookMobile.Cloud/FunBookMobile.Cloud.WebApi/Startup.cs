using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(FunBookMobile.Cloud.WebApi.Startup))]

namespace FunBookMobile.Cloud.WebApi
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);

            // used to seed data at runtime
            FunBookMobile.Cloud.Data.FunBookData.Create().Jokes.All().Any();
        }
    }
}
