function(conf) [{
  name: 'build',
  stages: conf.deps.stages.build
          + (import '../fragments/selinux-relabel.jsonnet')(conf, 'targeted', {
            '/usr/bin/cp': 'system_u:object_r:install_exec_t:s0',
          }),
}]
