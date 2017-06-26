
# react-native-recorder

## Getting started

`$ npm install react-native-recorder --save`

### Mostly automatic installation

`$ react-native link react-native-recorder`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-recorder` and add `RWRecorder.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRWRecorder.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import co.uk.radweb.recorder.RWRecorderPackage;` to the imports at the top of the file
  - Add `new RWRecorderPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-recorder'
  	project(':react-native-recorder').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-recorder/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-recorder')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RWRecorder.sln` in `node_modules/react-native-recorder/windows/RWRecorder.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Com.Reactlibrary.RWRecorder;` to the usings at the top of the file
  - Add `new RWRecorderPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RWRecorder from 'react-native-recorder';

// TODO: What to do with the module?
RWRecorder;
```
  