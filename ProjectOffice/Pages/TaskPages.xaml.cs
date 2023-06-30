using ProjectOffice.DataBase;
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
    /// Interaction logic for TaskPages.xaml
    /// </summary>
    public partial class TaskPages : Page
    {
        public TaskPages()
        {
            InitializeComponent();
        }


        public List<DataBase.Task> GetTasks(Project project)
        {
            var listForDataGrid = new List<DataBase.Task>();
            var list = GlobalSettings.DB.Task.Where(p => p.ProjectId == project.Id).ToList();
            var listInWorkOutDeadline = list.Where(p => p.Deadline < DateTime.Now && p.StatusId == 1).ToList();
            var listOpenOutDeadline = list.Where(p => p.Deadline < DateTime.Now && p.StatusId == 2).ToList();
            var listInWorkInDeadline = list.Where(p => p.Deadline > DateTime.Now && p.StatusId == 1).ToList();
            var listOpenInDeadline = list.Where(p => p.Deadline > DateTime.Now && p.StatusId == 2).ToList();
            var listOtherTasks = list.Where(p => p.StatusId == 3).ToList();
            foreach (var task in listInWorkOutDeadline)
            {
                var taskinList = listForDataGrid.FirstOrDefault(p => p.Id == task.Id);
                if (taskinList == null)
                    listForDataGrid.Add(task);
            }
            foreach (var task in listOpenOutDeadline)
            {
                var taskinList = listForDataGrid.FirstOrDefault(p => p.Id == task.Id);
                if (taskinList == null)
                    listForDataGrid.Add(task);
            }
            foreach (var task in listInWorkInDeadline)
            {
                var taskinList = listForDataGrid.FirstOrDefault(p => p.Id == task.Id);
                if (taskinList == null)
                    listForDataGrid.Add(task);
            }
            foreach (var task in listOpenInDeadline)
            {
                var taskinList = listForDataGrid.FirstOrDefault(p => p.Id == task.Id);
                if (taskinList == null)
                    listForDataGrid.Add(task);
            }
            foreach (var task in listOtherTasks)
            {
                var taskinList = listForDataGrid.FirstOrDefault(p => p.Id == task.Id);
                if (taskinList == null)
                    listForDataGrid.Add(task);
            }
            return listForDataGrid;
        }


        public void RefreshDataGrid()
        {
            var project = GlobalSettings.CurrentProject;
            if (project != null)
            {
                var listForDataGrid = GetTasks(project);
                DataGridTasks.ItemsSource = listForDataGrid;
            }
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            RefreshDataGrid();
        }

        private void ButtonAdd_Click(object sender, RoutedEventArgs e)
        {
            if (GlobalSettings.CurrentProject != null)
            {
                TaskFrame.NavigationService.Navigate(new AddEditeTaskPage(new DataBase.Task()));
                DataGridTasks.SetValue(Grid.ColumnSpanProperty, 1);
            }
        }

        private void DataGridTasks_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var task = DataGridTasks.SelectedItem as DataBase.Task;
            if (task != null)
            {
                DataGridTasks.SetValue(Grid.ColumnSpanProperty, 1);
                TaskFrame.NavigationService.Navigate(new AddEditeTaskPage(task));
            }
        }

        private void TaskFrame_Navigated(object sender, NavigationEventArgs e)
        {
            var frame = TaskFrame.Content as Page;
            var pageName = frame.GetType().Name;
            if (pageName.ToLower().Contains("mainpage"))
            {
                DataGridTasks.SetValue(Grid.ColumnSpanProperty, 2);
                RefreshDataGrid();
            }
        }
    }
}
