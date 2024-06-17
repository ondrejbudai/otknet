function(conf) if std.objectHas(conf, "authselect_profile") then [
  {
    type: 'org.osbuild.authselect',
    options: {
      profile: conf.authselect_profile,
    },
  },
] else []
