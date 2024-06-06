using PrinceMVCDemo.Services.IRepository;
using PrinceMVCDemo.Services.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Unity;
using Unity.AspNet.Mvc;

namespace PrinceMVCDemo.App_Start
{
    public static class IocConfig
    {
        public static void ConfigureIocUnityContainer()
        {
            IUnityContainer container = new UnityContainer();
            RegisterServices(container);
            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }

        private static void RegisterServices(IUnityContainer container)
        {
            container.RegisterType<IUserDetailsRepository, UserDetailsRepository>();
        }
    }
}