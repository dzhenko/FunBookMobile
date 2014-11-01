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
    using FunBookMobile.Cloud.ImageUploadProvider;

    [Authorize]
    [EnableCors("*", "*", "*")]
    public class PicturesController : BaseApiController
    {
        private readonly IBackendServicesProvider backendServices;

        public PicturesController(IBackendServicesProvider backendServicesProvider)
            : base()
        {
            this.backendServices = backendServicesProvider;
        }

        public PicturesController()
            : this(new TelerikBackendServicesProvider())
	    {
	    }

        [HttpPost]
        public IHttpActionResult Create([FromBody]NewPictureDataModel model)
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

            var tags = Regex.Split(model.Title, @"\W+").Where(tag => tag.Length > 2).ToArray();

            var url = backendServices.UrlFromBase64Image(/*TODO: */ "Finish this part", category.Name, tags);

            var picture = new Picture()
            {
                CategoryId = category.Id,
                Created = DateTime.Now,
                IsAnonymous = model.IsAnonymous,
                UrlPath = url,
                Title = model.Title,
                UserId = this.User.Identity.GetUserId()
            };

            this.Data.Pictures.Add(picture);

            foreach (var tagName in tags)
            {
                var tag = this.Data.Tags.All().FirstOrDefault(t => t.Name == tagName);
                if (tag == null)
                {
                    tag = new Tag() { Name = tagName };
                    this.Data.Tags.Add(tag);
                }

                tag.Pictures.Add(picture);
            }

            this.Data.SaveChanges();

            return this.Ok(JsonResultWrapper.Create(picture.Id));
        }

        [HttpGet]
        public IHttpActionResult Details(Guid id)
        {
            var picture = this.Data.Pictures.Find(id);

            if (picture == null)
            {
                return this.BadRequest("Invalid id");
            }

            var userId = this.User.Identity.GetUserId();

            if (!picture.Views.Any(v => v.UserId == userId))
            {
                picture.Views.Add(new View() { UserId = userId });
                this.Data.Pictures.Update(picture);
                this.Data.SaveChanges();
            }

            return this.Ok(JsonResultWrapper.Create(
                this.Data.Pictures.All().Where(p => p.Id == id).Select(DetailsPictureDataModel.FromPicture).FirstOrDefault()));
        }

        [HttpPost]
        public IHttpActionResult Comment([FromBody]NewCommentDataModel model)
        {
            if (!ModelState.IsValid)
            {
                return this.BadRequest(ModelState);
            }
            var pictures = this.Data.Pictures.Find(model.Id);

            if (pictures == null)
            {
                return this.BadRequest("Invalid id");
            }

            pictures.Comments.Add(new Comment() { UserId = this.User.Identity.GetUserId(), Text = model.Text, Created = DateTime.Now });
            this.Data.Pictures.Update(pictures);
            this.Data.SaveChanges();

            return this.Ok(JsonResultWrapper.Create(model));
        }

        [HttpGet]
        public IHttpActionResult Like(Guid id)
        {
            if (!this.Data.Pictures.All().Any(l => l.Id == id))
            {
                return this.BadRequest("Invalid Id");
            }

            this.VotePicture(true);

            return this.Ok(JsonResultWrapper.Create(id));
        }

        [HttpGet]
        public IHttpActionResult Hate(Guid id)
        {
            if (!this.Data.Pictures.All().Any(l => l.Id == id))
            {
                return this.BadRequest("Invalid Id");
            }

            this.VotePicture(false);

            return this.Ok(JsonResultWrapper.Create(id));
        }

        private void VotePicture(bool value)
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