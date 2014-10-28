namespace FunBookMobile.Cloud.WebApi.DataModels
{
    using System;
    using System.ComponentModel.DataAnnotations;

    public class NewCommentDataModel
    {
        [Required]
        public Guid Id { get; set; }

        [MinLength(3)]
        [Required]
        public string Text { get; set; }
    }
}