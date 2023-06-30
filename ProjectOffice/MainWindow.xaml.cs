using ProjectOffice.DataBase;
using ProjectOffice.Models;
using ProjectOffice.Pages;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
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

namespace ProjectOffice
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
           if(!string.IsNullOrWhiteSpace(Properties.Settings.Default.OpenedPage))
                MainFrame.NavigationService.Navigate(new Uri("Pages/" + Properties.Settings.Default.OpenedPage, UriKind.Relative));
            var version = GetVersionProject();
            TextBlockVersion.Text = "Version" + version;
            ComboBoxProject.ItemsSource = GlobalSettings.DB.Project.ToList();

        }

        public string GetVersionProject()
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            Version version = assembly.GetName().Version;
            version = new Version(version.Major, version.Minor, version.Build + 1, version.Revision);
            var versionString = $"{version.Major}.{version.Minor}.{version.Build.ToString("000")}";             
            return versionString;
        }


        protected override void OnClosing(CancelEventArgs e)
        {
            base.OnClosing(e);
            var frame = MainFrame.Content as Page;
            var frameName = frame.GetType().Name + ".xaml";
            Properties.Settings.Default.OpenedPage = frameName;
            Properties.Settings.Default.Save();
        }

        private void ButtonDashBoard_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.NavigationService.Navigate(new DashboardPage());
        }

        private void ButtonTasks_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.NavigationService.Navigate(new TaskPages());
        }

        private void ButtonGant_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.NavigationService.Navigate(new GantPage());
        }

        private void ComboBoxProject_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedProject = ComboBoxProject.SelectedItem as Project;
            if (selectedProject != null)
            {
                GlobalSettings.CurrentProject = selectedProject;
                MainFrame.NavigationService.Navigate(new MainPage());
            }
        }

      
    }
}
