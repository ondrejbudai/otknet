function(conf) [{
  type: 'org.osbuild.modprobe',
  options: opts,
} for opts in std.get(conf, 'modprobe', [])]
