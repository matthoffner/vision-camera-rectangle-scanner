#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/Frame.h>

// Example for an Objective-C Frame Processor plugin

@interface RectangleScannerPlugin : NSObject

@end

@implementation RectangleScannerPlugin

static inline id findRectangle(Frame* frame, NSArray* arguments) {
  guard let bufferFrame = CMSampleBufferGetImageBuffer(frame) else {
      debugPrint("unable to get image from sample buffer")
      return
  }
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
  let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: bufferFrame, options: [:])
  let response = try? imageRequestHandler.perform([request])

  return response;
}

VISION_EXPORT_FRAME_PROCESSOR(findRectangle)

@end
