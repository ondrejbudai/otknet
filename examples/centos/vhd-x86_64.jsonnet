local x86_64 = import './arches/x86_64.jsonnet';
local centos = import './common/centos.jsonnet';
local disk = import './image-templates/disk.jsonnet';

local conf = {
  packages: {
    os: {
      weak: true,
      packages: {
        include: [
          '@Server',
          'bzip2',
          'cloud-init',
          'cloud-utils-growpart',
          'dracut-config-generic',
          'efibootmgr',
          'gdisk',
          'hyperv-daemons',
          'kernel-core',
          'kernel-modules',
          'kernel',
          'langpacks-en',
          'lvm2',
          'NetworkManager',
          'NetworkManager-cloud-setup',
          'nvme-cli',
          'patch',
          'rng-tools',
          'selinux-policy-targeted',
          'uuid',
          'WALinuxAgent',
          'yum-utils',
        ],
        exclude: [
          'aic94xx-firmware',
          'alsa-firmware',
          'alsa-lib',
          'alsa-sof-firmware',
          'alsa-tools-firmware',
          'biosdevname',
          'bolt',
          'buildah',
          'cockpit-podman',
          'containernetworking-plugins',
          'dnf-plugin-spacewalk',
          'dracut-config-rescue',
          'glibc-all-langpacks',
          'iprutils',
          'ivtv-firmware',
          'iwl100-firmware',
          'iwl1000-firmware',
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
          'NetworkManager-config-server',
          'plymouth',
          'podman',
          'python3-dnf-plugin-spacewalk',
          'python3-hwdata',
          'python3-rhnlib',
          'rhn-check',
          'rhn-client-tools',
          'rhn-setup',
          'rhnlib',
          'rhnsd',
          'usb_modeswitch',
        ],
      },
    },
  },
  timezone: 'America/New_York',
  kernel_opts: [
    'no_timer_check',
  ],
  locale: 'C.UTF-8',
  convert_disk: {
    filename: 'disk.qcow2',
    format: {
      compat: '1.1',
      type: 'qcow2',
    },
  },
};

function(target, mods={})
  if target == 'osbuild' then
    disk([centos, x86_64, conf, mods])
  else
    'df'
