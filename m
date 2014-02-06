Content-Type: multipart/mixed; boundary="===============1550378763027090746=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: Re: Unable to connect Huawei HiLink E303
Date: Thu, 06 Feb 2014 17:20:35 +0000
Message-ID: <CAK+sfovfw-jxkgfYKA4sqURwmJV3AwGQKy_yiKO6cWhNq0a4sQ@mail.gmail.com>
In-Reply-To: <52F3BDB2.6040106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1550378763027090746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I don't think it is anything to do with the APN as I can connect with the
network-manager with out disconnecting the modem or replacing the sim.

Here is the full log + AT

hdabis(a)i102:~/workspace/connman/ofono-1.14/src$ sudo OFONO_AT_DEBUG=3D1
./ofonod -n -d
ofonod[18701]: oFono version 1.14
ofonod[18701]: Can't enable deferred setup: Protocol not available (92)
ofonod[18701]: src/plugin.c:__ofono_plugin_init()
ofonod[18701]: plugins/push-notification.c:push_notification_init()
ofonod[18701]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[18701]: src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x742c00 name: CDMA provisioning
ofonod[18701]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x742ba0 name: Provisioning
ofonod[18701]: plugins/he910.c:he910_init()
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742b00,
name: he910
ofonod[18701]: plugins/connman.c:connman_init()
ofonod[18701]:
src/private-network.c:ofono_private_network_driver_register() driver:
0x742aa0, name: ConnMan Private Network
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742a00,
name: sim900
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742960,
name: samsung
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x7428c0,
name: speedupcdma
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742820,
name: speedup
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742780,
name: alcatel
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x7426c0,
name: icera
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742620,
name: linktop
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742580,
name: nokiacdma
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x7424e0,
name: nokia
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742440,
name: tc65
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742320,
name: ste
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742260,
name: ifx
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x7421c0,
name: palmpre
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742120,
name: novatel
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x742080,
name: sierra
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x741f80,
name: huawei
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x741ee0,
name: zte
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x741e20,
name: hso
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x741d80,
name: mbm
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x741ce0,
name: calypso
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x741c40,
name: wavecom
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x741ba0,
name: g1
ofonod[18701]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x741a80, name: cdmamodem
ofonod[18701]: src/modem.c:ofono_devinfo_driver_register() driver:
0x741ac0, name: cdmamodem
ofonod[18701]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0x741b20, name: cdmamodem
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x741960,
name: phonesim
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x7419e0,
name: localhfp
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x741920, name: phonesim
ofonod[18701]: src/ctm.c:ofono_ctm_driver_register() driver: 0x7418e0,
name: phonesim
ofonod[18701]: plugins/phonesim.c:parse_config() filename
/usr/local/etc/ofono/phonesim.conf
ofonod[18701]: src/ussd.c:ofono_ussd_driver_register() driver: 0x741860,
name: speedupmodem
ofonod[18701]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x7415a0, name: hfpmodem
ofonod[18701]: src/modem.c:ofono_devinfo_driver_register() driver:
0x741720, name: hfpmodem
ofonod[18701]: src/network.c:ofono_netreg_driver_register() driver:
0x741640, name: hfpmodem
ofonod[18701]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x7416c0, name: hfpmodem
ofonod[18701]: src/handsfree.c:ofono_handsfree_driver_register() driver:
0x741760, name: hfpmodem
ofonod[18701]: src/siri.c:ofono_siri_driver_register() driver: 0x7417c0,
name: hfpmodem
ofonod[18701]: src/network.c:ofono_netreg_driver_register() driver:
0x741480, name: dunmodem
ofonod[18701]: src/gprs.c:ofono_gprs_driver_register() driver: 0x7414e0,
name: dunmodem
ofonod[18701]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x7412c0, name: stemodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x7413c0, name: stemodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x741360, name: stemodem
ofonod[18701]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x741040, name: ifxmodem
ofonod[18701]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x7410e0, name: ifxmodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x741120, name: ifxmodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x741180, name: ifxmodem
ofonod[18701]: src/stk.c:ofono_stk_driver_register() driver: 0x7411e0,
name: ifxmodem
ofonod[18701]: src/ctm.c:ofono_ctm_driver_register() driver: 0x741240,
name: ifxmodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x740f60, name: hsomodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740fa0, name: hsomodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x740e40, name: mbmmodem
ofonod[18701]: src/stk.c:ofono_stk_driver_register() driver: 0x740ea0,
name: mbmmodem
ofonod[18701]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x740ee0, name: mbmmodem
ofonod[18701]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x740d20, name: calypsomodem
ofonod[18701]: src/stk.c:ofono_stk_driver_register() driver: 0x740dc0,
name: calypsomodem
ofonod[18701]: src/ussd.c:ofono_ussd_driver_register() driver: 0x740b00,
name: huaweimodem
ofonod[18701]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x740b40, name: huaweimodem
ofonod[18701]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x740bd0, name: huaweimodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740c40, name: huaweimodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x740c00, name: huaweimodem
ofonod[18701]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register()
driver: 0x740ca0, name: huaweimodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x7409e0, name: iceramodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740a40, name: iceramodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740940, name: ztemodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x7408c0, name: swmodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740820, name: nwmodem
ofonod[18701]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x740480, name: atmodem
ofonod[18701]: src/modem.c:ofono_devinfo_driver_register() driver:
0x7405e0, name: atmodem
ofonod[18701]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x740540, name: atmodem
ofonod[18701]:
src/call-forwarding.c:ofono_call_forwarding_driver_register() driver:
0x73ffe0, name: atmodem
ofonod[18701]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x740040, name: atmodem
ofonod[18701]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x73fe00, name: atmodem
ofonod[18701]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x740580, name: atmodem
ofonod[18701]: src/ussd.c:ofono_ussd_driver_register() driver: 0x740420,
name: atmodem
ofonod[18701]: src/sms.c:ofono_sms_driver_register() driver: 0x73fee0,
name: atmodem
ofonod[18701]: src/sim.c:ofono_sim_driver_register() driver: 0x7401c0,
name: atmodem
ofonod[18701]: src/sim.c:ofono_sim_driver_register() driver: 0x740260,
name: atmodem-noef
ofonod[18701]: src/stk.c:ofono_stk_driver_register() driver: 0x7403e0,
name: atmodem
ofonod[18701]: src/network.c:ofono_netreg_driver_register() driver:
0x7400e0, name: atmodem
ofonod[18701]: src/cbs.c:ofono_cbs_driver_register() driver: 0x73ffa0,
name: atmodem
ofonod[18701]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x740640, name: atmodem
ofonod[18701]: src/gprs.c:ofono_gprs_driver_register() driver: 0x7406a0,
name: atmodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x740700, name: atmodem
ofonod[18701]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0x740740, name: atmodem
ofonod[18701]: src/gnss.c:ofono_gnss_driver_register() driver: 0x740780,
name: atmodem
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x73faa0,
name: gobi
ofonod[18701]: src/modem.c:ofono_devinfo_driver_register() driver:
0x73f640, name: qmimodem
ofonod[18701]: src/network.c:ofono_netreg_driver_register() driver:
0x73f720, name: qmimodem
ofonod[18701]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x73f680, name: qmimodem
ofonod[18701]: src/sim.c:ofono_sim_driver_register() driver: 0x73f780,
name: qmimodem-legacy
ofonod[18701]: src/sim.c:ofono_sim_driver_register() driver: 0x73f820,
name: qmimodem
ofonod[18701]: src/sms.c:ofono_sms_driver_register() driver: 0x73f8c0,
name: qmimodem
ofonod[18701]: src/ussd.c:ofono_ussd_driver_register() driver: 0x73f900,
name: qmimodem
ofonod[18701]: src/gprs.c:ofono_gprs_driver_register() driver: 0x73f940,
name: qmimodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x73f980, name: qmimodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x73f9c0, name: qmimodem
ofonod[18701]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x73fa20, name: qmimodem
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x73f5a0,
name: u8500
ofonod[18701]: src/modem.c:ofono_devinfo_driver_register() driver:
0x73f560, name: u8500
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x73f4c0,
name: n900
ofonod[18701]: src/modem.c:ofono_modem_driver_register() driver: 0x73f420,
name: isiusb
ofonod[18701]: src/modem.c:ofono_devinfo_driver_register() driver:
0x73ee60, name: isimodem
ofonod[18701]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x73ee40, name: isimodem
ofonod[18701]: src/network.c:ofono_netreg_driver_register() driver:
0x73eea0, name: isimodem
ofonod[18701]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x73ef00, name: isimodem
ofonod[18701]: src/sms.c:ofono_sms_driver_register() driver: 0x73efa0,
name: isimodem
ofonod[18701]: src/cbs.c:ofono_cbs_driver_register() driver: 0x73efe0,
name: isimodem
ofonod[18701]: src/sim.c:ofono_sim_driver_register() driver: 0x73f020,
name: isimodem
ofonod[18701]: src/ussd.c:ofono_ussd_driver_register() driver: 0x73f0c0,
name: isimodem
ofonod[18701]:
src/call-forwarding.c:ofono_call_forwarding_driver_register() driver:
0x73f100, name: isimodem
ofonod[18701]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x73f140, name: isimodem
ofonod[18701]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x73f1a0, name: isimodem
ofonod[18701]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x73f1e0, name: isimodem
ofonod[18701]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x73f240, name: isimodem
ofonod[18701]: src/gprs.c:ofono_gprs_driver_register() driver: 0x73f2a0,
name: isimodem
ofonod[18701]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x73f2e0, name: isimodem
ofonod[18701]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x73f310, name: isimodem
ofonod[18701]: src/sim.c:ofono_sim_driver_register() driver: 0x73f340,
name: wgmodem2.5
ofonod[18701]: plugins/udevng.c:udev_start()
ofonod[18701]: plugins/udevng.c:enumerate_devices()
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [046d:c52b]
ofonod[18701]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0bda:8176]
ofonod[18701]: plugins/udevng.c:check_usb_device() rtl8192cu [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() rtl8192cu [0bda:8176]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [067b:2303]
ofonod[18701]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [8087:0024]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [12d1:1001]
ofonod[18701]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[18701]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[18701]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/ttyUSB1/tty/t=
tyUSB1
ofonod[18701]: plugins/udevng.c:add_device() /dev/ttyUSB1 (huawei)
255/255/255 [00] =3D=3D> (null) (null)
ofonod[18701]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[18701]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[18701]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.1/ttyUSB2/tty/t=
tyUSB2
ofonod[18701]: plugins/udevng.c:add_device() /dev/ttyUSB2 (huawei)
255/255/255 [01] =3D=3D> (null) (null)
ofonod[18701]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[18701]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[18701]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.2/ttyUSB3/tty/t=
tyUSB3
ofonod[18701]: plugins/udevng.c:add_device() /dev/ttyUSB3 (huawei)
255/255/255 [02] =3D=3D> (null) (null)
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [8087:0024]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [0a5c:5801]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofonod[18701]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[18701]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[18701]: plugins/udevng.c:create_modem() driver=3Dhuawei
ofonod[18701]: src/modem.c:ofono_modem_create() name: (null), type: huawei
ofonod[18701]: plugins/udevng.c:setup_huawei()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[18701]: plugins/udevng.c:setup_huawei() /dev/ttyUSB1 255/255/255 00
(null)
ofonod[18701]: plugins/udevng.c:setup_huawei() /dev/ttyUSB2 255/255/255 01
(null)
ofonod[18701]: plugins/udevng.c:setup_huawei() /dev/ttyUSB3 255/255/255 02
(null)
ofonod[18701]: plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUSB1
pcui=3D/dev/ttyUSB3 diag=3D(null) qmi=3D(null) net=3D(null)
ofonod[18701]: src/modem.c:set_modem_property() modem 0x22eb4b0 property
Device
ofonod[18701]: src/modem.c:set_modem_property() modem 0x22eb4b0 property
Modem
ofonod[18701]: src/modem.c:set_modem_property() modem 0x22eb4b0 property
Pcui
ofonod[18701]: src/modem.c:set_modem_property() modem 0x22eb4b0 property
Diag
ofonod[18701]: src/modem.c:set_modem_property() modem 0x22eb4b0 property
NetworkInterface
ofonod[18701]: src/modem.c:ofono_modem_register() 0x22eb4b0
ofonod[18701]: plugins/huawei.c:huawei_probe() 0x22eb4b0
ofonod[18701]: src/modem.c:emit_modem_added() 0x22eb4b0
ofonod[18701]: src/modem.c:call_modemwatches() 0x22eb4b0 added:1
ofonod[18701]: plugins/smart-messaging.c:modem_watch() modem: 0x22eb4b0,
added: 1
ofonod[18701]: plugins/push-notification.c:modem_watch() modem: 0x22eb4b0,
added: 1
ofonod[18701]: src/modem.c:ofono_modem_create() name: (null), type: option
ofonod[18701]: src/modem.c:set_modem_property() modem 0x22f8010 property
Path
ofonod[18701]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.0/ttyUSB0/tty/ttyUSB0
(option)
ofonod[18701]: src/modem.c:ofono_modem_create() name: (null), type: option
ofonod[18701]: src/modem.c:set_modem_property() modem 0x22f9f60 property
Path
ofonod[18701]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/ttyUSB1/tty/ttyUS=
B1
(option)
ofonod[18701]: src/modem.c:ofono_modem_create() name: (null), type: option
ofonod[18701]: src/modem.c:set_modem_property() modem 0x22f8d90 property
Path
ofonod[18701]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.1/ttyUSB2/tty/ttyUS=
B2
(option)
ofonod[18701]: plugins/huawei.c:huawei_enable() 0x22eb4b0
ofonod[18701]: src/modem.c:get_modem_property() modem 0x22eb4b0 property
Modem
ofonod[18701]: plugins/huawei.c:open_device() Modem /dev/ttyUSB1
ofonod[18701]: src/modem.c:get_modem_property() modem 0x22eb4b0 property
Pcui
ofonod[18701]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB3
ofonod[18701]: Modem: > ATE0 +CMEE=3D1\r
ofonod[18701]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > ATI\r
ofonod[18701]: Modem: < \r\nOK\r\n
ofonod[18701]: PCUI: < \r\nManufacturer: huawei\r\nModel: E303\r\nRevision:
22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
+CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT^RFSWITCH=3D?\r
ofonod[18701]: PCUI: < \r\nERROR\r\n
ofonod[18701]: PCUI: > AT+CFUN=3D1\r
ofonod[18701]: PCUI: < \r\n^SIMST:0,0\r\n
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: < \r\n^SIMST:1,0\r\n
ofonod[18701]: plugins/huawei.c:cfun_enable()
ofonod[18701]: plugins/huawei.c:simst_notify() 255 -> 1
ofonod[18701]: PCUI: > AT^SYSINFO\r
ofonod[18701]: PCUI: < \r\n+CREG: 2\r\n
ofonod[18701]: PCUI: < \r\n+CGREG: 2\r\n
ofonod[18701]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
ofonod[18701]: plugins/huawei.c:sysinfo_enable_cb() 1 -> 1
ofonod[18701]: Modem: > AT&C0\r
ofonod[18701]: PCUI: > AT&C0\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CSCS=3D"GSM"\r
ofonod[18701]: Modem: < \r\nOK\r\n
ofonod[18701]: Modem: > AT+CSCS=3D"GSM"\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT^U2DIAG?\r
ofonod[18701]: Modem: < \r\nOK\r\n
ofonod[18701]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT^GETPORTMODE\r
ofonod[18701]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA: huawei,\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT^USSDMODE=3D?\r
ofonod[18701]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT^DIALMODE=3D?\r
ofonod[18701]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT^CVOICE=3D?\r
ofonod[18701]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CFUN=3D5\r
ofonod[18701]: PCUI: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[18701]: PCUI: < \r\nOK\r\n\r\n^MODE: 0,0\r\n
ofonod[18701]: plugins/huawei.c:cfun_offline()
ofonod[18701]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[18701]: plugins/huawei.c:huawei_pre_sim() 0x22eb4b0
ofonod[18701]: PCUI: > AT^USSDMODE?\r
ofonod[18701]: src/sim.c:ofono_sim_add_state_watch() 0x22f7a20
ofonod[18701]: src/sim.c:ofono_sim_add_state_watch() 0x22f7a20
ofonod[18701]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT^DIALMODE?\r
ofonod[18701]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT^CVOICE?\r
ofonod[18701]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
ofonod[18701]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[18701]: PCUI: > AT+GCAP\r
ofonod[18701]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\r\=
nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 30
ofonod[18701]: PCUI: > AT^DDSETEX=3D?\r
ofonod[18701]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CGMI\r
ofonod[18701]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 10
ofonod[18701]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[18701]: PCUI: > AT+CGMM\r
ofonod[18701]: PCUI: < \r\nE303\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\r\=
nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 30
ofonod[18701]: PCUI: > AT+CGMR\r
ofonod[18701]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 10
ofonod[18701]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[18701]: PCUI: > AT+CGSN\r
ofonod[18701]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\r\=
nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 30
ofonod[18701]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 10
ofonod[18701]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[18701]: PCUI: > AT+CPIN?\r
ofonod[18701]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[18701]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[18701]: PCUI: > AT^CPIN?\r
ofonod[18701]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D9,
val=3D10
ofonod[18701]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D1,
val=3D3
ofonod[18701]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D11,
val=3D10
ofonod[18701]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D4,
val=3D3
ofonod[18701]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\r\=
nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 30
ofonod[18701]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 4
ofonod[18701]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 4
ofonod[18701]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\r\=
nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 30
ofonod[18701]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 10
ofonod[18701]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[18701]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\r\=
nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 30
ofonod[18701]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 1
ofonod[18701]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 1
ofonod[18701]: PCUI: > AT+CIMI\r
ofonod[18701]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 272050100413580
ofonod[18701]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[18701]: plugins/huawei.c:huawei_post_sim() 0x22eb4b0
ofonod[18701]: drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[18701]: src/modem.c:get_modem_property() modem 0x22eb4b0 property
AlwaysOnline
ofonod[18701]: PCUI: > AT+CRC=3D1\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CLIP=3D1\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+COLP=3D1\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CCWA=3D1\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]:
drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized() registering
to notifications
ofonod[18701]: src/sim.c:ofono_sim_add_state_watch() 0x22f7a20
ofonod[18701]: PCUI: > AT^CVOICE=3D?\r
ofonod[18701]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CSCS=3D?\r
ofonod[18701]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT^SYSCFG=3D?\r
ofonod[18701]: PCUI: < \r\n^SYSCFG:
(2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(28=
0000,"GSM850/GSM1900"),(3fffffff,"All
bands")),(0-2),(0-4)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CSMS=3D?\r
ofonod[18701]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sms.c:at_csms_query_cb() CSMS query parsed
successfully
ofonod[18701]: PCUI: > AT+CGDCONT=3D?\r
ofonod[18701]: PCUI: < \r\n+CGDCONT:
(1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
(1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\r\=
n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 32
ofonod[18701]: PCUI: > AT+CPBS=3D?\r
ofonod[18701]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CSMS=3D1\r
ofonod[18701]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CGREG=3D?\r
ofonod[18701]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CSMS?\r
ofonod[18701]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CGREG=3D2\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CGAUTO=3D0\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CGEREP=3D2,1\r
ofonod[18701]: PCUI: < \r\nERROR\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CMGF=3D?\r
ofonod[18701]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CPMS=3D?\r
ofonod[18701]: PCUI: < \r\n+CPMS:
("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CMGF=3D0\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
ofonod[18701]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CNMI=3D?\r
ofonod[18701]: Duplicate EFsdn entries for `Emergency Services'
ofonod[18701]: PCUI: < \r\n+CNMI:
(0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[18701]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: src/sms.c:sms_restore_tx_queue()
ofonod[18701]: plugins/push-notification.c:sms_watch() registered
ofonod[18701]: plugins/smart-messaging.c:sms_watch() registered
ofonod[18701]: PCUI: > AT+CMGL=3D4\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: drivers/atmodem/sms.c:at_cmgl_done()
ofonod[18701]: PCUI: > AT+CGSMS=3D3\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: src/modem.c:get_modem_property() modem 0x22eb4b0 property
AlwaysOnline
ofonod[18701]: plugins/huawei.c:huawei_set_online() modem 0x22eb4b0 online
ofonod[18701]: PCUI: > AT+CFUN=3D1\r
ofonod[18701]: PCUI: < \r\n^SIMST:0,0\r\n
ofonod[18701]: plugins/huawei.c:simst_notify() 1 -> 0
ofonod[18701]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
ofonod[18701]: plugins/huawei.c:simst_notify() 0 -> 1
ofonod[18701]: PCUI: > AT^SYSINFO\r
ofonod[18701]: PCUI: < \r\n+CREG: 2\r\n
ofonod[18701]: PCUI: < \r\n+CGREG: 2\r\n
ofonod[18701]: src/gprs.c:ofono_gprs_status_notify() /huawei_0 status 2
ofonod[18701]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
ofonod[18701]: plugins/huawei.c:sysinfo_online_cb() 1 -> 1
ofonod[18701]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[18701]: plugins/huawei.c:huawei_post_online() 0x22eb4b0
ofonod[18701]: PCUI: > AT+CREG=3D?\r
ofonod[18701]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CSCB=3D?\r
ofonod[18701]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CUSD=3D1\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\r\=
n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 32
ofonod[18701]: PCUI: > AT+CREG=3D2\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: src/sim.c:ofono_sim_add_spn_watch() 0x22f7a20
ofonod[18701]: src/network.c:__ofono_netreg_add_status_watch() 0x22f6760
ofonod[18701]: src/network.c:__ofono_netreg_add_status_watch() 0x22f6760
ofonod[18701]: PCUI: > AT+CSCB=3D0\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: src/cbs.c:cbs_got_imsi() Got IMSI: 272050100413580
ofonod[18701]: src/network.c:__ofono_netreg_add_status_watch() 0x22f6760
ofonod[18701]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 6
ofonod[18701]: PCUI: > AT+CREG?\r
ofonod[18701]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
ofonod[18701]: src/network.c:ofono_netreg_status_notify() /huawei_0 status
2 tech -1
ofonod[18701]: src/network.c:current_operator_callback() 0x22f6760, (nil)
ofonod[18701]: src/cbs.c:cbs_location_changed() 2, -1, -1, -1, (null)(null)
ofonod[18701]: src/gprs.c:netreg_status_changed() 2
ofonod[18701]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 6
ofonod[18701]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 6
ofonod[18701]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 6
ofonod[18701]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 6
ofonod[18701]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\r\=
n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 32
ofonod[18701]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 5
ofonod[18701]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 5
ofonod[18701]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 5
ofonod[18701]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 5
ofonod[18701]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
ofonod[18701]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 5
ofonod[18701]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[18701]: src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on
SIM
ofonod[18701]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\r\=
n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 32
ofonod[18701]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 16
ofonod[18701]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 16
ofonod[18701]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 16
ofonod[18701]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 16
ofonod[18701]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 16
ofonod[18701]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39,
toread: 17
ofonod[18701]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39,
toread: 10
ofonod[18701]: drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[18701]: PCUI: > AT+CSCB=3D0\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CSCB=3D0,"0,34,50,80,214,555,4352-4356"\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
ofonod[18701]: PCUI: < \r\n^MODE: 5,4\r\n
ofonod[18701]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[18701]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\r\=
n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
00, 32
ofonod[18701]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
ofonod[18701]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 34
ofonod[18701]: PCUI: < \r\n^RSSI: 10\r\n\r\n^HCSQ:"WCDMA",37,29,49\r\n
ofonod[18701]: PCUI: < \r\n^SRVST: 2\r\n\r\n+CGREG: 1,"0040","02C10178"\r\n
ofonod[18701]: src/gprs.c:ofono_gprs_status_notify() /huawei_0 status 1
ofonod[18701]: PCUI: < \r\n+CREG: 1,"0040","02C10178"\r\n
ofonod[18701]: src/network.c:ofono_netreg_status_notify() /huawei_0 status
1 tech 2
ofonod[18701]: src/cbs.c:cbs_location_changed() 1, -1, -1, 2, (null)(null)
ofonod[18701]: src/gprs.c:netreg_status_changed() 1
ofonod[18701]: PCUI: > AT+COPS=3D3,2\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+COPS?\r
ofonod[18701]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 272, mnc: 05
ofonod[18701]: PCUI: > AT+CSQ\r
ofonod[18701]: PCUI: < \r\n+CSQ: 10,99\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/network-registration.c:csq_cb() csq_cb: 10
ofonod[18701]: src/network.c:ofono_netreg_strength_notify() strength 32
ofonod[18701]: PCUI: > AT+COPS=3D3,0\r
ofonod[18701]: PCUI: < \r\nOK\r\n
ofonod[18701]: PCUI: > AT+COPS?\r
ofonod[18701]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
ofonod[18701]: drivers/atmodem/network-registration.c:cops_cb() cops_cb: 3
IRL, 272 05 2
ofonod[18701]: src/network.c:current_operator_callback() 0x22f6760, (nil)
ofonod[18701]: src/cbs.c:cbs_location_changed() 1, -1, -1, 2, 27205
ofonod[18701]: src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[18701]: src/gprs.c:netreg_status_changed() 1
ofonod[18701]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary()
cid 1
ofonod[18701]: Modem: > AT+CGDCONT=3D1,"IP","3ireland.ie"\r
ofonod[18701]: Modem: < \r\nOK\r\n
ofonod[18701]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod[18701]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[18701]: Modem: < \r\n+CME ERROR: 50\r\n
ofonod[18701]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
ofonod[18701]: Unable to enter data state
ofonod[18701]: src/gprs.c:pri_activate_callback() 0x22f5900
ofonod[18701]: src/gprs.c:pri_activate_callback() Activating context failed
with error: Incorrect parameters
ofonod[18701]: PCUI: < \r\n^RSSI: 8\r\n\r\n^HCSQ:"WCDMA",36,24,41\r\n
ofonod[18701]: src/network.c:ofono_netreg_strength_notify() strength 25
ofonod[18701]: PCUI: < \r\n^RSSI: 10\r\n\r\n^HCSQ:"WCDMA",37,29,49\r\n
ofonod[18701]: src/network.c:ofono_netreg_strength_notify() strength 32
ofonod[18701]: PCUI: < \r\n^RSSI: 7\r\n\r\n^HCSQ:"WCDMA",35,23,41\r\n
ofonod[18701]: src/network.c:ofono_netreg_strength_notify() strength 22
ofonod[18701]: PCUI: < \r\n^RSSI: 10\r\n\r\n^HCSQ:"WCDMA",37,28,47\r\n
ofonod[18701]: src/network.c:ofono_netreg_strength_notify() strength 32
ofonod[18701]: PCUI: < \r\n^RSSI: 6\r\n\r\n^HCSQ:"WCDMA",35,20,35\r\n
ofonod[18701]: src/network.c:ofono_netreg_strength_notify() strength 19
ofonod[18701]: PCUI: < \r\n^RSSI: 9\r\n\r\n^HCSQ:"WCDMA",35,27,49\r\n
ofonod[18701]: src/network.c:ofono_netreg_strength_notify() strength 29
ofonod[18701]: PCUI: < \r\n^RSSI: 6\r\n\r\n^HCSQ:"WCDMA",35,21,37\r\n
ofonod[18701]: src/network.c:ofono_netreg_strength_notify() strength 19


Homam


On 6 February 2014 16:52, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Homam,
>
>
>  ofonod[17818]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
>> ofonod[17818]: Unable to enter data state
>> ofonod[17818]: src/gprs.c:pri_activate_callback() 0x2121c00
>> ofonod[17818]: src/gprs.c:pri_activate_callback() Activating context
>> failed with error: Incorrect parameters
>>
>>
> Can you enable AT command tracing by using:
>
> export OFONO_AT_DEBUG=3D1 the running ofonod and post that log.
>
> It looks like the either the APN setup is incorrect or the modem will
> require us to use the legacy form of context activation instead of +CGDAT=
A.
>
> Regards,
> -Denis
>
>


-- =

Homam Dabis | Software Consultant
m: +353 86 881 4018
skype: hdabis1

--===============1550378763027090746==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SSBkb24mIzM5O3QgdGhpbmsgaXQgaXMgYW55dGhpbmcgdG8gZG8gd2l0
aCB0aGUgQVBOIGFzIEkgY2FuIGNvbm5lY3Qgd2l0aCB0aGUgbmV0d29yay1tYW5hZ2VyIHdpdGgg
b3V0IGRpc2Nvbm5lY3RpbmcgdGhlIG1vZGVtIG9yIHJlcGxhY2luZyB0aGUgc2ltLjxkaXY+PGJy
PjwvZGl2PjxkaXY+SGVyZSBpcyB0aGUgZnVsbCBsb2cgKyBBVDwvZGl2PjxkaXY+PGJyPgo8L2Rp
dj48ZGl2PjxkaXY+aGRhYmlzQGkxMDI6fi93b3Jrc3BhY2UvY29ubm1hbi9vZm9uby0xLjE0L3Ny
YyQgc3VkbyBPRk9OT19BVF9ERUJVRz0xIC4vb2Zvbm9kIC1uIC1kIKA8L2Rpdj48ZGl2Pm9mb25v
ZFsxODcwMV06IG9Gb25vIHZlcnNpb24gMS4xNDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogQ2Fu
JiMzOTt0IGVuYWJsZSBkZWZlcnJlZCBzZXR1cDogUHJvdG9jb2wgbm90IGF2YWlsYWJsZSAoOTIp
PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3BsdWdpbi5jOl9fb2Zvbm9fcGx1Z2luX2lu
aXQoKaA8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24u
YzpwdXNoX25vdGlmaWNhdGlvbl9pbml0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVn
aW5zL3NtYXJ0LW1lc3NhZ2luZy5jOnNtYXJ0X21lc3NhZ2luZ19pbml0KCmgPC9kaXY+PGRpdj5v
Zm9ub2RbMTg3MDFdOiBzcmMvY2RtYS1wcm92aXNpb24uYzpvZm9ub19jZG1hX3Byb3Zpc2lvbl9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQyYzAwIG5hbWU6IENETUEgcHJvdmlzaW9uaW5n
PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2dwcnMtcHJvdmlzaW9uLmM6b2Zvbm9fZ3By
c19wcm92aXNpb25fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MmJhMCBuYW1lOiBQcm92
aXNpb25pbmc8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvaGU5MTAuYzpoZTkxMF9p
bml0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQyYjAwLCBuYW1lOiBoZTkxMDwvZGl2Pgo8ZGl2
Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvY29ubm1hbi5jOmNvbm5tYW5faW5pdCgpoDwvZGl2Pjxk
aXY+b2Zvbm9kWzE4NzAxXTogc3JjL3ByaXZhdGUtbmV0d29yay5jOm9mb25vX3ByaXZhdGVfbmV0
d29ya19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQyYWEwLCBuYW1lOiBDb25uTWFuIFBy
aXZhdGUgTmV0d29yazwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MmEwMCwgbmFtZTogc2ltOTAwPC9k
aXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDc0Mjk2MCwgbmFtZTogc2Ftc3VuZzwvZGl2PjxkaXY+b2Zvbm9k
WzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDc0MjhjMCwgbmFtZTogc3BlZWR1cGNkbWE8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNy
Yy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDI4MjAs
IG5hbWU6IHNwZWVkdXA8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQyNzgwLCBuYW1lOiBhbGNhdGVs
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQyNmMwLCBuYW1lOiBpY2VyYTwvZGl2PjxkaXY+b2Zvbm9k
WzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDc0MjYyMCwgbmFtZTogbGlua3RvcDwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDI1ODAsIG5h
bWU6IG5va2lhY2RtYTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MjRlMCwgbmFtZTogbm9raWE8L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg3NDI0NDAsIG5hbWU6IHRjNjU8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3
MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NzQyMzIwLCBuYW1lOiBzdGU8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDIyNjAsIG5hbWU6IGlmeDwv
ZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDc0MjFjMCwgbmFtZTogcGFsbXByZTwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxODcwMV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg3NDIxMjAsIG5hbWU6IG5vdmF0ZWw8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDIwODAsIG5h
bWU6IHNpZXJyYTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9k
ZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MWY4MCwgbmFtZTogaHVhd2VpPC9kaXY+
CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDc0MWVlMCwgbmFtZTogenRlPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQx
ZTIwLCBuYW1lOiBoc288L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDFkODAsIG5hbWU6IG1ibTwvZGl2
Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg3NDFjZTAsIG5hbWU6IGNhbHlwc288L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg3NDFjNDAsIG5hbWU6IHdhdmVjb208L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDFiYTAsIG5hbWU6
IGcxPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2NkbWEtdm9pY2VjYWxsLmM6b2Zvbm9f
Y2RtYV92b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MWE4MCwgbmFtZTog
Y2RtYW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19kZXZp
bmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDFhYzAsIG5hbWU6IGNkbWFtb2RlbTwv
ZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9jZG1hLWNvbm5tYW4uYzpvZm9ub19jZG1hX2Nv
bm5tYW5fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MWIyMCwgbmFtZTogY2RtYW1vZGVt
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxOTYwLCBuYW1lOiBwaG9uZXNpbTwvZGl2PjxkaXY+b2Zv
bm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDc0MTllMCwgbmFtZTogbG9jYWxoZnA8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBz
cmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NzQxOTIwLCBuYW1lOiBwaG9uZXNpbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2N0bS5j
Om9mb25vX2N0bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxOGUwLCBuYW1lOiBwaG9u
ZXNpbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy9waG9uZXNpbS5jOnBhcnNlX2Nv
bmZpZygpIGZpbGVuYW1lIC91c3IvbG9jYWwvZXRjL29mb25vL3Bob25lc2ltLmNvbmY8L2Rpdj4K
PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDc0MTg2MCwgbmFtZTogc3BlZWR1cG1vZGVtPC9kaXY+PGRpdj5vZm9ub2Rb
MTg3MDFdOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg3NDE1YTAsIG5hbWU6IGhmcG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBzcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3
NDE3MjAsIG5hbWU6IGhmcG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL25ldHdv
cmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTY0MCwgbmFt
ZTogaGZwbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9jYWxsLXZvbHVtZS5jOm9m
b25vX2NhbGxfdm9sdW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDE2YzAsIG5hbWU6
IGhmcG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvaGFuZHNmcmVlLmM6b2Zvbm9f
aGFuZHNmcmVlX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDE3NjAsIG5hbWU6IGhmcG1v
ZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3NpcmkuYzpvZm9ub19zaXJpX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDE3YzAsIG5hbWU6IGhmcG1vZGVtPC9kaXY+PGRpdj5v
Zm9ub2RbMTg3MDFdOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4NzQxNDgwLCBuYW1lOiBkdW5tb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDE0
ZTAsIG5hbWU6IGR1bm1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3ZvaWNlY2Fs
bC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxMmMwLCBu
YW1lOiBzdGVtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2dwcnMuYzpvZm9ub19n
cHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTNjMCwgbmFtZTogc3Rl
bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25v
X3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDEzNjAsIG5hbWU6
IHN0ZW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3ZvaWNlY2FsbC5jOm9mb25v
X3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxMDQwLCBuYW1lOiBpZnht
b2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2F1ZGlvLXNldHRpbmdzLmM6b2Zvbm9f
YXVkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTBlMCwgbmFtZTog
aWZ4bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpv
Zm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxMTIwLCBu
YW1lOiBpZnhtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2dwcnMuYzpvZm9ub19n
cHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTE4MCwgbmFtZTogaWZ4
bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDExZTAsIG5hbWU6IGlmeG1vZGVtPC9kaXY+PGRpdj5v
Zm9ub2RbMTg3MDFdOiBzcmMvY3RtLmM6b2Zvbm9fY3RtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg3NDEyNDAsIG5hbWU6IGlmeG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMv
Z3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQw
ZjYwLCBuYW1lOiBoc29tb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9yYWRpby1z
ZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg3NDBmYTAsIG5hbWU6IGhzb21vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvZ3By
cy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwZTQw
LCBuYW1lOiBtYm1tb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9zdGsuYzpvZm9u
b19zdGtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MGVhMCwgbmFtZTogbWJtbW9kZW08
L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9sb2NhdGlvbi1yZXBvcnRpbmcuYzpvZm9ub19s
b2NhdGlvbl9yZXBvcnRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MGVlMCwgbmFt
ZTogbWJtbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvdm9pY2VjYWxsLmM6b2Zv
bm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDBkMjAsIG5hbWU6IGNh
bHlwc29tb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3N0ay5jOm9mb25vX3N0a19k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwZGMwLCBuYW1lOiBjYWx5cHNvbW9kZW08L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NzQwYjAwLCBuYW1lOiBodWF3ZWltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxODcwMV06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDc0MGI0MCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHNyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg3NDBiZDAsIG5hbWU6IGh1YXdlaW1vZGVtPC9kaXY+CjxkaXY+
b2Zvbm9kWzE4NzAxXTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3Nf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MGM0MCwgbmFtZTogaHVhd2VpbW9kZW08L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDBjMDAsIG5hbWU6IGh1YXdlaW1vZGVtPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE4NzAxXTogc3JjL2NkbWEtbmV0cmVnLmM6b2Zvbm9fY2RtYV9uZXRyZWdfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MGNhMCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj48
ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg3NDA5ZTAsIG5hbWU6IGljZXJhbW9kZW08L2Rpdj4KPGRpdj5v
Zm9ub2RbMTg3MDFdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwYTQwLCBuYW1lOiBpY2VyYW1vZGVtPC9kaXY+
PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0
aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwOTQwLCBuYW1lOiB6dGVtb2RlbTwv
ZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDA4YzAsIG5hbWU6IHN3bW9kZW08L2Rpdj48ZGl2
Pm9mb25vZFsxODcwMV06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdz
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDA4MjAsIG5hbWU6IG53bW9kZW08L2Rpdj4K
PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDA0ODAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDc0MDVlMCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
c3JjL2NhbGwtYmFycmluZy5jOm9mb25vX2NhbGxfYmFycmluZ19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4NzQwNTQwLCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTog
c3JjL2NhbGwtZm9yd2FyZGluZy5jOm9mb25vX2NhbGxfZm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NzNmZmUwLCBuYW1lOiBhdG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3
MDFdOiBzcmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDc0MDA0MCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06
IHNyYy9jYWxsLXNldHRpbmdzLmM6b2Zvbm9fY2FsbF9zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4NzNmZTAwLCBuYW1lOiBhdG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg3NDA1ODAsIG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMv
dXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MDQyMCwgbmFt
ZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3Ntcy5jOm9mb25vX3Ntc19k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmZWUwLCBuYW1lOiBhdG1vZGVtPC9kaXY+PGRp
dj5vZm9ub2RbMTg3MDFdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg3NDAxYzAsIG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBz
cmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDAyNjAsIG5h
bWU6IGF0bW9kZW0tbm9lZjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3N0ay5jOm9mb25v
X3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwM2UwLCBuYW1lOiBhdG1vZGVtPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwMGUwLCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+b2Zv
bm9kWzE4NzAxXTogc3JjL2Nicy5jOm9mb25vX2Nic19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4NzNmZmEwLCBuYW1lOiBhdG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvY2Fs
bC12b2x1bWUuYzpvZm9ub19jYWxsX3ZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NzQwNjQwLCBuYW1lOiBhdG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvZ3Bycy5j
Om9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MDZhMCwgbmFtZTogYXRt
b2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250
ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDA3MDAsIG5hbWU6IGF0bW9kZW08L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9zaW0tYXV0aC5jOm9mb25vX3NpbV9hdXRoX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDA3NDAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IHNyYy9nbnNzLmM6b2Zvbm9fZ25zc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NzQwNzgwLCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZmFhMCwg
bmFtZTogZ29iaTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2
aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmNjQwLCBuYW1lOiBxbWltb2RlbTwv
ZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjcyMCwgbmFtZTogcW1pbW9kZW08L2Rpdj4KPGRpdj5v
Zm9ub2RbMTg3MDFdOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg3M2Y2ODAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2Rb
MTg3MDFdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3
M2Y3ODAsIG5hbWU6IHFtaW1vZGVtLWxlZ2FjeTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3Jj
L3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmODIwLCBuYW1l
OiBxbWltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9zbXMuYzpvZm9ub19zbXNf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjhjMCwgbmFtZTogcW1pbW9kZW08L2Rpdj48
ZGl2Pm9mb25vZFsxODcwMV06IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4NzNmOTAwLCBuYW1lOiBxbWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2Y5
NDAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2dwcnMuYzpv
Zm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjk4MCwgbmFt
ZTogcW1pbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9yYWRpby1zZXR0aW5ncy5j
Om9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2Y5YzAs
IG5hbWU6IHFtaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2xvY2F0aW9uLXJl
cG9ydGluZy5jOm9mb25vX2xvY2F0aW9uX3JlcG9ydGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NzNmYTIwLCBuYW1lOiBxbWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjVhMCwg
bmFtZTogdTg1MDA8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19k
ZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2Y1NjAsIG5hbWU6IHU4NTAwPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NzNmNGMwLCBuYW1lOiBuOTAwPC9kaXY+PGRpdj5vZm9ub2RbMTg3
MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NzNmNDIwLCBuYW1lOiBpc2l1c2I8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0u
YzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2VlNjAsIG5hbWU6
IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvcGhvbmVib29rLmM6b2Zvbm9f
cGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2VlNDAsIG5hbWU6IGlzaW1v
ZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNlZWEwLCBuYW1lOiBpc2ltb2RlbTwvZGl2Pgo8
ZGl2Pm9mb25vZFsxODcwMV06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZWYwMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IHNyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDczZWZhMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9j
YnMuYzpvZm9ub19jYnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZWZlMCwgbmFtZTog
aXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2YwMjAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRp
dj5vZm9ub2RbMTg3MDFdOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDczZjBjMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06
IHNyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9ub19jYWxsX2ZvcndhcmRpbmdfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDczZjEwMCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2Rb
MTg3MDFdOiBzcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0dGluZ3NfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDczZjE0MCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25v
ZFsxODcwMV06IHNyYy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDczZjFhMCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9u
b2RbMTg3MDFdOiBzcmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDczZjFlMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg3M2YyNDAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXY+b2Zv
bm9kWzE4NzAxXTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg3M2YyYTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMv
Z3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNm
MmUwLCBuYW1lOiBpc2ltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2F1ZGlvLXNl
dHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDczZjMxMCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvc2lt
LmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2YzNDAsIG5hbWU6IHdn
bW9kZW0yLjU8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6dWRldl9z
dGFydCgpoDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzplbnVtZXJh
dGVfZGV2aWNlcygpoDwvZGl2PjxkaXY+Cm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6
Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQyNDoyNTA3
XTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2
aWNlKCkgdXNiIFswNDI0OjI1MDddPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91
ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswNDZkOmM1MmJdPC9kaXY+PGRpdj5vZm9u
b2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2JoaWQgWyhu
dWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNo
ZWNrX3VzYl9kZXZpY2UoKSB1c2JoaWQgWyhudWxsKToobnVsbCldPC9kaXY+CjxkaXY+b2Zvbm9k
WzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVs
bCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgdXNiaGlkIFsobnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzE4
NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswYmRhOjgxNzZd
PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2
aWNlKCkgcnRsODE5MmN1IFsobnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
cGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcnRsODE5MmN1IFswYmRhOjgxNzZd
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSBodWIgWyhudWxsKToobnVsbCldPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswNDI0OjI1MDddPC9kaXY+PGRpdj5v
Zm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhu
dWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNo
ZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzA0MjQ6MjUwN108L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFd
OiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCld
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSB1c2IgWzA0MjQ6MjUwN108L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdj5v
Zm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzA0
MjQ6MjUwN108L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tf
dXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06
IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQyNDoyNTA3XTwvZGl2
Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgp
IGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQyNDoyNTA3XTwvZGl2PjxkaXY+b2Zvbm9k
WzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6
KG51bGwpXTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tf
dXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06
IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDY3YjoyMzAzXTwvZGl2
PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkg
cGwyMzAzIFsobnVsbCk6KG51bGwpXTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMv
dWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHBsMjMwMyBbMDY3YjoyMzAzXTwvZGl2PjxkaXY+
b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFso
bnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpj
aGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTwvZGl2Pgo8ZGl2Pm9mb25vZFsx
ODcwMV06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbODA4NzowMDI0
XTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2
aWNlKCkgdXNiIFsxMmQxOjEwMDFdPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3Vk
ZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWyhudWxsKToobnVsbCldPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0
aW9uIFsxMmQxOjEwMDFdPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5j
OmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8x
LTEvMS0xLjI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2Rl
dmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2IxLzEtMS8xLTEu
Mi8xLTEuMjoxLjAvdHR5VVNCMS90dHkvdHR5VVNCMTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06
IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMSAoaHVhd2VpKSAyNTUv
MjU1LzI1NSBbMDBdID09Jmd0OyAobnVsbCkgKG51bGwpPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWyhudWxsKToobnVs
bCldPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9k
ZXZpY2UoKSBvcHRpb24gWzEyZDE6MTAwMV08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVn
aW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAw
OjFhLjAvdXNiMS8xLTEvMS0xLjI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRl
dm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91
c2IxLzEtMS8xLTEuMi8xLTEuMjoxLjEvdHR5VVNCMi90dHkvdHR5VVNCMjwvZGl2Pgo8ZGl2Pm9m
b25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMiAo
aHVhd2VpKSAyNTUvMjU1LzI1NSBbMDFdID09Jmd0OyAobnVsbCkgKG51bGwpPC9kaXY+PGRpdj5v
Zm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24g
WyhudWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5j
OmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWzEyZDE6MTAwMV08L2Rpdj4KPGRpdj5vZm9ub2Rb
MTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGNpMDAw
MDowMC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06
IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAw
MDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuMi8xLTEuMjoxLjIvdHR5VVNCMy90dHkvdHR5VVNCMzwv
ZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9k
ZXYvdHR5VVNCMyAoaHVhd2VpKSAyNTUvMjU1LzI1NSBbMDJdID09Jmd0OyAobnVsbCkgKG51bGwp
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSBodWIgWyhudWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5z
L3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCldPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNi
IFs4MDg3OjAwMjRdPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNo
ZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzBhNWM6NTgwMV08L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06
IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbKG51bGwpOihudWxsKV08
L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSB1c2IgWyhudWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5z
L3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCldPC9kaXY+PGRp
dj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOmNyZWF0ZV9tb2RlbSgpIC9zeXMvZGV2
aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuMjwvZGl2Pgo8ZGl2Pm9m
b25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCkgZHJpdmVyPWh1YXdl
aTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRl
KCkgbmFtZTogKG51bGwpLCB0eXBlOiBodWF3ZWk8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBs
dWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAw
MDowMDoxYS4wL3VzYjEvMS0xLzEtMS4yPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lu
cy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjEgMjU1LzI1NS8yNTUgMDAgKG51
bGwpPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdl
aSgpIC9kZXYvdHR5VVNCMiAyNTUvMjU1LzI1NSAwMSAobnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IzIDI1NS8y
NTUvMjU1IDAyIChudWxsKTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvdWRldm5n
LmM6c2V0dXBfaHVhd2VpKCkgbWRtPS9kZXYvdHR5VVNCMSBwY3VpPS9kZXYvdHR5VVNCMyBkaWFn
PShudWxsKSBxbWk9KG51bGwpIG5ldD0obnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNy
Yy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjJlYjRiMCBwcm9wZXJ0eSBE
ZXZpY2U8L2Rpdj48ZGl2PgpvZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbSAweDIyZWI0YjAgcHJvcGVydHkgTW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjJlYjRiMCBw
cm9wZXJ0eSBQY3VpPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpzZXRfbW9k
ZW1fcHJvcGVydHkoKSBtb2RlbSAweDIyZWI0YjAgcHJvcGVydHkgRGlhZzwvZGl2Pgo8ZGl2Pm9m
b25vZFsxODcwMV06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjJl
YjRiMCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJmYWNlPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBz
cmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZWdpc3RlcigpIDB4MjJlYjRiMDwvZGl2PjxkaXY+b2Zv
bm9kWzE4NzAxXTogcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcHJvYmUoKSAweDIyZWI0YjA8L2Rp
dj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzplbWl0X21vZGVtX2FkZGVkKCkgMHgy
MmViNGIwPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpjYWxsX21vZGVtd2F0
Y2hlcygpIDB4MjJlYjRiMCBhZGRlZDoxPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5z
L3NtYXJ0LW1lc3NhZ2luZy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4MjJlYjRiMCwgYWRkZWQ6
IDE8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6
bW9kZW1fd2F0Y2goKSBtb2RlbTogMHgyMmViNGIwLCBhZGRlZDogMTwvZGl2PjxkaXY+b2Zvbm9k
WzE4NzAxXTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRlKCkgbmFtZTogKG51bGwpLCB0
eXBlOiBvcHRpb248L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOnNldF9tb2Rl
bV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjJmODAxMCBwcm9wZXJ0eSBQYXRoPC9kaXY+CjxkaXY+b2Zv
bm9kWzE4NzAxXTogcGx1Z2lucy91ZGV2LmM6YWRkX21vZGVtKCkgL2RldmljZXMvcGNpMDAwMDow
MC8wMDAwOjAwOjE0LjAvdXNiMy8zLTMvMy0zOjEuMC90dHlVU0IwL3R0eS90dHlVU0IwIChvcHRp
b24pPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9jcmVh
dGUoKSBuYW1lOiAobnVsbCksIHR5cGU6IG9wdGlvbjwvZGl2PjxkaXY+Cm9mb25vZFsxODcwMV06
IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjJmOWY2MCBwcm9wZXJ0
eSBQYXRoPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3VkZXYuYzphZGRfbW9kZW0o
KSAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2IxLzEtMS8xLTEuMi8xLTEuMjox
LjAvdHR5VVNCMS90dHkvdHR5VVNCMSAob3B0aW9uKTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IChudWxsKSwgdHlwZTogb3B0
aW9uPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVy
dHkoKSBtb2RlbSAweDIyZjhkOTAgcHJvcGVydHkgUGF0aDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogcGx1Z2lucy91ZGV2LmM6YWRkX21vZGVtKCkgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAw
OjFhLjAvdXNiMS8xLTEvMS0xLjIvMS0xLjI6MS4xL3R0eVVTQjIvdHR5L3R0eVVTQjIgKG9wdGlv
bik8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9lbmFi
bGUoKSAweDIyZWI0YjA8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOmdldF9t
b2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjJlYjRiMCBwcm9wZXJ0eSBNb2RlbTwvZGl2PjxkaXY+
b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy9odWF3ZWkuYzpvcGVuX2RldmljZSgpIE1vZGVtIC9kZXYv
dHR5VVNCMTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9w
cm9wZXJ0eSgpIG1vZGVtIDB4MjJlYjRiMCBwcm9wZXJ0eSBQY3VpPC9kaXY+PGRpdj5vZm9ub2Rb
MTg3MDFdOiBwbHVnaW5zL2h1YXdlaS5jOm9wZW5fZGV2aWNlKCkgUGN1aSAvZGV2L3R0eVVTQjM8
L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IE1vZGVtOiAmZ3Q7IEFURTAgK0NNRUU9MVxyPC9kaXY+
PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFURTAgK0NNRUU9MVxyPC9kaXY+CjxkaXY+
b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3
MDFdOiBQQ1VJOiAmZ3Q7IEFUSVxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBNb2RlbTogJmx0
OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG5NYW51
ZmFjdHVyZXI6IGh1YXdlaVxyXG5Nb2RlbDogRTMwM1xyXG5SZXZpc2lvbjogMjIuMzE4LjA1LjAw
LjAwXHJcbklNRUk6IDg2MjU2NjAyMDAwNTY5N1xyXG4rR0NBUDogK0NHU00sK0RTLCtFU1xyXG5c
clxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVF5SRlNXSVRD
SD0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbkVSUk9SXHJcbjwv
ZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDRlVOPTFccjwvZGl2PjxkaXY+
b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuXlNJTVNUOjAsMFxyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcw
MV06IFBDVUk6ICZsdDsgXHJcbl5TSU1TVDoxLDBcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBwbHVnaW5zL2h1YXdlaS5jOmNmdW5fZW5hYmxlKCmgPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBwbHVnaW5zL2h1YXdlaS5jOnNpbXN0X25vdGlmeSgpIDI1NSAtJmd0OyAxPC9kaXY+PGRpdj5v
Zm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0lORk9ccjwvZGl2Pgo8ZGl2Pm9mb25vZFsx
ODcwMV06IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAyXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogUENVSTogJmx0OyBcclxuK0NHUkVHOiAyXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
UENVSTogJmx0OyBcclxuXlNZU0lORk86MCwzLDAsMCwxLDAsMFxyXG5cclxuT0tcclxuPC9kaXY+
PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL2h1YXdlaS5jOnN5c2luZm9fZW5hYmxlX2NiKCkg
MSAtJmd0OyAxPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogTW9kZW06ICZndDsgQVQmYW1wO0Mw
XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQmYW1wO0MwXHI8L2Rpdj48
ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzE4NzAxXTogUENVSTogJmd0OyBBVCtDU0NTPSZxdW90O0dTTSZxdW90O1xyPC9kaXY+PGRpdj5v
Zm9ub2RbMTg3MDFdOiBNb2RlbTogJmx0OyBcclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE4
NzAxXTogTW9kZW06ICZndDsgQVQrQ1NDUz0mcXVvdDtHU00mcXVvdDtccjwvZGl2PjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmZ3Q7IEFUXlUyRElBRz9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogTW9kZW06
ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxu
XlUyRElBRzogMTE5XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJ
OiAmZ3Q7IEFUXkdFVFBPUlRNT0RFXHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZs
dDsgXHJcbl5HRVRQT1JUTU9ERTogVFlQRTogV0NETUE6IGh1YXdlaSxcclxuXHJcbk9LXHJcbjwv
ZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVF5VU1NETU9ERT0/XHI8L2Rpdj48
ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbl5VU1NETU9ERTogKDAtMSlcclxuXHJc
bk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVReRElBTE1PREU9
P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG5eRElBTE1PREU6ICgw
LTIpLCgwLTI1NSlcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTog
Jmd0OyBBVF5DVk9JQ0U9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxy
XG5eQ1ZPSUNFOiAoMClcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBD
VUk6ICZndDsgQVQrQ0ZVTj01XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsg
XHJcbitDUkVHOiAwXHJcblxyXG4rQ0dSRUc6IDBcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG5cclxuXk1PREU6IDAsMFxyXG48L2Rpdj48ZGl2Pm9mb25v
ZFsxODcwMV06IHBsdWdpbnMvaHVhd2VpLmM6Y2Z1bl9vZmZsaW5lKCmgPC9kaXY+CjxkaXY+b2Zv
bm9kWzE4NzAxXTogc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAw
LCBuZXcgc3RhdGU6IDE8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvaHVhd2VpLmM6
aHVhd2VpX3ByZV9zaW0oKSAweDIyZWI0YjA8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6
ICZndDsgQVReVVNTRE1PREU/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9zaW0uYzpv
Zm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHgyMmY3YTIwPC9kaXY+CjxkaXY+b2Zvbm9kWzE4
NzAxXTogc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2goKSAweDIyZjdhMjA8L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbl5VU1NETU9ERTogMVxyXG5cclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUXkRJQUxNT0RFP1xy
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG5eRElBTE1PREU6MywyXHJc
blxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUXkNWT0lD
RT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuXkNWT0lDRTogMSwg
ODAwMCwgMTYsIDIwXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFZvaWNl
IGNoYW5uZWw6IDgwMDAgSHosIDE2IGJpdHMsIDIwbXMgcGVyaW9kPC9kaXY+PGRpdj5vZm9ub2Rb
MTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0dDQVBccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBD
VUk6ICZsdDsgXHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VTXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2
Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMTIyNTgsMCwwLDI1NVxyPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
NjIxQzgyMDI0MTIxODMwMjJGRTJBNTAzODAwMTcxOEEwMTA1OEIwMzJGMDYwMzgwMDIwMDBBODgw
MTEwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMw
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUXkREU0VURVg9P1xyPC9kaXY+
PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG5eRERTRVRFWDogKDIpXHJcblxyXG5P
S1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ0dNSVxyPC9kaXY+
CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuaHVhd2VpXHJcblxyXG5PS1xyXG48
L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMTIyNTgsMCww
LDEwXHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQs
MCwmcXVvdDs5ODUzMDMwNTAxMDcwODUzMDVGNiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
IGNyc21fcmVhZF9jYjogOTAsIDAwLCAxMDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3Np
bWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRv
Y29weTogMTA8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ0dNTVxyPC9k
aXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuRTMwM1xyXG5cclxuT0tcclxu
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDIxLDAs
MCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0
NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RjA1QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDQ4
MDAyMDAwQTg4MDExMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAx
XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjog
OTAsIDAwLCAzMDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDR01SXHI8
L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbjIyLjMxOC4wNS4wMC4wMFxy
XG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTc2LDI4NDIxLDAsMCwxMFxyPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBc
clxuK0NSU006IDE0NCwwLCZxdW90OzY1NkVGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5P
S1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTA8L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHNyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBk
YXRhb2ZmOiAwLCB0b2NvcHk6IDEwPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0
OyBBVCtDR1NOXHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbjg2MjU2
NjAyMDAwNTY5N1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTkyLDEyMDM3LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
UENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDIyRjA1QTUw
MzgwMDE3MThBMDEwNThCMDMyRjA2MDQ4MDAyMDAwQTg4MDEyOCZxdW90O1xyXG5cclxuT0tcclxu
PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
aW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwxMjAzNywwLDAsMTBccjwvZGl2PjxkaXY+b2Zvbm9k
WzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzY1NkVGRkZGRkZGRkZG
RkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAs
IDEwPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9i
bG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxMDwvZGl2PjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUElOP1xyPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAx
XTogUENVSTogJmx0OyBcclxuK0NQSU46IFJFQURZXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcGluX2NiKCkgY3JzbV9waW5f
Y2I6IFJFQURZPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfcGluX3JldHJpZXNfcXVlcnkoKaA8L2Rpdj48ZGl2PgpvZm9ub2RbMTg3MDFdOiBQQ1VJOiAm
Z3Q7IEFUXkNQSU4/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbl5D
UElOOiBSRUFEWSwsMTAsMywxMCwzXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcw
MV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzpodWF3ZWlfY3Bpbl9jYigpIHJldHJ5IGNvdW50ZXIg
aWQ9OSwgdmFsPTEwPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2lt
LmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeSBjb3VudGVyIGlkPTEsIHZhbD0zPC9kaXY+CjxkaXY+
b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0
cnkgY291bnRlciBpZD0xMSwgdmFsPTEwPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJz
L2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeSBjb3VudGVyIGlkPTQsIHZhbD0z
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NTkwLDAs
MCwyNTVccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAx
MDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NTg5LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9k
WzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgz
MDI2RkFEQTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDY4MDAyMDAwNDg4MDExOCZxdW90O1xyXG5c
clxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2PjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODU4OSwwLDAsNFxyPC9kaXY+PGRp
dj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAw
MDImcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMv
YXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNDwv
ZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tf
Y2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogNDwvZGl2PjxkaXY+b2Zvbm9kWzE4
NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQzOCwwLDAsMjU1XHI8L2Rpdj4KPGRpdj5v
Zm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTA2LDEzMCwmcXVvdDsmcXVvdDtc
clxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNN
PTE5MiwyODQ3MiwwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsg
XHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyNkYzOEE1MDM4MDAxNzE4QTAx
MDU4QjAzNkYwNjAyODAwMjAwMEE4ODAxMjAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2
Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKSBj
cnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZn
dDsgQVQrQ1JTTT0xNzYsMjg0NzIsMCwwLDEwXHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBD
VUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs3RUVFMTExQzI3RjY1OTAwMDAwMCZxdW90
O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxMDwvZGl2Pjxk
aXY+b2Zvbm9kWzE4NzAxXTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBi
dWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTA8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06
IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1MDIsMCwwLDI1NVxyPC9kaXY+CjxkaXY+b2Zvbm9k
WzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgz
MDI2RjU2QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDc4MDAyMDAwMTg4MDEyOCZxdW90O1xyXG5c
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+CjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODUwMiwwLDAsMVxyPC9kaXY+PGRp
dj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAmcXVv
dDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE4NzAxXTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBi
dWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
UENVSTogJmd0OyBBVCtDSU1JXHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsg
XHJcbjI3MjA1MDEwMDQxMzU4MFxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY2ltaV9jYigpIGNpbWlfY2I6IDI3MjA1MDEwMDQx
MzU4MDwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9z
dGF0ZSgpIG9sZCBzdGF0ZTogMSwgbmV3IHN0YXRlOiAyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBwbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wb3N0X3NpbSgpIDB4MjJlYjRiMDwvZGl2PjxkaXY+
b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2dwcnNfY29u
dGV4dF9wcm9iZSgpoDwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9tb2RlbS5jOmdldF9t
b2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjJlYjRiMCBwcm9wZXJ0eSBBbHdheXNPbmxpbmU8L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JDPTFccjwvZGl2PjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmZ3Q7IEFUK0NMSVA9MVxyPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTog
Jmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NP
TFA9MVxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ0NXQT0xXHI8L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcw
MV06IGRyaXZlcnMvaHVhd2VpbW9kZW0vdm9pY2VjYWxsLmM6aHVhd2VpX3ZvaWNlY2FsbF9pbml0
aWFsaXplZCgpIHJlZ2lzdGVyaW5nIHRvIG5vdGlmaWNhdGlvbnM8L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHgyMmY3YTIwPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUXkNWT0lDRT0/XHI8L2Rpdj4KPGRp
dj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG5eQ1ZPSUNFOiAoMClcclxuXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDU0NTPT9ccjwvZGl2Pjxk
aXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NTQ1M6ICgmcXVvdDtJUkEmcXVvdDss
JnF1b3Q7VUNTMiZxdW90OywmcXVvdDtHU00mcXVvdDspXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRp
dj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0NGRz0/XHI8L2Rpdj48ZGl2Pm9mb25v
ZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbl5TWVNDRkc6ICgyLDEzLDE0LDE2KSwoMC0zKSwoKDIw
MDAwMDA0MDAzODAsJnF1b3Q7R1NNOTAwL0dTTTE4MDAvV0NETUE5MDAvV0NETUEyMTAwJnF1b3Q7
KSwoMjgwMDAwLCZxdW90O0dTTTg1MC9HU00xOTAwJnF1b3Q7KSwoM2ZmZmZmZmYsJnF1b3Q7QWxs
IGJhbmRzJnF1b3Q7KSksKDAtMiksKDAtNClcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1NNUz0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06
IFBDVUk6ICZsdDsgXHJcbitDU01TOiAoMCwxKVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9u
b2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc21zLmM6YXRfY3Ntc19xdWVyeV9jYigpIENTTVMg
cXVlcnkgcGFyc2VkIHN1Y2Nlc3NmdWxseTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTog
Jmd0OyBBVCtDR0RDT05UPT9ccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsg
XHJcbitDR0RDT05UOiAoMS0xMSksJnF1b3Q7SVAmcXVvdDssLCwoMC0yKSwoMC0zKSwoMCwxKSwo
MCwxKVxyXG4rQ0dEQ09OVDogKDEtMTEpLCZxdW90O1BQUCZxdW90OywsLCgwLTIpLCgwLTMpLCgw
LDEpLCgwLDEpXHJcblxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJ
OiAmZ3Q7IEFUK0NSU009MTkyLDI4NDgwLDAsMCwyNTVccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcw
MV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2MjFFODIwNTQyMjEwMDIyMDY4
MzAyNkY0MEE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA1ODAwMjAwQ0M4ODAwJnF1b3Q7XHJcblxy
XG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9jcnNtX2luZm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzI8L2Rpdj4KPGRpdj5vZm9u
b2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NQQlM9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1BCUzogKCZxdW90O1NNJnF1b3Q7LCZxdW90O0VOJnF1b3Q7LCZx
dW90O09OJnF1b3Q7LCZxdW90O0ZEJnF1b3Q7KVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9u
b2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NTTVM9MVxyPC9kaXY+PGRpdj4Kb2Zvbm9kWzE4NzAx
XTogUENVSTogJmx0OyBcclxuK0NTTVM6IDEsMSwxXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ0dSRUc9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTg3
MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ0dSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2
Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsMSw0LDM0XHI8L2Rp
dj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
NEQ3OTIwNEU3NTZENjI2NTcyRkZGRkZGRkZGRkZGRkZGRkZGRkZGRjA3OTE1MzgzMTM5Nzc4NDhG
RkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAs
IDAwLCAzNDwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1NNUz9ccjwv
ZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NTTVM6IDEsMSwxLDFcclxu
XHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDR1JFRz0y
XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2Pjxk
aXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDR0FVVE89MFxyPC9kaXY+CjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmZ3Q7IEFUK0NHRVJFUD0yLDFccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENV
STogJmx0OyBcclxuRVJST1JcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc4LDI4NDgwLDIsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9L
XHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IFBDVUk6ICZndDsgQVQrQ01HRj0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBD
VUk6ICZsdDsgXHJcbitDTUdGOiAoMCwxKVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2Rb
MTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgwLDMsNCwzNFxyPC9kaXY+CjxkaXY+
b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMv
YXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8
L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NQTVM9P1xyPC9kaXY+PGRp
dj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BNUzogKCZxdW90O1NNJnF1b3Q7LCZx
dW90O01FJnF1b3Q7KSwoJnF1b3Q7U00mcXVvdDssJnF1b3Q7TUUmcXVvdDspLCgmcXVvdDtTTSZx
dW90OywmcXVvdDtNRSZxdW90OylcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCw0LDQsMzRccjwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZx
dW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+
CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDTUdGPTBccjwvZGl2PjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgwLDUsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2Rb
MTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVv
dDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2Rl
bS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj48
ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1BNUz0mcXVvdDtNRSZxdW90OywmcXVv
dDtNRSZxdW90OywmcXVvdDtNRSZxdW90O1xyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1BNUzogMCwyMCwwLDIwLDAsMjBcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2
Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsNiw0LDM0XHI8L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBk
cml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwg
MDAsIDM0PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDTk1JPT9ccjwv
ZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogRHVwbGljYXRlIEVGc2RuIGVudHJpZXMgZm9yIGBFbWVy
Z2VuY3kgU2VydmljZXMmIzM5OzwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBc
clxuK0NOTUk6ICgwLTIpLCgwLTMpLCgwLDIpLCgwLTIpLCgwLDEpXHJcblxyXG5PS1xyXG48L2Rp
dj48ZGl2PgpvZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc21zLmM6YnVpbGRfY25taV9z
dHJpbmcoKaA8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ05NST0xLDEs
MiwxLDBccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvc21zLmM6c21zX3Jlc3RvcmVfdHhfcXVldWUoKaA8
L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6c21z
X3dhdGNoKCkgcmVnaXN0ZXJlZDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy9zbWFy
dC1tZXNzYWdpbmcuYzpzbXNfd2F0Y2goKSByZWdpc3RlcmVkPC9kaXY+PGRpdj5vZm9ub2RbMTg3
MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NNR0w9NFxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJ
OiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9k
ZW0vc21zLmM6YXRfY21nbF9kb25lKCmgPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAm
Z3Q7IEFUK0NHU01TPTNccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbSAweDIyZWI0YjAgcHJvcGVydHkgQWx3YXlzT25saW5lPC9kaXY+CjxkaXY+
b2Zvbm9kWzE4NzAxXTogcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfc2V0X29ubGluZSgpIG1vZGVt
IDB4MjJlYjRiMCBvbmxpbmU8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQr
Q0ZVTj0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbl5TSU1TVDow
LDBcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL2h1YXdlaS5jOnNpbXN0X25v
dGlmeSgpIDEgLSZndDsgMDwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJc
bk9LXHJcblxyXG5eU0lNU1Q6MSwwXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogcGx1Z2lu
cy9odWF3ZWkuYzpzaW1zdF9ub3RpZnkoKSAwIC0mZ3Q7IDE8L2Rpdj48ZGl2Pm9mb25vZFsxODcw
MV06IFBDVUk6ICZndDsgQVReU1lTSU5GT1xyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JFRzogMlxyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ0dSRUc6IDJcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvZ3Bycy5j
Om9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9odWF3ZWlfMCBzdGF0dXMgMjwvZGl2PjxkaXY+
b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuXlNZU0lORk86MCwzLDAsMCwxLDAsMFxyXG5c
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBwbHVnaW5zL2h1YXdlaS5jOnN5c2lu
Zm9fb25saW5lX2NiKCkgMSAtJmd0OyAxPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL21v
ZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAyLCBuZXcgc3RhdGU6IDM8L2Rp
dj48ZGl2Pm9mb25vZFsxODcwMV06IHBsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3Bvc3Rfb25saW5l
KCkgMHgyMmViNGIwPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSRUc9
P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JFRzogKDAtMilc
clxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1ND
Qj0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbitDU0NCOigwLDEp
XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1VT
RD0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxOCwwLDAsMjU1
XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7NjIxRTgyMDU0MjIxMDAwNjA1ODMwMjZGQ0FBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYw
NTgwMDIwMDFFODgwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5
MCwgMDAsIDMyPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUkVHPTJc
cjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMTg3MDFdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zcG5fd2F0Y2goKSAweDIy
ZjdhMjA8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRy
ZWdfYWRkX3N0YXR1c193YXRjaCgpIDB4MjJmNjc2MDwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06
IHNyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpIDB4MjJmNjc2
MDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDU0NCPTBccjwvZGl2Pjxk
aXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2Rb
MTg3MDFdOiBzcmMvY2JzLmM6Y2JzX2dvdF9pbXNpKCkgR290IElNU0k6IDI3MjA1MDEwMDQxMzU4
MDwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdf
YWRkX3N0YXR1c193YXRjaCgpIDB4MjJmNjc2MDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENV
STogJmd0OyBBVCtDUlNNPTE3OCwyODYxOCwxLDQsNlxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJc
blxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JFRz9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogUENVSTogJmx0OyBcclxuK0NSRUc6IDIsMlxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9u
b2RbMTg3MDFdOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCkgL2h1
YXdlaV8wIHN0YXR1cyAyIHRlY2ggLTE8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvbmV0
d29yay5jOmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2soKSAweDIyZjY3NjAsIChuaWwpPC9kaXY+
PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAyLCAt
MSwgLTEsIC0xLCAobnVsbCkobnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9ncHJz
LmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMiw0LDZccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8L2Rpdj4KPGRpdj5v
Zm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE4LDMsNCw2XHI8L2Rpdj48
ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAw
MDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJp
dmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAw
LCA2PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYx
OCw0LDQsNlxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgNjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsg
QVQrQ1JTTT0xNzgsMjg2MTgsNSw0LDZccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTog
Jmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Jz
bV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3
MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NjE3LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIy
MTAwMDUwNTgzMDI2RkM5QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDI4MDAyMDAxOTg4MDAmcXVv
dDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMjwvZGl2Pgo8
ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsMSw0LDVccjwv
ZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90
OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAs
IDAwLCA1PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwy
ODYxNywyLDQsNVxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5v
Zm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3Jz
bV9yZWFkX2NiOiA5MCwgMDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc4LDI4NjE3LDMsNCw1XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6
ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNt
X3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcw
MV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsNCw0LDVccjwvZGl2PjxkaXY+b2Zvbm9k
WzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAwMDAwMDAmcXVv
dDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA1PC9kaXY+Cjxk
aXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNyw1LDQsNVxyPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBk
cml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwg
MDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4
NDMzLDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NS
U006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IHNyYy9tZXNzYWdlLXdhaXRpbmcuYzptd19jcGhzX213aXNfcmVhZF9jYigpIE5vIENQ
SFMgTVdJUyBvbiBTSU08L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTkyLDI4NjE5LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0
OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMTAwNTgzMDI2RkNCQTUwMzgw
MDE3MThBMDEwNThCMDM2RjA2MDU4MDAyMDA1MDg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19j
YigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMSw0LDE2XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcw
MV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5
MCwgMDAsIDE2PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE3
OCwyODYxOSwyLDQsMTZccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxu
K0NSU006IDE0NCwwLCZxdW90O0ZGMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7
XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRp
dj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDMsNCwxNlxyPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9j
YigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksNCw0LDE2XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcw
MV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5
MCwgMDAsIDE2PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtDUlNNPTE3
OCwyODYxOSw1LDQsMTZccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxu
K0NSU006IDE0NCwwLCZxdW90O0ZGMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7
XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRp
dj5vZm9ub2RbMTg3MDFdOiBzcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9jaygpIGJ1Zm9m
ZjogMCwgc2Vla29mZjogMzksIHRvcmVhZDogMTc8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNy
Yy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLCBzZWVrb2ZmOiAzOSwg
dG9yZWFkOiAxMDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogZHJpdmVycy9hdG1vZGVtL2Nicy5j
OmF0X2Nic19zZXRfdG9waWNzKCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0
OyBBVCtDU0NCPTBccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9MCwmcXVvdDsw
LDM0LDUwLDgwLDIxNCw1NTUsNDM1Mi00MzU2JnF1b3Q7XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcw
MV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6
ICZndDsgQVQrQ1JTTT0xOTIsMjg0MzcsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmbHQ7IFxyXG5eTU9ERTogNSw0XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
UENVSTogJmx0OyBcclxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xyXG48
L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTUsMCww
LDI1NVxyPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0
NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMjIwNTgzMDI2RkM3QTUwMzgwMDE3MThBMDEwNThCMDM2
RjA2MDI4MDAyMDBBQTg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4
NzAxXTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19j
YjogOTAsIDAwLCAzMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JT
TT0xNzgsMjg2MTUsMSw0LDM0XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsg
XHJcbitDUlNNOiAxNDQsMCwmcXVvdDs0RDYxNjk2Q0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGMDc5MTUzODMzMzMzMTMxN0ZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTog
UENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwyLDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE4
NzAxXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7
XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj4KPGRp
dj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDMsNCwzNFxyPC9k
aXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAs
IDAwLCAzNDwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgs
Mjg2MTUsNCw0LDM0XHI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJcbitD
UlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkg
Y3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTog
Jmd0OyBBVCtDUlNNPTE3OCwyODYxNSw1LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTog
UENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxy
XG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj4KPGRpdj5vZm9u
b2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG5eUlNTSTogMTBcclxuXHJcbl5IQ1NROiZxdW90O1dD
RE1BJnF1b3Q7LDM3LDI5LDQ5XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0
OyBcclxuXlNSVlNUOiAyXHJcblxyXG4rQ0dSRUc6IDEsJnF1b3Q7MDA0MCZxdW90OywmcXVvdDsw
MkMxMDE3OCZxdW90O1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9ncHJzLmM6b2Zv
bm9fZ3Byc19zdGF0dXNfbm90aWZ5KCkgL2h1YXdlaV8wIHN0YXR1cyAxPC9kaXY+CjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDEsJnF1b3Q7MDA0MCZxdW90OywmcXVv
dDswMkMxMDE3OCZxdW90O1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9uZXR3b3Jr
LmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkoKSAvaHVhd2VpXzAgc3RhdHVzIDEgdGVjaCAy
PC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQo
KSAxLCAtMSwgLTEsIDIsIChudWxsKShudWxsKTwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNy
Yy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogUENVSTogJmd0OyBBVCtDT1BTPTMsMlxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJ
OiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZndDsgQVQr
Q09QUz9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuK0NPUFM6IDAs
MiwmcXVvdDsyNzIwNSZxdW90OywyXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTg3
MDFdOiBkcml2ZXJzL2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjb3BzX251bWVyaWNf
Y2IoKSBDb3BzIG51bWVyaWMgZ290IG1jYzogMjcyLCBtbmM6IDA1PC9kaXY+PGRpdj5vZm9ub2Rb
MTg3MDFdOiBQQ1VJOiAmZ3Q7IEFUK0NTUVxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1NROiAxMCw5OVxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE4
NzAxXTogZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y3NxX2NiKCkgY3Nx
X2NiOiAxMDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRy
ZWdfc3RyZW5ndGhfbm90aWZ5KCkgc3RyZW5ndGggMzI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06
IFBDVUk6ICZndDsgQVQrQ09QUz0zLDBccjwvZGl2PjxkaXY+Cm9mb25vZFsxODcwMV06IFBDVUk6
ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmd0OyBBVCtD
T1BTP1xyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBQQ1VJOiAmbHQ7IFxyXG4rQ09QUzogMCww
LCZxdW90OzMgSVJMJnF1b3Q7LDJcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAx
XTogZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19jYigpIGNvcHNf
Y2I6IDMgSVJMLCAyNzIgMDUgMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9uZXR3b3Jr
LmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4MjJmNjc2MCwgKG5pbCk8L2Rpdj48ZGl2
Pm9mb25vZFsxODcwMV06IHNyYy9jYnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDEsIC0xLCAt
MSwgMiwgMjcyMDU8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9jYnMuYzpjYnNfbG9jYXRp
b25fY2hhbmdlZCgpIDEsIDAsIDA8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvZ3Bycy5j
Om5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDE8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IGRyaXZl
cnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9ncHJzX2FjdGl2YXRlX3ByaW1hcnkoKSBjaWQg
MTwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogTW9kZW06ICZndDsgQVQrQ0dEQ09OVD0xLCZxdW90
O0lQJnF1b3Q7LCZxdW90OzxhIGhyZWY9Imh0dHA6Ly8zaXJlbGFuZC5pZSI+M2lyZWxhbmQuaWU8
L2E+JnF1b3Q7XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMTg3MDFdOiBNb2RlbTogJmx0OyBcclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFdOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0
LmM6YXRfY2dkY29udF9jYigpIG9rIDE8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IE1vZGVtOiAm
Z3Q7IEFUK0NHREFUQT0mcXVvdDtQUFAmcXVvdDssMVxyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBNb2RlbTogJmx0OyBcclxuK0NNRSBFUlJPUjogNTBcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE4
NzAxXTogZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2NnZGF0YV9jYigpIG9rIDA8
L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFVuYWJsZSB0byBlbnRlciBkYXRhIHN0YXRlPC9kaXY+
PGRpdj5vZm9ub2RbMTg3MDFdOiBzcmMvZ3Bycy5jOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIDB4
MjJmNTkwMDwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVf
Y2FsbGJhY2soKSBBY3RpdmF0aW5nIGNvbnRleHQgZmFpbGVkIHdpdGggZXJyb3I6IEluY29ycmVj
dCBwYXJhbWV0ZXJzPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuXlJT
U0k6IDhcclxuXHJcbl5IQ1NROiZxdW90O1dDRE1BJnF1b3Q7LDM2LDI0LDQxXHJcbjwvZGl2Pjxk
aXY+b2Zvbm9kWzE4NzAxXTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RyZW5ndGhfbm90
aWZ5KCkgc3RyZW5ndGggMjU8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZsdDsgXHJc
bl5SU1NJOiAxMFxyXG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDssMzcsMjksNDlcclxuPC9k
aXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RyZW5n
dGhfbm90aWZ5KCkgc3RyZW5ndGggMzI8L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IFBDVUk6ICZs
dDsgXHJcbl5SU1NJOiA3XHJcblxyXG5eSENTUTomcXVvdDtXQ0RNQSZxdW90OywzNSwyMyw0MVxy
XG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0
cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDIyPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogUENV
STogJmx0OyBcclxuXlJTU0k6IDEwXHJcblxyXG5eSENTUTomcXVvdDtXQ0RNQSZxdW90OywzNywy
OCw0N1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0
cmVnX3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDMyPC9kaXY+PGRpdj5vZm9ub2RbMTg3MDFd
OiBQQ1VJOiAmbHQ7IFxyXG5eUlNTSTogNlxyXG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDss
MzUsMjAsMzVcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL25ldHdvcmsuYzpvZm9u
b19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5KCkgc3RyZW5ndGggMTk8L2Rpdj48ZGl2Pm9mb25vZFsx
ODcwMV06IFBDVUk6ICZsdDsgXHJcbl5SU1NJOiA5XHJcblxyXG5eSENTUTomcXVvdDtXQ0RNQSZx
dW90OywzNSwyNyw0OVxyXG48L2Rpdj48ZGl2Pm9mb25vZFsxODcwMV06IHNyYy9uZXR3b3JrLmM6
b2Zvbm9fbmV0cmVnX3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDI5PC9kaXY+CjxkaXY+b2Zv
bm9kWzE4NzAxXTogUENVSTogJmx0OyBcclxuXlJTU0k6IDZcclxuXHJcbl5IQ1NROiZxdW90O1dD
RE1BJnF1b3Q7LDM1LDIxLDM3XHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE4NzAxXTogc3JjL25ldHdv
cmsuYzpvZm9ub19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5KCkgc3RyZW5ndGggMTk8L2Rpdj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhvbWFtPC9kaXY+CjwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5P
biA2IEZlYnJ1YXJ5IDIwMTQgMTY6NTIsIERlbmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZs
dDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5r
ZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CkhpIEhvbWFtLDxkaXYgY2xhc3M9IiI+PGJyPgo8
YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAu
OGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpvZm9ub2Rb
MTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0Ljx1PjwvdT5jOmF0X2NnZGF0YV9j
YigpIG9rIDA8YnI+Cm9mb25vZFsxNzgxOF06IFVuYWJsZSB0byBlbnRlciBkYXRhIHN0YXRlPGJy
PgpvZm9ub2RbMTc4MThdOiBzcmMvZ3Bycy5jOnByaV9hY3RpdmF0ZV88dT48L3U+Y2FsbGJhY2so
KSAweDIxMjFjMDA8YnI+Cm9mb25vZFsxNzgxOF06IHNyYy9ncHJzLmM6cHJpX2FjdGl2YXRlXzx1
PjwvdT5jYWxsYmFjaygpIEFjdGl2YXRpbmcgY29udGV4dCBmYWlsZWQgd2l0aCBlcnJvcjogSW5j
b3JyZWN0IHBhcmFtZXRlcnM8YnI+Cjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+CkNhbiB5
b3UgZW5hYmxlIEFUIGNvbW1hbmQgdHJhY2luZyBieSB1c2luZzo8YnI+Cjxicj4KZXhwb3J0IE9G
T05PX0FUX0RFQlVHPTEgdGhlIHJ1bm5pbmcgb2Zvbm9kIGFuZCBwb3N0IHRoYXQgbG9nLjxicj4K
PGJyPgpJdCBsb29rcyBsaWtlIHRoZSBlaXRoZXIgdGhlIEFQTiBzZXR1cCBpcyBpbmNvcnJlY3Qg
b3IgdGhlIG1vZGVtIHdpbGwgcmVxdWlyZSB1cyB0byB1c2UgdGhlIGxlZ2FjeSBmb3JtIG9mIGNv
bnRleHQgYWN0aXZhdGlvbiBpbnN0ZWFkIG9mICtDR0RBVEEuPGJyPgo8YnI+ClJlZ2FyZHMsPGJy
PgotRGVuaXM8YnI+Cjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+
PGRpdj48YnI+PC9kaXY+LS0gPGJyPjxkaXYgZGlyPSJsdHIiPjxkaXY+SG9tYW0gRGFiaXMgfCBT
b2Z0d2FyZSBDb25zdWx0YW50PC9kaXY+PGRpdj5tOiArMzUzIDg2IDg4MSA0MDE4PC9kaXY+PGRp
dj5za3lwZTogaGRhYmlzMTwvZGl2PjxkaXY+PGltZyBzcmM9ImNpZDo4MjFBNTUyNy02RjZDLTRF
NDctQkQ1MC00MjQwRUE0NTYyODAiPjxicj4KPC9kaXY+PGRpdj48YnI+PC9kaXY+PHNwYW4+PC9z
cGFuPjxzcGFuPjwvc3Bhbj48YnI+PGRpdj48YnI+PC9kaXY+PC9kaXY+CjwvZGl2Pgo=

--===============1550378763027090746==
Content-Type: image/png
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="BAC7E76C-8B6C-463B-8B8E-8703BA6787AC6.png"

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
tS4nW7n/C6ptvmFkQMaMAAAAAElFTkSuQmCC
--===============1550378763027090746==--

