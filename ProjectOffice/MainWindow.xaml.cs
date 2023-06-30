using ProjectOffice.DataBase;
using ProjectOffice.Models;
using ProjectOffice.Pages;
using System;
using System.Linq;
using System.Reflection;
using System.Windows;
using System.Windows.Controls;

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

        private string GetVersionProject()
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            Version version = assembly.GetName().Version;
            version = new Version(version.Major, version.Minor, version.Build + 1, version.Revision);
            var versionString = $"{version.Major}.{version.Minor}.{version.Build.ToString("000")}";
            return versionString;
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
