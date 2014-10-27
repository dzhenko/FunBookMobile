namespace FunBook.WebForms.DataGenerators
{
    using System.Data.Entity;

    using FunBook.Data;

    public interface IDataGenerator
    {
        void Generate(FunBookDbContext context);
    }
}
