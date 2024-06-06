using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PrinceMVCDemo.Models
{
    public class UserDetails
    {
        public int UserID { get; set; }
        [Required(ErrorMessage = "Name is required")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid Email Address")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Phone number is required")]
        [RegularExpression(@"^\d{10}$", ErrorMessage = "Invalid Phone Number")]
        public string PhoneNo { get; set; }
        public string Address { get; set; }
        [Display(Name = "City")]
        [Required(ErrorMessage = "City is required")]
        public string CityName { get; set; }
        [Display(Name = "State")]
        [Required(ErrorMessage = "State is required")]
        public string StateName { get; set; }
        public bool Agree { get; set; }
        public int CityId { get; set; }
        public int StateId { get; set; }
        public IEnumerable<State> States { get; set; }
        public IEnumerable<City> Cities { get; set; }
    }
}