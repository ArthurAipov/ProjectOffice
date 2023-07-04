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
using System.Windows.Forms.DataVisualization.Charting;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ProjectOffice.AppWindows
{
    /// <summary>
    /// Interaction logic for GantWindow.xaml
    /// </summary>
    public partial class GantWindow : Window
    {
        double Tick = 0;
        int Interval = 0;
        Random random = new Random();
        public GantWindow()
        {
            InitializeComponent();
            GantChart.ChartAreas.Add("TaskArea");
            RefreshChart();
        }

        private void RefreshChart()
        {
            GantChart.Series.Clear();
            var taskSeria = GantChart.Series.Add("TaskSeria");
            var project = GlobalSettings.CurrentProject;
            if (project == null)
            {
                MessageBox.Show("Select poject");
                return;
            }
            taskSeria.ChartType = SeriesChartType.RangeBar;
            var tasks = GlobalSettings.DB.Task.Where(p => p.ProjectId == project.Id).ToList();
            var startTimes = tasks.Select(x => x.StartActualTime).ToList();
            var finishTimes = tasks.Select(x => x.FinishActualTime).ToList();
            for (int i = 0; i < tasks.Count; i++)
            {
                if (startTimes[i] == finishTimes[i])
                {
                    startTimes[i] = startTimes[i].AddHours(-12);
                    finishTimes[i] = finishTimes[i].AddHours(12);
                }
            }
            taskSeria.Points.DataBindY(startTimes, finishTimes);
            var taskName = tasks.Select(x => x.ShortTitle).ToList();
            for (int i = 0; i < taskSeria.Points.Count; i++)
            {
                taskSeria.Points[i].AxisLabel = taskName[i];
                taskSeria.Points[i].Color = System.Drawing.Color.FromArgb((byte)random.Next(0, 255), (byte)random.Next(0, 255), (byte)random.Next(0, 255));
            }
            GantChart.ChartAreas[0].AxisY.LabelStyle.Angle = 45;
            GantChart.ChartAreas[0].AxisY.Interval = 1;
            GantChart.ChartAreas[0].AxisY.IntervalType = DateTimeIntervalType.Days;
            if (Tick != 0)
            {
                GantChart.ChartAreas[0].AxisY.Maximum = tasks.Max(x => x.FinishActualTime).AddDays(Interval + Tick).ToOADate();
                GantChart.ChartAreas[0].AxisY.Minimum = tasks.Max(x => x.StartActualTime).AddDays(-Interval - Tick).ToOADate();
            }
            else if (Interval != 0)
            {
                GantChart.ChartAreas[0].AxisY.Maximum = tasks.Max(x => x.FinishActualTime).AddDays(Interval).ToOADate();
                GantChart.ChartAreas[0].AxisY.Minimum = tasks.Min(x => x.StartActualTime).AddDays(-Interval).ToOADate();
            }
        }


        private void ComboBoxInterval_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ComboBoxInterval.SelectedIndex == 0)
                Interval = 7;
            if (ComboBoxInterval.SelectedIndex == 1)
                Interval = 31;
            RefreshChart();
        }


        private void SliderDays_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            Tick = SliderDays.Value;
            RefreshChart();

        }



        private void ButtonRemoveToActualFinish_Click(object sender, RoutedEventArgs e)
        {

        }

        private void ButtonAddToActualFinish_Click(object sender, RoutedEventArgs e)
        {

        }

        private void ButtonAddToActualStart_Click(object sender, RoutedEventArgs e)
        {

        }

        private void ButtonRemoveToActualStart_Click(object sender, RoutedEventArgs e)
        {

        }

    }
}
