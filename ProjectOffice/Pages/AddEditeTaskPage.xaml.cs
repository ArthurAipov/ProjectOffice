using ProjectOffice.DataBase;
using ProjectOffice.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
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
    /// Interaction logic for AddEditeTaskPage.xaml
    /// </summary>
    public partial class AddEditeTaskPage : Page
    {
        DbPropertyValues OldValues;
        bool IsSave = false;
        bool IsAdd = true;
        public AddEditeTaskPage(DataBase.Task task)
        {
            InitializeComponent();
            if (task.Id != 0)
            {
                OldValues = GlobalSettings.DB.Entry(task).CurrentValues.Clone();
                IsAdd = false;
            }
            else
            {
                task.ProjectId = GlobalSettings.CurrentProject.Id;
                task.CreatedTime = DateTime.Now;
                task.StartActualTime = DateTime.Now;
                task.FinishActualTime = DateTime.Now;
                task.Deadline = DateTime.Now.AddDays(1);
                task.DeletedTime = DateTime.Now;
                task.UpdatedTime = DateTime.Now;
                DatePickerCreatedTime.BlackoutDates.AddDatesInPast();
                DatePickerFinishActualTime.BlackoutDates.AddDatesInPast();
                DatePickerStartActualTime.BlackoutDates.AddDatesInPast();
                DatePickerUpdateTime.BlackoutDates.AddDatesInPast();
                DatePickerDeleteTime.BlackoutDates.AddDatesInPast();
                DatePickerDeadline.BlackoutDates.AddDatesInPast();
            }
            ComboBoxEmployee.ItemsSource = GlobalSettings.DB.Employee.ToList();
            ComboBoxTask.ItemsSource = GlobalSettings.DB.Task.Where(p => p.ProjectId == GlobalSettings.CurrentProject.Id && p.Id != task.Id).ToList();
            ComboBoxStatus.ItemsSource = GlobalSettings.DB.TaskStatus.ToList();
            DataContext = task;

        }

        private void Page_Unloaded(object sender, RoutedEventArgs e)
        {
            if (!IsSave)
            {
                if (!IsAdd)
                {
                    var task = DataContext as DataBase.Task;
                    GlobalSettings.DB.Entry(task).CurrentValues.SetValues(OldValues);
                }
            }
        }

        private void ButtonSave_Click(object sender, RoutedEventArgs e)
        {
            var errorMessage = "";
            var task = DataContext as DataBase.Task;
            if (task.TaskStatus == null)
                errorMessage += "Select status\n";
            if (task.ShortTitle == null)
                errorMessage += "Enter short title\n";
            if (task.FullTitle == null)
                errorMessage += "Enter FullTitle\n";
            if (task.Employee == null)
                errorMessage += "Select Employee\n";
            if (task.Description == null)
                errorMessage += "Enter Description\n";
            if (!string.IsNullOrWhiteSpace(errorMessage))
            {
                MessageBox.Show(errorMessage);
                return;
            }
            var selectedPreviousTask = ComboBoxTask.SelectedItem as DataBase.Task;
            if (selectedPreviousTask != null)
                task.PreviousTaskId = selectedPreviousTask.Id;
            if (IsAdd)
                GlobalSettings.DB.Task.Add(task);
            GlobalSettings.DB.SaveChanges();
            IsSave = true;
            NavigationService.Navigate(new MainPage());
        }

        private void ButtonBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new MainPage());
        }
    }
}
