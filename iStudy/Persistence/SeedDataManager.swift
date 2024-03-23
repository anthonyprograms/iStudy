//
//  SeedDataManager.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftData

/// Seeds the database with intial data for the game
/// Note: this could've been done with JSON, but this made it easier for me to work with
final class SeedDataManager {

    public static func seedDatabase(container: ModelContainer) {
        let modelContext = ModelContext(container)
        
        let descriptor = FetchDescriptor<Category>()
        do {            
            let categories = try modelContext.fetch(descriptor)
            
            if categories.count == 0 {
                for category in defaultCategories {
                    modelContext.insert(category)
                }
                
                try modelContext.save()
            }
        } catch {
            print("Error fetching database for seeding")
        }        
    }
    
    // MARK: - Categories
    
    private static var defaultCategories: [Category] = [
        Category(name: "SwiftUI", prompts: swiftUIPrompts),
        Category(name: "CoreData", prompts: coreDataPrompts),
        Category(name: "Animations", prompts: animationPrompts),
        Category(name: "Networking", prompts: networkingPrompts),
        Category(name: "Concurrency", prompts: concurrencyPrompts),
        Category(name: "App Architecture", prompts: appArchitecturePrompts),
        Category(name: "Design Patterns", prompts: designPatternsPrompts),
        Category(name: "Memory Management", prompts: memoryManagementPrompts)
    ]
    
    // MARK: - Prompts
        
