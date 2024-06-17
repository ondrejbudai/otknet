function(conf) if std.objectHas(conf, 'timezone') then [{
  type: 'org.osbuild.timezone',
  options: {
    zone: conf.timezone,
  }
}] else []
