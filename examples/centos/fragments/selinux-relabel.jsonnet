// TODO!
function(conf, policy, extra_labels={}) [
  {
    type: 'org.osbuild.selinux',
    options: {
      file_contexts: 'etc/selinux/%s/contexts/files/file_contexts' % policy,
      [if std.length(extra_labels) > 0 then 'labels']: extra_labels,
    },
  },
]
