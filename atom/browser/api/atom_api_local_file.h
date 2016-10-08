#ifndef ATOM_BROWSER_API_ATOM_API_LOCAL_FILE_H_
#define ATOM_BROWSER_API_ATOM_API_LOCAL_FILE_H_

#include <string>

namespace atom {

namespace api {

  class LocalFile {

  public:
/* #if defined(OS_MACOSX) */
    static std::string CreateBookmark(const std::string& path);
    static std::string ResolveBookmark(const std::string& path);
    static int StartAccessingSecurityScopedResource(const std::string& path);
    static bool StopAccessingSecurityScopedResource(const std::string& path);
/* #endif */

  };

}  // namespace api

}  // namespace atom

#endif  // ATOM_BROWSER_API_ATOM_API_APP_H_
