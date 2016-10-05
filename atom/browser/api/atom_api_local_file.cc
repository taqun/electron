#include <string>

#include "atom/browser/api/atom_api_local_file.h"

#include "native_mate/dictionary.h"
#include "atom/common/node_includes.h"

namespace {

  void Initialize(v8::Local<v8::Object> exports, v8::Local<v8::Value> unused,
                  v8::Local<v8::Context> context, void* priv) {
    using atom::api::LocalFile;
    v8::Isolate* isolate = context->GetIsolate();
    mate::Dictionary dict(isolate, exports);
#if defined(OS_MACOSX)
    dict.SetMethod("createBookmark", &LocalFile::CreateBookmark);
    dict.SetMethod("resolveBookmark", &LocalFile::ResolveBookmark);
#endif
  }

}  // namespace

NODE_MODULE_CONTEXT_AWARE_BUILTIN(atom_browser_local_file, Initialize)

