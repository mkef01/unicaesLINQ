using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LINQ_Ejemplo.Models
{
    public class AgregarLibro
    {
        
        public int codtema { get; set; }
        public int codeditorial { get; set; }
        public int codidioma { get; set; }
        public char donado { get; set; }
        public string titulo { get; set; }
        public decimal precio { get; set; }
        public int year { get; set; }
        /// 
        public int tematicascod { get; set; }
        public string tematicas { get; set; }
        //
        public int editorialcodigo { get; set; }
        public string editorialnombre { get; set; }
        //
        public int idiomacodigo { get; set; }
        public string idiomaidioma { get; set; }
    }
}