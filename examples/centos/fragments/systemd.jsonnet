function(conf) [
  {
    type: 'org.osbuild.systemd',
    options: {
      [if std.objectHas(conf, "enabled_services") then "enabled_services"]: conf.enabled_services,
      default_target: conf.default_target,
    },
  },
]
