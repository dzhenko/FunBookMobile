namespace FunBook.WebForms.DataGenerators
{
    using System;
    using System.Linq;

    using FunBook.Data;
    using FunBook.Models;

    public class JokesGenerator : IDataGenerator
    {
        public void Generate(FunBookDbContext context)
        {
            if (!context.Users.Any())
            {
                throw new ArgumentException("Register at least one user first !");
            }

            var userId = context.Users.FirstOrDefault().Id;

            System.Net.WebClient client = new System.Net.WebClient();
            var endpoints = new string[] {"popular-jokes","latest-jokes", "joke-of-the-day", "animal-jokes", "blonde-jokes",
            "boycott-these-jokes", "clean-jokes", "family-jokes","holiday-jokes", "how-to-be-insulting", "insult-jokes" ,"miscellaneous-jokes",
            "national-jokes" ,"office-jokes" ,"political-jokes","pop-culture-jokes","racist-jokes","relationship-jokes",
            "religious-jokes","school-jokes","science-jokes","sex-jokes","sexist-jokes","sports-jokes","technology-jokes","word-play-jokes","yo-momma-jokes"};

            var tagDict = new System.Collections.Generic.Dictionary<string, System.Collections.Generic.List<Joke>>();

            for (int j = 0; j < endpoints.Length; j++)
            {
                var jokeCategory = endpoints[j].Replace("-jokes", "");
                string downloadString = client.DownloadString(string.Format("http://www.laughfactory.com/jokes/{0}", endpoints[j]));
                var jokes = System.Text.RegularExpressions.Regex.Split(downloadString, @"<p id=""joke_\d+"">");

                context.Categories.Add(new Category() { Name = jokeCategory });
                context.SaveChanges();

                var categoryId = context.Categories.FirstOrDefault(c => c.Name == jokeCategory).Id;

                for (int i = 1; i < jokes.Length; i++)
                {
                    var joke = jokes[i].TrimStart();
                    joke = joke.Substring(0, joke.IndexOf("      "));

                    var tags = System.Text.RegularExpressions.Regex.Split(joke, @"\W+");

                    var jokeObj = new Joke()
                    {
                        CategoryId = categoryId,
                        UserId = userId,
                        IsAnonymous = true,
                        Title = joke.Substring(0, 10),
                        Text = joke,
                    };

                    foreach (var tag in tags)
                    {
                        if (!tagDict.ContainsKey(tag.ToLower()))
                        {
                            tagDict[tag.ToLower()] = new System.Collections.Generic.List<Joke>();
                        }

                        tagDict[tag.ToLower()].Add(jokeObj);
                    }

                    context.Jokes.Add(jokeObj);
                }

                context.SaveChanges();
            }

            var counter = 0;
            foreach (var kvPair in tagDict)
            {
                context.Tags.Add(new Tag()
                {
                    Name = kvPair.Key,
                    Jokes = kvPair.Value
                });
                counter++;
                if (counter > 10)
                {
                    counter = 0;
                    context.SaveChanges();
                }
            }

            context.SaveChanges();

            context.Categories.Add(new Category() { Name = "Other" });

            context.SaveChanges();
        }
    }
}
