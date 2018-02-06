using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LINQ_Ejemplo.Models;

namespace LINQ_Ejemplo.Controllers
{
    public class InicioController : Controller
    {
        private readonly OperacionDataContext _context;

        public InicioController()
        {
            _context = new OperacionDataContext();
        }

        // GET: /Inicio/
        public ActionResult Index()
        {
            IList<detalleLibro> detalleLista = new List<detalleLibro>();
            var query = from bs in _context.libros
                join ts in _context.tematicas on bs.codtema equals ts.codtema
                join es in _context.editoriales on bs.codeditorial equals es.codeditorial
                join idi in _context.idiomas on bs.codidioma equals idi.codidioma
                select new
                {
                    Codigo = bs.codlibro,
                    Titulo = bs.titulo,
                    Tema = ts.tema,
                    Editorial = es.editorial,
                    Idioma = idi.idioma,
                    Precio = bs.precio,
                    year = bs.year
                };
            var detalles = query.ToList();
            foreach (var detalleData in detalles)
            {
                detalleLista.Add(new detalleLibro()
                {
                    codlibro = detalleData.Codigo,
                    titulo = detalleData.Titulo,
                    tema = detalleData.Tema,
                    editorial = detalleData.Editorial,
                    idioma = detalleData.Idioma,
                    precio = float.Parse(detalleData.Precio.ToString()),
                    year = detalleData.year.GetValueOrDefault()
                });
            }

            return View(detalleLista);
        }
	}
}


//select codlibro, titulo, tema, editorial, idioma, precio, year from libros bs
//inner join tematicas ts on ts.codtema = bs.codtema
//inner join editoriales es on es.codeditorial = bs.codeditorial
//inner join idiomas idi on idi.codidioma = bs.codidioma