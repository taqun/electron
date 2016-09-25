#include <string>
#include <utility>
#include <vector>

#include "native_mate/dictionary.h"

#include "atom/common/node_includes.h"

namespace {

  void CreateBookmark() {
    // create bookmark
  }

  void ResolveBookmark() {
    // resolve bookmark
  }

  void Initialize(v8::Local<v8::Object> exports, v8::Local<v8::Value> unused,
                  v8::Local<v8::Context> context, void* priv) {
    v8::Isolate* isolate = context->GetIsolate();
    mate::Dictionary dict(isolate, exports);
    dict.SetMethod("createBookmark", &CreateBookmark);
    dict.SetMethod("resolveBookmark", &ResolveBookmark);
  }

}  // namespace

NODE_MODULE_CONTEXT_AWARE_BUILTIN(atom_browser_local_file, Initialize)
