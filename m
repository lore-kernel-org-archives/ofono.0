Content-Type: multipart/mixed; boundary="===============1459343084216036695=="
MIME-Version: 1.0
From: Jan Pohanka <xhpohanka@gmail.com>
Subject: sierra wireless MC8795V
Date: Mon, 16 Jul 2012 12:29:05 +0200
Message-ID: <op.whjberu4yxxkfz@pohanka-pc>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1459343084216036695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to try HSPDA module MC8795V with ofono. According to its  =

specification the module should be compatible with MC8790 and its driver  =

is included for a while. Unfortunately I cannot make ofono to detect the  =

module properly. The module itself works fine and all its terminals  =

/det/ttyUSB0-6 are present.

Is the support for sierra modems broken, or I'm missing something?

I have added this line to ofono udev rules
ATTRS{idVendor}=3D=3D"1199", ATTRS{idProduct}=3D=3D"683c",  =

ENV{OFONO_DRIVER}=3D"sierra"

and I'm getting following log...

ofonod[269]: oFono version 1.8
ofonod[269]: src/plugin.c:__ofono_plugin_init()
ofonod[269]: plugins/push-notification.c:push_notification_init()
ofonod[269]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x1295b0,  =

name: telit2
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129560,  =

name: sim900
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129518,  =

name: samsung
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x1294d0,  =

name: speedupcdma
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129488,  =

name: speedup
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129438,  =

name: alcatel
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x1293f0,  =

name: icera
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129398,  =

name: linktop
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129350,  =

name: nokiacdma
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129308,  =

name: nokia
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x1292c0,  =

name: tc65
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129238,  =

name: ste
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x1291d8,  =

name: ifx
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129150,  =

name: palmpre
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129108,  =

name: novatel
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x1290b8,  =

name: sierra
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x129070,  =

name: huawei
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x128ff8,  =

name: zte
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x128fb0,  =

name: hso
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x128f50,  =

name: mbm
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x128f00,  =

name: calypso
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x128ea0,  =

name: wavecom
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x128e58,  =

name: g1
ofonod[269]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()  =

driver: 0x128e00, name: cdmamodem
ofonod[269]: src/modem.c:ofono_devinfo_driver_register() driver: 0x128e28,  =

name: cdmamodem
ofonod[269]: src/cdma-connman.c:ofono_cdma_connman_driver_register()  =

driver: 0x128e44, name: cdmamodem
ofonod[269]: src/ussd.c:ofono_ussd_driver_register() driver: 0x128dcc,  =

name: speedupmodem
ofonod[269]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0x128cc0, name: hfpmodem
ofonod[269]: src/modem.c:ofono_devinfo_driver_register() driver: 0x128d64,  =

name: hfpmodem
ofonod[269]: src/network.c:ofono_netreg_driver_register() driver:  =

0x128d18, name: hfpmodem
ofonod[269]: src/call-volume.c:ofono_call_volume_driver_register() driver:  =

0x128d4c, name: hfpmodem
ofonod[269]: src/handsfree.c:ofono_handsfree_driver_register() driver:  =

0x128d90, name: hfpmodem
ofonod[269]: src/network.c:ofono_netreg_driver_register() driver:  =

0x128c40, name: dunmodem
ofonod[269]: src/gprs.c:ofono_gprs_driver_register() driver: 0x128c64,  =

name: dunmodem
ofonod[269]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0x128b7c, name: stemodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x128c04, name: stemodem
ofonod[269]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0x128bcc, name: stemodem
ofonod[269]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0x128a64, name: ifxmodem
ofonod[269]: src/audio-settings.c:ofono_audio_settings_driver_register()  =

driver: 0x128abc, name: ifxmodem
ofonod[269]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0x128ad0, name: ifxmodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x128b04, name: ifxmodem
ofonod[269]: src/stk.c:ofono_stk_driver_register() driver: 0x128b28, name:  =

ifxmodem
ofonod[269]: src/ctm.c:ofono_ctm_driver_register() driver: 0x128b48, name:  =

ifxmodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x1289fc, name: hsomodem
ofonod[269]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0x128a18, name: hsomodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x128980, name: mbmmodem
ofonod[269]: src/stk.c:ofono_stk_driver_register() driver: 0x12899c, name:  =

mbmmodem
ofonod[269]:  =

src/location-reporting.c:ofono_location_reporting_driver_register()  =

driver: 0x1289bc, name: mbmmodem
ofonod[269]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0x1288e8, name: calypsomodem
ofonod[269]: src/stk.c:ofono_stk_driver_register() driver: 0x128938, name:  =

calypsomodem
ofonod[269]: src/ussd.c:ofono_ussd_driver_register() driver: 0x1287f8,  =

name: huaweimodem
ofonod[269]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0x12880c, name: huaweimodem
ofonod[269]: src/audio-settings.c:ofono_audio_settings_driver_register()  =

driver: 0x12885c, name: huaweimodem
ofonod[269]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0x12888c, name: huaweimodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x128870, name: huaweimodem
ofonod[269]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:  =

0x1288b8, name: huaweimodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x128788, name: iceramodem
ofonod[269]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0x1287ac, name: iceramodem
ofonod[269]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0x128734, name: ztemodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x1286f8, name: swmodem
ofonod[269]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0x1286b4, name: nwmodem
ofonod[269]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0x128534, name: atmodem
ofonod[269]: src/modem.c:ofono_devinfo_driver_register() driver: 0x1285cc,  =

name: atmodem
ofonod[269]: src/call-barring.c:ofono_call_barring_driver_register()  =

driver: 0x128584, name: atmodem
ofonod[269]: src/call-forwarding.c:ofono_call_forwarding_driver_register()  =

