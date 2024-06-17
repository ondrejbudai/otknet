function(conf) [{
  type: 'org.osbuild.dracut.conf',
  options: opts,
} for opts in std.get(conf, 'dracut_conf', [])]
