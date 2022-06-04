# vision-camera-rectangle-scanner (WIP)

Frame processor plugin for [react-native-vision-camera](https://mrousavy.com/react-native-vision-camera/) that identifies rectangles for taking a cropped photo.

### iOS

Native rectangle detection is available as an API on iOS: https://developer.apple.com/documentation/vision/vndetectrectanglesrequest

From https://medium.com/@s.deluca/swift-detecting-rectangles-5c15209f6601:

```code
private func detectRectangle(in image: CVPixelBuffer) {
    let request = VNDetectRectanglesRequest(completionHandler: { (request: VNRequest, error: Error?) in
        DispatchQueue.main.async {
            guard let results = request.results as? [VNRectangleObservation] else { return }
            removeBoundingBoxLayer()
            //retrieve the first observed rectangle
            guard let rect = results.first else{return}
            //function used to draw the bounding box of the detected rectangle
            self.drawBoundingBox(rect: rect)
        }
    })
    //Set the value for the detected rectangle
    request.minimumAspectRatio = VNAspectRatio(0.3)
    request.maximumAspectRatio = VNAspectRatio(0.9)
    request.minimumSize = Float(0.3)
    request.maximumObservations = 1
    let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, options: [:])
    try? imageRequestHandler.perform([request])
}
```

The result from this will return the bounding box that could be overlayed on the camera.

### Android 

Other implementations use OpenCV, this will need to be installed as a dependency for Android only.


Todo:
- [] iOS
- [] Android
- [] Publish to NPM