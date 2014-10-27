namespace FunBookMobile.Cloud.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public class Link
    {
        private ICollection<Tag> tags;
        private ICollection<View> views;
        private ICollection<Comment> comments;

        public Link()
        {
            this.Id = Guid.NewGuid();

            this.tags = new HashSet<Tag>();
            this.views = new HashSet<View>();
            this.comments = new HashSet<Comment>();

            this.Created = DateTime.Now;
        }

        public Guid Id { get; set; }
        
        [Required]
        public string URL { get; set; }

        [MinLength(3)]
        [Required]
        public string Title { get; set; }

        //user id
        [Required]
        public string UserId { get; set; }

        public virtual User User { get; set; }

        // should the owner of this content be visible to other users or not
        public bool IsAnonymous { get; set; }

        public int CategoryId { get; set; }

        public virtual Category Category { get; set; }

        public DateTime Created { get; set; }

        public virtual ICollection<Tag> Tags
        {
            get { return this.tags; }
            set { this.tags = value; }
        }

        public virtual ICollection<View> Views
        {
            get { return this.views; }
            set { this.views = value; }
        }

        public virtual ICollection<Comment> Comments
        {
            get { return this.comments; }
            set { this.comments = value; }
        }
    }
}
