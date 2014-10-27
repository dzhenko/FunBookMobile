namespace FunBookMobile.Cloud.WebApi.Controllers
{
    using System;
    using System.Linq;
    using System.Web.Http;
    using System.Web.Http.Cors;

    using FunBookMobile.Cloud.WebApi.DataModels;

    [EnableCors("*", "*", "*")]
    public class PicturesController : BaseApiController
    {
        [Authorize]
        [HttpGet]
        public IHttpActionResult Create([FromBody]NewPictureDataModel model)
        {
            return Ok();
        }
    }
}