    private static var swiftUIPrompts: [Prompt] {
        return [
            Prompt(categoryName: "SwiftUI",  id: "P001", question: "What is the primary benefit of using SwiftUI for iOS app development?", choices: [
                Choice(promptId: "P001", text: "Improved performance", isCorrect: false),
                Choice(promptId: "P001", text: "Reduced development time", isCorrect: true),
                Choice(promptId: "P001", text: "Better backward compatibility", isCorrect: false),
                Choice(promptId: "P001", text: "Enhanced security", isCorrect: false),
            ], explanation: "SwiftUI simplifies the process of building user interfaces by using a declarative syntax and providing built-in tools for common tasks, which can significantly reduce the amount of code needed and speed up development time."),
            Prompt(categoryName: "SwiftUI",  id: "P002", question: "How can you create a button with SwiftUI?", choices: [
                Choice(promptId: "P002", text: "Using UIButton class", isCorrect: false),
                Choice(promptId: "P002", text: "Using UILabel class", isCorrect: false),
                Choice(promptId: "P002", text: "Using Text view with onTapGesture modifier", isCorrect: true),
                Choice(promptId: "P002", text: "Using UIImageView class", isCorrect: false),
            ], explanation: "In SwiftUI, you can create a button using a Text view and apply the onTapGesture modifier to detect taps and trigger actions. This approach provides a simple and flexible way to create interactive elements in SwiftUI interfaces."),
            Prompt(categoryName: "SwiftUI",  id: "P003", question: "What is the primary layout system used in SwiftUI?", choices: [
                Choice(promptId: "P003", text: "Auto Layout", isCorrect: false),
                Choice(promptId: "P003", text: "Stacks", isCorrect: true),
                Choice(promptId: "P003", text: "Frame-based layout", isCorrect: false),
                Choice(promptId: "P003", text: "Constraint-based layout", isCorrect: false),
            ], explanation: "The primary layout system used in SwiftUI is stacks, which allow you to arrange views horizontally or vertically and automatically adjust their positions and sizes based on content and device size."),
            Prompt(categoryName: "SwiftUI",  id: "P004", question: "Which modifier is used to apply padding to a view in SwiftUI?", choices: [
                Choice(promptId: "P004", text: "padding()", isCorrect: true),
                Choice(promptId: "P004", text: "margin()", isCorrect: false),
                Choice(promptId: "P004", text: "spacing()", isCorrect: false),
                Choice(promptId: "P004", text: "frame()", isCorrect: false),
            ], explanation: "The padding() modifier is used to apply padding around a view in SwiftUI, specifying the amount of padding to apply to each edge of the view."),
            Prompt(categoryName: "SwiftUI",  id: "P005", question: "What is the purpose of the @State property wrapper in SwiftUI?", choices: [
                Choice(promptId: "P005", text: "To store global application state", isCorrect: false),
                Choice(promptId: "P005", text: "To manage mutable state within a view", isCorrect: true),
                Choice(promptId: "P005", text: "To define a computed property", isCorrect: false),
                Choice(promptId: "P005", text: "To bind data to user interface elements", isCorrect: false),
            ], explanation: "The @State property wrapper is used to manage mutable state within a view in SwiftUI, allowing the view to update its appearance based on changes to the state."),
            Prompt(categoryName: "SwiftUI",  id: "P006", question: "Which container view is used to display a single child view in SwiftUI?", choices: [
                Choice(promptId: "P006", text: "HStack", isCorrect: false),
                Choice(promptId: "P006", text: "VStack", isCorrect: false),
                Choice(promptId: "P006", text: "ZStack", isCorrect: false),
                Choice(promptId: "P006", text: "NavigationView", isCorrect: true),
            ], explanation: "The NavigationView container view is used to display a single child view with built-in navigation functionality in SwiftUI, typically used as the root view for navigation-based interfaces."),
            Prompt(categoryName: "SwiftUI",  id: "P007", question: "What is the purpose of the NavigationLink view in SwiftUI?", choices: [
                Choice(promptId: "P007", text: "To create a navigation bar title", isCorrect: false),
                Choice(promptId: "P007", text: "To embed child views within a navigation hierarchy", isCorrect: true),
                Choice(promptId: "P007", text: "To customize the appearance of navigation bar items", isCorrect: false),
                Choice(promptId: "P007", text: "To define navigation transitions and animations", isCorrect: false),
            ], explanation: "The NavigationLink view is used to embed child views within a navigation hierarchy in SwiftUI, allowing users to navigate between different views using built-in navigation functionality."),
            Prompt(categoryName: "SwiftUI",  id: "P008", question: "Which view modifier is used to apply a border to a view in SwiftUI?", choices: [
                Choice(promptId: "P008", text: "border()", isCorrect: true),
                Choice(promptId: "P008", text: "stroke()", isCorrect: false),
                Choice(promptId: "P008", text: "shadow()", isCorrect: false),
                Choice(promptId: "P008", text: "background()", isCorrect: false),
            ], explanation: "The border() modifier is used to apply a border with the specified color and width to a view in SwiftUI, adding a border around the edges of the view."),
            Prompt(categoryName: "SwiftUI",  id: "P009", question: "What is the purpose of the List view in SwiftUI?", choices: [
                Choice(promptId: "P009", text: "To display a scrollable list of data", isCorrect: true),
                Choice(promptId: "P009", text: "To create a navigation bar title", isCorrect: false),
                Choice(promptId: "P009", text: "To embed child views within a navigation hierarchy", isCorrect: false),
                Choice(promptId: "P009", text: "To define navigation transitions and animations", isCorrect: false),
            ], explanation: "The List view is used to display a scrollable list of data in SwiftUI, allowing users to scroll through and interact with a collection of items."),
            Prompt(categoryName: "SwiftUI",  id: "P010", question: "Which view modifier is used to apply a shadow to a view in SwiftUI?", choices: [
                Choice(promptId: "P010", text: "shadow()", isCorrect: true),
                Choice(promptId: "P010", text: "border()", isCorrect: false),
                Choice(promptId: "P010", text: "padding()", isCorrect: false),
                Choice(promptId: "P010", text: "frame()", isCorrect: false),
            ], explanation: "The shadow() modifier is used to apply a shadow with the specified color, radius, and other parameters to a view in SwiftUI, adding a shadow effect to the view's appearance."),
            Prompt(categoryName: "SwiftUI",  id: "P011", question: "What is the purpose of the @Binding property wrapper in SwiftUI?", choices: [
                Choice(promptId: "P011", text: "To store global application state", isCorrect: false),
                Choice(promptId: "P011", text: "To manage mutable state within a view", isCorrect: false),
                Choice(promptId: "P011", text: "To bind data to user interface elements", isCorrect: true),
                Choice(promptId: "P011", text: "To define a computed property", isCorrect: false),
            ], explanation: "The @Binding property wrapper is used to bind data from a parent view to a child view in SwiftUI, allowing changes to the child view's state to be reflected in the parent view and vice versa."),
            Prompt(categoryName: "SwiftUI",  id: "P012", question: "Which view modifier is used to apply a gradient to a view background in SwiftUI?", choices: [
                Choice(promptId: "P012", text: "background()", isCorrect: true),
                Choice(promptId: "P012", text: "padding()", isCorrect: false),
                Choice(promptId: "P012", text: "shadow()", isCorrect: false),
                Choice(promptId: "P012", text: "frame()", isCorrect: false),
            ], explanation: "The background() modifier is used to apply a gradient with the specified colors and gradient type to a view background in SwiftUI, adding a gradient effect to the view's appearance.")
        ]
    }
    
