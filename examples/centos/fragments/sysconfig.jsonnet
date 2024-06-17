function(conf)
if std.objectHas(conf, "sysconfig_kernel") || std.objectHas(conf, "sysconfig_network") || std.objectHas(conf, "sysconfig_network_scripts") then [{
  type: 'org.osbuild.sysconfig',
  options: {
    [if std.objectHas(conf, "sysconfig_kernel") then "kernel"]: conf.sysconfig_kernel,
    [if std.objectHas(conf, "sysconfig_network") then "network"]: conf.sysconfig_network,
    [if std.objectHas(conf, "sysconfig_network_scripts") then "network-scripts"]: conf.sysconfig_network_scripts,
  },
}] else []
