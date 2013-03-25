Content-Type: multipart/mixed; boundary="===============1169833047228559735=="
MIME-Version: 1.0
From: Etienne Mabille <mabille.etienne@gmail.com>
Subject: Setting Up oFono-1.3 with Telit HE 910
Date: Mon, 25 Mar 2013 16:59:51 +0100
Message-ID: <CAMtf1D_gk4HtsvB=VHzS+RCnZi3ntZdpFkkamNNbKjvs5Oojow@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1169833047228559735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I am new to the oFono project and am currently trying to set up a Telit HE
910 with oFono-1.3
I looked into the documentation and the code itself but I still have some
issues.

So far, I have added this udev rule:

ATTRS(idVendor)=3D=3D"1bc7", ATTRS(idProduct)=3D=3D"0021", ENV(OFONO_DRIVER=
)=3D"telit"

And I have added the changes listed here : Udevng: Support Telit Modems
Using Cdc-acm Drive<http://lists.linuxwimax.org/pipermail/ofono/2012-Decemb=
er/013973.html>

When I run ofono, the telit driver is not loaded properly. Using the debug
option and adding some DBG messages, I found that during
the execution of "ofono_modem_register", the "telit" driver is not in the
in the list.
I tracked the problem all the way up to the configure file.
It seems that the Telit plugin needs the Bluetooth option enabled, to be
included in the built-in modules.

Does anyone know why ? Is it possible to bypass this ?

Any help or clarification will be greatly appreciated.

Etienne


Here is the output of the debug run :


