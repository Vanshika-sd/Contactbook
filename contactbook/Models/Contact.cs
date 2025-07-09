// Models/Contact.cs
using System.ComponentModel.DataAnnotations;

public class Contact
{
    public int Id { get; set; }

    [Required]
    public string? Name { get; set; }

    [EmailAddress]
    public string? Email { get; set; }

    [Phone]
    public string? Phone { get; set; }
}
