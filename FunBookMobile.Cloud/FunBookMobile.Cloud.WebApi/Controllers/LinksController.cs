namespace FunBookMobile.Cloud.WebApi.Controllers
{
    using System;
    using System.Linq;
    using System.Web.Http;
    using System.Web.Http.Cors;

    using FunBookMobile.Cloud.WebApi.DataModels;

    public class LinksController : BaseApiController
    {
        [Authorize]
        [HttpGet]
        public IHttpActionResult Create([FromBody]NewLinkDataModel model)
        {
            return Ok();
        }
    }
}