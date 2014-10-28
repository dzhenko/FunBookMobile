namespace FunBookMobile.Cloud.WebApi.Controllers
{
    using System;
    using System.Linq;
    using System.Web.Http;
    using System.Text.RegularExpressions;
    using System.Web.Http.Cors;

    using Microsoft.AspNet.Identity;

    using FunBookMobile.Cloud.WebApi.DataModels;
    using FunBookMobile.Cloud.Models;

    [Authorize]
    [EnableCors("*", "*", "*")]
    public class JokesController : BaseApiController
    {
        [HttpPost]
        public IHttpActionResult Create([FromBody]NewJokeDataModel model)
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

            var tags = Regex.Split(model.Text, @"\W+").Union(Regex.Split(model.Title, @"\W+")).Where(tag => tag.Length > 2);

            var joke = new Joke()
            {
                CategoryId = category.Id,
                Created = DateTime.Now,
                IsAnonymous = model.IsAnonymous,
                Text = model.Text,
                Title = model.Title,
                UserId = this.User.Identity.GetUserId()
            };

            this.Data.Jokes.Add(joke);

            foreach (var tagName in tags)
            {
                var tag = this.Data.Tags.All().FirstOrDefault(t => t.Name == tagName);
                if (tag == null)
                {
                    tag = new Tag() { Name = tagName };
                    this.Data.Tags.Add(tag);
                }

                tag.Jokes.Add(joke);
            }

            this.Data.SaveChanges();

            return this.Created(string.Empty, joke.Id);
        }

        [HttpGet]
        public IHttpActionResult Details(Guid id)
        {
            var joke = this.Data.Jokes.Find(id);

            if (joke == null)
            {
                return this.BadRequest("Invalid id");
            }

            var userId = this.User.Identity.GetUserId();

            if (!joke.Views.Any(v => v.UserId == userId))
            {
                joke.Views.Add(new View() { UserId = userId });
                this.Data.Jokes.Update(joke);
                this.Data.SaveChanges();
            }

            return this.Ok(this.Data.Jokes.All().Where(j => j.Id == id).Select(DetailsJokeDataModel.FromJoke).FirstOrDefault());
        }

        [HttpPost]
        public IHttpActionResult Comment([FromBody]NewCommentDataModel model)
        {
            if (!ModelState.IsValid)
            {
                return this.BadRequest(ModelState);
            }
            var joke = this.Data.Jokes.Find(model.Id);

            if (joke == null)
            {
                return this.BadRequest("Invalid id");
            }

            joke.Comments.Add(new Comment() { UserId = this.User.Identity.GetUserId(), Text = model.Text, Created = DateTime.Now });
            this.Data.Jokes.Update(joke);
            this.Data.SaveChanges();

            return this.Created(string.Empty, model);
        }

        [HttpGet]
        public IHttpActionResult Like(Guid id)
        {
            if (!this.Data.Jokes.All().Any(l => l.Id == id))
            {
                return this.BadRequest("Invalid Id");
            }

            this.VoteJoke(true);

            return this.Ok();
        }

        [HttpGet]
        public IHttpActionResult Hate(Guid id)
        {
            if (!this.Data.Jokes.All().Any(l => l.Id == id))
            {
                return this.BadRequest("Invalid Id");
            }

            this.VoteJoke(false);

            return this.Ok();
        }

        private void VoteJoke(bool value)
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