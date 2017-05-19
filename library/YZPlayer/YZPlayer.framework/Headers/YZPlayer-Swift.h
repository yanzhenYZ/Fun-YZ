// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import CoreGraphics;
@import UIKit;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

SWIFT_CLASS("_TtC8YZPlayer8YZAVMark")
@interface YZAVMark : NSObject
- (nonnull instancetype)init:(NSString * _Nonnull)mark rect:(CGRect)rect attrs:(NSDictionary<NSString *, id> * _Nullable)attrs OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC8YZPlayer8YZAVTime")
@interface YZAVTime : NSObject
@property (nonatomic) double totalTime;
@property (nonatomic) double currentTime;
@property (nonatomic) double loadedTime;
- (nonnull instancetype)initWithTotalTime:(double)totalTime currentTime:(double)currentTime loadedTime:(double)loadedTime OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@protocol YZAVViewDelegate;
@class UIImage;
@class NSCoder;

SWIFT_CLASS("_TtC8YZPlayer8YZAVView")
@interface YZAVView : UIImageView
@property (nonatomic, weak) id <YZAVViewDelegate> _Nullable delegate;
/// default is 1.0
@property (nonatomic) NSTimeInterval duration;
/// default is true
@property (nonatomic) BOOL playWhenDidBecomeActive;
@property (nonatomic) float rate;
@property (nonatomic, readonly, strong) YZAVTime * _Nonnull currentTime;
@property (nonatomic, readonly) BOOL isPlaying;
@property (nonatomic, readonly) BOOL isPausing;
@property (nonatomic, strong) YZAVMark * _Null_unspecified mark;
- (void)playAV:(NSString * _Nonnull)videoUrlStr begin:(void (^ _Nullable)(void))begin finished:(void (^ _Nullable)(void))finished failed:(void (^ _Nullable)(NSError * _Nullable))failed process:(void (^ _Nullable)(YZAVTime * _Nonnull))process;
- (void)reset;
- (void)observeValueForKeyPath:(NSString * _Nullable)keyPath ofObject:(id _Nullable)object change:(NSDictionary<NSKeyValueChangeKey, id> * _Nullable)change context:(void * _Nullable)context;
- (void)layoutSubviews;
- (nonnull instancetype)initWithImage:(UIImage * _Nullable)image OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithImage:(UIImage * _Nullable)image highlightedImage:(UIImage * _Nullable)highlightedImage OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface YZAVView (SWIFT_EXTENSION(YZPlayer))
- (void)play;
- (void)pause;
- (void)seekTo:(double)time completionHandler:(void (^ _Nullable)(BOOL))completionHandler SWIFT_AVAILABILITY(ios,introduced=5.0);
@end


SWIFT_PROTOCOL("_TtP8YZPlayer16YZAVViewDelegate_")
@protocol YZAVViewDelegate <NSObject>
@optional
- (void)yz_videoPlayBeginWithAvView:(YZAVView * _Nonnull)avView;
- (void)yz_videoPlayFinishedWithAvView:(YZAVView * _Nonnull)avView;
- (void)yz_videoPlayProcess:(YZAVView * _Nonnull)avView time:(YZAVTime * _Nonnull)time;
- (void)yz_videoPlayFail:(YZAVView * _Nonnull)avView error:(NSError * _Nullable)error;
@end

@class UITouch;
@class UIEvent;

SWIFT_CLASS("_TtC8YZPlayer10YZAVWindow")
@interface YZAVWindow : UIWindow
@property (nonatomic, strong) UIImage * _Nullable coverImage;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)setImageName:(NSString * _Nonnull)pause close:(NSString * _Nonnull)close;
- (void)playAV:(NSString * _Nonnull)avUrl;
- (void)mark:(YZAVMark * _Nonnull)mark SWIFT_AVAILABILITY(ios,introduced=7.0);
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)touchesMoved:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)touchesEnded:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)layoutSubviews;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
