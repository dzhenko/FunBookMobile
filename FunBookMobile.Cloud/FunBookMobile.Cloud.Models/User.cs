namespace FunBookMobile.Cloud.Models
{
    using System;
    using System.Collections.Generic;
    using System.Security.Claims;
    using System.Threading.Tasks;
    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;

    public class User : IdentityUser
    {
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<User> manager, string authenticationType)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, authenticationType);
            // Add custom user claims here
            return userIdentity;
        }

        private ICollection<View> views;
        private ICollection<Comment> comments;
        private ICollection<Joke> jokes;
        private ICollection<Link> links;
        private ICollection<Picture> pictures;

        public User()
            : base()
        {
            this.views = new HashSet<View>();
            this.comments = new HashSet<Comment>();
            this.jokes = new HashSet<Joke>();
            this.links = new HashSet<Link>();
            this.pictures = new HashSet<Picture>();
        }

        public virtual ICollection<View> Views { get { return this.views; } set { this.views = value; } }

        public virtual ICollection<Comment> Comments { get { return this.comments; } set { this.comments = value; } }

        public virtual ICollection<Joke> Jokes { get { return this.jokes; } set { this.jokes = value; } }

        public virtual ICollection<Link> Links { get { return this.links; } set { this.links = value; } }

        public virtual ICollection<Picture> Pictures { get { return this.pictures; } set { this.pictures = value; } }

    }
}
