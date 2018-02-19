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
            IList<DetalleLibro> detalleLista = new List<DetalleLibro>();
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
                detalleLista.Add(new DetalleLibro()
                {
                    Codlibro = detalleData.Codigo,
                    Titulo = detalleData.Titulo,
                    Tema = detalleData.Tema,
                    Editorial = detalleData.Editorial,
                    Idioma = detalleData.Idioma,
                    Precio = float.Parse(detalleData.Precio.ToString()),
                    Year = detalleData.year.GetValueOrDefault()
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

        public ActionResult InsertarLibro()
        {
            libros modelo = new libros();
            //
            var tema = new List<Dbtemas>();
            var query = from tem in _context.tematicas
                select new
                {
                    codigo = tem.codtema,
                    tematica = tem.tema
                };
            var lista = query.ToList();
            foreach (var ddltematica in lista)
            {
                tema.Add(new Dbtemas()
                {
                    Tematicascod = ddltematica.codigo,
                    Tematicas = ddltematica.tematica
                });
            }
            ViewBag.tema = new SelectList(tema,"tematicascod","tematicas");
            //
            var edito = new List<dbeditoriales>();
            var query2 = from edit in _context.editoriales
                select new
                {
                    codigoedito = edit.codeditorial,
                    editorialnombre = edit.editorial
                };
            var lista2 = query2.ToList();
            foreach (var ddleditorial in lista2)
            {
                edito.Add(new dbeditoriales()
                {
                    Editorialcodigo = ddleditorial.codigoedito,
                    Editorialnombre = ddleditorial.editorialnombre
                });
            }
            ViewBag.edito = new SelectList(edito, "editorialcodigo", "editorialnombre");
            //
            var idioma = new List<dbidiomas>();
            var query3 = from idio in _context.idiomas
                select new
                {
                    idiomacod = idio.codidioma,
                    idiomanombre = idio.idioma
                };
            var lista3 = query3.ToList();
            foreach (var ddlidioma in lista3)
            {
                idioma.Add(new dbidiomas()
                {
                   Idiomacodigo = ddlidioma.idiomacod,
                   Idiomaidioma = ddlidioma.idiomanombre
                });
            }
            ViewBag.idioma = new SelectList(idioma, "idiomacodigo", "idiomaidioma");
            //
            var autor = new List<dbautor>();
            var query4 = from aut in _context.autores
                select new
                {
                    autorCod = aut.codautor,
                    autorNombre = aut.autor
                };
            var lista4 = query4.ToList();
            foreach (var ddlautor in lista4)
            {
                autor.Add(new dbautor()
                {
                    codautor = ddlautor.autorCod,
                    autornombre = ddlautor.autorNombre
                });
            }
            ViewBag.autor = new SelectList(autor, "codautor","autornombre");
            //
            ViewData["regresar"] = "nada";
            return View(modelo);
        }

        [HttpPost]
        public ActionResult InsertarLibro (int tema,int edito,int idioma,int donado, dblibros datos,int autor)
        {
            string sn;
            char[] don = new char[5];
            if (donado == 1)
            {
                don[1] = 'S';
            }
            else
            {
                don[1] = 'N';
            }
            using (OperacionDataContext objDataContext = new OperacionDataContext())
            {
                libros baseDatos = new libros();
                baseDatos.titulo = datos.Titulo;
                baseDatos.codtema = tema;
                baseDatos.codeditorial = edito;
                baseDatos.codidioma = idioma;
                baseDatos.precio = datos.Precio;
                baseDatos.year = datos.Year;
                baseDatos.donado = don[1];
                try
                {
                    objDataContext.libros.InsertOnSubmit(baseDatos);
                    objDataContext.SubmitChanges();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                    throw;
                }
                //
                var libronuevo = new List<libros>();
                var query = from lib in _context.libros
                            where lib.titulo == datos.Titulo
                    select new
                    {
                        codlibro = lib.codlibro
                    };
                var lista = query.ToList();
                int[] codigo = new int[10];
                foreach (var libro in lista)
                {
                    codigo[0] = libro.codlibro;
                }
                try
                {
                  var queryproc = objDataContext.insertarAutorxLibro(codigo[0], autor);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                    throw;
                }
                ViewData["regresar"] = "index";
            }
            return View();
        }

        public ActionResult VerAlumnos()
        {
            IList<alumnos> listaAlumnos = new List<alumnos>();
            var query = from alum in _context.alumnos
                select new
                {
                    codalumno = alum.codalumno,
                    nombre = alum.codalumno,
                    telefo = alum.telefono,
                    prestados = alum.numPrestados
                };
            var lista = query.ToList();
            foreach (var listalum in lista)
            {
                listaAlumnos.Add(new alumnos()
                {
                   codalumno = listalum.codalumno,
                   nombre = listalum.nombre,
                   telefono = listalum.telefo,
                   numPrestados = listalum.prestados
                });
            }
            return View(listaAlumnos);
        }

	}
}