    private static var coreDataPrompts: [Prompt] {
        return [
            Prompt(categoryName: "CoreData",  id: "P101", question: "What is Core Data used for in iOS development?", choices: [
                Choice(promptId: "P101", text: "Networking", isCorrect: false),
                Choice(promptId: "P101", text: "User interface layout", isCorrect: false),
                Choice(promptId: "P101", text: "Data persistence", isCorrect: true),
                Choice(promptId: "P101", text: "Concurrency", isCorrect: false),
            ], explanation: "Core Data is a framework provided by Apple for managing the model layer of an iOS app and enabling data persistence."),
            Prompt(categoryName: "CoreData",  id: "P102", question: "What is the primary entity in a Core Data data model called?", choices: [
                Choice(promptId: "P102", text: "Object", isCorrect: false),
                Choice(promptId: "P102", text: "Table", isCorrect: false),
                Choice(promptId: "P102", text: "Entity", isCorrect: true),
                Choice(promptId: "P102", text: "Model", isCorrect: false),
            ], explanation: "In Core Data, the primary entity in a data model is called an Entity, which represents a type of object that can be persisted to a data store."),
            Prompt(categoryName: "CoreData",  id: "P103", question: "Which type of data store does Core Data primarily use for data persistence on iOS devices?", choices: [
                Choice(promptId: "P103", text: "SQLite", isCorrect: true),
                Choice(promptId: "P103", text: "JSON", isCorrect: false),
                Choice(promptId: "P103", text: "UserDefaults", isCorrect: false),
                Choice(promptId: "P103", text: "Firebase", isCorrect: false),
            ], explanation: "Core Data primarily uses SQLite as the underlying data store for data persistence on iOS devices, providing efficient storage and retrieval of data."),
            Prompt(categoryName: "CoreData",  id: "P104", question: "What is the purpose of an NSManagedObject subclass in Core Data?", choices: [
                Choice(promptId: "P104", text: "To define the structure of the data model", isCorrect: false),
                Choice(promptId: "P104", text: "To represent an instance of a managed object", isCorrect: true),
                Choice(promptId: "P104", text: "To manage the Core Data stack", isCorrect: false),
                Choice(promptId: "P104", text: "To perform fetch requests", isCorrect: false),
            ], explanation: "An NSManagedObject subclass in Core Data is used to represent an instance of a managed object, providing properties and methods for accessing and manipulating data stored in the data store."),
            Prompt(categoryName: "CoreData",  id: "P105", question: "How do you perform fetch requests in Core Data?", choices: [
                Choice(promptId: "P105", text: "Using NSCoding", isCorrect: false),
                Choice(promptId: "P105", text: "Using NSFetchRequest", isCorrect: true),
                Choice(promptId: "P105", text: "Using NSUserDefaults", isCorrect: false),
                Choice(promptId: "P105", text: "Using NSManagedObjectModel", isCorrect: false),
            ], explanation: "In Core Data, you perform fetch requests using NSFetchRequest, which allows you to specify criteria for fetching managed objects from the data store."),
            Prompt(categoryName: "CoreData",  id: "P106", question: "What is the purpose of the NSFetchedResultsController class in Core Data?", choices: [
                Choice(promptId: "P106", text: "To define the structure of the data model", isCorrect: false),
                Choice(promptId: "P106", text: "To manage the Core Data stack", isCorrect: false),
                Choice(promptId: "P106", text: "To perform fetch requests", isCorrect: false),
                Choice(promptId: "P106", text: "To efficiently manage results from fetch requests", isCorrect: true),
            ], explanation: "The NSFetchedResultsController class in Core Data is used to efficiently manage results from fetch requests, providing automatic updates and sectioning for use with table and collection views."),
            Prompt(categoryName: "CoreData",  id: "P107", question: "What is a managed object context in Core Data?", choices: [
                Choice(promptId: "P107", text: "A representation of an entity in the data model", isCorrect: false),
                Choice(promptId: "P107", text: "A representation of a data store", isCorrect: false),
                Choice(promptId: "P107", text: "An object representing a single instance of a managed object", isCorrect: false),
                Choice(promptId: "P107", text: "An environment for managing a collection of managed objects", isCorrect: true),
            ], explanation: "A managed object context in Core Data is an environment for managing a collection of managed objects, providing a context for objects to interact with each other and the data store."),
            Prompt(categoryName: "CoreData",  id: "P108", question: "What is the purpose of the NSPersistentContainer class in Core Data?", choices: [
                Choice(promptId: "P108", text: "To define the structure of the data model", isCorrect: false),
                Choice(promptId: "P108", text: "To represent an instance of a managed object", isCorrect: false),
                Choice(promptId: "P108", text: "To manage the Core Data stack", isCorrect: true),
                Choice(promptId: "P108", text: "To perform fetch requests", isCorrect: false),
            ], explanation: "The NSPersistentContainer class in Core Data is used to manage the Core Data stack, providing access to the managed object model, persistent store coordinator, and managed object context.")
        ]
    }
    
