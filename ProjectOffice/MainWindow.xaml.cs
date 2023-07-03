using ProjectOffice.AppWindows;
using ProjectOffice.DataBase;
using ProjectOffice.Models;
using ProjectOffice.Pages;
using System;
using System.ComponentModel;
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
            if (!string.IsNullOrWhiteSpace(Properties.Settings.Default.OpenedPage))
                MainFrame.NavigationService.Navigate(new Uri("Pages/" + Properties.Settings.Default.OpenedPage, UriKind.Relative));
            var version = GetVersionProject();
            TextBlockVersion.Text = "Version" + version;
            ComboBoxProject.ItemsSource = GlobalSettings.DB.Project.ToList();

        }

        private string GetVersionProject()
        {
            Version version = Assembly.GetExecutingAssembly().GetName().Version;
            Properties.Settings.Default.BuildVersion++;
            Properties.Settings.Default.Save();
            var versionString = $"{version.Major}.{version.Minor}.{(version.Build + Properties.Settings.Default.BuildVersion).ToString("00")}";
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
            new GantWindow().ShowDialog();
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
