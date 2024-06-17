function(conf) if std.objectHas(conf, "sshd_password_authentication") then [
  {
    type: 'org.osbuild.sshd.config',
    options: {
      config: {
        PasswordAuthentication: conf.sshd_password_authentication,
      },
    },
  },
] else []
