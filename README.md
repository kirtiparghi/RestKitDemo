# RestKitDemo

RestKit is a popular and easy-to-use framework that saves you from having to write much of the code you usually have to when working with web service APIs, such as parsing JSON or mapping responses to objects.

RestKit has three main components:
Network – RestKit now uses AFNetworking v1.3.3 for the network layer. RestKit maintainers are working on updating to AFNetworking 2.0.
Object Mapping – Provides a simple API for turning remote JSON/XML responses into local objects.
Core Data – Provides additional support on top of the object mapper for mapping remote resources to persisted local objects. (No Core Data for this tutorial)

# How to install RestKit Framework?

Using cocoapods

$ sudo gem install cocoapods  
$ pod setup  
$ cd /path/to/RestKitDemo  
$ touch Podfile  
$ [edit] Podfile (using your preferred editor; vim, nano, etc)  
platform :ios, '12.0'  
pod 'RestKit'  
$ pod install  

Here you go!!!! You have successfully install Restkit framework in your project.  

