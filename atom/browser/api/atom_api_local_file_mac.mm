#include <string>
#include <utility>
#include <vector>

#include "atom/browser/api/atom_api_local_file_mac.h"

#include "native_mate/dictionary.h"
#include "base/strings/sys_string_conversions.h"

namespace atom {

namespace api {

  std::string LocalFile::CreateBookmark(const std::string& path) {
    NSString* pathString = [NSString stringWithUTF8String:path.c_str()];
    NSURL* url = [NSURL fileURLWithPath:pathString];

    int bookmarkOptions = NSURLBookmarkCreationMinimalBookmark;
#if defined(MAS_BUILD)
    bookmarkOptions = NSURLBookmarkCreationWithSecurityScope;
#endif

    NSError* error = nil;
    NSData* data = [url bookmarkDataWithOptions:bookmarkOptions includingResourceValuesForKeys:nil relativeToURL:nil error:&error];

    if(error) {
      // NSString* errorDesc = [[NSNumber numberWithInt:[error code]] stringValue];
      // return std::string([errorDesc UTF8String]);
      return std::string([[error localizedDescription] UTF8String]);
    }

    if(!data) {
      return "no data";
    }
    NSString *bookmarkString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return [bookmarkString UTF8String];
  }

  std::string LocalFile::ResolveBookmark(const std::string& path) {
    NSString* bookmarkString = [NSString stringWithUTF8String:path.c_str()];
    NSData* bookmark = [[NSData alloc] initWithBase64EncodedString:bookmarkString options:NSDataBase64DecodingIgnoreUnknownCharacters];

    int bookmarkOptions = NSURLBookmarkCreationMinimalBookmark;
#if defined(MAS_BUILD)
    bookmarkOptions = NSURLBookmarkResolutionWithSecurityScope;
#endif

    NSError* error = nil;
    NSURL *url = [NSURL URLByResolvingBookmarkData:bookmark options:bookmarkOptions relativeToURL:nil bookmarkDataIsStale:nil error:&error];

    if(error) {
      // NSString* errorDesc = [[NSNumber numberWithInt:[error code]] stringValue];
      // return std::string([errorDesc UTF8String]);
      return std::string([[error localizedDescription] UTF8String]);
    }

    if(!url) {
      return "no url";
    }
    return std::string([[url path] UTF8String]);
  }

  int LocalFile::StartAccessingSecurityScopedResource(const std::string& bookmarkString) {
    NSString* bkString = [NSString stringWithUTF8String:bookmarkString.c_str()];
    NSData *bookmark = [[NSData alloc] initWithBase64EncodedString:bkString options:NSDataBase64DecodingIgnoreUnknownCharacters];

    int bookmarkOptions = NSURLBookmarkResolutionWithSecurityScope;
    NSError* error = nil;
    NSURL *url = [NSURL URLByResolvingBookmarkData:bookmark options:bookmarkOptions relativeToURL:nil bookmarkDataIsStale:nil error:&error];

    int isSuccess = [url startAccessingSecurityScopedResource];
    if(isSuccess == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool LocalFile::StopAccessingSecurityScopedResource(const std::string& bookmarkString) {
    NSString* bkString = [NSString stringWithUTF8String:bookmarkString.c_str()];
    NSData *bookmark = [[NSData alloc] initWithBase64EncodedString:bkString options:NSDataBase64DecodingIgnoreUnknownCharacters];

    int bookmarkOptions = NSURLBookmarkResolutionWithSecurityScope;
    NSError* error = nil;
    NSURL *url = [NSURL URLByResolvingBookmarkData:bookmark options:bookmarkOptions relativeToURL:nil bookmarkDataIsStale:nil error:&error];

    [url stopAccessingSecurityScopedResource];
    return true;
  }

}  // api

} // atom
