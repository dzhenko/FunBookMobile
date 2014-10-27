namespace FunBookMobile.Cloud.WebApi.Controllers
{
    using System;
    using System.Linq;
    using System.Web.Http;
    using System.Web.Http.Cors;

    using FunBookMobile.Cloud.WebApi.DataModels;

    [EnableCors("*", "*", "*")]
    public class JokesController : BaseApiController
    {
        [Authorize]
        [HttpGet]
        public IHttpActionResult Create([FromBody]NewJokeDataModel model)
        {
            return Ok();
        }
    }
}