function(conf) [{
  type: 'org.osbuild.cloud-init',
  options: opts,
} for opts in std.get(conf, 'cloud_init', [])]
