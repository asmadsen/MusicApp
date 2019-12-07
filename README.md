# Exam PG5600

The app is written using SwiftUI and is using Combine for handling asyncronous behavior in a stream oriented fashion. Because of this it might not be ideomatic compared to the way one would write a UIKit app, but from my understanding it matches the style Apple is focusing on with SwiftUI.

Because of the little to no overhead from creating SwiftUI components I have split functionality up into multiple components both for separation of concerns and reusability.

I have also created a component named ActivityIndicator, which is a UIViewRepresentable and is the way you would use regular UIKit components from SwiftUI.


The app is built using a MVVM pattern, in that sense that little to no business logic is in the components itself, but most of the logic is in a ViewModel. And because of the scope of the app I choose to gather all of that logic in one AppViewModel. 


The external libraries is used as Swift Packages, I'm not sure where the files are located but when opening the project from another folder XCode automatically loaded them.

I have used two external libraries, one called [SwURL](https://github.com/cmtrounce/SwURL) which makes it easier to handle displaying images from URL's, and one called [GridStack](https://github.com/pietropizzi/GridStack) which implements the same functionality as a CollectionView which isn't provided by SwiftUI.

