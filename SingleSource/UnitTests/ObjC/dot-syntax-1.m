#include <Foundation/NSObject.h>
#include <stdio.h>

// Property above methods...

@interface Top0 : NSObject
@property(getter=_getX,setter=_setX:) int x;
@end

@interface Bot0 : Top0
-(int) x;
-(void) setX: (int) arg;
@end

@implementation Top0
-(int) _getX {
  printf("-[ Top0 _getX ]\n");
  return 0;
}
-(void) _setX: (int) arg {
  printf("-[ Top0 _setX: %d ]\n", arg);
}
@end

@implementation Bot0
-(int) x {
  printf("-[ Bot0 _getX ]\n");
  return 0;
}
-(void) setX: (int) arg {
  printf("-[ Bot0 _setX: %d ]\n", arg);
}
@end

// Methods above property...

@interface Top1 : NSObject
-(int) x;
-(void) setX: (int) arg;
@end

@interface Bot1 : Top1
@property(getter=_getX,setter=_setX:) int x;
@end

@implementation Top1
-(int) x {
  printf("-[ Top1 x ]\n");
  return 0;
}
-(void) setX: (int) arg {
  printf("-[ Top1 setX: %d ]\n", arg);
}
@end

@implementation Bot1
-(int) _getX {
  printf("-[ Bot1 _getX ]\n");
  return 0;
}
-(void) _setX: (int) arg {
  printf("-[ Bot1 _setX: %d ]\n", arg);
}
@end

// Mixed setter & getter (variant 1)

@interface Top2 : NSObject
-(int) x;
-(void) _setX: (int) arg;
@end

@interface Bot2 : Top2
@property(getter=_getX,setter=_setX:) int x;
@end

@implementation Top2
-(int) x {
  printf("-[ Top2 x ]\n");
  return 0;
}
-(void) _setX: (int) arg {
  printf("-[ Top2 _setX: %d ]\n", arg);
}
@end

@implementation Bot2
// default synthesis of Bot2 synthesizes Bot2::_setX as a setter.
// So it gets called instead of Top2's _setX when Bot2 is not
// default synthesized.
-(int) _getX {
  printf("-[ Bot2 _getX ]\n");
  return 0;
}
-(void) setX: (int) arg {
  printf("-[ Bot2 setX: %d ]\n", arg);
}
@end

// Mixed setter & getter (variant 2)

@interface Top3 : NSObject
-(int) _getX;
-(void) setX: (int) arg;
@end

@interface Bot3 : Top3
@property(getter=_getX,setter=_setX:) int x;
@end

@implementation Top3
-(int) _getX {
  printf("-[ Top3 _getX ]\n");
  return 0;
}
-(void) setX: (int) arg {
  printf("-[ Top3 setX: %d ]\n", arg);
}
@end

@implementation Bot3
// default synthesis of Bot3 synthesizes Bot3::_getX as getter
// which is then called, instead of calling Top3::_getX which 
// would get called had Bot3 not default synthesized.
-(int) x {
  printf("-[ Bot3 x ]\n");
  return 0;
}
-(void) _setX: (int) arg {
  printf("-[ Bot3 _setX: %d ]\n", arg);
}
@end

// Mixed setter & getter (variant 3)

@interface Top4 : NSObject
@property(getter=_getX,setter=_setX:) int x;
@end

@interface Bot4 : Top4
-(int) _getX;
-(void) setX: (int) arg;
@end

@implementation Top4
-(int) x {
  printf("-[ Top4 x ]\n");
  return 0;
}
-(void) _setX: (int) arg {
  printf("-[ Top4 _setX: %d ]\n", arg);
}
@end

@implementation Bot4
-(int) _getX {
  printf("-[ Bot4 _getX ]\n");
  return 0;
}
-(void) setX: (int) arg {
  printf("-[ Bot4 setX: %d ]\n", arg);
}
@end

// Mixed setter & getter (variant 4)

@interface Top5 : NSObject
@property(getter=_getX,setter=_setX:) int x;
@end

@interface Bot5 : Top5
-(int) x;
-(void) _setX: (int) arg;
@end

@implementation Top5
-(int) _getX {
  printf("-[ Top5 _getX ]\n");
  return 0;
}
-(void) setX: (int) arg {
  printf("-[ Top5 setX: %d ]\n", arg);
}
@end

@implementation Bot5
-(int) x {
  printf("-[ Bot5 x ]\n");
  return 0;
}
-(void) _setX: (int) arg {
  printf("-[ Bot5 _setX: %d ]\n", arg);
}
@end

// Mixed level calls (variant 1)

@interface Top6 : NSObject
-(int) x;
@end

@interface Bot6 : Top6
-(void) setX: (int) arg;
@end

@implementation Top6
-(int) x {
  printf("-[ Top6 x ]\n");
  return 0;
}
@end

@implementation Bot6
-(void) setX: (int) arg {
  printf("-[ Bot5 setX: %d ]\n", arg);
}
@end

// Mixed level calls (variant 1)

@interface Top7 : NSObject
-(void) setX: (int) arg;
@end

@interface Bot7 : Top7
-(int) x;
@end

@implementation Top7
-(void) setX: (int) arg {
  printf("-[ Top7 setX: %d ]\n", arg);
}
@end

@implementation Bot7
-(int) x {
  printf("-[ Bot7 x ]\n");
  return 0;
}
@end

//

int main() {
#define test(N) { \
  Bot##N *ob = [[Bot##N alloc] init]; \
  int x = ob.x; \
  ob.x = 10; }

  test(0);
  test(1);
  test(2);
  test(3);
  test(4);
  test(5);
  test(6);
  test(7);

  return 0;
}

