# SwiftUI-Server-Driver-UI

This article will talk about server-driven UI, its implementation using re-usable components called UIComponents, and creating a generic vertical list view for rendering UI components. It will conclude with a brief discussion of how UI components can serve different purposes.

### What Is Server-Driven UI? ###
* It is an architecture where the server decides the UI views that need to be rendered on the application screen.
* There exists a contract between the application and the server. The basis of this __contract__ gives the server control over the UI of the application.


#### What is that contract?- 
* The server defines the list of components. 
* For each of the components defined at the server, we have a corresponding UI implementation in the app (UIComponent). 


 Consider an entertainment app like Hotstar, whose contract is defined as shown below. On the left are the components from the server, and on the right are the corresponding UI components.

![](https://miro.medium.com/max/1400/1*e0caqOJanQdl7yvrU1Y0pg.png)

#### Working #### 
* The screen does not have a predefined layout like a storyboard. Rather, it consists of a generic list view rendering multiple different views vertically, as per the server response. 
* To make it possible, we have to create views that are standalone and can be reused throughout the application. We call these re-usable views the UIComponent.

#### Contract #### 
    For every server component, we have a corresponding UIComponent.
    
----

## SwiftUI ##
 Swift is a UI toolkit that lets you design application screens in a programmatic, declarative way.
```swift
  struct NotificationView: View {
      let notificationMessage: String

      var body: some View {
          Text(notificationMessage)
      }
  }
```

### Server-Driven UI Implementation in SwiftUI ###

This is a three-step process.
1. Define the standalone UIComponents.
2. Construct the UIComponents based on the API response.
3. Render the UIComponents on the screen.

### Step 1 - Define standalone UIComponents ###

![](https://miro.medium.com/max/1400/1*vaTfkYDRJuPnUQm8nYskgQ.png)

__Input:__ Firstly, for the UIComponent to render itself, it should be provided with data.<br/>  __Output:__ UIComponent defines its UI. When used for rendering inside a screen, it renders itself based on the data (input) provided to it.


#### UIComponent implementation ####

```swift
protocol UIComponent {
    var uniqueId: String  { get }
    func render() -> AnyView
}
```

* All the UI views have to conform to this UI-component protocol.
* As the components are rendered inside a generic vertical list, each UIComponent has to be independently identified. The `uniqueId` property is used to serve that purpose.
* The `render()` is where the UI of the component is defined. Calling this function on a screen will render the component. 

Let's look at NotificationComponent.


```swift
struct NotificationComponent: UIComponent {
    var uniqueId: String
    
    // The data required for rendering is passed as a dependency
    let uiModel: NotificationUIModel
    
    // Defines the View for the Component
    func render() -> AnyView {
        NotificationView(uiModel: uiModel).toAny()
    }
}

// Contains the properties required for rendering the Notification View
struct NotificationUIModel {
    let header: String
    let message: String
    let actionText: String
}

// Notification view takes the NotificationUIModel as a dependency
struct NotificationView: View {
    let uiModel: NotificationUIModel
    var body: some View {
        VStack {
            Text(uiModel.header)
            Text(uiModel.message)
            Button(action: {}) {
                Text(uiModel.actionText)
            }
        }
    }
}
```

* `NotificationUIModel` is the data required by the component to render. This is the input to the UIComponent.
* `NotificationView` is a SwiftUI view that defines the UI of the component. It takes in `NotificationUIModel` as a dependency. This view is the output of the UIComponent when used for rendering on the screen.


### Step 2 - Construct the UIComponents based on the API response ###
```swift
 class HomePageController: ObservableObject {
 
    let repository: Repository
    @Published var uiComponents: [UIComponent] = []
  
    ..
    .. 
    
    func loadPage() {
        val response = repository.getHomePageResult()
        response.forEach { serverComponent in
          let uiComponent = parseToUIComponent(serverComponent)
          uiComponents.append(uiComponent)
        }
    }
}

func parseToUIComponent(serverComponent: ServerComponent) -> UIComponent {
  var uiComponent: UIComponent
  
  if serverComponent.type == "NotificationComponent" {
    uiComponent = NotificationComponent(serverComponent.data, serverComponent.id)
  }
  else if serverComponent.type == "GenreListComponent" {
    uiComponent = GenreListComponent(serverComponent.data, serverComponent.id)
  }
  ...
  ...
  return uiComponent
}
```

* `HomePageController` loads the server components from the repository and converts them into the UIComponents.
* The `uiComponent`'s property is responsible for holding the list of UIComponents. Wrapping it with the `@Published` property makes it an observable. Any change in its value will be published to the `Observer(View)`. __This makes it possible to keep the View in sync with the state of the application.__



