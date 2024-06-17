local prepare_sets = function(conf)
  if std.objectHas(conf, 'kernel_package') && conf.kernel_package != null && std.objectHas(conf.packages, 'os') then conf.packages {
    os: conf.packages.os {
      packages: conf.packages.os.packages {
        include: conf.packages.os.packages.include + [conf.kernel_package],
      },
    },
  }
  else conf.packages;

local resolve_sources = function(conf)
  std.native('external')('resolve-sources', {
    rpm: {
      base_repositories: conf.base_repositories,
      sets: prepare_sets(conf),
      releasever: conf.releasever,
      architecture: conf.architecture,
      module_platform_id: conf.module_platform_id,
    },
  });

local merge_field = function(a, b, field_name)
  if std.objectHas(b, field_name) then
    { [field_name]: b[field_name] }
  else if std.objectHas(a, field_name) then
    { [field_name]: a[field_name] }
  else {};

// It works... but it's not pretty
local merge_packages = function(a, b)
  local a_sets = std.objectFields(a);
  local b_sets = std.objectFields(b);
  local sets = std.set(a_sets + b_sets);
  {
    [set]:
      local a_set = std.get(a, set, {});
      local b_set = std.get(b, set, {});
      (merge_field(a_set, b_set, 'docs') + merge_field(a_set, b_set, 'weak')
       + {
         packages: {
           include: std.get(std.get(a_set, 'packages', {}), 'include', []) + std.get(std.get(b_set, 'packages', {}), 'include', []),
           exclude: std.get(std.get(a_set, 'packages', {}), 'exclude', []) + std.get(std.get(b_set, 'packages', {}), 'exclude', []),
         },
       })
    for set in sets
  };

local merge_conf = function(a, b) a + b + {
  kernel_opts: std.get(a, 'kernel_opts', []) + std.get(b, 'kernel_opts', []),
  packages: merge_packages(std.get(a, 'packages', {}), std.get(b, 'packages', {})),
};

{

  manifest: function(conf, pipelineFns) {
    version: '2',
    pipelines: std.flattenArrays([fn(conf) for fn in pipelineFns]),
    sources: conf.deps.sources,
  },

  resolve_confs: function(confs)
    local mergedConf = std.foldl(merge_conf, confs, {});
    mergedConf {
      deps: resolve_sources(mergedConf),
      disk_setup: std.native('external')('otk-gen-partition-table', mergedConf.partition_table),
    },

}
