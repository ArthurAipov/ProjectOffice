using ProjectOffice.DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectOffice.Models
{
    public static class GlobalSettings
    {
        public static TaskListEntities DB = new TaskListEntities();
        public static Project CurrentProject;

    }
}
