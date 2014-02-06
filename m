Content-Type: multipart/mixed; boundary="===============4207785043047215670=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: Unable to connect Huawei HiLink E303
Date: Thu, 06 Feb 2014 16:40:06 +0000
Message-ID: <CAK+sfosT-thxn02iuvScDvF8Nz9ZO5cw_YiB=z5ku-_5fkv-Uw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4207785043047215670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am using ubuntu 12.04, kernel 3.2.0-58-generic, ofono-1.14

I insert 3G dongle into USB port. I mode switch using:

sudo usb_modeswitch -I -s 20 -p 0x1f01 -v 0x12d1 -P 1001 -M
"55534243123456780000000000000011062000000100000000000000000000"

I run
sudo ofonod
test/enable-modem
test/list-contexts
[ /huawei_0 ]
    [ /huawei_0/context1 ]
        Username =3D
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        IPv6.Settings =3D { }
        Active =3D 0
        AccessPointName =3D 3ireland.ie
        Password =3D
        Type =3D internet


test/activate-context
Error activating /huawei_0/context1: org.ofono.Error.Failed: Operation
failed

ofono log:

ofonod[17818]: oFono version 1.14
ofonod[17818]: Can't enable deferred setup: Protocol not available (92)
ofonod[17818]: src/plugin.c:__ofono_plugin_init()
ofonod[17818]: plugins/push-notification.c:push_notification_init()
ofonod[17818]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[17818]: src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x742c00 name: CDMA provisioning
ofonod[17818]: src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x742ba0 name: Provisioning
ofonod[17818]: plugins/he910.c:he910_init()
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742b00, name: he910
ofonod[17818]: plugins/connman.c:connman_init()
ofonod[17818]: src/private-network.c:ofono_private_network_driver_register()
driver: 0x742aa0, name: ConnMan Private Network
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742a00, name: sim900
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742960, name: samsung
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x7428c0, name: speedupcdma
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742820, name: speedup
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742780, name: alcatel
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x7426c0, name: icera
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742620, name: linktop
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742580, name: nokiacdma
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x7424e0, name: nokia
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742440, name: tc65
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742320, name: ste
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742260, name: ifx
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x7421c0, name: palmpre
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742120, name: novatel
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x742080, name: sierra
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x741f80, name: huawei
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x741ee0, name: zte
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x741e20, name: hso
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x741d80, name: mbm
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x741ce0, name: calypso
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x741c40, name: wavecom
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x741ba0, name: g1
ofonod[17818]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x741a80, name: cdmamodem
ofonod[17818]: src/modem.c:ofono_devinfo_driver_register() driver:
0x741ac0, name: cdmamodem
ofonod[17818]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0x741b20, name: cdmamodem
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x741960, name: phonesim
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x7419e0, name: localhfp
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x741920, name: phonesim
ofonod[17818]: src/ctm.c:ofono_ctm_driver_register() driver: 0x7418e0,
name: phonesim
ofonod[17818]: plugins/phonesim.c:parse_config() filename
/usr/local/etc/ofono/phonesim.conf
ofonod[17818]: src/ussd.c:ofono_ussd_driver_register() driver:
0x741860, name: speedupmodem
ofonod[17818]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x7415a0, name: hfpmodem
ofonod[17818]: src/modem.c:ofono_devinfo_driver_register() driver:
0x741720, name: hfpmodem
ofonod[17818]: src/network.c:ofono_netreg_driver_register() driver:
0x741640, name: hfpmodem
ofonod[17818]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x7416c0, name: hfpmodem
ofonod[17818]: src/handsfree.c:ofono_handsfree_driver_register()
driver: 0x741760, name: hfpmodem
ofonod[17818]: src/siri.c:ofono_siri_driver_register() driver:
0x7417c0, name: hfpmodem
ofonod[17818]: src/network.c:ofono_netreg_driver_register() driver:
0x741480, name: dunmodem
ofonod[17818]: src/gprs.c:ofono_gprs_driver_register() driver:
0x7414e0, name: dunmodem
ofonod[17818]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x7412c0, name: stemodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x7413c0, name: stemodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x741360, name: stemodem
ofonod[17818]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x741040, name: ifxmodem
ofonod[17818]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x7410e0, name: ifxmodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x741120, name: ifxmodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x741180, name: ifxmodem
ofonod[17818]: src/stk.c:ofono_stk_driver_register() driver: 0x7411e0,
name: ifxmodem
ofonod[17818]: src/ctm.c:ofono_ctm_driver_register() driver: 0x741240,
name: ifxmodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x740f60, name: hsomodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740fa0, name: hsomodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x740e40, name: mbmmodem
ofonod[17818]: src/stk.c:ofono_stk_driver_register() driver: 0x740ea0,
name: mbmmodem
ofonod[17818]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister()
driver: 0x740ee0, name: mbmmodem
ofonod[17818]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x740d20, name: calypsomodem
ofonod[17818]: src/stk.c:ofono_stk_driver_register() driver: 0x740dc0,
name: calypsomodem
ofonod[17818]: src/ussd.c:ofono_ussd_driver_register() driver:
0x740b00, name: huaweimodem
ofonod[17818]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x740b40, name: huaweimodem
ofonod[17818]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x740bd0, name: huaweimodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740c40, name: huaweimodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x740c00, name: huaweimodem
ofonod[17818]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register()
driver: 0x740ca0, name: huaweimodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x7409e0, name: iceramodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740a40, name: iceramodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740940, name: ztemodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x7408c0, name: swmodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x740820, name: nwmodem
ofonod[17818]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x740480, name: atmodem
ofonod[17818]: src/modem.c:ofono_devinfo_driver_register() driver:
0x7405e0, name: atmodem
ofonod[17818]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x740540, name: atmodem
ofonod[17818]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x73ffe0, name: atmodem
ofonod[17818]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x740040, name: atmodem
ofonod[17818]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x73fe00, name: atmodem
ofonod[17818]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x740580, name: atmodem
ofonod[17818]: src/ussd.c:ofono_ussd_driver_register() driver:
0x740420, name: atmodem
ofonod[17818]: src/sms.c:ofono_sms_driver_register() driver: 0x73fee0,
name: atmodem
ofonod[17818]: src/sim.c:ofono_sim_driver_register() driver: 0x7401c0,
name: atmodem
ofonod[17818]: src/sim.c:ofono_sim_driver_register() driver: 0x740260,
name: atmodem-noef
ofonod[17818]: src/stk.c:ofono_stk_driver_register() driver: 0x7403e0,
name: atmodem
ofonod[17818]: src/network.c:ofono_netreg_driver_register() driver:
0x7400e0, name: atmodem
ofonod[17818]: src/cbs.c:ofono_cbs_driver_register() driver: 0x73ffa0,
name: atmodem
ofonod[17818]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0x740640, name: atmodem
ofonod[17818]: src/gprs.c:ofono_gprs_driver_register() driver:
0x7406a0, name: atmodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x740700, name: atmodem
ofonod[17818]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0x740740, name: atmodem
ofonod[17818]: src/gnss.c:ofono_gnss_driver_register() driver:
0x740780, name: atmodem
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x73faa0, name: gobi
ofonod[17818]: src/modem.c:ofono_devinfo_driver_register() driver:
0x73f640, name: qmimodem
ofonod[17818]: src/network.c:ofono_netreg_driver_register() driver:
0x73f720, name: qmimodem
ofonod[17818]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x73f680, name: qmimodem
ofonod[17818]: src/sim.c:ofono_sim_driver_register() driver: 0x73f780,
name: qmimodem-legacy
ofonod[17818]: src/sim.c:ofono_sim_driver_register() driver: 0x73f820,
name: qmimodem
ofonod[17818]: src/sms.c:ofono_sms_driver_register() driver: 0x73f8c0,
name: qmimodem
ofonod[17818]: src/ussd.c:ofono_ussd_driver_register() driver:
0x73f900, name: qmimodem
ofonod[17818]: src/gprs.c:ofono_gprs_driver_register() driver:
0x73f940, name: qmimodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x73f980, name: qmimodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x73f9c0, name: qmimodem
ofonod[17818]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister()
driver: 0x73fa20, name: qmimodem
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x73f5a0, name: u8500
ofonod[17818]: src/modem.c:ofono_devinfo_driver_register() driver:
0x73f560, name: u8500
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x73f4c0, name: n900
ofonod[17818]: src/modem.c:ofono_modem_driver_register() driver:
0x73f420, name: isiusb
ofonod[17818]: src/modem.c:ofono_devinfo_driver_register() driver:
0x73ee60, name: isimodem
ofonod[17818]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x73ee40, name: isimodem
ofonod[17818]: src/network.c:ofono_netreg_driver_register() driver:
0x73eea0, name: isimodem
ofonod[17818]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x73ef00, name: isimodem
ofonod[17818]: src/sms.c:ofono_sms_driver_register() driver: 0x73efa0,
name: isimodem
ofonod[17818]: src/cbs.c:ofono_cbs_driver_register() driver: 0x73efe0,
name: isimodem
ofonod[17818]: src/sim.c:ofono_sim_driver_register() driver: 0x73f020,
name: isimodem
ofonod[17818]: src/ussd.c:ofono_ussd_driver_register() driver:
0x73f0c0, name: isimodem
ofonod[17818]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x73f100, name: isimodem
ofonod[17818]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x73f140, name: isimodem
ofonod[17818]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x73f1a0, name: isimodem
ofonod[17818]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0x73f1e0, name: isimodem
ofonod[17818]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x73f240, name: isimodem
ofonod[17818]: src/gprs.c:ofono_gprs_driver_register() driver:
0x73f2a0, name: isimodem
ofonod[17818]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x73f2e0, name: isimodem
ofonod[17818]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x73f310, name: isimodem
ofonod[17818]: src/sim.c:ofono_sim_driver_register() driver: 0x73f340,
name: wgmodem2.5
ofonod[17818]: plugins/udevng.c:udev_start()
ofonod[17818]: plugins/udevng.c:enumerate_devices()
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [046d:c52b]
ofonod[17818]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usbhid [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0bda:8176]
ofonod[17818]: plugins/udevng.c:check_usb_device() rtl8192cu [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() rtl8192cu [0bda:8176]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0424:2507]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [067b:2303]
ofonod[17818]: plugins/udevng.c:check_usb_device() pl2303 [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() pl2303 [067b:2303]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [8087:0024]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [12d1:1001]
ofonod[17818]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[17818]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[17818]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/ttyUSB1/tty/t=
tyUSB1
ofonod[17818]: plugins/udevng.c:add_device() /dev/ttyUSB1 (huawei)
255/255/255 [00] =3D=3D> (null) (null)
ofonod[17818]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[17818]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[17818]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.1/ttyUSB2/tty/t=
tyUSB2
ofonod[17818]: plugins/udevng.c:add_device() /dev/ttyUSB2 (huawei)
255/255/255 [01] =3D=3D> (null) (null)
ofonod[17818]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() option [12d1:1001]
ofonod[17818]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[17818]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.2/ttyUSB3/tty/t=
tyUSB3
ofonod[17818]: plugins/udevng.c:add_device() /dev/ttyUSB3 (huawei)
255/255/255 [02] =3D=3D> (null) (null)
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [8087:0024]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [0a5c:5801]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofonod[17818]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[17818]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[17818]: plugins/udevng.c:create_modem() driver=3Dhuawei
ofonod[17818]: src/modem.c:ofono_modem_create() name: (null), type: huawei
ofonod[17818]: plugins/udevng.c:setup_huawei()
/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2
ofonod[17818]: plugins/udevng.c:setup_huawei() /dev/ttyUSB1
255/255/255 00 (null)
ofonod[17818]: plugins/udevng.c:setup_huawei() /dev/ttyUSB2
255/255/255 01 (null)
ofonod[17818]: plugins/udevng.c:setup_huawei() /dev/ttyUSB3
255/255/255 02 (null)
ofonod[17818]: plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUSB1
pcui=3D/dev/ttyUSB3 diag=3D(null) qmi=3D(null) net=3D(null)
ofonod[17818]: src/modem.c:set_modem_property() modem 0x21194b0 property De=
vice
ofonod[17818]: src/modem.c:set_modem_property() modem 0x21194b0 property Mo=
dem
ofonod[17818]: src/modem.c:set_modem_property() modem 0x21194b0 property Pc=
ui
ofonod[17818]: src/modem.c:set_modem_property() modem 0x21194b0 property Di=
ag
ofonod[17818]: src/modem.c:set_modem_property() modem 0x21194b0
property NetworkInterface
ofonod[17818]: src/modem.c:ofono_modem_register() 0x21194b0
ofonod[17818]: plugins/huawei.c:huawei_probe() 0x21194b0
ofonod[17818]: src/modem.c:emit_modem_added() 0x21194b0
ofonod[17818]: src/modem.c:call_modemwatches() 0x21194b0 added:1
ofonod[17818]: plugins/smart-messaging.c:modem_watch() modem:
0x21194b0, added: 1
ofonod[17818]: plugins/push-notification.c:modem_watch() modem:
0x21194b0, added: 1
ofonod[17818]: src/modem.c:ofono_modem_create() name: (null), type: option
ofonod[17818]: src/modem.c:set_modem_property() modem 0x2126010 property Pa=
th
ofonod[17818]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.0/ttyUSB0/tty/ttyUSB0
(option)
ofonod[17818]: src/modem.c:ofono_modem_create() name: (null), type: option
ofonod[17818]: src/modem.c:set_modem_property() modem 0x2127f60 property Pa=
th
ofonod[17818]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/ttyUSB1/tty/ttyUS=
B1
(option)
ofonod[17818]: src/modem.c:ofono_modem_create() name: (null), type: option
ofonod[17818]: src/modem.c:set_modem_property() modem 0x2126d90 property Pa=
th
ofonod[17818]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.1/ttyUSB2/tty/ttyUS=
B2
(option)
ofonod[17818]: plugins/huawei.c:huawei_enable() 0x21194b0
ofonod[17818]: src/modem.c:get_modem_property() modem 0x21194b0 property Mo=
dem
ofonod[17818]: plugins/huawei.c:open_device() Modem /dev/ttyUSB1
ofonod[17818]: src/modem.c:get_modem_property() modem 0x21194b0 property Pc=
ui
ofonod[17818]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB3
ofonod[17818]: plugins/huawei.c:cfun_enable()
ofonod[17818]: plugins/huawei.c:simst_notify() 255 -> 1
ofonod[17818]: plugins/huawei.c:sysinfo_enable_cb() 1 -> 1
ofonod[17818]: plugins/huawei.c:cfun_offline()
ofonod[17818]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[17818]: plugins/huawei.c:huawei_pre_sim() 0x21194b0
ofonod[17818]: src/sim.c:ofono_sim_add_state_watch() 0x2125a80
ofonod[17818]: src/sim.c:ofono_sim_add_state_watch() 0x2125a80
ofonod[17818]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 10
ofonod[17818]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 10
ofonod[17818]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 10
ofonod[17818]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[17818]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[17818]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[17818]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D9,=
 val=3D10
ofonod[17818]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D1,=
 val=3D3
ofonod[17818]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter
id=3D11, val=3D10
ofonod[17818]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D4,=
 val=3D3
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 4
ofonod[17818]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 4
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 10
ofonod[17818]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 1
ofonod[17818]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[17818]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 272050100413580
ofonod[17818]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[17818]: plugins/huawei.c:huawei_post_sim() 0x21194b0
ofonod[17818]: drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[17818]: src/modem.c:get_modem_property() modem 0x21194b0
property AlwaysOnline
ofonod[17818]: drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized=
()
registering to notifications
ofonod[17818]: src/sim.c:ofono_sim_add_state_watch() 0x2125a80
ofonod[17818]: drivers/atmodem/sms.c:at_csms_query_cb() CSMS query
parsed successfully
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 32
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: Duplicate EFsdn entries for `Emergency Services'
ofonod[17818]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[17818]: src/sms.c:sms_restore_tx_queue()
ofonod[17818]: plugins/push-notification.c:sms_watch() registered
ofonod[17818]: plugins/smart-messaging.c:sms_watch() registered
ofonod[17818]: drivers/atmodem/sms.c:at_cmgl_done()
ofonod[17818]: src/modem.c:get_modem_property() modem 0x21194b0
property AlwaysOnline
ofonod[17818]: plugins/huawei.c:huawei_set_online() modem 0x21194b0 online
ofonod[17818]: plugins/huawei.c:simst_notify() 1 -> 0
ofonod[17818]: plugins/huawei.c:simst_notify() 0 -> 1
ofonod[17818]: src/gprs.c:ofono_gprs_status_notify() /huawei_0 status 2
ofonod[17818]: plugins/huawei.c:sysinfo_online_cb() 1 -> 1
ofonod[17818]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[17818]: plugins/huawei.c:huawei_post_online() 0x21194b0
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 32
ofonod[17818]: src/sim.c:ofono_sim_add_spn_watch() 0x2125a80
ofonod[17818]: src/network.c:__ofono_netreg_add_status_watch() 0x2124a60
ofonod[17818]: src/network.c:__ofono_netreg_add_status_watch() 0x2124a60
ofonod[17818]: src/cbs.c:cbs_got_imsi() Got IMSI: 272050100413580
ofonod[17818]: src/network.c:__ofono_netreg_add_status_watch() 0x2124a60
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 6
ofonod[17818]: src/network.c:ofono_netreg_status_notify() /huawei_0
status 2 tech -1
ofonod[17818]: src/network.c:current_operator_callback() 0x2124a60, (nil)
ofonod[17818]: src/cbs.c:cbs_location_changed() 2, -1, -1, -1, (null)(null)
ofonod[17818]: src/gprs.c:netreg_status_changed() 2
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 6
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 6
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 6
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 6
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 32
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 5
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 5
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 5
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 5
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 5
ofonod[17818]: src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on=
 SIM
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 32
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 16
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 16
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 16
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 16
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 16
ofonod[17818]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff:
39, toread: 17
ofonod[17818]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff:
39, toread: 10
ofonod[17818]: drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 32
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 34
ofonod[17818]: src/gprs.c:ofono_gprs_status_notify() /huawei_0 status 1
ofonod[17818]: src/network.c:ofono_netreg_status_notify() /huawei_0
status 1 tech 2
ofonod[17818]: src/cbs.c:cbs_location_changed() 1, -1, -1, 2, (null)(null)
ofonod[17818]: src/gprs.c:netreg_status_changed() 1
ofonod[17818]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 272, mnc: 05
ofonod[17818]: drivers/atmodem/network-registration.c:csq_cb() csq_cb: 8
ofonod[17818]: src/network.c:ofono_netreg_strength_notify() strength 25
ofonod[17818]: drivers/atmodem/network-registration.c:cops_cb()
cops_cb: 3 IRL, 272 05 2
ofonod[17818]: src/network.c:current_operator_callback() 0x2124a60, (nil)
ofonod[17818]: src/cbs.c:cbs_location_changed() 1, -1, -1, 2, 27205
ofonod[17818]: src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[17818]: src/gprs.c:netreg_status_changed() 1
ofonod[17818]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() ci=
d 1
ofonod[17818]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod[17818]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
ofonod[17818]: Unable to enter data state
ofonod[17818]: src/gprs.c:pri_activate_callback() 0x2121c00
ofonod[17818]: src/gprs.c:pri_activate_callback() Activating context
failed with error: Incorrect parameters




Using Ubuntu's network-manager, using the same dongle and SIM card, I am
able to connect..

-- =

Homam

--===============4207785043047215670==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7
Zm9udC1zaXplOjEzLjMzMzMzMzk2OTExNjIxMXB4Ij5JIGFtIHVzaW5nIHVidW50dSAxMi4wNCwg
a2VybmVsoDMuMi4wLTU4LWdlbmVyaWMsIG9mb25vLTEuMTQ8L3NwYW4+PGRpdiBzdHlsZT0iZm9u
dC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTMuMzMzMzMzOTY5MTE2MjExcHgi
Pgo8YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZjtmb250
LXNpemU6MTMuMzMzMzMzOTY5MTE2MjExcHgiPkkgaW5zZXJ0IDNHIGRvbmdsZSBpbnRvIFVTQiBw
b3J0LiBJIG1vZGUgc3dpdGNoIHVzaW5nOjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFy
aWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzLjMzMzMzMzk2OTExNjIxMXB4Ij48YnI+PC9kaXY+
CjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzLjMz
MzMzMzk2OTExNjIxMXB4Ij5zdWRvIHVzYl9tb2Rlc3dpdGNoIC1JIC1zIDIwIC1wIDB4MWYwMSAt
diAweDEyZDEgLVAgMTAwMSAtTSAmcXVvdDs1NTUzNDI0MzEyMzQ1Njc4MDAwMDAwMDAwMDAwMDAx
MTA2MjAwMDAwMDEwMDAwMDAwMDAwMDAwMDAwMDAwMCZxdW90OzwvZGl2PjxkaXYgc3R5bGU9ImZv
bnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzLjMzMzMzMzk2OTExNjIxMXB4
Ij4KPGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9u
dC1zaXplOjEzLjMzMzMzMzk2OTExNjIxMXB4Ij5JIHJ1bjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQt
ZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzLjMzMzMzMzk2OTExNjIxMXB4Ij5z
dWRvIG9mb25vZDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7
Zm9udC1zaXplOjEzLjMzMzMzMzk2OTExNjIxMXB4Ij4KdGVzdC9lbmFibGUtbW9kZW08L2Rpdj48
ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMy4zMzMz
MzM5NjkxMTYyMTFweCI+PGRpdj48ZGl2PnRlc3QvbGlzdC1jb250ZXh0czwvZGl2PjxkaXY+PGRp
dj5bIC9odWF3ZWlfMCBdPC9kaXY+PGRpdj6gIKAgWyAvaHVhd2VpXzAvY29udGV4dDEgXTwvZGl2
PjxkaXY+oCCgIKAgoCBVc2VybmFtZSA9oDwvZGl2Pgo8ZGl2PqAgoCCgIKAgUHJvdG9jb2wgPSBp
cDwvZGl2PjxkaXY+oCCgIKAgoCBOYW1lID0gSW50ZXJuZXQ8L2Rpdj48ZGl2PqAgoCCgIKAgU2V0
dGluZ3MgPSB7IH08L2Rpdj48ZGl2PqAgoCCgIKAgSVB2Ni5TZXR0aW5ncyA9IHsgfTwvZGl2Pjxk
aXY+oCCgIKAgoCBBY3RpdmUgPSAwPC9kaXY+PGRpdj6gIKAgoCCgIEFjY2Vzc1BvaW50TmFtZSA9
oDxhIGhyZWY9Imh0dHA6Ly8zaXJlbGFuZC5pZS8iIHRhcmdldD0iX2JsYW5rIj4zaXJlbGFuZC5p
ZTwvYT48L2Rpdj4KPGRpdj6gIKAgoCCgIFBhc3N3b3JkID2gPC9kaXY+PGRpdj6gIKAgoCCgIFR5
cGUgPSBpbnRlcm5ldDwvZGl2PjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjxkaXYg
c3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzLjMzMzMzMzk2
OTExNjIxMXB4Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsc2Fucy1z
ZXJpZjtmb250LXNpemU6MTMuMzMzMzMzOTY5MTE2MjExcHgiPgp0ZXN0L2FjdGl2YXRlLWNvbnRl
eHQ8L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6
ZToxMy4zMzMzMzM5NjkxMTYyMTFweCI+RXJyb3IgYWN0aXZhdGluZyAvaHVhd2VpXzAvY29udGV4
dDE6IG9yZy5vZm9uby5FcnJvci5GYWlsZWQ6IE9wZXJhdGlvbiBmYWlsZWQ8YnI+PC9kaXY+PGRp
diBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTMuMzMzMzMz
OTY5MTE2MjExcHgiPgo8YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsc2Fu
cy1zZXJpZjtmb250LXNpemU6MTMuMzMzMzMzOTY5MTE2MjExcHgiPm9mb25vIGxvZzo8L2Rpdj48
ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMy4zMzMz
MzM5NjkxMTYyMTFweCI+PGRpdj48YnI+PC9kaXY+PGRpdj48cHJlIHN0eWxlPSJjb2xvcjpyZ2Io
MCwwLDApO3dvcmQtd3JhcDpicmVhay13b3JkO3doaXRlLXNwYWNlOnByZS13cmFwIj4Kb2Zvbm9k
WzE3ODE4XTogb0Zvbm8gdmVyc2lvbiAxLjE0Cm9mb25vZFsxNzgxOF06IENhbiYjMzk7dCBlbmFi
bGUgZGVmZXJyZWQgc2V0dXA6IFByb3RvY29sIG5vdCBhdmFpbGFibGUgKDkyKQpvZm9ub2RbMTc4
MThdOiBzcmMvcGx1Z2luLmM6X19vZm9ub19wbHVnaW5faW5pdCgpIApvZm9ub2RbMTc4MThdOiBw
bHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6cHVzaF9ub3RpZmljYXRpb25faW5pdCgpIApvZm9u
b2RbMTc4MThdOiBwbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOnNtYXJ0X21lc3NhZ2luZ19pbml0
KCkgCm9mb25vZFsxNzgxOF06IHNyYy9jZG1hLXByb3Zpc2lvbi5jOm9mb25vX2NkbWFfcHJvdmlz
aW9uX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDJjMDAgbmFtZTogQ0RNQSBwcm92aXNp
b25pbmcKb2Zvbm9kWzE3ODE4XTogc3JjL2dwcnMtcHJvdmlzaW9uLmM6b2Zvbm9fZ3Byc19wcm92
aXNpb25fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MmJhMCBuYW1lOiBQcm92aXNpb25p
bmcKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy9oZTkxMC5jOmhlOTEwX2luaXQoKSAKb2Zvbm9kWzE3
ODE4XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDc0MmIwMCwgbmFtZTogaGU5MTAKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy9jb25ubWFuLmM6Y29u
bm1hbl9pbml0KCkgCm9mb25vZFsxNzgxOF06IHNyYy9wcml2YXRlLW5ldHdvcmsuYzpvZm9ub19w
cml2YXRlX25ldHdvcmtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MmFhMCwgbmFtZTog
Q29ubk1hbiBQcml2YXRlIE5ldHdvcmsKb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MmEwMCwgbmFtZTogc2ltOTAwCm9m
b25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg3NDI5NjAsIG5hbWU6IHNhbXN1bmcKb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MjhjMCwgbmFtZTogc3Bl
ZWR1cGNkbWEKb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDc0MjgyMCwgbmFtZTogc3BlZWR1cApvZm9ub2RbMTc4MThdOiBz
cmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQyNzgw
LCBuYW1lOiBhbGNhdGVsCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDI2YzAsIG5hbWU6IGljZXJhCm9mb25vZFsxNzgx
OF06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3
NDI2MjAsIG5hbWU6IGxpbmt0b3AKb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9k
ZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MjU4MCwgbmFtZTogbm9raWFjZG1hCm9m
b25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg3NDI0ZTAsIG5hbWU6IG5va2lhCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDI0NDAsIG5hbWU6IHRjNjUK
b2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDc0MjMyMCwgbmFtZTogc3RlCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDIyNjAsIG5hbWU6IGlmeApv
Zm9ub2RbMTc4MThdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4NzQyMWMwLCBuYW1lOiBwYWxtcHJlCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDIxMjAsIG5hbWU6IG5v
dmF0ZWwKb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDc0MjA4MCwgbmFtZTogc2llcnJhCm9mb25vZFsxNzgxOF06IHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDFmODAsIG5h
bWU6IGh1YXdlaQpvZm9ub2RbMTc4MThdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxZWUwLCBuYW1lOiB6dGUKb2Zvbm9kWzE3ODE4XTogc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MWUyMCwg
bmFtZTogaHNvCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg3NDFkODAsIG5hbWU6IG1ibQpvZm9ub2RbMTc4MThdOiBzcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxY2UwLCBu
YW1lOiBjYWx5cHNvCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDFjNDAsIG5hbWU6IHdhdmVjb20Kb2Zvbm9kWzE3ODE4
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0
MWJhMCwgbmFtZTogZzEKb2Zvbm9kWzE3ODE4XTogc3JjL2NkbWEtdm9pY2VjYWxsLmM6b2Zvbm9f
Y2RtYV92b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MWE4MCwgbmFtZTog
Y2RtYW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MWFjMCwgbmFtZTogY2RtYW1vZGVtCm9mb25vZFsxNzgx
OF06IHNyYy9jZG1hLWNvbm5tYW4uYzpvZm9ub19jZG1hX2Nvbm5tYW5fZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDc0MWIyMCwgbmFtZTogY2RtYW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDE5NjAsIG5h
bWU6IHBob25lc2ltCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDE5ZTAsIG5hbWU6IGxvY2FsaGZwCm9mb25vZFsxNzgx
OF06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg3NDE5MjAsIG5hbWU6IHBob25lc2ltCm9mb25vZFsxNzgxOF06IHNyYy9jdG0uYzpvZm9u
b19jdG1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MThlMCwgbmFtZTogcGhvbmVzaW0K
b2Zvbm9kWzE3ODE4XTogcGx1Z2lucy9waG9uZXNpbS5jOnBhcnNlX2NvbmZpZygpIGZpbGVuYW1l
IC91c3IvbG9jYWwvZXRjL29mb25vL3Bob25lc2ltLmNvbmYKb2Zvbm9kWzE3ODE4XTogc3JjL3Vz
c2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDE4NjAsIG5hbWU6
IHNwZWVkdXBtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2Vj
YWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDE1YTAsIG5hbWU6IGhmcG1vZGVtCm9m
b25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDc0MTcyMCwgbmFtZTogaGZwbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL25ldHdv
cmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTY0MCwgbmFt
ZTogaGZwbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL2NhbGwtdm9sdW1lLmM6b2Zvbm9fY2FsbF92
b2x1bWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTZjMCwgbmFtZTogaGZwbW9kZW0K
b2Zvbm9kWzE3ODE4XTogc3JjL2hhbmRzZnJlZS5jOm9mb25vX2hhbmRzZnJlZV9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NzQxNzYwLCBuYW1lOiBoZnBtb2RlbQpvZm9ub2RbMTc4MThdOiBz
cmMvc2lyaS5jOm9mb25vX3NpcmlfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTdjMCwg
bmFtZTogaGZwbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTQ4MCwgbmFtZTogZHVubW9kZW0Kb2Zvbm9k
WzE3ODE4XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg3NDE0ZTAsIG5hbWU6IGR1bm1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy92b2ljZWNhbGwuYzpv
Zm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTJjMCwgbmFtZTog
c3RlbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTNjMCwgbmFtZTogc3RlbW9kZW0Kb2Zvbm9kWzE3
ODE4XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDc0MTM2MCwgbmFtZTogc3RlbW9kZW0Kb2Zvbm9kWzE3ODE4XTog
c3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4NzQxMDQwLCBuYW1lOiBpZnhtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvYXVkaW8tc2V0dGlu
Z3MuYzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQx
MGUwLCBuYW1lOiBpZnhtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpv
Zm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxMTIwLCBu
YW1lOiBpZnhtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4
dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQxMTgwLCBuYW1lOiBpZnhtb2RlbQpvZm9u
b2RbMTc4MThdOiBzcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg3NDExZTAsIG5hbWU6IGlmeG1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9jdG0uYzpvZm9ub19j
dG1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MTI0MCwgbmFtZTogaWZ4bW9kZW0Kb2Zv
bm9kWzE3ODE4XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDc0MGY2MCwgbmFtZTogaHNvbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL3Jh
ZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDc0MGZhMCwgbmFtZTogaHNvbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL2dwcnMuYzpv
Zm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MGU0MCwgbmFt
ZTogbWJtbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NzQwZWEwLCBuYW1lOiBtYm1tb2RlbQpvZm9ub2RbMTc4MThdOiBz
cmMvbG9jYXRpb24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0aW5nX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg3NDBlZTAsIG5hbWU6IG1ibW1vZGVtCm9mb25vZFsxNzgxOF06
IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDc0MGQyMCwgbmFtZTogY2FseXBzb21vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9zdGsuYzpv
Zm9ub19zdGtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MGRjMCwgbmFtZTogY2FseXBz
b21vZGVtCm9mb25vZFsxNzgxOF06IHNyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NzQwYjAwLCBuYW1lOiBodWF3ZWltb2RlbQpvZm9ub2RbMTc4MThdOiBz
cmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg3NDBiNDAsIG5hbWU6IGh1YXdlaW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9hdWRpby1zZXR0
aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3
NDBiZDAsIG5hbWU6IGh1YXdlaW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9yYWRpby1zZXR0aW5n
cy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDBj
NDAsIG5hbWU6IGh1YXdlaW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9ncHJzLmM6b2Zvbm9fZ3By
c19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDBjMDAsIG5hbWU6IGh1YXdl
aW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9jZG1hLW5ldHJlZy5jOm9mb25vX2NkbWFfbmV0cmVn
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDBjYTAsIG5hbWU6IGh1YXdlaW1vZGVtCm9m
b25vZFsxNzgxOF06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg3NDA5ZTAsIG5hbWU6IGljZXJhbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3Jj
L3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDc0MGE0MCwgbmFtZTogaWNlcmFtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvcmFk
aW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NzQwOTQwLCBuYW1lOiB6dGVtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvZ3Bycy5jOm9m
b25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwOGMwLCBuYW1l
OiBzd21vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlv
X3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDA4MjAsIG5hbWU6IG53bW9k
ZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwNDgwLCBuYW1lOiBhdG1vZGVtCm9mb25vZFsxNzgxOF06
IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0
MDVlMCwgbmFtZTogYXRtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvY2FsbC1iYXJyaW5nLmM6b2Zv
bm9fY2FsbF9iYXJyaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDA1NDAsIG5hbWU6
IGF0bW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL2NhbGwtZm9yd2FyZGluZy5jOm9mb25vX2NhbGxf
Zm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmZmUwLCBuYW1lOiBhdG1v
ZGVtCm9mb25vZFsxNzgxOF06IHNyYy9jYWxsLW1ldGVyLmM6b2Zvbm9fY2FsbF9tZXRlcl9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwMDQwLCBuYW1lOiBhdG1vZGVtCm9mb25vZFsxNzgx
OF06IHNyYy9jYWxsLXNldHRpbmdzLmM6b2Zvbm9fY2FsbF9zZXR0aW5nc19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NzNmZTAwLCBuYW1lOiBhdG1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9w
aG9uZWJvb2suYzpvZm9ub19waG9uZWJvb2tfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0
MDU4MCwgbmFtZTogYXRtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvdXNzZC5jOm9mb25vX3Vzc2Rf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MDQyMCwgbmFtZTogYXRtb2RlbQpvZm9ub2Rb
MTc4MThdOiBzcmMvc21zLmM6b2Zvbm9fc21zX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3
M2ZlZTAsIG5hbWU6IGF0bW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL3NpbS5jOm9mb25vX3NpbV9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwMWMwLCBuYW1lOiBhdG1vZGVtCm9mb25vZFsx
NzgxOF06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0
MDI2MCwgbmFtZTogYXRtb2RlbS1ub2VmCm9mb25vZFsxNzgxOF06IHNyYy9zdGsuYzpvZm9ub19z
dGtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MDNlMCwgbmFtZTogYXRtb2RlbQpvZm9u
b2RbMTc4MThdOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4NzQwMGUwLCBuYW1lOiBhdG1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9jYnMuYzpv
Zm9ub19jYnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZmZhMCwgbmFtZTogYXRtb2Rl
bQpvZm9ub2RbMTc4MThdOiBzcmMvY2FsbC12b2x1bWUuYzpvZm9ub19jYWxsX3ZvbHVtZV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQwNjQwLCBuYW1lOiBhdG1vZGVtCm9mb25vZFsxNzgx
OF06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzQw
NmEwLCBuYW1lOiBhdG1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19j
b250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3NDA3MDAsIG5hbWU6IGF0bW9kZW0K
b2Zvbm9kWzE3ODE4XTogc3JjL3NpbS1hdXRoLmM6b2Zvbm9fc2ltX2F1dGhfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDc0MDc0MCwgbmFtZTogYXRtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMv
Z25zcy5jOm9mb25vX2duc3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDc0MDc4MCwgbmFt
ZTogYXRtb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmYWEwLCBuYW1lOiBnb2JpCm9mb25vZFsxNzgxOF06IHNy
Yy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjY0
MCwgbmFtZTogcW1pbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRy
ZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjcyMCwgbmFtZTogcW1pbW9kZW0Kb2Zv
bm9kWzE3ODE4XTogc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NzNmNjgwLCBuYW1lOiBxbWltb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMv
c2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2Y3ODAsIG5hbWU6
IHFtaW1vZGVtLWxlZ2FjeQpvZm9ub2RbMTc4MThdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2Y4MjAsIG5hbWU6IHFtaW1vZGVtCm9mb25vZFsxNzgx
OF06IHNyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjhj
MCwgbmFtZTogcW1pbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL3Vzc2QuYzpvZm9ub191c3NkX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2Y5MDAsIG5hbWU6IHFtaW1vZGVtCm9mb25vZFsx
NzgxOF06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NzNmOTQwLCBuYW1lOiBxbWltb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvZ3Bycy5jOm9mb25vX2dw
cnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmOTgwLCBuYW1lOiBxbWlt
b2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0
aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmOWMwLCBuYW1lOiBxbWltb2RlbQpv
Zm9ub2RbMTc4MThdOiBzcmMvbG9jYXRpb24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVw
b3J0aW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2ZhMjAsIG5hbWU6IHFtaW1vZGVt
Cm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg3M2Y1YTAsIG5hbWU6IHU4NTAwCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5j
Om9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjU2MCwgbmFtZTog
dTg1MDAKb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDczZjRjMCwgbmFtZTogbjkwMApvZm9ub2RbMTc4MThdOiBzcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmNDIwLCBuYW1l
OiBpc2l1c2IKb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNlZTYwLCBuYW1lOiBpc2ltb2RlbQpvZm9ub2RbMTc4MThd
OiBzcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg3M2VlNDAsIG5hbWU6IGlzaW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9uZXR3b3JrLmM6
b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2VlYTAsIG5hbWU6IGlz
aW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZWYwMCwgbmFtZTogaXNpbW9kZW0Kb2Zvbm9kWzE3
ODE4XTogc3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNl
ZmEwLCBuYW1lOiBpc2ltb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvY2JzLmM6b2Zvbm9fY2JzX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2VmZTAsIG5hbWU6IGlzaW1vZGVtCm9mb25vZFsx
NzgxOF06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDcz
ZjAyMCwgbmFtZTogaXNpbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL3Vzc2QuYzpvZm9ub191c3Nk
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2YwYzAsIG5hbWU6IGlzaW1vZGVtCm9mb25v
ZFsxNzgxOF06IHNyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9ub19jYWxsX2ZvcndhcmRpbmdfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDczZjEwMCwgbmFtZTogaXNpbW9kZW0Kb2Zvbm9kWzE3
ODE4XTogc3JjL2NhbGwtc2V0dGluZ3MuYzpvZm9ub19jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg3M2YxNDAsIG5hbWU6IGlzaW1vZGVtCm9mb25vZFsxNzgxOF06IHNy
Yy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDczZjFhMCwgbmFtZTogaXNpbW9kZW0Kb2Zvbm9kWzE3ODE4XTogc3JjL2NhbGwtbWV0
ZXIuYzpvZm9ub19jYWxsX21ldGVyX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2YxZTAs
IG5hbWU6IGlzaW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25v
X3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2YyNDAsIG5hbWU6
IGlzaW1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NzNmMmEwLCBuYW1lOiBpc2ltb2RlbQpvZm9ub2RbMTc4MThdOiBz
cmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NzNmMmUwLCBuYW1lOiBpc2ltb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvYXVkaW8tc2V0dGluZ3Mu
YzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NzNmMzEw
LCBuYW1lOiBpc2ltb2RlbQpvZm9ub2RbMTc4MThdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg3M2YzNDAsIG5hbWU6IHdnbW9kZW0yLjUKb2Zvbm9kWzE3
ODE4XTogcGx1Z2lucy91ZGV2bmcuYzp1ZGV2X3N0YXJ0KCkgCm9mb25vZFsxNzgxOF06IHBsdWdp
bnMvdWRldm5nLmM6ZW51bWVyYXRlX2RldmljZXMoKSAKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91
ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXQpvZm9ub2RbMTc4
MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzA0MjQ6MjUwN10K
b2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFsw
NDI0OjI1MDddCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rldmlj
ZSgpIHVzYiBbMDQ2ZDpjNTJiXQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNr
X3VzYl9kZXZpY2UoKSB1c2JoaWQgWyhudWxsKToobnVsbCldCm9mb25vZFsxNzgxOF06IHBsdWdp
bnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYmhpZCBbKG51bGwpOihudWxsKV0Kb2Zv
bm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiaGlkIFso
bnVsbCk6KG51bGwpXQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9k
ZXZpY2UoKSB1c2JoaWQgWyhudWxsKToobnVsbCldCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMGJkYTo4MTc2XQpvZm9ub2RbMTc4MThdOiBw
bHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBydGw4MTkyY3UgWyhudWxsKToobnVs
bCldCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHJ0
bDgxOTJjdSBbMGJkYTo4MTc2XQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNr
X3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCldCm9mb25vZFsxNzgxOF06IHBsdWdpbnMv
dWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQyNDoyNTA3XQpvZm9ub2RbMTc4MThd
OiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCld
Cm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBb
MDQyNDoyNTA3XQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSBodWIgWyhudWxsKToobnVsbCldCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6
Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQyNDoyNTA3XQpvZm9ub2RbMTc4MThdOiBwbHVnaW5z
L3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCldCm9mb25vZFsx
NzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQyNDoyNTA3
XQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIg
WyhudWxsKToobnVsbCldCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNi
X2RldmljZSgpIHVzYiBbMDQyNDoyNTA3XQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5j
OmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToobnVsbCldCm9mb25vZFsxNzgxOF06IHBs
dWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMDQyNDoyNTA3XQpvZm9ub2Rb
MTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWIgWyhudWxsKToo
bnVsbCldCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgp
IGh1YiBbKG51bGwpOihudWxsKV0Kb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgdXNiIFswNjdiOjIzMDNdCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHBsMjMwMyBbKG51bGwpOihudWxsKV0Kb2Zvbm9kWzE3
ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcGwyMzAzIFswNjdiOjIz
MDNdCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1
YiBbKG51bGwpOihudWxsKV0Kb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191
c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3Vk
ZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzgwODc6MDAyNF0Kb2Zvbm9kWzE3ODE4XTog
cGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFsxMmQxOjEwMDFdCm9mb25v
ZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbKG51
bGwpOihudWxsKV0Kb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2
aWNlKCkgb3B0aW9uIFsxMmQxOjEwMDFdCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6
YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2IxLzEt
MS8xLTEuMgpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lz
L2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjIvMS0xLjI6MS4w
L3R0eVVTQjEvdHR5L3R0eVVTQjEKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzphZGRf
ZGV2aWNlKCkgL2Rldi90dHlVU0IxIChodWF3ZWkpIDI1NS8yNTUvMjU1IFswMF0gPT0mZ3Q7IChu
dWxsKSAobnVsbCkKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2
aWNlKCkgb3B0aW9uIFsobnVsbCk6KG51bGwpXQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWzEyZDE6MTAwMV0Kb2Zvbm9kWzE3ODE4XTog
cGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAw
MDowMDoxYS4wL3VzYjEvMS0xLzEtMS4yCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6
YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91c2IxLzEt
MS8xLTEuMi8xLTEuMjoxLjEvdHR5VVNCMi90dHkvdHR5VVNCMgpvZm9ub2RbMTc4MThdOiBwbHVn
aW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjIgKGh1YXdlaSkgMjU1LzI1NS8y
NTUgWzAxXSA9PSZndDsgKG51bGwpIChudWxsKQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWyhudWxsKToobnVsbCldCm9mb25vZFsxNzgx
OF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbMTJkMToxMDAx
XQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2Rldmlj
ZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjAvdXNiMS8xLTEvMS0xLjIKb2Zvbm9kWzE3ODE4XTog
cGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAw
MDowMDoxYS4wL3VzYjEvMS0xLzEtMS4yLzEtMS4yOjEuMi90dHlVU0IzL3R0eS90dHlVU0IzCm9m
b25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMyAo
aHVhd2VpKSAyNTUvMjU1LzI1NSBbMDJdID09Jmd0OyAobnVsbCkgKG51bGwpCm9mb25vZFsxNzgx
OF06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxs
KV0Kb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHVi
IFsobnVsbCk6KG51bGwpXQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3Vz
Yl9kZXZpY2UoKSB1c2IgWzgwODc6MDAyNF0Kb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2bmcu
YzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFswYTVjOjU4MDFdCm9mb25vZFsxNzgxOF06IHBsdWdp
bnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbKG51bGwpOihudWxsKV0Kb2Zvbm9k
WzE3ODE4XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFsobnVsbCk6
KG51bGwpXQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2Uo
KSBodWIgWyhudWxsKToobnVsbCldCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y3Jl
YXRlX21vZGVtKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0x
LzEtMS4yCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCkgZHJp
dmVyPWh1YXdlaQpvZm9ub2RbMTc4MThdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9jcmVhdGUo
KSBuYW1lOiAobnVsbCksIHR5cGU6IGh1YXdlaQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZu
Zy5jOnNldHVwX2h1YXdlaSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWEuMC91
c2IxLzEtMS8xLTEuMgpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdl
aSgpIC9kZXYvdHR5VVNCMSAyNTUvMjU1LzI1NSAwMCAobnVsbCkKb2Zvbm9kWzE3ODE4XTogcGx1
Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjIgMjU1LzI1NS8yNTUgMDEg
KG51bGwpCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rl
di90dHlVU0IzIDI1NS8yNTUvMjU1IDAyIChudWxsKQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL3Vk
ZXZuZy5jOnNldHVwX2h1YXdlaSgpIG1kbT0vZGV2L3R0eVVTQjEgcGN1aT0vZGV2L3R0eVVTQjMg
ZGlhZz0obnVsbCkgcW1pPShudWxsKSBuZXQ9KG51bGwpCm9mb25vZFsxNzgxOF06IHNyYy9tb2Rl
bS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjExOTRiMCBwcm9wZXJ0eSBEZXZpY2UK
b2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHgy
MTE5NGIwIHByb3BlcnR5IE1vZGVtCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOnNldF9tb2Rl
bV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjExOTRiMCBwcm9wZXJ0eSBQY3VpCm9mb25vZFsxNzgxOF06
IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjExOTRiMCBwcm9wZXJ0
eSBEaWFnCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1v
ZGVtIDB4MjExOTRiMCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJmYWNlCm9mb25vZFsxNzgxOF06IHNy
Yy9tb2RlbS5jOm9mb25vX21vZGVtX3JlZ2lzdGVyKCkgMHgyMTE5NGIwCm9mb25vZFsxNzgxOF06
IHBsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3Byb2JlKCkgMHgyMTE5NGIwCm9mb25vZFsxNzgxOF06
IHNyYy9tb2RlbS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDIxMTk0YjAKb2Zvbm9kWzE3ODE4XTog
c3JjL21vZGVtLmM6Y2FsbF9tb2RlbXdhdGNoZXMoKSAweDIxMTk0YjAgYWRkZWQ6MQpvZm9ub2Rb
MTc4MThdOiBwbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4
MjExOTRiMCwgYWRkZWQ6IDEKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlv
bi5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4MjExOTRiMCwgYWRkZWQ6IDEKb2Zvbm9kWzE3ODE4
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRlKCkgbmFtZTogKG51bGwpLCB0eXBlOiBv
cHRpb24Kb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9k
ZW0gMHgyMTI2MDEwIHByb3BlcnR5IFBhdGgKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy91ZGV2LmM6
YWRkX21vZGVtKCkgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE0LjAvdXNiMy8zLTMvMy0z
OjEuMC90dHlVU0IwL3R0eS90dHlVU0IwIChvcHRpb24pCm9mb25vZFsxNzgxOF06IHNyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IChudWxsKSwgdHlwZTogb3B0aW9uCm9mb25v
ZFsxNzgxOF06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjEyN2Y2
MCBwcm9wZXJ0eSBQYXRoCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldi5jOmFkZF9tb2RlbSgp
IC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS4yLzEtMS4yOjEu
MC90dHlVU0IxL3R0eS90dHlVU0IxIChvcHRpb24pCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IChudWxsKSwgdHlwZTogb3B0aW9uCm9mb25vZFsx
NzgxOF06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjEyNmQ5MCBw
cm9wZXJ0eSBQYXRoCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvdWRldi5jOmFkZF9tb2RlbSgpIC9k
ZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxYS4wL3VzYjEvMS0xLzEtMS4yLzEtMS4yOjEuMS90
dHlVU0IyL3R0eS90dHlVU0IyIChvcHRpb24pCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvaHVhd2Vp
LmM6aHVhd2VpX2VuYWJsZSgpIDB4MjExOTRiMApvZm9ub2RbMTc4MThdOiBzcmMvbW9kZW0uYzpn
ZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDIxMTk0YjAgcHJvcGVydHkgTW9kZW0Kb2Zvbm9k
WzE3ODE4XTogcGx1Z2lucy9odWF3ZWkuYzpvcGVuX2RldmljZSgpIE1vZGVtIC9kZXYvdHR5VVNC
MQpvZm9ub2RbMTc4MThdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAw
eDIxMTk0YjAgcHJvcGVydHkgUGN1aQpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL2h1YXdlaS5jOm9w
ZW5fZGV2aWNlKCkgUGN1aSAvZGV2L3R0eVVTQjMKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy9odWF3
ZWkuYzpjZnVuX2VuYWJsZSgpIApvZm9ub2RbMTc4MThdOiBwbHVnaW5zL2h1YXdlaS5jOnNpbXN0
X25vdGlmeSgpIDI1NSAtJmd0OyAxCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvaHVhd2VpLmM6c3lz
aW5mb19lbmFibGVfY2IoKSAxIC0mZ3Q7IDEKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy9odWF3ZWku
YzpjZnVuX29mZmxpbmUoKSAKb2Zvbm9kWzE3ODE4XTogc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdl
X3N0YXRlKCkgb2xkIHN0YXRlOiAwLCBuZXcgc3RhdGU6IDEKb2Zvbm9kWzE3ODE4XTogcGx1Z2lu
cy9odWF3ZWkuYzpodWF3ZWlfcHJlX3NpbSgpIDB4MjExOTRiMApvZm9ub2RbMTc4MThdOiBzcmMv
c2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4MjEyNWE4MApvZm9ub2RbMTc4MThd
OiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4MjEyNWE4MApvZm9ub2Rb
MTc4MThdOiBWb2ljZSBjaGFubmVsOiA4MDAwIEh6LCAxNiBiaXRzLCAyMG1zIHBlcmlvZApvZm9u
b2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9p
bmZvX2NiOiA5MCwgMDAsIDMwCm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTAKb2Zvbm9kWzE3ODE4XTog
c3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6
IDAsIHRvY29weTogMTAKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Ny
c21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMApvZm9ub2RbMTc4MThdOiBkcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAs
IDEwCm9mb25vZFsxNzgxOF06IHNyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkg
YnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwCm9mb25vZFsxNzgxOF06IGRyaXZlcnMv
YXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzAK
b2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNy
c21fcmVhZF9jYjogOTAsIDAwLCAxMApvZm9ub2RbMTc4MThdOiBzcmMvc2ltZnMuYzpzaW1fZnNf
b3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxMApvZm9u
b2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Bpbl9jYigpIGNyc21fcGluX2Ni
OiBSRUFEWQpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfcGluX3JldHJp
ZXNfcXVlcnkoKSAKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9j
cGluX2NiKCkgcmV0cnkgY291bnRlciBpZD05LCB2YWw9MTAKb2Zvbm9kWzE3ODE4XTogZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD0xLCB2YWw9
MwpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSBy
ZXRyeSBjb3VudGVyIGlkPTExLCB2YWw9MTAKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD00LCB2YWw9MwpvZm9ub2Rb
MTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZv
X2NiOiA5MCwgMDAsIDMwCm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNApvZm9ub2RbMTc4MThdOiBzcmMv
c2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwg
dG9jb3B5OiA0Cm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2lu
Zm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzAKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxMApv
Zm9ub2RbMTc4MThdOiBzcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9m
ZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxMApvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwCm9mb25v
ZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3Jl
YWRfY2I6IDkwLCAwMCwgMQpvZm9ub2RbMTc4MThdOiBzcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVh
ZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxCm9mb25vZFsxNzgx
OF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jaW1pX2NiKCkgY2ltaV9jYjogMjcyMDUwMTAw
NDEzNTgwCm9mb25vZFsxNzgxOF06IHNyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9s
ZCBzdGF0ZTogMSwgbmV3IHN0YXRlOiAyCm9mb25vZFsxNzgxOF06IHBsdWdpbnMvaHVhd2VpLmM6
aHVhd2VpX3Bvc3Rfc2ltKCkgMHgyMTE5NGIwCm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2Rl
bS9ncHJzLWNvbnRleHQuYzphdF9ncHJzX2NvbnRleHRfcHJvYmUoKSAKb2Zvbm9kWzE3ODE4XTog
c3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHgyMTE5NGIwIHByb3BlcnR5
IEFsd2F5c09ubGluZQpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2h1YXdlaW1vZGVtL3ZvaWNlY2Fs
bC5jOmh1YXdlaV92b2ljZWNhbGxfaW5pdGlhbGl6ZWQoKSByZWdpc3RlcmluZyB0byBub3RpZmlj
YXRpb25zCm9mb25vZFsxNzgxOF06IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNo
KCkgMHgyMTI1YTgwCm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zbXMuYzphdF9jc21z
X3F1ZXJ5X2NiKCkgQ1NNUyBxdWVyeSBwYXJzZWQgc3VjY2Vzc2Z1bGx5Cm9mb25vZFsxNzgxOF06
IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKSBjcnNtX2luZm9fY2I6IDkw
LCAwMCwgMzIKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVh
ZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNApvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0Cm9m
b25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMzQKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNApvZm9ub2RbMTc4MThd
OiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5
MCwgMDAsIDM0Cm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3Jl
YWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQKb2Zvbm9kWzE3ODE4XTogRHVwbGljYXRl
IEVGc2RuIGVudHJpZXMgZm9yIGBFbWVyZ2VuY3kgU2VydmljZXMmIzM5OwpvZm9ub2RbMTc4MThd
OiBkcml2ZXJzL2F0bW9kZW0vc21zLmM6YnVpbGRfY25taV9zdHJpbmcoKSAKb2Zvbm9kWzE3ODE4
XTogc3JjL3Ntcy5jOnNtc19yZXN0b3JlX3R4X3F1ZXVlKCkgCm9mb25vZFsxNzgxOF06IHBsdWdp
bnMvcHVzaC1ub3RpZmljYXRpb24uYzpzbXNfd2F0Y2goKSByZWdpc3RlcmVkCm9mb25vZFsxNzgx
OF06IHBsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6c21zX3dhdGNoKCkgcmVnaXN0ZXJlZApvZm9u
b2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc21zLmM6YXRfY21nbF9kb25lKCkgCm9mb25vZFsx
NzgxOF06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MjExOTRiMCBw
cm9wZXJ0eSBBbHdheXNPbmxpbmUKb2Zvbm9kWzE3ODE4XTogcGx1Z2lucy9odWF3ZWkuYzpodWF3
ZWlfc2V0X29ubGluZSgpIG1vZGVtIDB4MjExOTRiMCBvbmxpbmUKb2Zvbm9kWzE3ODE4XTogcGx1
Z2lucy9odWF3ZWkuYzpzaW1zdF9ub3RpZnkoKSAxIC0mZ3Q7IDAKb2Zvbm9kWzE3ODE4XTogcGx1
Z2lucy9odWF3ZWkuYzpzaW1zdF9ub3RpZnkoKSAwIC0mZ3Q7IDEKb2Zvbm9kWzE3ODE4XTogc3Jj
L2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvaHVhd2VpXzAgc3RhdHVzIDIKb2Zv
bm9kWzE3ODE4XTogcGx1Z2lucy9odWF3ZWkuYzpzeXNpbmZvX29ubGluZV9jYigpIDEgLSZndDsg
MQpvZm9ub2RbMTc4MThdOiBzcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3Rh
dGU6IDIsIG5ldyBzdGF0ZTogMwpvZm9ub2RbMTc4MThdOiBwbHVnaW5zL2h1YXdlaS5jOmh1YXdl
aV9wb3N0X29ubGluZSgpIDB4MjExOTRiMApvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0v
c2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyCm9mb25vZFsx
NzgxOF06IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3Nwbl93YXRjaCgpIDB4MjEyNWE4MApvZm9u
b2RbMTc4MThdOiBzcmMvbmV0d29yay5jOl9fb2Zvbm9fbmV0cmVnX2FkZF9zdGF0dXNfd2F0Y2go
KSAweDIxMjRhNjAKb2Zvbm9kWzE3ODE4XTogc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19h
ZGRfc3RhdHVzX3dhdGNoKCkgMHgyMTI0YTYwCm9mb25vZFsxNzgxOF06IHNyYy9jYnMuYzpjYnNf
Z290X2ltc2koKSBHb3QgSU1TSTogMjcyMDUwMTAwNDEzNTgwCm9mb25vZFsxNzgxOF06IHNyYy9u
ZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpIDB4MjEyNGE2MApvZm9u
b2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDYKb2Zvbm9kWzE3ODE4XTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRy
ZWdfc3RhdHVzX25vdGlmeSgpIC9odWF3ZWlfMCBzdGF0dXMgMiB0ZWNoIC0xCm9mb25vZFsxNzgx
OF06IHNyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4MjEyNGE2MCwg
KG5pbCkKb2Zvbm9kWzE3ODE4XTogc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMiwg
LTEsIC0xLCAtMSwgKG51bGwpKG51bGwpCm9mb25vZFsxNzgxOF06IHNyYy9ncHJzLmM6bmV0cmVn
X3N0YXR1c19jaGFuZ2VkKCkgMgpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDYKb2Zvbm9kWzE3ODE4XTog
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAs
IDAwLCA2Cm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRf
Y2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNgpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDYKb2Zvbm9k
WzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5m
b19jYjogOTAsIDAwLCAzMgpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDUKb2Zvbm9kWzE3ODE4XTogZHJp
dmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAw
LCA1Cm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2Io
KSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNQpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0v
c2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDUKb2Zvbm9kWzE3
ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9j
YjogOTAsIDAwLCA1Cm9mb25vZFsxNzgxOF06IHNyYy9tZXNzYWdlLXdhaXRpbmcuYzptd19jcGhz
X213aXNfcmVhZF9jYigpIE5vIENQSFMgTVdJUyBvbiBTSU0Kb2Zvbm9kWzE3ODE4XTogZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAz
MgpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkg
Y3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE2Cm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTYKb2Zvbm9kWzE3
ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9j
YjogOTAsIDAwLCAxNgpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Jz
bV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE2Cm9mb25vZFsxNzgxOF06IGRyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MTYKb2Zvbm9kWzE3ODE4XTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2soKSBidWZv
ZmY6IDAsIHNlZWtvZmY6IDM5LCB0b3JlYWQ6IDE3Cm9mb25vZFsxNzgxOF06IHNyYy9zaW1mcy5j
OnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLCBzZWVrb2ZmOiAzOSwgdG9yZWFkOiAx
MApvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vY2JzLmM6YXRfY2JzX3NldF90b3BpY3Mo
KSAKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigp
IGNyc21faW5mb19jYjogOTAsIDAwLCAzMgpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0v
c2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0Cm9mb25vZFsx
NzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRf
Y2I6IDkwLCAwMCwgMzQKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Ny
c21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNApvZm9ub2RbMTc4MThdOiBkcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAs
IDM0Cm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2Io
KSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQKb2Zvbm9kWzE3ODE4XTogc3JjL2dwcnMuYzpvZm9u
b19ncHJzX3N0YXR1c19ub3RpZnkoKSAvaHVhd2VpXzAgc3RhdHVzIDEKb2Zvbm9kWzE3ODE4XTog
c3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgpIC9odWF3ZWlfMCBzdGF0
dXMgMSB0ZWNoIDIKb2Zvbm9kWzE3ODE4XTogc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2Vk
KCkgMSwgLTEsIC0xLCAyLCAobnVsbCkobnVsbCkKb2Zvbm9kWzE3ODE4XTogc3JjL2dwcnMuYzpu
ZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAxCm9mb25vZFsxNzgxOF06IGRyaXZlcnMvYXRtb2RlbS9u
ZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNvcHNfbnVtZXJpY19jYigpIENvcHMgbnVtZXJpYyBnb3Qg
bWNjOiAyNzIsIG1uYzogMDUKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL25ldHdvcmst
cmVnaXN0cmF0aW9uLmM6Y3NxX2NiKCkgY3NxX2NiOiA4Cm9mb25vZFsxNzgxOF06IHNyYy9uZXR3
b3JrLmM6b2Zvbm9fbmV0cmVnX3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDI1Cm9mb25vZFsx
NzgxOF06IGRyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNvcHNfY2IoKSBj
b3BzX2NiOiAzIElSTCwgMjcyIDA1IDIKb2Zvbm9kWzE3ODE4XTogc3JjL25ldHdvcmsuYzpjdXJy
ZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHgyMTI0YTYwLCAobmlsKQpvZm9ub2RbMTc4MThdOiBz
cmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAxLCAtMSwgLTEsIDIsIDI3MjA1Cm9mb25v
ZFsxNzgxOF06IHNyYy9jYnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDEsIDAsIDAKb2Zvbm9k
WzE3ODE4XTogc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAxCm9mb25vZFsxNzgx
OF06IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9ncHJzX2FjdGl2YXRlX3ByaW1h
cnkoKSBjaWQgMQpvZm9ub2RbMTc4MThdOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6
YXRfY2dkY29udF9jYigpIG9rIDEKb2Zvbm9kWzE3ODE4XTogZHJpdmVycy9hdG1vZGVtL2dwcnMt
Y29udGV4dC5jOmF0X2NnZGF0YV9jYigpIG9rIDAKb2Zvbm9kWzE3ODE4XTogVW5hYmxlIHRvIGVu
dGVyIGRhdGEgc3RhdGUKb2Zvbm9kWzE3ODE4XTogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2Fs
bGJhY2soKSAweDIxMjFjMDAKb2Zvbm9kWzE3ODE4XTogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVf
Y2FsbGJhY2soKSBBY3RpdmF0aW5nIGNvbnRleHQgZmFpbGVkIHdpdGggZXJyb3I6IEluY29ycmVj
dCBwYXJhbWV0ZXJzCjwvcHJlPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj48YnI+PC9k
aXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Vc2luZyBVYnVudHUmIzM5O3MgbmV0d29yay1t
YW5hZ2VyLCB1c2luZyB0aGUgc2FtZSBkb25nbGUgYW5kIFNJTSBjYXJkLCBJIGFtIGFibGUgdG8g
Y29ubmVjdC4uPC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+LS0gPGJyPjxkaXYgZGlyPSJsdHIi
PjxkaXY+CkhvbWFtPC9kaXY+PGRpdj48YnI+PC9kaXY+PHNwYW4+PC9zcGFuPjxzcGFuPjwvc3Bh
bj48YnI+PGRpdj48YnI+PC9kaXY+PC9kaXY+CjwvZGl2Pgo=

--===============4207785043047215670==--

