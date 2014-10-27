namespace FunBook.WebForms.DataGenerators
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net;
    using System.Text.RegularExpressions;

    using FunBook.Data;
    using FunBook.Models;

    public class LinksGenerator : IDataGenerator
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

            var titlesFromBase = context.Jokes.Select(j => j.Title);
            var titles = new List<string>();

            foreach (var title in titlesFromBase)
            {
                var meaningfullTitle = title.IndexOf(" ") >= 0 ? title.Substring(0, title.IndexOf(" ")) : title;
                if (meaningfullTitle.Length > 3)
                {
                    titles.Add(meaningfullTitle);
                }
            }

            var categoryIds = context.Categories.Select(c => c.Id).ToList();

            WebClient client = new WebClient();
            var endpoints = new string[] { "http://imgfave.com/funny", 
                "http://imgfave.com/funny/page:2?after=1413928204", 
                "http://imgfave.com/funny/page:3?after=1413866704",
                "http://imgfave.com/funny/page:4?after=1413842106",
                "http://imgfave.com/funny/page:5?after=1413781205"};

            var linkString = @"<a class=""image_link"" href=""";

            foreach (var endpoint in endpoints)
            {
                var downloadString = client.DownloadString(endpoint);
                var URLs = Regex.Split(downloadString, linkString);
                for (int i = 1; i < URLs.Length; i++)
                {
                    var title = Regex.Replace(titles[(i-1) % titles.Count], @"\W", "");
                    var link = URLs[i].Substring(0, URLs[i].IndexOf("\"", linkString.Length + 1));
                    var linkObj = new Link()
                    {
                        CategoryId = categoryIds[(i-1) % categoryIds.Count],
                        UserId = userId,
                        IsAnonymous = true,
                        Title = title,
                        URL = link
                    };

                    context.Links.Add(linkObj);

                    var tag = context.Tags.FirstOrDefault(t => t.Name == title.ToLower());
                    if (tag != null)
                    {
                        tag.Links.Add(linkObj);
                    }
                }

                context.SaveChanges();
            }
        }
    }
}
