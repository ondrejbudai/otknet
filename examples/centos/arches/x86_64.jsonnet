{
  architecture: 'x86_64',
  packages: {
    build: {
      packages: {
        include: [
          'grub2-pc',
        ],
      },
    },
    os: {
      packages: {
        include: [

          // BIOS
          'dracut-config-generic',
          'grub2-pc',

          // UEFI
          'dracut-config-generic',
          'efibootmgr',
          'grub2-efi-x64',
          'shim-x64',
        ],
      },
    },
  },
}
