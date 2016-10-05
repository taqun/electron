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
      NSString* errorDesc = [[NSNumber numberWithInt:[error code]] stringValue];
      return std::string([errorDesc UTF8String]);
      // return std::string([[error localizedDescription] UTF8String]);
      // return std::string([[error localizedFailureReason] UTF8String]);
    }

    if(!data) {
      return "no data";
    }
    NSString *bookmarkString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return [bookmarkString UTF8String];
  }

  std::string LocalFile::ResolveBookmark(const std::string& path) {
    return "resolve";
  }

}  // api

} // atom
