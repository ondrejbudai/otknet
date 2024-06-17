function(conf) if std.objectHas(conf, 'chrony') then [{
  type: 'org.osbuild.chrony',
  options: conf.chrony
}] else []
