using System;

namespace Employ
{

    abstract class Employee
    {
        public string Name { get; set; }
        public double Price { get; set; }
        public abstract double CountSalary();
        public  void Display()
        {
            Console.WriteLine(Price);
        }
    }

    class FixedEmployee : Employee
    {
        const double fixedPrice = 100000;
        double fixedPriceInput = 0;
        public FixedEmployee(double Price)
        {
            this.fixedPriceInput = Price;
        }
        public override double CountSalary()
        {
            if (fixedPriceInput != 0)
            {
                this.Price = fixedPriceInput;
                return Price;
            }
            this.Price = fixedPrice;
            return fixedPrice;
        }
    }
    class HourlyEmployee : Employee
    {
        const double hourlyPrice = 125.5;
        double hourlyPriceInput = 0;
        public HourlyEmployee(double Price)
        {
            this.hourlyPriceInput = Price;
        }
        public override double CountSalary()
        {
            if (hourlyPriceInput != 0)
            {
                this.Price = 20.8 * 8 * hourlyPriceInput;
                return Price;
            }
            this.Price = 20.8 * 8 * hourlyPrice;
            return 20.8 * 8 * hourlyPrice;
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            FixedEmployee fixedEmployee = new FixedEmployee(90000);
            HourlyEmployee hourlyEmployee = new HourlyEmployee(300);

            fixedEmployee.Name = "Employee1";
            hourlyEmployee.Name = "Employee2";
            fixedEmployee.CountSalary();
            hourlyEmployee.CountSalary();
            fixedEmployee.Display();
            Console.WriteLine("****************");
            hourlyEmployee.Display();
            
        }
    }
}