driver: 0x1282d4, name: atmodem
ofonod[269]: src/call-meter.c:ofono_call_meter_driver_register() driver:  =

0x128314, name: atmodem
ofonod[269]: src/call-settings.c:ofono_call_settings_driver_register()  =

driver: 0x12820c, name: atmodem
ofonod[269]: src/phonebook.c:ofono_phonebook_driver_register() driver:  =

0x1285b4, name: atmodem
ofonod[269]: src/ussd.c:ofono_ussd_driver_register() driver: 0x128510,  =

name: atmodem
ofonod[269]: src/sms.c:ofono_sms_driver_register() driver: 0x128290, name:  =

atmodem
ofonod[269]: src/sim.c:ofono_sim_driver_register() driver: 0x1283f0, name:  =

atmodem
ofonod[269]: src/sim.c:ofono_sim_driver_register() driver: 0x128438, name:  =

atmodem-noef
ofonod[269]: src/stk.c:ofono_stk_driver_register() driver: 0x1284e8, name:  =

atmodem
ofonod[269]: src/network.c:ofono_netreg_driver_register() driver:  =

0x128370, name: atmodem
ofonod[269]: src/cbs.c:ofono_cbs_driver_register() driver: 0x1282b8, name:  =

atmodem
ofonod[269]: src/call-volume.c:ofono_call_volume_driver_register() driver:  =

0x1285f8, name: atmodem
ofonod[269]: src/gprs.c:ofono_gprs_driver_register() driver: 0x128628,  =

name: atmodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x12863c, name: atmodem
ofonod[269]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:  =

0x128658, name: atmodem
ofonod[269]: src/gnss.c:ofono_gnss_driver_register() driver: 0x128678,  =

name: atmodem
ofonod[269]: src/modem.c:ofono_modem_driver_register() driver: 0x127cdc,  =

name: gobi
ofonod[269]: src/modem.c:ofono_devinfo_driver_register() driver: 0x127b74,  =

name: qmimodem
ofonod[269]: src/network.c:ofono_netreg_driver_register() driver:  =

0x127bd8, name: qmimodem
ofonod[269]: src/voicecall.c:ofono_voicecall_driver_register() driver:  =

0x127b90, name: qmimodem
ofonod[269]: src/sim.c:ofono_sim_driver_register() driver: 0x127bfc, name:  =

qmimodem-legacy
ofonod[269]: src/sms.c:ofono_sms_driver_register() driver: 0x127c44, name:  =

qmimodem
ofonod[269]: src/ussd.c:ofono_ussd_driver_register() driver: 0x127c64,  =

name: qmimodem
ofonod[269]: src/gprs.c:ofono_gprs_driver_register() driver: 0x127c78,  =

name: qmimodem
ofonod[269]: src/gprs.c:ofono_gprs_context_driver_register() driver:  =

0x127c8c, name: qmimodem
ofonod[269]: src/radio-settings.c:ofono_radio_settings_driver_register()  =

driver: 0x127ca0, name: qmimodem
ofonod[269]:  =

src/location-reporting.c:ofono_location_reporting_driver_register()  =

driver: 0x127cc4, name: qmimodem
ofonod[269]: plugins/udevng.c:udev_start()
ofonod[269]: plugins/udevng.c:enumerate_devices()
ofonod[269]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() MOSCHIP usb-ethernet  =

driver [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() sierra [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() sierra [1199:683c]
ofonod[269]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb-davinci/musb-hdrc/usb1/1-1/1-1.3
ofonod[269]: plugins/udevng.c:add_device()  =

/sys/devices/platform/musb-davinci/musb-hdrc/usb1/1-1/1-1.3/1-1.3:1.0/tty
USB0/tty/ttyUSB0
ofonod[269]: plugins/udevng.c:add_device() /dev/ttyUSB0 (sierra)  =

255/255/255 [00] =3D=3D> (null) (null)
ofonod[269]: plugins/udevng.c:check_usb_device() sierra [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() sierra [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() sierra [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() sierra [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() sierra [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() sierra [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() usb [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() rt2800usb [(null):(null)]
ofonod[269]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[269]: plugins/udevng.c:create_modem()  =

/sys/devices/platform/musb-davinci/musb-hdrc/usb1/1-1/1-1.3
ofonod[269]: plugins/udevng.c:create_modem() driver=3Dsierra
ofonod[269]: src/modem.c:ofono_modem_create() name: (null), type: sierra
ofonod[269]: plugins/udevng.c:setup_sierra()  =

/sys/devices/platform/musb-davinci/musb-hdrc/usb1/1-1/1-1.3
ofonod[269]: plugins/udevng.c:setup_sierra() /dev/ttyUSB0 255/255/255 00  =

(null)
ofonod[269]: plugins/udevng.c:destroy_modem()  =

/sys/devices/platform/musb-davinci/musb-hdrc/usb1/1-1/1-1.3
ofonod[269]: src/modem.c:ofono_modem_remove() 0x148bd0
ofonod[269]: plugins/udevng.c:destroy_modem() /dev/ttyUSB0
ofonod[269]: src/modem.c:ofono_modem_create() name: (null), type: sierra
ofonod[269]: src/modem.c:set_modem_property() modem 0x14c378 property Path
ofonod[269]: plugins/udev.c:add_modem()  =

/devices/platform/musb-davinci/musb-hdrc/usb1/1-1/1-1.3/1-1.3:1.0/ttyUSB0/tt
y/ttyUSB0 (sierra)



best regards
Jan

-- =

Tato zpr=C3=A1va byla vytvo=C5=99ena p=C5=99evratnou po=C5=A1tovn=C3=AD apl=
ikac=C3=AD Opery:  =

http://www.opera.com/mail/

--===============1459343084216036695==--

