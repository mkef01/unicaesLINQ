using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
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

        public ActionResult Alumno()
        {
            var lista = DdlAlumnos();
            var list = new SelectList(lista, "codigo", "nombre");
            ViewData["alumnos"] = list;
            ViewData["autorizar"] = null;
            return View();
        }

        [HttpPost]
        public ActionResult Alumno(string seleccion)
        {
            var idi = seleccion;
            var lista = DdlAlumnos();
            var list = new SelectList(lista, "codigo", "nombre");
            ViewData["alumnos"] = list;
            IList<LibrosAlumno> detalleLista = new List<LibrosAlumno>();
            var query = from alum in _context.alumnos
                join pre in _context.prestamos on alum.codalumno equals pre.codalumno
                join ejem in _context.ejemplares on pre.codejemplar equals ejem.codejemplar
                join lib in _context.libros on ejem.codlibro equals lib.codlibro
                where alum.codalumno == seleccion
                select new
                {
                    Nombre = alum.nombre,
                    Fecha = pre.fechaprestamo,
                    Libro = lib.titulo
                };
            var listado = query.ToList();
            foreach (var listaEstudiante in listado)
            {
                detalleLista.Add(new LibrosAlumno()
                {
                   Nombre = listaEstudiante.Nombre,
                   Fecha = listaEstudiante.Fecha.ToString(),
                   Titulo = listaEstudiante.Libro
                    
                });
            }
            ViewData["autorizar"] = "entrar";
            return View(detalleLista);
        }

        private List<LibrosAlumno> DdlAlumnos()
        {
            var alumnosDdl = new List<LibrosAlumno>();
            var query = from alum in _context.alumnos
                select new
                {
                    Nombre = alum.nombre,
                    Codigo = alum.codalumno
                };
            var lista = query.ToList();
            foreach (var ddlLista in lista)
            {
                alumnosDdl.Add(new LibrosAlumno()
                {
                    Codigo = ddlLista.Codigo,
                    Nombre = ddlLista.Nombre
                });
            }
            return alumnosDdl;
        }
	}
}


//select alum.nombre, pre.fechaprestamo, lib.titulo from alumnos alum
//inner join prestamos pre on alum.codalumno = pre.codalumno
//inner join ejemplares ejem on ejem.codejemplar = pre.codejemplar
//inner join libros lib on lib.codlibro = ejem.codlibro where alum.nombre = 'Ana Toledo'