package ar.org.centro8.curso.java.aplicaciones.test;

import ar.org.centro8.curso.java.aplicaciones.entities.Articulo;
import ar.org.centro8.curso.java.aplicaciones.repositories.interfaces.I_ArticuloRepository;
import ar.org.centro8.curso.java.aplicaciones.repositories.interfaces.list.ArticuloRepositoryFactory;

public class TestArticuloRepository {
    public static void main(String[] args) {
        I_ArticuloRepository ar = ArticuloRepositoryFactory.getArticuloRepository();
        
        ar.save(null);
        ar.save(new Articulo(1, "Parlante usb", 2500));
        ar.save(new Articulo(2, "mouse usb", 2000));
        ar.save(new Articulo(3, "monitor lcd", 25000));
        ar.save(new Articulo(4, "Parlante bluetooth", 3500));
        
        ar.getAll().forEach(System.out::println);
        System.out.println("**************************************");
        ar.getLikeDescripcion("parlante").forEach(System.out::println);
    }
}
