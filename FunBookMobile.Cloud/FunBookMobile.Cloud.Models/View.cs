namespace FunBookMobile.Cloud.Models
{
    public class View
    {
        public int Id { get; set; }

        public bool? Liked { get; set; }

        public string UserId { get; set; }

        public virtual User User { get; set; }
    }
}
