# SwiftUI-Server-Driver-UI

This article will talk about server-driven UI, its implementation using re-usable components called UIComponents, and creating a generic vertical list view for rendering UI components. It will conclude with a brief discussion of how UI components can serve different purposes.

### What Is Server-Driven UI? ##
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
```
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
