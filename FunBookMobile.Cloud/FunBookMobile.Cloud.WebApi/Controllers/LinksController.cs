namespace FunBookMobile.Cloud.WebApi.Controllers
{
    using System;
    using System.Linq;
    using System.Text.RegularExpressions;
    using System.Web.Http;
    using System.Web.Http.Cors;

    using Microsoft.AspNet.Identity;

    using FunBookMobile.Cloud.Models;
    using FunBookMobile.Cloud.WebApi.DataModels;

    //[Authorize]
    [EnableCors("*", "*", "*")]
    public class LinksController : BaseApiController
    {
        [HttpPost]
        public IHttpActionResult Create([FromBody]NewLinkDataModel model)
        {
            if (!ModelState.IsValid)
            {
                return this.BadRequest(ModelState);
            }

            var category = this.Data.Categories.All().FirstOrDefault(c => c.Name == model.Category);

            if (category == null)
            {
                return this.BadRequest("Invalid category");
            }

            var tags = Regex.Split(model.Title, @"\W+").Where(tag => tag.Length > 2);

            var link = new Link()
            {
                CategoryId = category.Id,
                Created = DateTime.Now,
                IsAnonymous = model.IsAnonymous,
                URL = model.URL,
                Title = model.Title,
                UserId = this.User.Identity.GetUserId()
            };

            //TODO: Remove after restoring authorize attribute
            if (link.UserId == null)
            {
                link.UserId = "3b7aca9e-bd08-4eae-b62e-d81a7d387957";
            }

            this.Data.Links.Add(link);

            foreach (var tagName in tags)
            {
                var tag = this.Data.Tags.All().FirstOrDefault(t => t.Name == tagName);
                if (tag == null)
                {
                    tag = new Tag() { Name = tagName };
                    this.Data.Tags.Add(tag);
                }

                tag.Links.Add(link);
            }

            this.Data.SaveChanges();

            return this.Ok(JsonResultWrapper.Create(link.Id));
        }

        [HttpGet]
        public IHttpActionResult Details(Guid id)
        {
            var link = this.Data.Links.Find(id);

            if (link == null)
            {
                return this.BadRequest("Invalid id");
            }

            var userId = this.User.Identity.GetUserId();

            if (!link.Views.Any(v => v.UserId == userId))
            {
                link.Views.Add(new View() { UserId = userId });
                this.Data.Links.Update(link);
                this.Data.SaveChanges();
            }

            return this.Ok(JsonResultWrapper.Create(
                this.Data.Links.All().Where(l => l.Id == id).Select(DetailsLinkDataModel.FromLink).FirstOrDefault()));
        }

        [HttpPost]
        public IHttpActionResult Comment([FromBody]NewCommentDataModel model)
        {
            if (!ModelState.IsValid)
            {
                return this.BadRequest(ModelState);
            }
            var link = this.Data.Links.Find(model.Id);

            if (link == null)
            {
                return this.BadRequest("Invalid id");
            }

            link.Comments.Add(new Comment() { UserId = this.User.Identity.GetUserId(), Text = model.Text, Created = DateTime.Now });
            this.Data.Links.Update(link);
            this.Data.SaveChanges();

            return this.Ok(JsonResultWrapper.Create(model));
        }

        [HttpGet]
        public IHttpActionResult Like(Guid id)
        {
            if (!this.Data.Links.All().Any(l => l.Id == id))
            {
                return this.BadRequest("Invalid Id");
            }

            this.VoteLink(true);

            return this.Ok(JsonResultWrapper.Create(id));
        }

        [HttpGet]
        public IHttpActionResult Hate(Guid id)
        {
            if (!this.Data.Links.All().Any(l => l.Id == id))
            {
                return this.BadRequest("Invalid Id");
            }

            this.VoteLink(false);

            return this.Ok(JsonResultWrapper.Create(id));
        }

        private void VoteLink(bool value)
        {
            var userId = this.User.Identity.GetUserId();

            // will always exist, because to hate or like you must ask for content details, thus creating a view object
            var view = this.Data.Views.All().FirstOrDefault(v => v.UserId == userId);
            view.Liked = value;
            this.Data.Views.Update(view);
            this.Data.SaveChanges();
        }
    }
}