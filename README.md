# Square Take Home Project

## Build tools & versions used
Xcode 14.1, Cocoapods 1.11.3, Swift 5.5

## Steps to run the app
Assuming Cocoapods is installed, run `pod install` to generate the `.xcworkspace` and then build and run the app from Xcode.

## What areas of the app did you focus on?
- Clear seperation of concerns between modules
- Testability
- An MVVM+C code archicture.

## What was the reason for your focus? What problems were you trying to solve?

Well thought out architecure plays a huge role in app development. While some aspects may be overkill for this small app, such as using a Coordinator for one screen, building on solid foundations has many benefits in app development. Some of which include:

- Clear responsibilities produce smaller modules, which makes it easier to write comprenhensive test suites
- Conforming to patterns allows teams to move faster and collaborate while adhearing to high standards. More junior developers or new team members get high quality examples to emulate. If the team decides to adopt different patterns, it becomes easy to refactor the code due to the uniform nature.

## How long did you spend on this project?
6 hours. I forgot how much work creating a project from scratch can be, even when there are only a few basic functions it requires! I also wanted to try working with `UICollectionViewDiffableDataSource` which I hadn't done yet in a project.

## Did you make any trade-offs for this project? What would you have done differently with more time?
- The UI is pretty simple.
- Currently the app sets the URL for the employee directory upon launch. With more time I may have created a UI that allows for the user to swap endpoints and reload without rebuilding the app, allowing for faster QA iterations.


## What do you think is the weakest part of your project?
I know the UICollectionViewCell does not resize to fit text. Given the cells contain a bio, on smaller devices this may cut off.

## Did you copy any code or dependencies? Please make sure to attribute them here!

## Is there any other information you’d like us to know?
The project includes Cocoapods to make use of the ReactiveSwift and ReactiveCocoa dependenies. While Apple and Swift are evolving in the functional direction with SwiftUI and Combine, I wanted to stick with what I was more familiar with.