ofonod[1736]: oFono version 1.3
ofonod[1736]: plugins/push-notification.c:
push_notification_init()
ofonod[1736]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156a60,
name: sim900
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156a00,
name: samsung
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81569a0,
name: speedupcdma
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156940,
name: speedup
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81568e0,
name: alcatel
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156880,
name: linktop
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156820,
name: nokiacdma
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81567c0,
name: nokia
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156760,
name: tc65
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81566c0,
name: ste
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156660,
name: ifx
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156600,
name: palmpre
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81565a0,
name: novatel
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156540,
name: sierra
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81564c0,
name: huawei
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156460,
name: zte
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156400,
name: hso
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81563a0,
name: mbm
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156340,
name: calypso
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81562e0,
name: wavecom
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156280,
name: gobi
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156220,
name: g1
ofonod[1736]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x81561a0, name: cdmamodem
ofonod[1736]: src/modem.c:ofono_devinfo_driver_register() driver:
0x81561c0, name: cdmamodem
ofonod[1736]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0x81561e4, name: cdmamodem
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156100,
name: phonesim
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8156140,
name: localhfp
ofonod[1736]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x81560d4, name: phonesim
ofonod[1736]: src/ctm.c:ofono_ctm_driver_register() driver: 0x81560c0,
name: phonesim
ofonod[1736]: plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[1736]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8155fa0, name: hfpmodem
ofonod[1736]: src/modem.c:ofono_devinfo_driver_register() driver:
0x815605c, name: hfpmodem
ofonod[1736]: src/network.c:ofono_netreg_driver_register() driver:
0x8156000, name: hfpmodem
ofonod[1736]: src/call-volume.c:ofono_call_volume_driver_register() driver:
0x8156034, name: hfpmodem
ofonod[1736]: src/handsfree.c:ofono_handsfree_driver_register() driver:
0x8156078, name: hfpmodem
ofonod[1736]: src/network.c:ofono_netreg_driver_register() driver:
0x8155f20, name: dunmodem
ofonod[1736]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8155f4c,
name: dunmodem
ofonod[1736]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8155e40, name: stemodem
ofonod[1736]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8155ecc, name: stemodem
ofonod[1736]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8155ea0, name: stemodem
ofonod[1736]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8155d00, name: ifxmodem
ofonod[1736]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x8155d50, name: ifxmodem
ofonod[1736]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8155d80, name: ifxmodem
ofonod[1736]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8155dac, name: ifxmodem
ofonod[1736]: src/stk.c:ofono_stk_driver_register() driver: 0x8155dd0,
name: ifxmodem
ofonod[1736]: src/ctm.c:ofono_ctm_driver_register() driver: 0x8155df8,
name: ifxmodem
ofonod[1736]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8155c80, name: hsomodem
ofonod[1736]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8155ca0, name: hsomodem
ofonod[1736]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8155be0, name: mbmmodem
ofonod[1736]: src/stk.c:ofono_stk_driver_register() driver: 0x8155c04,
name: mbmmodem
ofonod[1736]:
src/location-reporting.c:ofono_location_reporting_driver_register() driver:
0x8155c24, name: mbmmodem
ofonod[1736]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8155b40, name: calypsomodem
ofonod[1736]: src/stk.c:ofono_stk_driver_register() driver: 0x8155b88,
name: calypsomodem
ofonod[1736]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8155a20,
name: huaweimodem
ofonod[1736]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8155a40, name: huaweimodem
ofonod[1736]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x8155a88, name: huaweimodem
ofonod[1736]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x8155ac0, name: huaweimodem
ofonod[1736]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8155a9c, name: huaweimodem
ofonod[1736]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:
0x8155aec, name: huaweimodem
ofonod[1736]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x81559c0, name: nwmodem
ofonod[1736]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8155820, name: atmodem
ofonod[1736]: src/modem.c:ofono_devinfo_driver_register() driver:
0x81558c0, name: atmodem
ofonod[1736]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x8155878, name: atmodem
ofonod[1736]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x81555e0, name: atmodem
ofonod[1736]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x8155620, name: atmodem
ofonod[1736]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x81554e0, name: atmodem
ofonod[1736]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x8155898, name: atmodem
ofonod[1736]: src/ussd.c:ofono_ussd_driver_register() driver: 0x81557f4,
name: atmodem
ofonod[1736]: src/sms.c:ofono_sms_driver_register() driver: 0x8155560,
name: atmodem
ofonod[1736]: src/sim.c:ofono_sim_driver_register() driver: 0x81556e0,
name: atmodem
ofonod[1736]: src/sim.c:ofono_sim_driver_register() driver: 0x8155740,
name: atmodem-noef
ofonod[1736]: src/stk.c:ofono_stk_driver_register() driver: 0x81557d4,
name: atmodem
ofonod[1736]: src/network.c:ofono_netreg_driver_register() driver:
0x8155680, name: atmodem
ofonod[1736]: src/cbs.c:ofono_cbs_driver_register() driver: 0x81555c0,
name: atmodem
ofonod[1736]: src/call-volume.c:ofono_call_volume_driver_register() driver:
0x81558e4, name: atmodem
ofonod[1736]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8155914,
name: atmodem
ofonod[1736]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8155938, name: atmodem
ofonod[1736]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0x815594c, name: atmodem
ofonod[1736]: src/gnss.c:ofono_gnss_driver_register() driver: 0x8155964,
name: atmodem
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81552a0,
name: u8500
ofonod[1736]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8155280, name: u8500
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x8155220,
name: n900
ofonod[1736]: src/modem.c:ofono_modem_driver_register() driver: 0x81551c0,
name: isiusb
ofonod[1736]: src/modem.c:ofono_devinfo_driver_register() driver:
0x8154eb0, name: isimodem
ofonod[1736]: src/phonebook.c:ofono_phonebook_driver_register() driver:
0x8154ea0, name: isimodem
ofonod[1736]: src/network.c:ofono_netreg_driver_register() driver:
0x8154ee0, name: isimodem
ofonod[1736]: src/voicecall.c:ofono_voicecall_driver_register() driver:
0x8154f20, name: isimodem
ofonod[1736]: src/sms.c:ofono_sms_driver_register() driver: 0x8154f80,
name: isimodem
ofonod[1736]: src/cbs.c:ofono_cbs_driver_register() driver: 0x8154fa0,
name: isimodem
ofonod[1736]: src/sim.c:ofono_sim_driver_register() driver: 0x8154fc0,
name: isimodem
ofonod[1736]: src/ussd.c:ofono_ussd_driver_register() driver: 0x8155008,
name: isimodem
ofonod[1736]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x8155020, name: isimodem
ofonod[1736]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x8155040, name: isimodem
ofonod[1736]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0x8155070, name: isimodem
ofonod[1736]: src/call-meter.c:ofono_call_meter_driver_register() driver:
0x81550a0, name: isimodem
ofonod[1736]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x81550e0, name: isimodem
ofonod[1736]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8155104,
name: isimodem
ofonod[1736]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0x8155118, name: isimodem
ofonod[1736]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x815512c, name: isimodem
ofonod[1736]: src/sim.c:ofono_sim_driver_register() driver: 0x8155140,
name: wgmodem2.5
ofonod[1736]: plugins/udevng.c:udev_start()
ofonod[1736]: plugins/udevng.c:enumerate_devices()
ofonod[1736]: plugins/udevng.c:check_usb_device() cdc_acm [1546:01a5]
ofonod[1736]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.0/tty/ttyACM0
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyACM0 (telit) 2/2/1 [00]
=3D=3D> (null) Telit Wireless Module Modem
ofonod[1736]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.10/tty/ttyACM5
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyACM5 (telit) 2/2/1 [0a]
=3D=3D> (null) Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.12/tty/ttyACM6
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyACM6 (telit) 2/2/1 [0c]
=3D=3D> (null) Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.2/tty/ttyACM1
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyACM1 (telit) 2/2/1 [02]
=3D=3D> (null) Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.4/tty/ttyACM2
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyACM2 (telit) 2/2/1 [04]
=3D=3D> (null) Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.6/tty/ttyACM3
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyACM3 (telit) 2/2/1 [06]
=3D=3D> (null) Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0021]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.8/tty/ttyACM4
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyACM4 (telit) 2/2/1 [08]
=3D=3D> (null) Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:check_usb_device() hso [0af0:7601]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.0/tty/ttyHS0
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyHS0 (hso) 255/255/255
[00] =3D=3D> (null) Diagnostic
ofonod[1736]: plugins/udevng.c:check_usb_device() hso [0af0:7601]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.1/tty/ttyHS1
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyHS1 (hso) 255/255/255
[01] =3D=3D> (null) GPS
ofonod[1736]: plugins/udevng.c:check_usb_device() hso [0af0:7601]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.2/tty/ttyHS2
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyHS2 (hso) 255/255/255
[02] =3D=3D> (null) GPS Control
ofonod[1736]: plugins/udevng.c:check_usb_device() hso [0af0:7601]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.3/tty/ttyHS3
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyHS3 (hso) 255/255/255
[03] =3D=3D> (null) Application
ofonod[1736]: plugins/udevng.c:check_usb_device() hso [0af0:7601]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.6/tty/ttyHS4
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyHS4 (hso) 255/255/255
[06] =3D=3D> (null) Control
ofonod[1736]: plugins/udevng.c:check_usb_device() hso [0af0:7601]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.7/net/hso0
ofonod[1736]: plugins/udevng.c:add_device() hso0 (hso) 255/255/255 [07] =3D=
=3D>
(null) (null)
ofonod[1736]: plugins/udevng.c:check_usb_device() hso [0af0:7601]
ofonod[1736]: plugins/udevng.c:add_device()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.9/tty/ttyHS5
ofonod[1736]: plugins/udevng.c:add_device() /dev/ttyHS5 (hso) 255/255/255
[09] =3D=3D> (null) Modem
ofonod[1736]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6
ofonod[1736]: src/modem.c:ofono_modem_create() name: (null), type: hso
ofonod[1736]: src/modem.c:ofono_modem_create() ofono_dbus_valid_object_path
=3D=3D TRUE
ofonod[1736]: src/modem.c:ofono_modem_create() g_try_new0 !=3D NULL
ofonod[1736]: plugins/udevng.c:setup_hso()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6
ofonod[1736]: plugins/udevng.c:setup_hso() /dev/ttyHS0 255/255/255 00
(null) Diagnostic
ofonod[1736]: plugins/udevng.c:setup_hso() /dev/ttyHS1 255/255/255 01
(null) GPS
ofonod[1736]: plugins/udevng.c:setup_hso() /dev/ttyHS2 255/255/255 02
(null) GPS Control
ofonod[1736]: plugins/udevng.c:setup_hso() /dev/ttyHS3 255/255/255 03
(null) Application
ofonod[1736]: plugins/udevng.c:setup_hso() /dev/ttyHS4 255/255/255 06
(null) Control
ofonod[1736]: plugins/udevng.c:setup_hso() hso0 255/255/255 07 (null) (null)
ofonod[1736]: plugins/udevng.c:setup_hso() /dev/ttyHS5 255/255/255 09
(null) Modem
ofonod[1736]: plugins/udevng.c:setup_hso() control=3D/dev/ttyHS4
application=3D/dev/ttyHS3 network=3Dhso0
ofonod[1736]: src/modem.c:set_modem_property() modem 0x9535cf8 property
ControlPort
ofonod[1736]: src/modem.c:set_modem_property() modem 0x9535cf8 property
ApplicationPort
ofonod[1736]: src/modem.c:set_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: src/modem.c:set_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: plugins/udevng.c:setup_hso() RECHECK: hso0
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: plugins/udevng.c:setup_hso() RECHECK:
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6
ofonod[1736]: src/modem.c:ofono_modem_register() 0x9535cf8
ofonod[1736]: plugins/hso.c:hso_probe() 0x9535cf8
ofonod[1736]: src/modem.c:emit_modem_added() 0x9535cf8
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: src/modem.c:__ofono_modem_append_properties() Ifname hso0
ofonod[1736]: src/modem.c:call_modemwatches() 0x9535cf8 added:1
ofonod[1736]: plugins/smart-messaging.c:modem_watch() modem: 0x9535cf8,
added: 1
ofonod[1736]: plugins/push-notification.c:modem_watch() modem: 0x9535cf8,
added: 1
ofonod[1736]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1
ofonod[1736]: src/modem.c:ofono_modem_create() name: (null), type: telit
ofonod[1736]: src/modem.c:ofono_modem_create() ofono_dbus_valid_object_path
=3D=3D TRUE
ofonod[1736]: src/modem.c:ofono_modem_create() g_try_new0 !=3D NULL
ofonod[1736]: plugins/udevng.c:setup_telit()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1
ofonod[1736]: plugins/udevng.c:setup_telit() /dev/ttyACM0 2/2/1 00 (null)
Telit Wireless Module Modem
ofonod[1736]: plugins/udevng.c:setup_telit() /dev/ttyACM1 2/2/1 02 (null)
Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:setup_telit() /dev/ttyACM2 2/2/1 04 (null)
Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:setup_telit() /dev/ttyACM3 2/2/1 06 (null)
Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:setup_telit() /dev/ttyACM4 2/2/1 08 (null)
Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:setup_telit() /dev/ttyACM5 2/2/1 0a (null)
Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:setup_telit() /dev/ttyACM6 2/2/1 0c (null)
Telit Wireless Module Port
ofonod[1736]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyACM0
aux=3D/dev/ttyACM3 gps=3D(null) diag=3D/dev/ttyACM1
ofonod[1736]: src/modem.c:set_modem_property() modem 0x9535dd0 property
Modem
ofonod[1736]: src/modem.c:set_modem_property() modem 0x9535dd0 property Data
ofonod[1736]: src/modem.c:set_modem_property() modem 0x9535dd0 property GPS
ofonod[1736]: src/modem.c:set_modem_property() modem 0x9535dd0 property Diag
ofonod[1736]: src/modem.c:ofono_modem_register() 0x9535dd0
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: src/modem.c:__ofono_modem_append_properties() Ifname hso0
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: src/modem.c:__ofono_modem_append_properties() Ifname hso0
ofonod[1736]: plugins/hso.c:hso_enable() 0x9535cf8
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
ControlPort
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
ApplicationPort
ofonod[1736]: Control: > ATE0 +CMEE=3D1\r
ofonod[1736]: App: > ATE0 +CMEE=3D1\r
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: src/modem.c:__ofono_modem_append_properties() Ifname hso0
ofonod[1736]: App: < \r\nOK\r\n
ofonod[1736]: Control: < \r\nOK\r\n
ofonod[1736]: Control: > AT+CFUN=3D4\r
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: src/modem.c:__ofono_modem_append_properties() Ifname hso0
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: src/modem.c:__ofono_modem_append_properties() Ifname hso0
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
NetworkInterface
ofonod[1736]: src/modem.c:get_modem_property() modem 0x9535cf8 property
SysPath
ofonod[1736]: src/modem.c:__ofono_modem_append_properties() Ifname hso0
ofonod[1736]: Control: < \r\nOK\r\n
ofonod[1736]: plugins/hso.c:cfun_enable()
ofonod[1736]: Control: > AT_OPMN\r
ofonod[1736]: Control: < \r\n\r\r\n_OPMN: GTM382 E\r\n\r\nOK\r\n
ofonod[1736]: plugins/hso.c:check_model()
ofonod[1736]: Model is GTM382 E
ofonod[1736]: Control: > AT_OBLS\r
ofonod[1736]: Control: < \r\n_OBLS: 2,0,0\r\n\r\nOK\r\n
ofonod[1736]: plugins/hso.c:sim_status()
ofonod[1736]: plugins/hso.c:sim_status() status sim 2 pb 0 sms 0

