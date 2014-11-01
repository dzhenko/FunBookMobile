namespace FunBookMobile.Cloud.WebApi.DataModels
{
    public class JsonResultWrapper
    {
        public static JsonResultWrapper Create(object obj)
        {
            return new JsonResultWrapper() { Result = obj };
        }

        public object Result { get; set; }
    }
}