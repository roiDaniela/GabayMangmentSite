using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(GabayManageSite.Startup))]
namespace GabayManageSite
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
