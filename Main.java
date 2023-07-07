import Controller.PetController;
import Model.Pet;
import Services.Repository;
import Services.PetRepository;
import UI.Menu;

public class Main {
    public static void main(String[] args) throws Exception {

        Repository <Pet> myFarm = new PetRepository();
        PetController controller = new PetController(myFarm);
        new Menu (controller).start();
    }
}    