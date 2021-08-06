package ar.org.centro8.curso.java.aplicaciones.repositories.interfaces.list;
public class ArticuloRepositoryFactory {
    private static ArticuloRepository ar = new ArticuloRepository();

    private ArticuloRepositoryFactory() {}

    public static ArticuloRepository getArticuloRepository() {
        return ar;
    }
}