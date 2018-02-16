using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LINQ_Ejemplo.Models
{
    public class DetalleLibro
    {
        public int Codlibro { get; set; }
        public string Titulo { get; set; }
        public string Tema { get; set; }
        public string Editorial { get; set; }
        public string Idioma { get; set; }
        public float Precio { get; set; }
        public int Year { get; set; }

    }
}