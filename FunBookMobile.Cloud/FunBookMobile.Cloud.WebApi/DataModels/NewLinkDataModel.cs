﻿namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;

    public class NewLinkDataModel
    {
        [Required]
        [MinLength(3)]
        public string URL { get; set; }

        [MinLength(3)]
        [Required]
        public string Title { get; set; }

        // should the owner of this content be visible to other users or not
        public bool IsAnonymous { get; set; }

        [Required]
        public string Category { get; set; }
    }
}