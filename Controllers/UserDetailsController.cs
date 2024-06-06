using Microsoft.Ajax.Utilities;
using PrinceMVCDemo.Models;
using PrinceMVCDemo.Services.IRepository;
using PrinceMVCDemo.Services.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PrinceMVCDemo.Controllers
{
    public class UserDetailsController : Controller
    {
        private readonly IUserDetailsRepository userDetailsRepository;

        public UserDetailsController(IUserDetailsRepository _userDetailsRepository)
        {
            userDetailsRepository = _userDetailsRepository;
        }
        public ActionResult Index()
        {
            IEnumerable<UserDetails> userDetails = userDetailsRepository.GetAllUserDetails() ?? new List<UserDetails>();
            var dropdowns = GetDropdowns();
            ViewBag.States = dropdowns.States;
            ViewBag.Cities = dropdowns.Cities;
            return View(userDetails);
        }

        [HttpGet]
        [Route("UserDetails/GetById/{UserID}")]
        public JsonResult GetById(int UserID)
        {
            UserDetails userDetails = userDetailsRepository.GetUserDetailsById(UserID);
            return Json(new { UserDetails = userDetails }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [Route("UserDetails/GetCitiesByStateId/{stateId}")]
        public JsonResult GetCitiesByStateId(int stateId)
        {
            List<DropdownState> dropdowns = userDetailsRepository.GetAllCitiesAndStates().ToList();
            var cities = dropdowns.Where(cs => cs.StateId == stateId).Select(cs => new City { Id = cs.CityId, CityName = cs.CityName, StateId = cs.StateId }).OrderBy(c => c.Id).ToList();
            return Json(new {Cities = cities }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult addEditUserDetails(UserDetails userDetails)
        {
            bool IsSaved = userDetailsRepository.AddEditUserDetails(userDetails);
            return Json(new { IsValid = IsSaved, UserDetails = userDetails });
        }

        [HttpPost]
        public JsonResult deleteUserDetails(int UserID) 
        {
            bool Isdeleted = userDetailsRepository.DeleteUserDetails(UserID);
            return Json(new { IsValid = Isdeleted });
        }

        private DropdownData GetDropdowns()
        {
            List<DropdownState> dropdowns = userDetailsRepository.GetAllCitiesAndStates().ToList();
            var states = dropdowns.GroupBy(cs => new { cs.StateId, cs.StateName }).Select(g => new State {Id = g.Key.StateId,StateName = g.Key.StateName }).OrderBy(s => s.Id).ToList();
            var cities = dropdowns.Select(cs => new City { Id = cs.CityId,CityName = cs.CityName, StateId = cs.StateId }).OrderBy(c => c.Id).ToList();

            return new DropdownData
            {
                States = states,
                Cities = cities
            };
        }
    }
}