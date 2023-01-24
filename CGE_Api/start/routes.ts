import Route from '@ioc:Adonis/Core/Route'

Route.post('/login', 'AuthController.login');
Route.post('/logout', 'AuthController.logout');

Route.post('/empresa/cadastro', 'EmpresasController.store');

Route.group(() => {
  Route.get('auth/me', 'AuthController.me');

  Route.get('/Tecnicos', 'TecnicosController.index');
  Route.post('/tecnico/cadastro', 'TecnicosController.store');
  Route.put('/tecnico', 'TecnicosController.update');
  Route.delete('/tecnico/:id', 'TecnicosController.destroy');

  Route.get('/Empresas', 'EmpresasController.index');
  Route.put('/empresa', 'EmpresasController.update');
  Route.delete('/empresa/:id', 'EmpresasController.destroy');

  Route.get('/setors', 'SetorsController.index');
  Route.post('/setor/cadastro', 'SetorsController.store');
  Route.put('/setor', 'SetorsController.update');
  Route.delete('/setor/:id', 'SetorsController.destroy');
  
}).middleware('auth');