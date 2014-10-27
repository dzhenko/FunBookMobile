namespace FunBookMobile.Cloud.Models
{
    using System.Collections.Generic;

    public class Category
    {
        private ICollection<Joke> jokes;
        private ICollection<Link> links;
        private ICollection<Picture> pictures;

        public Category()
        {
            this.jokes = new HashSet<Joke>();
            this.links = new HashSet<Link>();
            this.pictures = new HashSet<Picture>();
        }

        public int Id { get; set; }

        public string Name { get; set; }

        public virtual ICollection<Joke> Jokes
        {
            get { return this.jokes; }
            set { this.jokes = value; }
        }

        public virtual ICollection<Link> Links
        {
            get { return this.links; }
            set { this.links = value; }
        }

        public virtual ICollection<Picture> Pictures
        {
            get { return this.pictures; }
            set { this.pictures = value; }
        }
    }
}
