function(conf) [{
  type: 'org.osbuild.systemd-logind',
  options: opts,
} for opts in std.get(conf, 'systemd_logind', [])]
