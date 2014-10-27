namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.IO;
    using System.Linq;

    public class NewPictureDataModel
    {
        /*
         We must decide how to pass data from the iphone - stream/ byte[], base64string ?
         * */

        //[Required]
        //public MemoryStream Stream { get; set; }

        //[Required]
        //public string Base64String { get; set; }

        [MinLength(3)]
        [Required]
        public string Title { get; set; }

        // should the owner of this content be visible to other users or not
        public bool IsAnonymous { get; set; }

        public string Category { get; set; }
    }
}