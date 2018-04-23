// Compile with: 
// gcc -o click interval_click.m -framework ApplicationServices -framework Foundation
//
// Usage:
// ./click -x pixels -y pixels -t seconds
// At the given coordinates it will click and release.

#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

void postMouseEvent(const CGMouseButton button, const CGEventType type, const CGPoint point) {
   CGEventRef mouseEvent = CGEventCreateMouseEvent(NULL, type, point, button);
   CGEventSetType(mouseEvent, type);
   CGEventPost(kCGHIDEventTap, mouseEvent);
   CFRelease(mouseEvent);
}

void leftClickLocation(const CGPoint point, const unsigned int millisec) {
   postMouseEvent(kCGMouseButtonLeft, kCGEventLeftMouseDown, point);
   usleep(1000 * millisec);
   postMouseEvent(kCGMouseButtonLeft, kCGEventLeftMouseUp, point);
}

int main(int argc, char *argv[]) {
  NSUserDefaults *args = [NSUserDefaults standardUserDefaults];

  // grabs command line arguments -x, -y and -t
  unsigned int x = [args integerForKey:@"x"];
  unsigned int y = [args integerForKey:@"y"];
  unsigned int t = [args integerForKey:@"t"];

  // Define the point to be clicked
  CGPoint point;
  point.x = x;
  point.y = y;

  // Click every t seconds
  if (t > 0) {
     while (true) {
        sleep(t);
        leftClickLocation(point, 100);
     }
  } else {
     leftClickLocation(point, 100);
  }

  return 0;
}
