using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LINQ_Ejemplo.Models
{
    public class detalleLibro
    {
        public int codlibro { get; set; }
        public string titulo { get; set; }
        public string tema { get; set; }
        public string editorial { get; set; }
        public string idioma { get; set; }
        public float precio { get; set; }
        public int year { get; set; }
    }
}