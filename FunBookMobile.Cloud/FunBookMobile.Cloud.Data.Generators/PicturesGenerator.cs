namespace FunBook.WebForms.DataGenerators
{
    using System;
    using System.Linq;

    using FunBook.Data;
    using FunBook.ImageUpload;
    using FunBook.Models;

    public class PicturesGenerator : IDataGenerator
    {
        public void Generate(FunBookDbContext context)
        {
            if (!context.Users.Any())
            {
                throw new ArgumentException("Register at least one user first !");
            }

            if (!context.Jokes.Any() || !context.Categories.Any() || !context.Tags.Any())
            {
                throw new ArgumentException("Method needs already added jokes, categories and tags!");
            }

            var userId = context.Users.FirstOrDefault().Id;

            var uploader = new TelerikBackendServicesImageUpload();
            var allFiles = uploader.GetUploadedFiles();
            foreach (var file in allFiles)
            {
                var categoryName = file.Item1.Substring(0, file.Item1.IndexOf("#"));
                if (context.Categories.FirstOrDefault(c => c.Name == categoryName) == null)
                {
                    context.Categories.Add(new Category() { Name = categoryName });
                    context.SaveChanges();
                }

                var categoryId = context.Categories.FirstOrDefault(c => c.Name == categoryName).Id;

                var hashIndex = file.Item1.IndexOf("#") + 1;
                var tagString = file.Item1.Substring(hashIndex, file.Item1.IndexOf("#", hashIndex) - hashIndex);

                var title = "Funny pic";

                var picObj = new Picture() 
                {
                    CategoryId = categoryId,
                    IsAnonymous = true,
                    Title = title,
                    UrlPath = file.Item2,
                    UserId = userId
                };

                context.Pictures.Add(picObj);

                context.SaveChanges();

                var allTags = tagString.Split();

                foreach (var tag in allTags)
                {
                    if (context.Tags.FirstOrDefault(t => t.Name == tag.ToLower()) == null)
                    {
                        context.Tags.Add(new Tag() { Name = tag.ToLower() });
                        context.SaveChanges();
                    }

                    context.Tags.FirstOrDefault(t => t.Name == tag.ToLower()).Pictures.Add(picObj);
                }

                context.SaveChanges();
            }
        }
    }
}
