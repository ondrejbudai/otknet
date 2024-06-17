local lib = import '../lib/lib.jsonnet';
function(confs)
local conf = lib.resolve_confs(confs);
lib.manifest(conf, [
  (import '../pipelines/build.jsonnet'),
  (import '../pipelines/os.jsonnet'),
  (import '../pipelines/disk.jsonnet'),
  (import '../pipelines/convert-disk.jsonnet'),
])
