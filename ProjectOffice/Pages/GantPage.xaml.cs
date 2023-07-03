using ProjectOffice.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ProjectOffice.Pages
{
    /// <summary>
    /// Interaction logic for GantPage.xaml
    /// </summary>
    public partial class GantPage : Page
    {
        public GantPage()
        {
            InitializeComponent();
            
        }

        private void RefreshChart()
        {
            var project = GlobalSettings.CurrentProject;
            if(project != null)
            {
                var tasks = GlobalSettings.DB.Task.Where(p => p.ProjectId == project.Id);
            }
        }

    }
}
