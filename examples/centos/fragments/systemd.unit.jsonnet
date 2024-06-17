function(conf) [{
  type: 'org.osbuild.systemd.unit',
  options: opts,
} for opts in std.get(conf, 'systemd_unit', [])]
