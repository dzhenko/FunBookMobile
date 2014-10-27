namespace FunBookMobile.Cloud.WebApi.Controllers
{
    using System;
    using System.Web.Http;

    using FunBookMobile.Cloud.Data;

    public abstract class BaseApiController : ApiController
    {
        private IFunBookData data;

        public BaseApiController()
        {
            this.data = new FunBookData();
        }

        protected IFunBookData Data
        {
            get { return this.data; }
        }
    }
}