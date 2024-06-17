function(conf) if std.objectHas(conf, 'locale') then [{
  type: 'org.osbuild.locale',
  options: {
    language: conf.locale,
  }
}] else []
