# SwiftMVVMSample
MVVM has become the default way I write iOS apps. There are many advantages in using MVVM vs the classic MVC in iOS development. It divides the business logic with the presentation layer. Instead of having a massive ViewController, we can delegate things like requesting data from the network or a local database to viewModel.

This is a simple example that shows how to use MVVM in Swift project.
I created a simple collectionview with custom cells, that shows a track's image and title.
I used this API -> "https://itunes.apple.com/search?term=onedirection&entity=musicVideo"


I made a viewmodel for the main viewcontroller of the app that contains a collectionview. Actually the controller is responsible for creating the viewmodel. Viewmodel is the business layer and contains the business logic.
The viewmodel does not perform networking tasks. There is another layer called service, that performs API calls and gets data from a server and delivers data to the viewmodel.
I used a custom class Dynamic<T> ( http://rasic.info/bindings-generics-swift-and-mvvm/ ). This setups one-directional binding from viewmodel to the user interface elements.
I also created a viewmodel for each cell of collectionview that contains the logic of each cell.
