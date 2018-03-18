using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
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
            //Se inicia el modulo LINQ en modo solo lectura para recuperar los datos
            _context = new OperacionDataContext();
        }

        public ActionResult Index()
        {
            //Consulta SQL de mas de una tabla
            IList<DetalleLibro> detalleLista = new List<DetalleLibro>(); // se especifica el modelo de datos
            var query = from li in _context.libros
                join te in _context.tematicas on li.codtema equals te.codtema
                join edit in _context.editoriales on li.codeditorial equals edit.codeditorial
                join idi in _context.idiomas on li.codidioma equals idi.codidioma
                select new
                {
                    Codigo = li.codlibro,
                    Titulo = li.titulo,
                    Tema = te.tema,
                    Editorial = edit.editorial,
                    Idioma = idi.idioma,
                    Precio = li.precio,
                    year = li.year
                };
            //Consulta SQL: 
            //select 
            //li.codlibro,li.titulo,te.tema,edit.editorial,idi.idioma,li.precio,li.year
            //    from libros li
            //inner join tematicas te on li.codtema = te.codtema
            //inner join editoriales edit on li.codeditorial = edit.codeditorial
            //inner join idiomas idi on li.codidioma = idi.codidioma
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
            //luego cargamos los valores dentro del modelo de datos y lo enviamos
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
            //Comando where
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
            //select alum.nombre, pre.fechaprestamo, lib.titulo from alumnos alum
            //inner join prestamos pre on alum.codalumno = pre.codalumno
            //inner join ejemplares ejem on ejem.codejemplar = pre.codejemplar
            //inner join libros lib on lib.codlibro = ejem.codlibro 
            //where alum.codalumno = '122311'
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
            //Consulta SQL:
            //select nombre,codalumno from alumnos;
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
            var tema = new List<tematicas>();
            var query = from tem in _context.tematicas
                select new
                {
                    codigo = tem.codtema,
                    tematica = tem.tema
                };
            //select codtema,tema from tematicas;
            var lista = query.ToList();
            foreach (var ddltematica in lista)
            {
                tema.Add(new tematicas()
                {
                    codtema = ddltematica.codigo,
                    tema = ddltematica.tematica
                });
            }
            ViewBag.tema = tema;
            //
            var edito = new List<editoriales>();
            var query2 = from edit in _context.editoriales
                select new
                {
                    codigoedito = edit.codeditorial,
                    editorialnombre = edit.editorial
                };
            var lista2 = query2.ToList();
            foreach (var ddleditorial in lista2)
            {
                edito.Add(new editoriales()
                {
                    codeditorial = ddleditorial.codigoedito,
                    editorial = ddleditorial.editorialnombre
                });
            }
            ViewBag.edito = edito;
            //
            var idioma = new List<idiomas>();
            var query3 = from idio in _context.idiomas
                select new
                {
                    idiomacod = idio.codidioma,
                    idiomanombre = idio.idioma
                };
            var lista3 = query3.ToList();
            foreach (var ddlidioma in lista3)
            {
                idioma.Add(new idiomas()
                {
                   codidioma = ddlidioma.idiomacod,
                   idioma = ddlidioma.idiomanombre
                });
            }
            ViewBag.idioma = idioma;
            //
            var autor = new List<autores>();
            var query4 = from aut in _context.autores
                select new
                {
                    autorCod = aut.codautor,
                    autorNombre = aut.autor
                };
            var lista4 = query4.ToList();
            foreach (var ddlautor in lista4)
            {
                autor.Add(new autores()
                {
                    codautor = ddlautor.autorCod,
                    autor = ddlautor.autorNombre
                });
            }
            ViewBag.autor = autor;
            //
            ViewData["regresar"] = "nada";
            return View(modelo);
        }

        [HttpPost]
        public ActionResult InsertarLibro (int donado, libros datos)
        {
            char[] don = new char[5];
            if (donado == 1)
            {
                don[1] = 'S';
            }
            else
            {
                don[1] = 'N';
            }
            int autor = datos.codlibro;
            using (OperacionDataContext objDataContext = new OperacionDataContext())
            {
                datos.donado = don[1];
                try
                {
                    //Comando Insert
                    objDataContext.libros.InsertOnSubmit(datos);
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
                            where lib.titulo == datos.titulo
                    select new
                    {
                        cod = lib.codlibro
                    };
                var lista = query.ToList();
                int[] codigo = new int[10];
                foreach (var libro in lista)
                {
                    codigo[0] = libro.cod;
                }
                try
                {
                    //Se ejecuta el procedimiento almacenado
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
                    codigo = alum.codalumno,
                    nom = alum.nombre,
                    telefo = alum.telefono,
                    prestados = alum.numPrestados
                };
            // equivalente al select * from alumnos;
            var lista = query.ToList();
            foreach (var listalum in lista)
            {
                listaAlumnos.Add(new alumnos()
                {
                   codalumno = listalum.codigo,
                   nombre = listalum.nom,
                   telefono = listalum.telefo,
                   numPrestados = listalum.prestados
                });
            }
            return View(listaAlumnos);
        }

        public ActionResult HistorialPrestamos()
        {
            //Funciones de agregado count, group by y order by
            IList<Historial> listHistorial = new List<Historial>();
            var query = from alumnose in _context.alumnos
                join prestamose in _context.prestamos on alumnose.codalumno equals prestamose.codalumno
                group new {alumnose, prestamose} by new {alumnose.nombre}
                into grop orderby grop.Count() descending 
                select new
                {
                    _Nombre = grop.Key.nombre,
                    _Cantidad = grop.Count()
                };
            //select alum.nombre,count(pre.codprestamo) from alumnos alum
            //join prestamos pre on alum.codalumno = pre.codalumno
            //group by alum.nombre;
            var lista = query.ToList();
            foreach (var item in lista)
            {
                listHistorial.Add(new Historial()
                {
                    Nombre = item._Nombre,
                    prestamos = item._Cantidad
                });
            }
            return View(listHistorial);
        }

        public ActionResult Autores()
        {
            //Llamar a una vista
           IList<VistaxAutores> listaAutorexlibros = new List<VistaxAutores>();
            var query = from aux in _context.VistaxAutores
                select new
                {
                    Au = aux.autor,
                    lib = aux.titulo
                };
            var lista = query.ToList();
            foreach (var item in lista)
            {
                listaAutorexlibros.Add(new VistaxAutores()
                {
                   autor = item.Au,
                   titulo = item.lib
                });
            }
            return View(listaAutorexlibros);
        }

        public ActionResult ModificarAlumno()
        {
            alumnos alumno = new alumnos();
            var listAlumnos = new List<alumnos>();
            var query = from alum in _context.alumnos
                select new
                {
                    cod = alum.codalumno,
                    nom = alum.nombre
                };
            var lista = query.ToList();
            foreach (var item in lista)
            {
                listAlumnos.Add(new alumnos()
                {
                    codalumno = item.cod,
                    nombre = item.nom,
                });
            }
            ViewBag.alumnos = listAlumnos;
            return View(alumno);
        }

        [HttpPost]
        public ActionResult ModificarAlumno(string nuevo, alumnos datosAlumnos)
        {
                //Comando Update
                OperacionDataContext objDataContext = new OperacionDataContext();
                alumnos alum = objDataContext.alumnos.Single(x => x.codalumno == datosAlumnos.codalumno);
                alum.telefono = nuevo;
                try
                {
                    objDataContext.SubmitChanges();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                    throw;
                }
            return RedirectToAction("Index");
        }

        public ActionResult BorrarAlumno()
        {
            alumnos alumno = new alumnos();
            var listAlumnos = new List<alumnos>();
            var query = from alum in _context.alumnos
                select new
                {
                    cod = alum.codalumno,
                    nom = alum.nombre
                };
            var lista = query.ToList();
            foreach (var item in lista)
            {
                listAlumnos.Add(new alumnos()
                {
                    codalumno = item.cod,
                    nombre = item.nom,
                });
            }
            ViewBag.alumnos = listAlumnos;
            return View(alumno);
        }

        [HttpPost]
        public ActionResult BorrarAlumno(alumnos objAlumnos)
        {
            //comando delete
            try
            {
                OperacionDataContext objDataContext = new OperacionDataContext();
                alumnos alum = objDataContext.alumnos.Single(x => x.codalumno == objAlumnos.codalumno);
                objDataContext.alumnos.DeleteOnSubmit(alum);
                objDataContext.SubmitChanges();
            }
            catch
            {
                Console.WriteLine("ERROR");
            }
            return RedirectToAction("Index");
        }

        public ActionResult ArregloNumeros()
        {
            //Usando LINQ sin necesidad de una base de datos (Ejemplo Basico)
            IList<numeros> nume = new List<numeros>();
            int[] numeros = new int[51];
            Random rnd = new Random();
            for (int i = 0; i < 50; i++)
            {
                numeros[i] = rnd.Next(-5000, 5000);
            }

            var query = from num in numeros
                where (num % 2) == 0
                orderby num descending 
                select new
                {
                    n = num
                };

            var lista = query.ToList();

            foreach (var item in lista)
            {
                nume.Add(new numeros()
                {
                    num = item.n
                });
            }

            return View(nume);

        }
	}
}