--===============1169833047228559735==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+PGRpdj5IZWxsbyBl
dmVyeW9uZSw8YnI+PGJyPjwvZGl2PkkgYW0gbmV3IHRvIHRoZSBvRm9ubyBwcm9qZWN0IGFuZCBh
bSBjdXJyZW50bHkgdHJ5aW5nIHRvIHNldCB1cCBhIFRlbGl0IEhFIDkxMCB3aXRoIG9Gb25vLTEu
Mzxicj48L2Rpdj48ZGl2PkkgbG9va2VkIGludG8gdGhlIGRvY3VtZW50YXRpb24gYW5kIHRoZSBj
b2RlIGl0c2VsZiBidXQgSSBzdGlsbCBoYXZlIHNvbWUgaXNzdWVzLiA8YnI+Cgo8YnI+PC9kaXY+
U28gZmFyLCBJIGhhdmUgYWRkZWQgdGhpcyB1ZGV2IHJ1bGU6IDxicj48YnI+QVRUUlMoaWRWZW5k
b3IpPT0mcXVvdDsxYmM3JnF1b3Q7LCBBVFRSUyhpZFByb2R1Y3QpPT0mcXVvdDswMDIxJnF1b3Q7
LCBFTlYoT0ZPTk9fRFJJVkVSKT0mcXVvdDt0ZWxpdCZxdW90Ozxicj48YnI+PC9kaXY+QW5kIEkg
aGF2ZSBhZGRlZCB0aGUgY2hhbmdlcyBsaXN0ZWQgaGVyZSA6IDxhIGhyZWY9Imh0dHA6Ly9saXN0
cy5saW51eHdpbWF4Lm9yZy9waXBlcm1haWwvb2Zvbm8vMjAxMi1EZWNlbWJlci8wMTM5NzMuaHRt
bCIgdGFyZ2V0PSJfYmxhbmsiPlVkZXZuZzogU3VwcG9ydCBUZWxpdCBNb2RlbXMgVXNpbmcgQ2Rj
LWFjbSBEcml2ZTwvYT48YnI+Cgo8YnI+PC9kaXY+V2hlbiBJIHJ1biBvZm9ubywgdGhlIHRlbGl0
IGRyaXZlciBpcyBub3QgbG9hZGVkIHByb3Blcmx5LiAKVXNpbmcgdGhlIGRlYnVnIG9wdGlvbiBh
bmQgYWRkaW5nIHNvbWUgREJHIG1lc3NhZ2VzLCBJIGZvdW5kIHRoYXQgZHVyaW5nCiA8YnI+PC9k
aXY+dGhlIGV4ZWN1dGlvbiBvZiAmcXVvdDtvZm9ub19tb2RlbV9yZWdpc3RlciZxdW90OywgdGhl
ICZxdW90O3RlbGl0JnF1b3Q7IGRyaXZlciBpcyBub3QgaW4gdGhlIGluIHRoZSBsaXN0Ljxicj4K
PC9kaXY+SSB0cmFja2VkIHRoZSBwcm9ibGVtIGFsbCB0aGUgd2F5IHVwIHRvIHRoZSBjb25maWd1
cmUgZmlsZS4gPGJyPkl0IHNlZW1zIHRoYXQgdGhlIFRlbGl0IHBsdWdpbiBuZWVkcyB0aGUgQmx1
ZXRvb3RoIG9wdGlvbiBlbmFibGVkLCB0byBiZSBpbmNsdWRlZCBpbiB0aGUgYnVpbHQtaW4gbW9k
dWxlcy48YnI+PGJyPjwvZGl2PjxkaXY+RG9lcyBhbnlvbmUga25vdyB3aHkgPyBJcyBpdCBwb3Nz
aWJsZSB0byBieXBhc3MgdGhpcyA/PGJyPgoKPGJyPjwvZGl2PjxkaXY+QW55IGhlbHAgb3IgY2xh
cmlmaWNhdGlvbiB3aWxsIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuIDxicj48YnI+PC9kaXY+PGRp
dj5FdGllbm5lPGJyPjxicj48YnI+PC9kaXY+PGRpdj5IZXJlIGlzIHRoZSBvdXRwdXQgb2YgdGhl
IGRlYnVnIHJ1biA6PGJyPjxicj48YnI+PC9kaXY+b2Zvbm9kWzE3MzZdOiBvRm9ubyB2ZXJzaW9u
IDEuMzxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzo8ZGl2Pgpw
dXNoX25vdGlmaWNhdGlvbl9pbml0KCk8YnI+Cm9mb25vZFsxNzM2XTogcGx1Z2lucy9zbWFydC1t
ZXNzYWdpbmcuYzpzbWFydF9tZXNzYWdpbmdfaW5pdCgpPGJyPm9mb25vZFsxNzM2XTogc3JjL21v
ZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTZhNjAsIG5h
bWU6IHNpbTkwMDxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2YTAwLCBuYW1lOiBzYW1zdW5nPGJyPgoKb2Zvbm9k
WzE3MzZdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE1NjlhMCwgbmFtZTogc3BlZWR1cGNkbWE8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1Njk0MCwgbmFtZTog
c3BlZWR1cDxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2OGUwLCBuYW1lOiBhbGNhdGVsPGJyPgoKb2Zvbm9kWzE3
MzZdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE1Njg4MCwgbmFtZTogbGlua3RvcDxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2ODIwLCBuYW1lOiBub2tpYWNk
bWE8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE1NjdjMCwgbmFtZTogbm9raWE8YnI+CgpvZm9ub2RbMTczNl06IHNy
Yy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2NzYw
LCBuYW1lOiB0YzY1PGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTY2YzAsIG5hbWU6IHN0ZTxicj5vZm9ub2RbMTcz
Nl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4
MTU2NjYwLCBuYW1lOiBpZng8YnI+CgpvZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2NjAwLCBuYW1lOiBwYWxtcHJlPGJy
Pm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDgxNTY1YTAsIG5hbWU6IG5vdmF0ZWw8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NjU0MCwgbmFt
ZTogc2llcnJhPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NjRjMCwgbmFtZTogaHVhd2VpPGJyPm9mb25vZFsx
NzM2XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxNTY0NjAsIG5hbWU6IHp0ZTxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2NDAwLCBuYW1lOiBoc288YnI+Cgpv
Zm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MTU2M2EwLCBuYW1lOiBtYm08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpv
Zm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NjM0MCwgbmFtZTogY2Fs
eXBzbzxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg4MTU2MmUwLCBuYW1lOiB3YXZlY29tPGJyPgoKb2Zvbm9kWzE3MzZd
OiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1
NjI4MCwgbmFtZTogZ29iaTxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2MjIwLCBuYW1lOiBnMTxicj5vZm9ub2Rb
MTczNl06IHNyYy9jZG1hLXZvaWNlY2FsbC5jOm9mb25vX2NkbWFfdm9pY2VjYWxsX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2MWEwLCBuYW1lOiBjZG1hbW9kZW08YnI+CgpvZm9ub2Rb
MTczNl06IHNyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDgxNTYxYzAsIG5hbWU6IGNkbWFtb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy9jZG1hLWNv
bm5tYW4uYzpvZm9ub19jZG1hX2Nvbm5tYW5fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
NTYxZTQsIG5hbWU6IGNkbWFtb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2MTAwLCBuYW1lOiBwaG9uZXNp
bTxicj4KCm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxNTYxNDAsIG5hbWU6IGxvY2FsaGZwPGJyPm9mb25vZFsxNzM2XTog
c3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxNTYwZDQsIG5hbWU6IHBob25lc2ltPGJyPm9mb25vZFsxNzM2XTogc3JjL2N0bS5jOm9mb25v
X2N0bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NjBjMCwgbmFtZTogcGhvbmVzaW08
YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvcGhvbmVzaW0uYzpwYXJzZV9jb25maWcoKSBmaWxl
bmFtZSAvZXRjL29mb25vL3Bob25lc2ltLmNvbmY8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvdm9pY2Vj
YWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1ZmEw
LCBuYW1lOiBoZnBtb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX2Rldmlu
Zm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTYwNWMsIG5hbWU6IGhmcG1vZGVtPGJy
PgoKb2Zvbm9kWzE3MzZdOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4ODE1NjAwMCwgbmFtZTogaGZwbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBz
cmMvY2FsbC12b2x1bWUuYzpvZm9ub19jYWxsX3ZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE1NjAzNCwgbmFtZTogaGZwbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvaGFuZHNm
cmVlLmM6b2Zvbm9faGFuZHNmcmVlX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU2MDc4
LCBuYW1lOiBoZnBtb2RlbTxicj4KCm9mb25vZFsxNzM2XTogc3JjL25ldHdvcmsuYzpvZm9ub19u
ZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTVmMjAsIG5hbWU6IGR1bm1vZGVt
PGJyPm9mb25vZFsxNzM2XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTU1ZjRjLCBuYW1lOiBkdW5tb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy92
b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgx
NTVlNDAsIG5hbWU6IHN0ZW1vZGVtPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvZ3Bycy5jOm9mb25v
X2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NWVjYywgbmFtZTog
c3RlbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRp
b19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NWVhMCwgbmFtZTogc3Rl
bW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1ZDAwLCBuYW1lOiBpZnhtb2RlbTxicj4KCm9m
b25vZFsxNzM2XTogc3JjL2F1ZGlvLXNldHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTVkNTAsIG5hbWU6IGlmeG1vZGVtPGJyPm9mb25v
ZFsxNzM2XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTVkODAsIG5hbWU6IGlmeG1vZGVtPGJyPgoKb2Zvbm9k
WzE3MzZdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE1NWRhYywgbmFtZTogaWZ4bW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvc3Rr
LmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1ZGQwLCBuYW1lOiBp
Znhtb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy9jdG0uYzpvZm9ub19jdG1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDgxNTVkZjgsIG5hbWU6IGlmeG1vZGVtPGJyPgoKb2Zvbm9kWzE3MzZd
OiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4ODE1NWM4MCwgbmFtZTogaHNvbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvcmFkaW8tc2V0
dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE1NWNhMCwgbmFtZTogaHNvbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvZ3Bycy5jOm9mb25v
X2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NWJlMCwgbmFtZTog
bWJtbW9kZW08YnI+CgpvZm9ub2RbMTczNl06IHNyYy9zdGsuYzpvZm9ub19zdGtfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxNTVjMDQsIG5hbWU6IG1ibW1vZGVtPGJyPm9mb25vZFsxNzM2
XTogc3JjL2xvY2F0aW9uLXJlcG9ydGluZy5jOm9mb25vX2xvY2F0aW9uX3JlcG9ydGluZ19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NWMyNCwgbmFtZTogbWJtbW9kZW08YnI+b2Zvbm9k
WzE3MzZdOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTU1YjQwLCBuYW1lOiBjYWx5cHNvbW9kZW08YnI+CgpvZm9ub2RbMTczNl06
IHNyYy9zdGsuYzpvZm9ub19zdGtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTViODgs
IG5hbWU6IGNhbHlwc29tb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy91c3NkLmM6b2Zvbm9fdXNz
ZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NWEyMCwgbmFtZTogaHVhd2VpbW9kZW08
YnI+b2Zvbm9kWzE3MzZdOiBzcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1YTQwLCBuYW1lOiBodWF3ZWltb2RlbTxicj4KCm9mb25v
ZFsxNzM2XTogc3JjL2F1ZGlvLXNldHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTVhODgsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPm9mb25v
ZFsxNzM2XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTVhYzAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPgoKb2Zv
bm9kWzE3MzZdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4ODE1NWE5YywgbmFtZTogaHVhd2VpbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBz
cmMvY2RtYS1uZXRyZWcuYzpvZm9ub19jZG1hX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE1NWFlYywgbmFtZTogaHVhd2VpbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvcmFk
aW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE1NTljMCwgbmFtZTogbndtb2RlbTxicj4KCm9mb25vZFsxNzM2XTogc3JjL3ZvaWNl
Y2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NTgy
MCwgbmFtZTogYXRtb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX2Rldmlu
Zm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTU4YzAsIG5hbWU6IGF0bW9kZW08YnI+
b2Zvbm9kWzE3MzZdOiBzcmMvY2FsbC1iYXJyaW5nLmM6b2Zvbm9fY2FsbF9iYXJyaW5nX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1ODc4LCBuYW1lOiBhdG1vZGVtPGJyPgoKb2Zvbm9k
WzE3MzZdOiBzcmMvY2FsbC1mb3J3YXJkaW5nLmM6b2Zvbm9fY2FsbF9mb3J3YXJkaW5nX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1NWUwLCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFsx
NzM2XTogc3JjL2NhbGwtbWV0ZXIuYzpvZm9ub19jYWxsX21ldGVyX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg4MTU1NjIwLCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFsxNzM2XTogc3JjL2Nh
bGwtc2V0dGluZ3MuYzpvZm9ub19jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg4MTU1NGUwLCBuYW1lOiBhdG1vZGVtPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvcGhvbmVi
b29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1ODk4
LCBuYW1lOiBhdG1vZGVtPGJyPm9mb25vZFsxNzM2XTogc3JjL3Vzc2QuYzpvZm9ub191c3NkX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1N2Y0LCBuYW1lOiBhdG1vZGVtPGJyPm9mb25v
ZFsxNzM2XTogc3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE1NTU2MCwgbmFtZTogYXRtb2RlbTxicj4KCm9mb25vZFsxNzM2XTogc3JjL3NpbS5jOm9mb25v
X3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NTZlMCwgbmFtZTogYXRtb2RlbTxi
cj5vZm9ub2RbMTczNl06IHNyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxNTU3NDAsIG5hbWU6IGF0bW9kZW0tbm9lZjxicj5vZm9ub2RbMTczNl06IHNyYy9z
dGsuYzpvZm9ub19zdGtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTU3ZDQsIG5hbWU6
IGF0bW9kZW08YnI+CgpvZm9ub2RbMTczNl06IHNyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1NjgwLCBuYW1lOiBhdG1vZGVtPGJyPm9mb25v
ZFsxNzM2XTogc3JjL2Nicy5jOm9mb25vX2Nic19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
ODE1NTVjMCwgbmFtZTogYXRtb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy9jYWxsLXZvbHVtZS5j
Om9mb25vX2NhbGxfdm9sdW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1OGU0LCBu
YW1lOiBhdG1vZGVtPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTU5MTQsIG5hbWU6IGF0bW9kZW08YnI+b2Zvbm9k
WzE3MzZdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4ODE1NTkzOCwgbmFtZTogYXRtb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy9zaW0t
YXV0aC5jOm9mb25vX3NpbV9hdXRoX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1OTRj
LCBuYW1lOiBhdG1vZGVtPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvZ25zcy5jOm9mb25vX2duc3Nf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTU5NjQsIG5hbWU6IGF0bW9kZW08YnI+b2Zv
bm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4ODE1NTJhMCwgbmFtZTogdTg1MDA8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpv
Zm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1MjgwLCBuYW1lOiB1
ODUwMDxicj4KCm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxNTUyMjAsIG5hbWU6IG45MDA8YnI+b2Zvbm9kWzE3MzZdOiBz
cmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NTFj
MCwgbmFtZTogaXNpdXNiPGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5m
b19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NGViMCwgbmFtZTogaXNpbW9kZW08YnI+
CgpvZm9ub2RbMTczNl06IHNyYy9waG9uZWJvb2suYzpvZm9ub19waG9uZWJvb2tfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxNTRlYTAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFsxNzM2
XTogc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxNTRlZTAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFsxNzM2XTogc3JjL3ZvaWNlY2FsbC5j
Om9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1NGYyMCwgbmFt
ZTogaXNpbW9kZW08YnI+CgpvZm9ub2RbMTczNl06IHNyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTRmODAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFsx
NzM2XTogc3JjL2Nicy5jOm9mb25vX2Nic19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1
NGZhMCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvc2ltLmM6b2Zvbm9fc2lt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU0ZmMwLCBuYW1lOiBpc2ltb2RlbTxicj4K
Cm9mb25vZFsxNzM2XTogc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg4MTU1MDA4LCBuYW1lOiBpc2ltb2RlbTxicj5vZm9ub2RbMTczNl06IHNyYy9jYWxs
LWZvcndhcmRpbmcuYzpvZm9ub19jYWxsX2ZvcndhcmRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDgxNTUwMjAsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFsxNzM2XTogc3JjL2NhbGwt
c2V0dGluZ3MuYzpvZm9ub19jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg4MTU1MDQwLCBuYW1lOiBpc2ltb2RlbTxicj4KCm9mb25vZFsxNzM2XTogc3JjL2NhbGwtYmFy
cmluZy5jOm9mb25vX2NhbGxfYmFycmluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4ODE1
NTA3MCwgbmFtZTogaXNpbW9kZW08YnI+b2Zvbm9kWzE3MzZdOiBzcmMvY2FsbC1tZXRlci5jOm9m
b25vX2NhbGxfbWV0ZXJfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTUwYTAsIG5hbWU6
IGlzaW1vZGVtPGJyPm9mb25vZFsxNzM2XTogc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFk
aW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDgxNTUwZTAsIG5hbWU6IGlz
aW1vZGVtPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDgxNTUxMDQsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFsxNzM2
XTogc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDgxNTUxMTgsIG5hbWU6IGlzaW1vZGVtPGJyPm9mb25vZFsxNzM2XTogc3JjL2F1ZGlvLXNl
dHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAw
eDgxNTUxMmMsIG5hbWU6IGlzaW1vZGVtPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvc2ltLmM6b2Zv
bm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg4MTU1MTQwLCBuYW1lOiB3Z21vZGVt
Mi41PGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzp1ZGV2X3N0YXJ0KCk8YnI+b2Zv
bm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmVudW1lcmF0ZV9kZXZpY2VzKCk8YnI+b2Zvbm9k
WzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBjZGNfYWNtIFsxNTQ2
OjAxYTVdPGJyPgoKb2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSBjZGNfYWNtIFsxYmM3OjAwMjFdPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcu
YzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC43L3VzYjEv
MS0xLzEtMToxLjAvdHR5L3R0eUFDTTA8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5j
OmFkZF9kZXZpY2UoKSAvZGV2L3R0eUFDTTAgKHRlbGl0KSAyLzIvMSBbMDBdID09Jmd0OyAobnVs
bCkgVGVsaXQgV2lyZWxlc3MgTW9kdWxlIE1vZGVtPGJyPgoKb2Zvbm9kWzE3MzZdOiBwbHVnaW5z
L3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBjZGNfYWNtIFsxYmM3OjAwMjFdPGJyPm9mb25v
ZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAw
MDA6MDAvMDAwMDowMDoxZC43L3VzYjEvMS0xLzEtMToxLjEwL3R0eS90dHlBQ001PGJyPm9mb25v
ZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlBQ001ICh0ZWxp
dCkgMi8yLzEgWzBhXSA9PSZndDsgKG51bGwpIFRlbGl0IFdpcmVsZXNzIE1vZHVsZSBQb3J0PGJy
PgoKb2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBjZGNf
YWNtIFsxYmM3OjAwMjFdPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2
aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC43L3VzYjEvMS0xLzEtMTox
LjEyL3R0eS90dHlBQ002PGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2
aWNlKCkgL2Rldi90dHlBQ002ICh0ZWxpdCkgMi8yLzEgWzBjXSA9PSZndDsgKG51bGwpIFRlbGl0
IFdpcmVsZXNzIE1vZHVsZSBQb3J0PGJyPgoKb2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5j
OmNoZWNrX3VzYl9kZXZpY2UoKSBjZGNfYWNtIFsxYmM3OjAwMjFdPGJyPm9mb25vZFsxNzM2XTog
cGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAw
MDowMDoxZC43L3VzYjEvMS0xLzEtMToxLjIvdHR5L3R0eUFDTTE8YnI+b2Zvbm9kWzE3MzZdOiBw
bHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eUFDTTEgKHRlbGl0KSAyLzIvMSBb
MDJdID09Jmd0OyAobnVsbCkgVGVsaXQgV2lyZWxlc3MgTW9kdWxlIFBvcnQ8YnI+CgpvZm9ub2Rb
MTczNl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGNkY19hY20gWzFiYzc6
MDAyMV08YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lz
L2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFkLjcvdXNiMS8xLTEvMS0xOjEuNC90dHkvdHR5
QUNNMjxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYv
dHR5QUNNMiAodGVsaXQpIDIvMi8xIFswNF0gPT0mZ3Q7IChudWxsKSBUZWxpdCBXaXJlbGVzcyBN
b2R1bGUgUG9ydDxicj4KCm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2Jf
ZGV2aWNlKCkgY2RjX2FjbSBbMWJjNzowMDIxXTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRl
dm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91
c2IxLzEtMS8xLTE6MS42L3R0eS90dHlBQ00zPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2
bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlBQ00zICh0ZWxpdCkgMi8yLzEgWzA2XSA9PSZndDsg
KG51bGwpIFRlbGl0IFdpcmVsZXNzIE1vZHVsZSBQb3J0PGJyPgoKb2Zvbm9kWzE3MzZdOiBwbHVn
aW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBjZGNfYWNtIFsxYmM3OjAwMjFdPGJyPm9m
b25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3Bj
aTAwMDA6MDAvMDAwMDowMDoxZC43L3VzYjEvMS0xLzEtMToxLjgvdHR5L3R0eUFDTTQ8YnI+b2Zv
bm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eUFDTTQgKHRl
bGl0KSAyLzIvMSBbMDhdID09Jmd0OyAobnVsbCkgVGVsaXQgV2lyZWxlc3MgTW9kdWxlIFBvcnQ8
YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGhz
byBbMGFmMDo3NjAxXTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2Rldmlj
ZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91c2IxLzEtNi8xLTY6MS4w
L3R0eS90dHlIUzA8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2Uo
KSAvZGV2L3R0eUhTMCAoaHNvKSAyNTUvMjU1LzI1NSBbMDBdID09Jmd0OyAobnVsbCkgRGlhZ25v
c3RpYzxicj4KCm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNl
KCkgaHNvIFswYWYwOjc2MDFdPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzphZGRf
ZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC43L3VzYjEvMS02LzEt
NjoxLjEvdHR5L3R0eUhTMTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2Rl
dmljZSgpIC9kZXYvdHR5SFMxIChoc28pIDI1NS8yNTUvMjU1IFswMV0gPT0mZ3Q7IChudWxsKSBH
UFM8YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgp
IGhzbyBbMGFmMDo3NjAxXTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6YWRkX2Rl
dmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91c2IxLzEtNi8xLTY6
MS4yL3R0eS90dHlIUzI8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZp
Y2UoKSAvZGV2L3R0eUhTMiAoaHNvKSAyNTUvMjU1LzI1NSBbMDJdID09Jmd0OyAobnVsbCkgR1BT
IENvbnRyb2w8YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rl
dmljZSgpIGhzbyBbMGFmMDo3NjAxXTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6
YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91c2IxLzEt
Ni8xLTY6MS4zL3R0eS90dHlIUzM8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmFk
ZF9kZXZpY2UoKSAvZGV2L3R0eUhTMyAoaHNvKSAyNTUvMjU1LzI1NSBbMDNdID09Jmd0OyAobnVs
bCkgQXBwbGljYXRpb248YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tf
dXNiX2RldmljZSgpIGhzbyBbMGFmMDo3NjAxXTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRl
dm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91
c2IxLzEtNi8xLTY6MS42L3R0eS90dHlIUzQ8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZu
Zy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eUhTNCAoaHNvKSAyNTUvMjU1LzI1NSBbMDZdID09Jmd0
OyAobnVsbCkgQ29udHJvbDxicj4KCm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgaHNvIFswYWYwOjc2MDFdPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91
ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC43
L3VzYjEvMS02LzEtNjoxLjcvbmV0L2hzbzA8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZu
Zy5jOmFkZF9kZXZpY2UoKSBoc28wIChoc28pIDI1NS8yNTUvMjU1IFswN10gPT0mZ3Q7IChudWxs
KSAobnVsbCk8YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rl
dmljZSgpIGhzbyBbMGFmMDo3NjAxXTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6
YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91c2IxLzEt
Ni8xLTY6MS45L3R0eS90dHlIUzU8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmFk
ZF9kZXZpY2UoKSAvZGV2L3R0eUhTNSAoaHNvKSAyNTUvMjU1LzI1NSBbMDldID09Jmd0OyAobnVs
bCkgTW9kZW08YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVt
KCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC43L3VzYjEvMS02PGJyPm9mb25v
ZFsxNzM2XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRlKCkgbmFtZTogKG51bGwpLCB0
eXBlOiBoc288YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9jcmVhdGUo
KSBvZm9ub19kYnVzX3ZhbGlkX29iamVjdF9wYXRoID09IFRSVUU8YnI+CgpvZm9ub2RbMTczNl06
IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIGdfdHJ5X25ldzAgIT0gTlVMTDxicj5v
Zm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHNvKCkgL3N5cy9kZXZpY2VzL3Bj
aTAwMDA6MDAvMDAwMDowMDoxZC43L3VzYjEvMS02PGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91
ZGV2bmcuYzpzZXR1cF9oc28oKSAvZGV2L3R0eUhTMCAyNTUvMjU1LzI1NSAwMCAobnVsbCkgRGlh
Z25vc3RpYzxicj4KCm9mb25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9oc28oKSAv
ZGV2L3R0eUhTMSAyNTUvMjU1LzI1NSAwMSAobnVsbCkgR1BTPGJyPm9mb25vZFsxNzM2XTogcGx1
Z2lucy91ZGV2bmcuYzpzZXR1cF9oc28oKSAvZGV2L3R0eUhTMiAyNTUvMjU1LzI1NSAwMiAobnVs
bCkgR1BTIENvbnRyb2w8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX2hz
bygpIC9kZXYvdHR5SFMzIDI1NS8yNTUvMjU1IDAzIChudWxsKSBBcHBsaWNhdGlvbjxicj4KCm9m
b25vZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9oc28oKSAvZGV2L3R0eUhTNCAyNTUv
MjU1LzI1NSAwNiAobnVsbCkgQ29udHJvbDxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5n
LmM6c2V0dXBfaHNvKCkgaHNvMCAyNTUvMjU1LzI1NSAwNyAobnVsbCkgKG51bGwpPGJyPm9mb25v
ZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9oc28oKSAvZGV2L3R0eUhTNSAyNTUvMjU1
LzI1NSAwOSAobnVsbCkgTW9kZW08YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6
c2V0dXBfaHNvKCkgY29udHJvbD0vZGV2L3R0eUhTNCBhcHBsaWNhdGlvbj0vZGV2L3R0eUhTMyBu
ZXR3b3JrPWhzbzA8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVy
dHkoKSBtb2RlbSAweDk1MzVjZjggcHJvcGVydHkgQ29udHJvbFBvcnQ8YnI+b2Zvbm9kWzE3MzZd
OiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk1MzVjZjggcHJvcGVy
dHkgQXBwbGljYXRpb25Qb3J0PGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpzZXRfbW9k
ZW1fcHJvcGVydHkoKSBtb2RlbSAweDk1MzVjZjggcHJvcGVydHkgTmV0d29ya0ludGVyZmFjZTxi
cj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4
OTUzNWNmOCBwcm9wZXJ0eSBTeXNQYXRoPGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6Z2V0
X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NTM1Y2Y4IHByb3BlcnR5IE5ldHdvcmtJbnRlcmZh
Y2U8YnI+CgpvZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHNvKCkgUkVDSEVD
SzogaHNvMDxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgp
IG1vZGVtIDB4OTUzNWNmOCBwcm9wZXJ0eSBTeXNQYXRoPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lu
cy91ZGV2bmcuYzpzZXR1cF9oc28oKSBSRUNIRUNLOiAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8w
MDAwOjAwOjFkLjcvdXNiMS8xLTY8YnI+CgpvZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25v
X21vZGVtX3JlZ2lzdGVyKCkgMHg5NTM1Y2Y4PGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy9oc28u
Yzpoc29fcHJvYmUoKSAweDk1MzVjZjg8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzplbWl0
X21vZGVtX2FkZGVkKCkgMHg5NTM1Y2Y4PGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6Z2V0
X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NTM1Y2Y4IHByb3BlcnR5IE5ldHdvcmtJbnRlcmZh
Y2U8YnI+CgpvZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1v
ZGVtIDB4OTUzNWNmOCBwcm9wZXJ0eSBTeXNQYXRoPGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVt
LmM6X19vZm9ub19tb2RlbV9hcHBlbmRfcHJvcGVydGllcygpIElmbmFtZSBoc28wPGJyPm9mb25v
ZFsxNzM2XTogc3JjL21vZGVtLmM6Y2FsbF9tb2RlbXdhdGNoZXMoKSAweDk1MzVjZjggYWRkZWQ6
MTxicj4KCm9mb25vZFsxNzM2XTogcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzptb2RlbV93YXRj
aCgpIG1vZGVtOiAweDk1MzVjZjgsIGFkZGVkOiAxPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy9w
dXNoLW5vdGlmaWNhdGlvbi5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OTUzNWNmOCwgYWRkZWQ6
IDE8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOmNyZWF0ZV9tb2RlbSgpIC9zeXMv
ZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91c2IxLzEtMTxicj4KCm9mb25vZFsxNzM2
XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRlKCkgbmFtZTogKG51bGwpLCB0eXBlOiB0
ZWxpdDxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIG9m
b25vX2RidXNfdmFsaWRfb2JqZWN0X3BhdGggPT0gVFJVRTxicj5vZm9ub2RbMTczNl06IHNyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIGdfdHJ5X25ldzAgIT0gTlVMTDxicj4KCm9mb25v
ZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF90ZWxpdCgpIC9zeXMvZGV2aWNlcy9wY2kw
MDAwOjAwLzAwMDA6MDA6MWQuNy91c2IxLzEtMTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRl
dm5nLmM6c2V0dXBfdGVsaXQoKSAvZGV2L3R0eUFDTTAgMi8yLzEgMDAgKG51bGwpIFRlbGl0IFdp
cmVsZXNzIE1vZHVsZSBNb2RlbTxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6c2V0
dXBfdGVsaXQoKSAvZGV2L3R0eUFDTTEgMi8yLzEgMDIgKG51bGwpIFRlbGl0IFdpcmVsZXNzIE1v
ZHVsZSBQb3J0PGJyPgoKb2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX3RlbGl0
KCkgL2Rldi90dHlBQ00yIDIvMi8xIDA0IChudWxsKSBUZWxpdCBXaXJlbGVzcyBNb2R1bGUgUG9y
dDxicj5vZm9ub2RbMTczNl06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVsaXQoKSAvZGV2L3R0
eUFDTTMgMi8yLzEgMDYgKG51bGwpIFRlbGl0IFdpcmVsZXNzIE1vZHVsZSBQb3J0PGJyPm9mb25v
ZFsxNzM2XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF90ZWxpdCgpIC9kZXYvdHR5QUNNNCAyLzIv
MSAwOCAobnVsbCkgVGVsaXQgV2lyZWxlc3MgTW9kdWxlIFBvcnQ8YnI+CgpvZm9ub2RbMTczNl06
IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVsaXQoKSAvZGV2L3R0eUFDTTUgMi8yLzEgMGEgKG51
bGwpIFRlbGl0IFdpcmVsZXNzIE1vZHVsZSBQb3J0PGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy91
ZGV2bmcuYzpzZXR1cF90ZWxpdCgpIC9kZXYvdHR5QUNNNiAyLzIvMSAwYyAobnVsbCkgVGVsaXQg
V2lyZWxlc3MgTW9kdWxlIFBvcnQ8YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL3VkZXZuZy5jOnNl
dHVwX3RlbGl0KCkgbW9kZW09L2Rldi90dHlBQ00wIGF1eD0vZGV2L3R0eUFDTTMgZ3BzPShudWxs
KSBkaWFnPS9kZXYvdHR5QUNNMTxicj4KCm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6c2V0X21v
ZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NTM1ZGQwIHByb3BlcnR5IE1vZGVtPGJyPm9mb25vZFsx
NzM2XTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NTM1ZGQwIHBy
b3BlcnR5IERhdGE8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVy
dHkoKSBtb2RlbSAweDk1MzVkZDAgcHJvcGVydHkgR1BTPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMv
bW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk1MzVkZDAgcHJvcGVydHkgRGlh
Zzxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOm9mb25vX21vZGVtX3JlZ2lzdGVyKCkgMHg5
NTM1ZGQwPGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkg
bW9kZW0gMHg5NTM1Y2Y4IHByb3BlcnR5IE5ldHdvcmtJbnRlcmZhY2U8YnI+CgpvZm9ub2RbMTcz
Nl06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTUzNWNmOCBwcm9w
ZXJ0eSBTeXNQYXRoPGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6X19vZm9ub19tb2RlbV9h
cHBlbmRfcHJvcGVydGllcygpIElmbmFtZSBoc28wPGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVt
LmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NTM1Y2Y4IHByb3BlcnR5IE5ldHdvcmtJ
bnRlcmZhY2U8YnI+CgpvZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0
eSgpIG1vZGVtIDB4OTUzNWNmOCBwcm9wZXJ0eSBTeXNQYXRoPGJyPm9mb25vZFsxNzM2XTogc3Jj
L21vZGVtLmM6X19vZm9ub19tb2RlbV9hcHBlbmRfcHJvcGVydGllcygpIElmbmFtZSBoc28wPGJy
Pm9mb25vZFsxNzM2XTogcGx1Z2lucy9oc28uYzpoc29fZW5hYmxlKCkgMHg5NTM1Y2Y4PGJyPm9m
b25vZFsxNzM2XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NTM1
Y2Y4IHByb3BlcnR5IENvbnRyb2xQb3J0PGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpn
ZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk1MzVjZjggcHJvcGVydHkgQXBwbGljYXRpb25Q
b3J0PGJyPm9mb25vZFsxNzM2XTogQ29udHJvbDogJmd0OyBBVEUwICtDTUVFPTFccjxicj5vZm9u
b2RbMTczNl06IEFwcDogJmd0OyBBVEUwICtDTUVFPTFccjxicj5vZm9ub2RbMTczNl06IHNyYy9t
b2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OTUzNWNmOCBwcm9wZXJ0eSBOZXR3
b3JrSW50ZXJmYWNlPGJyPgoKb2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbSAweDk1MzVjZjggcHJvcGVydHkgU3lzUGF0aDxicj5vZm9ub2RbMTczNl06
IHNyYy9tb2RlbS5jOl9fb2Zvbm9fbW9kZW1fYXBwZW5kX3Byb3BlcnRpZXMoKSBJZm5hbWUgaHNv
MDxicj5vZm9ub2RbMTczNl06IEFwcDogJmx0OyBcclxuT0tcclxuPGJyPm9mb25vZFsxNzM2XTog
Q29udHJvbDogJmx0OyBcclxuT0tcclxuPGJyPgoKb2Zvbm9kWzE3MzZdOiBDb250cm9sOiAmZ3Q7
IEFUK0NGVU49NFxyPGJyPm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3Bl
cnR5KCkgbW9kZW0gMHg5NTM1Y2Y4IHByb3BlcnR5IE5ldHdvcmtJbnRlcmZhY2U8YnI+b2Zvbm9k
WzE3MzZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk1MzVjZjgg
cHJvcGVydHkgU3lzUGF0aDxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOl9fb2Zvbm9fbW9k
ZW1fYXBwZW5kX3Byb3BlcnRpZXMoKSBJZm5hbWUgaHNvMDxicj4KCm9mb25vZFsxNzM2XTogc3Jj
L21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg5NTM1Y2Y4IHByb3BlcnR5IE5l
dHdvcmtJbnRlcmZhY2U8YnI+b2Zvbm9kWzE3MzZdOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbSAweDk1MzVjZjggcHJvcGVydHkgU3lzUGF0aDxicj5vZm9ub2RbMTczNl06
IHNyYy9tb2RlbS5jOl9fb2Zvbm9fbW9kZW1fYXBwZW5kX3Byb3BlcnRpZXMoKSBJZm5hbWUgaHNv
MDxicj4KCm9mb25vZFsxNzM2XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9k
ZW0gMHg5NTM1Y2Y4IHByb3BlcnR5IE5ldHdvcmtJbnRlcmZhY2U8YnI+b2Zvbm9kWzE3MzZdOiBz
cmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDk1MzVjZjggcHJvcGVydHkg
U3lzUGF0aDxicj5vZm9ub2RbMTczNl06IHNyYy9tb2RlbS5jOl9fb2Zvbm9fbW9kZW1fYXBwZW5k
X3Byb3BlcnRpZXMoKSBJZm5hbWUgaHNvMDxicj4KCm9mb25vZFsxNzM2XTogQ29udHJvbDogJmx0
OyBcclxuT0tcclxuPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy9oc28uYzpjZnVuX2VuYWJsZSgp
PGJyPm9mb25vZFsxNzM2XTogQ29udHJvbDogJmd0OyBBVF9PUE1OXHI8YnI+b2Zvbm9kWzE3MzZd
OiBDb250cm9sOiAmbHQ7IFxyXG5cclxyXG5fT1BNTjogR1RNMzgyIEVcclxuXHJcbk9LXHJcbjxi
cj5vZm9ub2RbMTczNl06IHBsdWdpbnMvaHNvLmM6Y2hlY2tfbW9kZWwoKTxicj4KCm9mb25vZFsx
NzM2XTogTW9kZWwgaXMgR1RNMzgyIEU8YnI+b2Zvbm9kWzE3MzZdOiBDb250cm9sOiAmZ3Q7IEFU
X09CTFNccjxicj5vZm9ub2RbMTczNl06IENvbnRyb2w6ICZsdDsgXHJcbl9PQkxTOiAyLDAsMFxy
XG5cclxuT0tcclxuPGJyPm9mb25vZFsxNzM2XTogcGx1Z2lucy9oc28uYzpzaW1fc3RhdHVzKCk8
YnI+b2Zvbm9kWzE3MzZdOiBwbHVnaW5zL2hzby5jOnNpbV9zdGF0dXMoKSBzdGF0dXMgc2ltIDIg
cGIgMCBzbXMgMDwvZGl2Pgo8L2Rpdj4K

--===============1169833047228559735==--