    private static var animationPrompts: [Prompt] {
        return [
            Prompt(categoryName: "Animations",  id: "P201", question: "What is the primary purpose of animations in iOS app development?", choices: [
                Choice(promptId: "P201", text: "To enhance user interactions", isCorrect: true),
                Choice(promptId: "P201", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P201", text: "To handle networking requests", isCorrect: false),
                Choice(promptId: "P201", text: "To define app architecture", isCorrect: false),
            ], explanation: "Animations in iOS app development are primarily used to enhance user interactions, providing visual feedback and making the user interface more engaging and intuitive."),
            Prompt(categoryName: "Animations",  id: "P202", question: "Which framework is commonly used for creating animations in iOS apps?", choices: [
                Choice(promptId: "P202", text: "Core Data", isCorrect: false),
                Choice(promptId: "P202", text: "SpriteKit", isCorrect: true),
                Choice(promptId: "P202", text: "Core Graphics", isCorrect: false),
                Choice(promptId: "P202", text: "Core Animation", isCorrect: false),
            ], explanation: "SpriteKit is a framework commonly used for creating animations in iOS apps, providing high-performance support for 2D graphics and animations."),
            Prompt(categoryName: "Animations",  id: "P203", question: "What is the purpose of the UIView.animate() method in iOS development?", choices: [
                Choice(promptId: "P203", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P203", text: "To create animations with explicit timing and options", isCorrect: true),
                Choice(promptId: "P203", text: "To handle networking requests", isCorrect: false),
                Choice(promptId: "P203", text: "To define app architecture", isCorrect: false),
            ], explanation: "The UIView.animate() method in iOS development is used to create animations with explicit timing and options, allowing developers to define custom animations for view transitions and changes."),
            Prompt(categoryName: "Animations",  id: "P204", question: "Which animation curve is characterized by constant speed throughout the animation?", choices: [
                Choice(promptId: "P204", text: "Ease In", isCorrect: false),
                Choice(promptId: "P204", text: "Ease Out", isCorrect: false),
                Choice(promptId: "P204", text: "Ease In-Out", isCorrect: false),
                Choice(promptId: "P204", text: "Linear", isCorrect: true),
            ], explanation: "The Linear animation curve is characterized by constant speed throughout the animation, resulting in a consistent rate of change in the animation over time."),
            Prompt(categoryName: "Animations",  id: "P205", question: "What is the purpose of the CGAffineTransform struct in iOS development?", choices: [
                Choice(promptId: "P205", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P205", text: "To apply affine transformations to views", isCorrect: true),
                Choice(promptId: "P205", text: "To handle networking requests", isCorrect: false),
                Choice(promptId: "P205", text: "To define app architecture", isCorrect: false),
            ], explanation: "The CGAffineTransform struct in iOS development is used to apply affine transformations, such as rotation, scaling, translation, and skewing, to views and other graphical elements."),
            Prompt(categoryName: "Animations",  id: "P206", question: "What is the primary benefit of using keyframe animations in iOS development?", choices: [
                Choice(promptId: "P206", text: "To simplify the animation code", isCorrect: false),
                Choice(promptId: "P206", text: "To create complex animations with precise control", isCorrect: true),
                Choice(promptId: "P206", text: "To improve app performance", isCorrect: false),
                Choice(promptId: "P206", text: "To handle networking requests", isCorrect: false),
            ], explanation: "Keyframe animations in iOS development allow developers to create complex animations with precise control over timing and intermediate states, enabling the creation of dynamic and engaging user interfaces."),
        ]
    }

    private static var networkingPrompts: [Prompt] {
        return [
            Prompt(categoryName: "Networking",  id: "P301", question: "What is networking used for in iOS app development?", choices: [
                Choice(promptId: "P301", text: "To create user interfaces", isCorrect: false),
                Choice(promptId: "P301", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P301", text: "To communicate with remote servers", isCorrect: true),
                Choice(promptId: "P301", text: "To define app architecture", isCorrect: false),
            ], explanation: "Networking in iOS app development is used to communicate with remote servers, allowing apps to fetch and send data over the internet."),
            Prompt(categoryName: "Networking",  id: "P302", question: "Which framework is commonly used for making network requests in iOS apps?", choices: [
                Choice(promptId: "P302", text: "Core Data", isCorrect: false),
                Choice(promptId: "P302", text: "SpriteKit", isCorrect: false),
                Choice(promptId: "P302", text: "Core Graphics", isCorrect: false),
                Choice(promptId: "P302", text: "URLSession", isCorrect: true),
            ], explanation: "URLSession is a framework commonly used for making network requests in iOS apps, providing high-level APIs for sending and receiving data over HTTP and other protocols."),
            Prompt(categoryName: "Networking",  id: "P303", question: "What is the purpose of the URLRequest class in iOS development?", choices: [
                Choice(promptId: "P303", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P303", text: "To define the structure of the data model", isCorrect: false),
                Choice(promptId: "P303", text: "To represent a URL request", isCorrect: true),
                Choice(promptId: "P303", text: "To create animations", isCorrect: false),
            ], explanation: "The URLRequest class in iOS development is used to represent a URL request, encapsulating the information needed to make a network request, such as the URL, HTTP method, headers, and body."),
            Prompt(categoryName: "Networking",  id: "P304", question: "Which HTTP method is typically used for retrieving data from a server in iOS app development?", choices: [
                Choice(promptId: "P304", text: "GET", isCorrect: true),
                Choice(promptId: "P304", text: "POST", isCorrect: false),
                Choice(promptId: "P304", text: "PUT", isCorrect: false),
                Choice(promptId: "P304", text: "DELETE", isCorrect: false),
            ], explanation: "The GET HTTP method is typically used for retrieving data from a server in iOS app development, allowing clients to request data from a specified resource."),
            Prompt(categoryName: "Networking",  id: "P305", question: "What is the purpose of the URLSessionDataTask class in iOS development?", choices: [
                Choice(promptId: "P305", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P305", text: "To represent a single network data transfer task", isCorrect: true),
                Choice(promptId: "P305", text: "To create animations", isCorrect: false),
                Choice(promptId: "P305", text: "To define the structure of the data model", isCorrect: false),
            ], explanation: "The URLSessionDataTask class in iOS development is used to represent a single network data transfer task, providing methods for starting, suspending, resuming, and canceling the task."),
            Prompt(categoryName: "Networking",  id: "P306", question: "What is the purpose of the URLSessionDelegate protocol in iOS development?", choices: [
                Choice(promptId: "P306", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P306", text: "To handle URL session events and authentication challenges", isCorrect: true),
                Choice(promptId: "P306", text: "To create animations", isCorrect: false),
                Choice(promptId: "P306", text: "To define the structure of the data model", isCorrect: false),
            ], explanation: "The URLSessionDelegate protocol in iOS development is used to handle URL session events, such as task completion, and authentication challenges, providing methods for responding to and customizing the behavior of URL session tasks."),
        ]
    }

    private static var concurrencyPrompts: [Prompt] {
        return [
            Prompt(categoryName: "Concurrency",  id: "P401", question: "What is concurrency in the context of iOS app development?", choices: [
                Choice(promptId: "P401", text: "Handling networking requests", isCorrect: false),
                Choice(promptId: "P401", text: "Managing user interface layout", isCorrect: false),
                Choice(promptId: "P401", text: "Performing multiple tasks concurrently", isCorrect: true),
                Choice(promptId: "P401", text: "Creating animations", isCorrect: false),
            ], explanation: "Concurrency in iOS app development refers to the ability to perform multiple tasks concurrently, allowing apps to execute multiple operations simultaneously to improve performance and responsiveness."),
            Prompt(categoryName: "Concurrency",  id: "P402", question: "Which framework provides APIs for performing concurrent operations in iOS apps?", choices: [
                Choice(promptId: "P402", text: "Core Data", isCorrect: false),
                Choice(promptId: "P402", text: "SpriteKit", isCorrect: false),
                Choice(promptId: "P402", text: "GCD (Grand Central Dispatch)", isCorrect: true),
                Choice(promptId: "P402", text: "Core Graphics", isCorrect: false),
            ], explanation: "GCD (Grand Central Dispatch) is a framework that provides APIs for performing concurrent operations in iOS apps, allowing developers to execute tasks concurrently on different threads."),
            Prompt(categoryName: "Concurrency",  id: "P403", question: "What is the purpose of DispatchQueue in GCD?", choices: [
                Choice(promptId: "P403", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P403", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P403", text: "To schedule and execute tasks concurrently on different threads", isCorrect: true),
                Choice(promptId: "P403", text: "To create animations", isCorrect: false),
            ], explanation: "DispatchQueue in GCD is used to schedule and execute tasks concurrently on different threads, providing a mechanism for managing concurrent execution and synchronization."),
            Prompt(categoryName: "Concurrency",  id: "P404", question: "What is the difference between serial and concurrent queues in GCD?", choices: [
                Choice(promptId: "P404", text: "Serial queues execute tasks concurrently, while concurrent queues execute tasks sequentially", isCorrect: false),
                Choice(promptId: "P404", text: "Serial queues execute tasks sequentially, while concurrent queues execute tasks concurrently", isCorrect: true),
                Choice(promptId: "P404", text: "Serial queues execute tasks in parallel, while concurrent queues execute tasks sequentially", isCorrect: false),
                Choice(promptId: "P404", text: "Serial queues execute tasks concurrently, while concurrent queues execute tasks in parallel", isCorrect: false),
            ], explanation: "Serial queues in GCD execute tasks sequentially, while concurrent queues execute tasks concurrently, meaning that tasks in a concurrent queue can run simultaneously on different threads."),
            Prompt(categoryName: "Concurrency",  id: "P405", question: "What is the purpose of DispatchQueue.main in iOS app development?", choices: [
                Choice(promptId: "P405", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P405", text: "To manage user interface layout", isCorrect: true),
                Choice(promptId: "P405", text: "To schedule and execute tasks concurrently on different threads", isCorrect: false),
                Choice(promptId: "P405", text: "To create animations", isCorrect: false),
            ], explanation: "DispatchQueue.main in iOS app development is used to manage user interface layout, allowing tasks to be scheduled and executed on the main thread, which is responsible for updating the user interface."),
            Prompt(categoryName: "Concurrency",  id: "P406", question: "What is the purpose of DispatchQueue.global() in iOS app development?", choices: [
                Choice(promptId: "P406", text: "To manage data persistence", isCorrect: false),
                Choice(promptId: "P406", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P406", text: "To schedule and execute tasks concurrently on different threads", isCorrect: true),
                Choice(promptId: "P406", text: "To create animations", isCorrect: false),
            ], explanation: "DispatchQueue.global() in iOS app development is used to schedule and execute tasks concurrently on different threads, providing a global concurrent queue for performing background tasks."),
        ]
    }

    private static var appArchitecturePrompts: [Prompt] {
        return [
            Prompt(categoryName: "App Architecture",  id: "P501", question: "What is app architecture in the context of iOS development?", choices: [
                Choice(promptId: "P501", text: "The design of user interface elements", isCorrect: false),
                Choice(promptId: "P501", text: "The structure and organization of an app's codebase", isCorrect: true),
                Choice(promptId: "P501", text: "The process of submitting an app to the App Store", isCorrect: false),
                Choice(promptId: "P501", text: "The distribution of app resources on different devices", isCorrect: false),
            ], explanation: "App architecture in iOS development refers to the structure and organization of an app's codebase, including how components are designed, connected, and managed."),
            Prompt(categoryName: "App Architecture",  id: "P502", question: "What is the Model-View-Controller (MVC) architecture pattern?", choices: [
                Choice(promptId: "P502", text: "A design pattern for creating user interfaces", isCorrect: false),
                Choice(promptId: "P502", text: "An architectural pattern that separates an app into three components: Model, View, and Controller", isCorrect: true),
                Choice(promptId: "P502", text: "A framework provided by Apple for building iOS apps", isCorrect: false),
                Choice(promptId: "P502", text: "A protocol-oriented programming paradigm", isCorrect: false),
            ], explanation: "The Model-View-Controller (MVC) architecture pattern is an architectural pattern that separates an app into three main components: Model (data), View (presentation), and Controller (logic)."),
            Prompt(categoryName: "App Architecture",  id: "P503", question: "What is the purpose of the Model component in the MVC architecture pattern?", choices: [
                Choice(promptId: "P503", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P503", text: "To handle user interactions and events", isCorrect: false),
                Choice(promptId: "P503", text: "To represent the data and business logic of an app", isCorrect: true),
                Choice(promptId: "P503", text: "To define the appearance and behavior of user interface elements", isCorrect: false),
            ], explanation: "The purpose of the Model component in the MVC architecture pattern is to represent the data and business logic of an app, encapsulating the app's data and providing methods for accessing and manipulating that data."),
            Prompt(categoryName: "App Architecture",  id: "P504", question: "What is the purpose of the View component in the MVC architecture pattern?", choices: [
                Choice(promptId: "P504", text: "To represent the data and business logic of an app", isCorrect: false),
                Choice(promptId: "P504", text: "To manage user interface layout", isCorrect: true),
                Choice(promptId: "P504", text: "To handle user interactions and events", isCorrect: false),
                Choice(promptId: "P504", text: "To define the appearance and behavior of user interface elements", isCorrect: false),
            ], explanation: "The purpose of the View component in the MVC architecture pattern is to manage user interface layout, defining the appearance and layout of user interface elements based on the data provided by the Model."),
            Prompt(categoryName: "App Architecture",  id: "P505", question: "What is the purpose of the Controller component in the MVC architecture pattern?", choices: [
                Choice(promptId: "P505", text: "To represent the data and business logic of an app", isCorrect: false),
                Choice(promptId: "P505", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P505", text: "To handle user interactions and events", isCorrect: true),
                Choice(promptId: "P505", text: "To define the appearance and behavior of user interface elements", isCorrect: false),
            ], explanation: "The purpose of the Controller component in the MVC architecture pattern is to handle user interactions and events, serving as an intermediary between the View and Model components."),
            Prompt(categoryName: "App Architecture",  id: "P506", question: "What is the purpose of the AppDelegate.swift file in an iOS app project?", choices: [
                Choice(promptId: "P506", text: "To define the structure of the data model", isCorrect: false),
                Choice(promptId: "P506", text: "To manage the app's user interface layout", isCorrect: false),
                Choice(promptId: "P506", text: "To handle app-level events and lifecycle callbacks", isCorrect: true),
                Choice(promptId: "P506", text: "To implement custom animations and transitions", isCorrect: false),
            ], explanation: "The AppDelegate.swift file in an iOS app project is used to handle app-level events and lifecycle callbacks, such as app launch, termination, and background execution."),
        ]
    }

    private static var designPatternsPrompts: [Prompt] {
        return [
            Prompt(categoryName: "Design Patterns",  id: "P601", question: "What are design patterns in the context of software development?", choices: [
                Choice(promptId: "P601", text: "Predefined UI components provided by Apple", isCorrect: false),
                Choice(promptId: "P601", text: "Reusable solutions to common problems in software design", isCorrect: true),
                Choice(promptId: "P601", text: "Built-in features of programming languages", isCorrect: false),
                Choice(promptId: "P601", text: "Techniques for optimizing app performance", isCorrect: false),
            ], explanation: "Design patterns in the context of software development are reusable solutions to common problems in software design, providing templates and guidelines for structuring and organizing code."),
            Prompt(categoryName: "Design Patterns",  id: "P602", question: "What is the Singleton design pattern?", choices: [
                Choice(promptId: "P602", text: "A design pattern for creating a single instance of a class", isCorrect: true),
                Choice(promptId: "P602", text: "A design pattern for managing user interface layout", isCorrect: false),
                Choice(promptId: "P602", text: "A design pattern for handling user interactions and events", isCorrect: false),
                Choice(promptId: "P602", text: "A design pattern for defining the appearance and behavior of user interface elements", isCorrect: false),
            ], explanation: "The Singleton design pattern is a design pattern for creating a single instance of a class, ensuring that only one instance of the class is created and providing a global point of access to that instance."),
            Prompt(categoryName: "Design Patterns",  id: "P603", question: "What is the purpose of the Delegate design pattern?", choices: [
                Choice(promptId: "P603", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P603", text: "To handle user interactions and events", isCorrect: false),
                Choice(promptId: "P603", text: "To define the appearance and behavior of user interface elements", isCorrect: false),
                Choice(promptId: "P603", text: "To allow objects to communicate and pass data between each other", isCorrect: true),
            ], explanation: "The purpose of the Delegate design pattern is to allow objects to communicate and pass data between each other, providing a way for one object to delegate responsibilities or actions to another object."),
            Prompt(categoryName: "Design Patterns",  id: "P604", question: "What is the purpose of the Observer design pattern?", choices: [
                Choice(promptId: "P604", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P604", text: "To handle user interactions and events", isCorrect: false),
                Choice(promptId: "P604", text: "To define the appearance and behavior of user interface elements", isCorrect: false),
                Choice(promptId: "P604", text: "To establish a one-to-many dependency between objects, allowing them to be notified of changes", isCorrect: true),
            ], explanation: "The purpose of the Observer design pattern is to establish a one-to-many dependency between objects, allowing them to be notified of changes and updates to another object's state."),
            Prompt(categoryName: "Design Patterns",  id: "P605", question: "What is the Factory Method design pattern?", choices: [
                Choice(promptId: "P605", text: "A design pattern for managing user interface layout", isCorrect: false),
                Choice(promptId: "P605", text: "A design pattern for creating objects without specifying their concrete classes", isCorrect: true),
                Choice(promptId: "P605", text: "A design pattern for handling user interactions and events", isCorrect: false),
                Choice(promptId: "P605", text: "A design pattern for defining the appearance and behavior of user interface elements", isCorrect: false),
            ], explanation: "The Factory Method design pattern is a design pattern for creating objects without specifying their concrete classes, allowing subclasses to override the method responsible for creating instances of the class."),
            Prompt(categoryName: "Design Patterns",  id: "P606", question: "What is the purpose of the MVC design pattern in iOS development?", choices: [
                Choice(promptId: "P606", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P606", text: "To handle user interactions and events", isCorrect: false),
                Choice(promptId: "P606", text: "To define the appearance and behavior of user interface elements", isCorrect: false),
                Choice(promptId: "P606", text: "To separate an app into three main components: Model, View, and Controller", isCorrect: true),
            ], explanation: "The purpose of the MVC design pattern in iOS development is to separate an app into three main components: Model (data), View (presentation), and Controller (logic), allowing for better organization and maintenance of code."),
        ]
    }

    private static var memoryManagementPrompts: [Prompt] {
        return [
            Prompt(categoryName: "Memory Management",  id: "P701", question: "What is memory management in iOS app development?", choices: [
                Choice(promptId: "P701", text: "Managing network connections", isCorrect: false),
                Choice(promptId: "P701", text: "Handling user interface layout", isCorrect: false),
                Choice(promptId: "P701", text: "Managing the allocation and deallocation of memory resources", isCorrect: true),
                Choice(promptId: "P701", text: "Creating animations", isCorrect: false),
            ], explanation: "Memory management in iOS app development refers to the process of managing the allocation and deallocation of memory resources, ensuring efficient use of memory and preventing memory leaks and crashes."),
            Prompt(categoryName: "Memory Management",  id: "P702", question: "What is reference counting in memory management?", choices: [
                Choice(promptId: "P702", text: "A technique for managing network connections", isCorrect: false),
                Choice(promptId: "P702", text: "A technique for managing user interface layout", isCorrect: false),
                Choice(promptId: "P702", text: "A technique for tracking the number of references to an object in memory", isCorrect: true),
                Choice(promptId: "P702", text: "A technique for creating animations", isCorrect: false),
            ], explanation: "Reference counting in memory management is a technique for tracking the number of references to an object in memory, incrementing the count when a new reference is made and decrementing it when a reference is removed."),
            Prompt(categoryName: "Memory Management",  id: "P049", question: "What is a retain cycle in memory management?", choices: [
                Choice(promptId: "P703", text: "A situation where memory resources are exhausted", isCorrect: false),
                Choice(promptId: "P703", text: "A situation where two objects reference each other, preventing their deallocation", isCorrect: true),
                Choice(promptId: "P703", text: "A situation where memory leaks occur", isCorrect: false),
                Choice(promptId: "P703", text: "A situation where objects are deallocated prematurely", isCorrect: false),
            ], explanation: "A retain cycle in memory management is a situation where two objects reference each other, creating a loop that prevents their deallocation by the memory management system."),
            Prompt(categoryName: "Memory Management",  id: "P050", question: "What is the purpose of weak references in memory management?", choices: [
                Choice(promptId: "P704", text: "To manage network connections", isCorrect: false),
                Choice(promptId: "P704", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P704", text: "To prevent retain cycles and memory leaks", isCorrect: true),
                Choice(promptId: "P704", text: "To create animations", isCorrect: false),
            ], explanation: "Weak references in memory management are used to prevent retain cycles and memory leaks by allowing an object to be deallocated when there are no strong references to it."),
            Prompt(categoryName: "Memory Management",  id: "P051", question: "What is the purpose of the autoreleasepool in memory management?", choices: [
                Choice(promptId: "P705", text: "To manage network connections", isCorrect: false),
                Choice(promptId: "P705", text: "To manage user interface layout", isCorrect: false),
                Choice(promptId: "P705", text: "To temporarily manage the memory usage of objects within a specific scope", isCorrect: true),
                Choice(promptId: "P705", text: "To create animations", isCorrect: false),
            ], explanation: "The autoreleasepool in memory management is used to temporarily manage the memory usage of objects within a specific scope, allowing objects to be automatically released when the pool is drained."),
            Prompt(categoryName: "Memory Management",  id: "P052", question: "What is the purpose of the deinit method in Swift?", choices: [
                Choice(promptId: "P706", text: "To initialize an object", isCorrect: false),
                Choice(promptId: "P706", text: "To allocate memory for an object", isCorrect: false),
                Choice(promptId: "P706", text: "To perform cleanup and deallocation tasks when an object is destroyed", isCorrect: true),
                Choice(promptId: "P706", text: "To handle user interactions and events", isCorrect: false),
            ], explanation: "The deinit method in Swift is used to perform cleanup and deallocation tasks when an object is destroyed, allowing resources associated with the object to be released."),
        ]
    }

}
