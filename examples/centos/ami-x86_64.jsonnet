local x86_64 = import './arches/x86_64.jsonnet';
local centos = import './common/centos.jsonnet';
local disk = import './image-templates/disk.jsonnet';

local conf = {
  packages: {
    os: {
      weak: true,
      packages: {
        include: [
          '@core',
          'authselect-compat',
          'chrony',
          'cloud-init',
          'cloud-utils-growpart',
          'dhcp-client',
          'yum-utils',
          'dracut-config-generic',
          'gdisk',
          'grub2',
          'langpacks-en',
          'NetworkManager-cloud-setup',
          'redhat-release',
          'redhat-release-eula',
          'rsync',
          'tuned',
          'tar',
        ],
        exclude: [
          'aic94xx-firmware',
          'alsa-firmware',
          'alsa-tools-firmware',
          'biosdevname',
          'firewalld',
          'iprutils',
          'ivtv-firmware',
          'iwl1000-firmware',
          'iwl100-firmware',
          'iwl105-firmware',
          'iwl135-firmware',
          'iwl2000-firmware',
          'iwl2030-firmware',
          'iwl3160-firmware',
          'iwl3945-firmware',
          'iwl4965-firmware',
          'iwl5000-firmware',
          'iwl5150-firmware',
          'iwl6000-firmware',
          'iwl6000g2a-firmware',
          'iwl6000g2b-firmware',
          'iwl6050-firmware',
          'iwl7260-firmware',
          'libertas-sd8686-firmware',
          'libertas-sd8787-firmware',
          'libertas-usb8388-firmware',
          'plymouth',
          // RHBZ#2064087
          'dracut-config-rescue',
          // RHBZ#2075815
          'qemu-guest-agent',
        ],
      },
    },
  },
  sshd_password_authentication: false,
  timezone: 'UTC',
  enabled_services: [
    'sshd',
    'NetworkManager',
    'nm-cloud-setup.service',
    'nm-cloud-setup.timer',
    'cloud-init',
    'cloud-init-local',
    'cloud-config',
    'cloud-final',
    'reboot.target',
    'tuned',
  ],
  kernel_opts: [
    'rd.blacklist=nouveau',
    'nvme_core.io_timeout=4294967295',
  ],
  chrony: {
    leapsectz: '',
    servers: [
      {
        hostname: '169.254.169.123',
        minpoll: 4,
        maxpoll: 4,
        iburst: true,
        prefer: true,
      },
    ],
  },
  keymap: 'us',
  sysconfig_network_scripts: {
    ifcfg: {
      eth0: {
        bootproto: 'dhcp',
        device: 'eth0',
        ipv6init: false,
        onboot: true,
        peerdns: true,
        type: 'Ethernet',
        userctl: true,
      },
    },
  },
  systemd_logind: [{
    filename: '00-getty-fixes.conf',
    config: {
      Login: {
        NAutoVTs: 0,
      },
    },
  }],
  cloud_init: [{
    filename: '00-rhel-default-user.cfg',
    config: {
      system_info: {
        default_user: {
          name: 'ec2-user',
        },
      },
    },
  }],
  modprobe: [
    {
      filename: 'blacklist-nouveau.conf',
      commands: [
        {
          command: 'blacklist',
          modulename: 'nouveau',
        },
      ],
    },
    {
      filename: 'blacklist-amdgpu.conf',
      commands: [
        {
          command: 'blacklist',
          modulename: 'amdgpu',
        },
      ],
    },
  ],
  dracut_conf: [
    {
      filename: 'sgdisk.conf',
      config: {
        install_items: [
          'sgdisk',
        ],
      },
    },
    {
      filename: 'ec2.conf',
      config: {
        add_drivers: [
          'nvme',
          'xen-blkfront',
        ],
      },
    },
  ],
  systemd_unit: [{
      unit: 'nm-cloud-setup.service',
      dropin: '10-rh-enable-for-ec2.conf',
      config: {
        Service: {
          Environment: [
            {
              key: 'NM_CLOUD_SETUP_EC2',
              value: 'yes',
            },
          ],
        },
      },
    }],
    authselect_profile: 'sssd',
};

function(target, mods={})
  if target == 'osbuild' then
    disk([centos, x86_64, conf, mods])
  else
    'df'
