using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

using FunBookMobile.Cloud.WebApi.DataModels;
using System.Web.Http.Cors;

namespace FunBookMobile.Cloud.WebApi.Controllers
{
    [EnableCors("*", "*", "*")]
    public class ContentController : BaseApiController
    {
        private const int PageSize = 10;

        [AllowAnonymous]
        [HttpGet]
        public IHttpActionResult Home()
        {
            return this.Ok(JsonResultWrapper.Create(new 
                {
                    UsersCount = this.Data.Users.All().Count(),
                    JokesCount = this.Data.Jokes.All().Count(),
                    LinksCount = this.Data.Links.All().Count(),
                    PicturesCount = this.Data.Pictures.All().Count(),
                    LastJoke = this.Data.Jokes.All().OrderByDescending(j => j.Created).Take(1).Select(ContentOverviewDataModel.FromJoke).FirstOrDefault(),
                    LastLink = this.Data.Links.All().OrderByDescending(l => l.Created).Take(1).Select(ContentOverviewDataModel.FromLink).FirstOrDefault(),
                    LastPicture = this.Data.Pictures.All().OrderByDescending(p => p.Created).Take(1).Select(ContentOverviewDataModel.FromPicture).FirstOrDefault(),
                    BestJoke = this.Data.Jokes.All().OrderByDescending(j => j.Views.Count()).Take(1).Select(ContentOverviewDataModel.FromJoke).FirstOrDefault(),
                    BestLink = this.Data.Links.All().OrderByDescending(l => l.Views.Count()).Take(1).Select(ContentOverviewDataModel.FromLink).FirstOrDefault(),
                    BestPicture = this.Data.Pictures.All().OrderByDescending(p => p.Views.Count()).Take(1).Select(ContentOverviewDataModel.FromPicture).FirstOrDefault(),
                }));
        }

        [AllowAnonymous]
        [HttpGet]
        public IHttpActionResult All(int page = 0)
        {
            return this.Ok(JsonResultWrapper.Create(
                this.Data.Jokes.All().Select(ContentOverviewDataModel.FromJoke)
                    .Union(this.Data.Links.All().Select(ContentOverviewDataModel.FromLink))
                    .Union(this.Data.Pictures.All().Select(ContentOverviewDataModel.FromPicture))
                    .OrderByDescending(c => c.Date)
                    .Skip(page * PageSize)
                    .Take(PageSize)));
        }

        [AllowAnonymous]
        [HttpGet]
        public IHttpActionResult Jokes(int page = 0)
        {
            return this.Ok(JsonResultWrapper.Create(
                this.Data.Jokes.All().Select(ContentOverviewDataModel.FromJoke)
                    .OrderByDescending(c => c.Date)
                    .Skip(page * PageSize)
                    .Take(PageSize)));
        }

        [AllowAnonymous]
        [HttpGet]
        public IHttpActionResult Links(int page = 0)
        {
            return this.Ok(JsonResultWrapper.Create(
                this.Data.Links.All().Select(ContentOverviewDataModel.FromLink)
                    .OrderByDescending(c => c.Date)
                    .Skip(page * PageSize)
                    .Take(PageSize)));
        }

        [AllowAnonymous]
        [HttpGet]
        public IHttpActionResult Pictures(int page = 0)
        {
            return this.Ok(JsonResultWrapper.Create(
                this.Data.Pictures.All().Select(ContentOverviewDataModel.FromPicture)
                    .OrderByDescending(c => c.Date)
                    .Skip(page * PageSize)
                    .Take(PageSize)));
        }

        [Authorize]
        [HttpGet]
        public IHttpActionResult Find(string text, int page = 0)
        {
            if (string.IsNullOrEmpty(text))
	        {
		         return this.BadRequest("Search text is empty");
	        }

            text = text.ToLower();

            return this.Ok(JsonResultWrapper.Create(
                this.Data.Jokes.All().Where(j => j.Text.ToLower().Contains(text) || j.Title.ToLower().Contains(text)).Select(ContentOverviewDataModel.FromJoke)
                    .Union(this.Data.Links.All().Where(j => j.URL.ToLower().Contains(text) || j.Title.ToLower().Contains(text)).Select(ContentOverviewDataModel.FromLink))
                    .Union(this.Data.Pictures.All().Where(j => j.UrlPath.ToLower().Contains(text) || j.Title.ToLower().Contains(text)).Select(ContentOverviewDataModel.FromPicture))
                    .OrderByDescending(c => c.Date)
                    .Skip(page * PageSize)
                    .Take(PageSize)));
        }
    }
}