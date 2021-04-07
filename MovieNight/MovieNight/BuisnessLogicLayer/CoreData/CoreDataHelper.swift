import UIKit
import CoreData

final class CoreDataHelper {

    private var context: NSManagedObjectContext? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.persistentContainer.viewContext
    }

    func save(_ movie: MovieResonse, with completion: @escaping (String) -> Void) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
        else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)

        let movieData = try? JSONEncoder().encode(movie)
        managedObject.setValue(movieData, forKey: "movieData")

        do {
            try context.save()
            completion("Saved")
        } catch let error as NSError {
            completion("Error")
            print(error)
        }
    }

    func fetchMovies(with completion: @escaping ([MovieResonse]) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")

        do {
            let entries = try context?.fetch(fetchRequest)
            var movies = [MovieResonse]()
            entries?.forEach { managedObject in
                guard let movieData = managedObject.value(forKey: "movieData") as? Data,
                      let movie = try? JSONDecoder().decode(MovieResonse.self, from: movieData)
                else { return }
                movies.append(movie)
            }
            completion(movies)
        } catch let error as NSError {
            print(error)
        }
    }
}
