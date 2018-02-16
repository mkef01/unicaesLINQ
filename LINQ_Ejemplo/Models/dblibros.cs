using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LINQ_Ejemplo.Models
{
    public class dblibros
    {
        public string Titulo { get; set; }
        public int Codtema { get; set; }
        public int Codeditorial { get; set; }
        public int Codidioma { get; set; }
        public decimal Precio { get; set; }
        public int Year { get; set; }
        public string Donado { get; set; }
    }
}