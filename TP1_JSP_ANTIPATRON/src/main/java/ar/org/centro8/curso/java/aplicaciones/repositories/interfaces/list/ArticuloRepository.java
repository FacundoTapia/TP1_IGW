package ar.org.centro8.curso.java.aplicaciones.repositories.interfaces.list;

import ar.org.centro8.curso.java.aplicaciones.entities.Articulo;
import ar.org.centro8.curso.java.aplicaciones.repositories.interfaces.I_ArticuloRepository;
import java.util.ArrayList;
import java.util.List;

public class ArticuloRepository implements I_ArticuloRepository{
    private List<Articulo> list = new ArrayList();
    
    @Override
    public void save(Articulo articulo) {
        list.add(articulo);
    }

    @Override
    public void remove(Articulo articulo) {
        list.remove(articulo);
    }

    @Override
    public void update(Articulo articulo) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Articulo> getAll() {
        return list;
    }
}