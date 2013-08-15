Content-Type: multipart/mixed; boundary="===============3309927093637209165=="
MIME-Version: 1.0
From: Fabio S. Higa <fabio.higa@dataprom.com>
Subject: PPP negotiation failing
Date: Thu, 15 Aug 2013 09:26:24 -0300
Message-ID: <520CC8F0.2030802@dataprom.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3309927093637209165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

We are working with the modem Telit GE910-QUAD (GSM/GPRS) and trying to =

make it work with Ofono 1.12.

In our tests we successfuly make a connection using pppd, but using =

Ofono occur an error during ppp negotiation (configuration rejected, RCR-).

Log follows below. Any help would be appreciated.

Regards,

Fabio


# OFONO_PPP_DEBUG=3D1 OFONO_AT_DEBUG=3D1 ofonod -nd
ofonod[1540]: oFono version 1.12
ofonod[1540]: src/plugin.c:__ofono_plugin_init()
ofonod[1540]: plugins/push-notification.c:push_notification_init()
ofonod[1540]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[1540]: =

src/cdma-provision.c:ofono_cdma_provision_driver_register() driver: =

0xef9a4 name: CDMA provisioning
ofonod[1540]: =

src/gprs-provision.c:ofono_gprs_provision_driver_register() driver: =

0xef978 name: Provisioning
ofonod[1540]: plugins/connman.c:connman_init()
ofonod[1540]: =

src/private-network.c:ofono_private_network_driver_register() driver: =

0xef94c, name: ConnMan Private Network
ofonod[1540]: plugins/dun_gw.c:dun_gw_init()
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef89c, =

name: hfp
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef844, =

name: sap
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef7fc, =

name: telit
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef790, =

name: sim900
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef748, =

name: samsung
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef700, =

name: speedupcdma
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef6b0, =

name: speedup
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef668, =

name: alcatel
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef610, =

name: icera
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef5c8, =

name: linktop
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef580, =

name: nokiacdma
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef538, =

name: nokia
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef4f0, =

name: tc65
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef468, =

name: ste
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef410, =

name: ifx
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef3c8, =

name: palmpre
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef378, =

name: novatel
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef330, =

name: sierra
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef2b8, =

name: huawei
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef270, =

name: zte
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef210, =

name: hso
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef1c0, =

name: mbm
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef170, =

name: calypso
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef128, =

name: wavecom
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef0e0, =

name: g1
ofonod[1540]: =

src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register() driver: =

0xef088, name: cdmamodem
ofonod[1540]: src/modem.c:ofono_devinfo_driver_register() driver: =

0xef0b0, name: cdmamodem
ofonod[1540]: src/cdma-connman.c:ofono_cdma_connman_driver_register() =

driver: 0xef0cc, name: cdmamodem
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xeeff0, =

name: phonesim
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xef020, =

name: localhfp
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xeefd8, name: phonesim
ofonod[1540]: src/ctm.c:ofono_ctm_driver_register() driver: 0xeefc4, =

name: phonesim
ofonod[1540]: plugins/phonesim.c:parse_config() filename =

/etc/ofono/phonesim.conf
ofonod[1540]: src/ussd.c:ofono_ussd_driver_register() driver: 0xeefb0, =

name: speedupmodem
ofonod[1540]: src/voicecall.c:ofono_voicecall_driver_register() driver: =

0xeeea4, name: hfpmodem
ofonod[1540]: src/modem.c:ofono_devinfo_driver_register() driver: =

0xeef48, name: hfpmodem
ofonod[1540]: src/network.c:ofono_netreg_driver_register() driver: =

0xeeefc, name: hfpmodem
ofonod[1540]: src/call-volume.c:ofono_call_volume_driver_register() =

driver: 0xeef30, name: hfpmodem
ofonod[1540]: src/handsfree.c:ofono_handsfree_driver_register() driver: =

0xeef74, name: hfpmodem
ofonod[1540]: src/network.c:ofono_netreg_driver_register() driver: =

0xeee24, name: dunmodem
ofonod[1540]: src/gprs.c:ofono_gprs_driver_register() driver: 0xeee48, =

name: dunmodem
ofonod[1540]: src/voicecall.c:ofono_voicecall_driver_register() driver: =

0xeed5c, name: stemodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xeede4, name: stemodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xeedac, name: stemodem
ofonod[1540]: src/voicecall.c:ofono_voicecall_driver_register() driver: =

0xeec40, name: ifxmodem
ofonod[1540]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xeec98, name: ifxmodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xeecac, name: ifxmodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xeece0, name: ifxmodem
ofonod[1540]: src/stk.c:ofono_stk_driver_register() driver: 0xeed08, =

name: ifxmodem
ofonod[1540]: src/ctm.c:ofono_ctm_driver_register() driver: 0xeed28, =

name: ifxmodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xeebd4, name: hsomodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xeebf4, name: hsomodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xeeb54, name: mbmmodem
ofonod[1540]: src/stk.c:ofono_stk_driver_register() driver: 0xeeb74, =

name: mbmmodem
ofonod[1540]: =

src/location-reporting.c:ofono_location_reporting_driver_register() =

driver: 0xeeb94, name: mbmmodem
ofonod[1540]: src/voicecall.c:ofono_voicecall_driver_register() driver: =

0xeeabc, name: calypsomodem
ofonod[1540]: src/stk.c:ofono_stk_driver_register() driver: 0xeeb0c, =

name: calypsomodem
ofonod[1540]: src/ussd.c:ofono_ussd_driver_register() driver: 0xee9c8, =

name: huaweimodem
ofonod[1540]: src/voicecall.c:ofono_voicecall_driver_register() driver: =

0xee9dc, name: huaweimodem
ofonod[1540]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xeea2c, name: huaweimodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xeea60, name: huaweimodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xeea40, name: huaweimodem
ofonod[1540]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() =

driver: 0xeea8c, name: huaweimodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xee954, name: iceramodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xee97c, name: iceramodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xee900, name: ztemodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xee8c0, name: swmodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xee87c, name: nwmodem
ofonod[1540]: src/voicecall.c:ofono_voicecall_driver_register() driver: =

0xee6f8, name: atmodem
ofonod[1540]: src/modem.c:ofono_devinfo_driver_register() driver: =

0xee790, name: atmodem
ofonod[1540]: src/call-barring.c:ofono_call_barring_driver_register() =

driver: 0xee748, name: atmodem
ofonod[1540]: =

src/call-forwarding.c:ofono_call_forwarding_driver_register() driver: =

0xee4e0, name: atmodem
ofonod[1540]: src/call-meter.c:ofono_call_meter_driver_register() =

driver: 0xee520, name: atmodem
ofonod[1540]: src/call-settings.c:ofono_call_settings_driver_register() =

driver: 0xee42c, name: atmodem
ofonod[1540]: src/phonebook.c:ofono_phonebook_driver_register() driver: =

0xee778, name: atmodem
ofonod[1540]: src/ussd.c:ofono_ussd_driver_register() driver: 0xee6d4, =

name: atmodem
ofonod[1540]: src/sms.c:ofono_sms_driver_register() driver: 0xee49c, =

name: atmodem
ofonod[1540]: src/sim.c:ofono_sim_driver_register() driver: 0xee614, =

name: atmodem
ofonod[1540]: src/sim.c:ofono_sim_driver_register() driver: 0xee65c, =

name: atmodem-noef
ofonod[1540]: src/stk.c:ofono_stk_driver_register() driver: 0xee6ac, =

name: atmodem
ofonod[1540]: src/network.c:ofono_netreg_driver_register() driver: =

0xee584, name: atmodem
ofonod[1540]: src/cbs.c:ofono_cbs_driver_register() driver: 0xee4c4, =

name: atmodem
ofonod[1540]: src/call-volume.c:ofono_call_volume_driver_register() =

driver: 0xee7bc, name: atmodem
ofonod[1540]: src/gprs.c:ofono_gprs_driver_register() driver: 0xee7ec, =

name: atmodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xee800, name: atmodem
ofonod[1540]: src/sim-auth.c:ofono_sim_auth_driver_register() driver: =

0xee820, name: atmodem
ofonod[1540]: src/gnss.c:ofono_gnss_driver_register() driver: 0xee840, =

name: atmodem
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xee210, =

name: gobi
ofonod[1540]: src/modem.c:ofono_devinfo_driver_register() driver: =

0xee05c, name: qmimodem
ofonod[1540]: src/network.c:ofono_netreg_driver_register() driver: =

0xee0c0, name: qmimodem
ofonod[1540]: src/voicecall.c:ofono_voicecall_driver_register() driver: =

0xee078, name: qmimodem
ofonod[1540]: src/sim.c:ofono_sim_driver_register() driver: 0xee0e4, =

name: qmimodem-legacy
ofonod[1540]: src/sim.c:ofono_sim_driver_register() driver: 0xee12c, =

name: qmimodem
ofonod[1540]: src/sms.c:ofono_sms_driver_register() driver: 0xee174, =

name: qmimodem
ofonod[1540]: src/ussd.c:ofono_ussd_driver_register() driver: 0xee194, =

name: qmimodem
ofonod[1540]: src/gprs.c:ofono_gprs_driver_register() driver: 0xee1a8, =

name: qmimodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xee1bc, name: qmimodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xee1d4, name: qmimodem
ofonod[1540]: =

src/location-reporting.c:ofono_location_reporting_driver_register() =

driver: 0xee1f8, name: qmimodem
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xedff4, =

name: u8500
ofonod[1540]: src/modem.c:ofono_devinfo_driver_register() driver: =

0xedfd8, name: u8500
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xedf90, =

name: n900
ofonod[1540]: src/modem.c:ofono_modem_driver_register() driver: 0xedf48, =

name: isiusb
ofonod[1540]: src/modem.c:ofono_devinfo_driver_register() driver: =

0xedcfc, name: isimodem
ofonod[1540]: src/phonebook.c:ofono_phonebook_driver_register() driver: =

0xedcec, name: isimodem
ofonod[1540]: src/network.c:ofono_netreg_driver_register() driver: =

0xedd18, name: isimodem
ofonod[1540]: src/voicecall.c:ofono_voicecall_driver_register() driver: =

0xedd3c, name: isimodem
ofonod[1540]: src/sms.c:ofono_sms_driver_register() driver: 0xedd84, =

name: isimodem
ofonod[1540]: src/cbs.c:ofono_cbs_driver_register() driver: 0xedda4, =

name: isimodem
ofonod[1540]: src/sim.c:ofono_sim_driver_register() driver: 0xeddb8, =

name: isimodem
ofonod[1540]: src/ussd.c:ofono_ussd_driver_register() driver: 0xede00, =

name: isimodem
ofonod[1540]: =

src/call-forwarding.c:ofono_call_forwarding_driver_register() driver: =

0xede14, name: isimodem
ofonod[1540]: src/call-settings.c:ofono_call_settings_driver_register() =

driver: 0xede34, name: isimodem
ofonod[1540]: src/call-barring.c:ofono_call_barring_driver_register() =

driver: 0xede64, name: isimodem
ofonod[1540]: src/call-meter.c:ofono_call_meter_driver_register() =

driver: 0xede7c, name: isimodem
ofonod[1540]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xedea4, name: isimodem
ofonod[1540]: src/gprs.c:ofono_gprs_driver_register() driver: 0xedec8, =

name: isimodem
ofonod[1540]: src/gprs.c:ofono_gprs_context_driver_register() driver: =

0xededc, name: isimodem
ofonod[1540]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xedef4, name: isimodem
ofonod[1540]: src/sim.c:ofono_sim_driver_register() driver: 0xedf00, =

name: wgmodem2.5
ofonod[1540]: plugins/udevng.c:udev_start()
ofonod[1540]: plugins/udevng.c:enumerate_devices()
ofonod[1540]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[1540]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[1540]: plugins/udevng.c:check_usb_device() usb [0424:2514]
ofonod[1540]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
usb 2-1.2: new full speed USB device number 5 using fsl-ehci
cdc_acm 2-1.2:1.0: This device cannot do calls on its own. It is not a =

modem.
ofonod[1540]: plugins/udevng.c:chcdc_acm 2-1.2:1.0: ttyACM0: USB ACM device
eck_usb_device() usb [058b:0041]
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [(null):(null)]
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [(null):(null)]
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [058b:0041]
ofonod[1540]: plugins/udev.c:udev_event() subsystem tty add
ofonod[1540]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[1540]: plugins/udevng.c:check_modem_list()
usb 2-1.2: USB disconnect, device number 5
ofonod[1540]: plugins/udevng.c:remove_device() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2/2-1.2:1.1
ofonod[1540]: plugins/udevng.c:remove_device() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2/2-1.2:1.0/tty/ttyACM0
ofonod[1540]: plugins/udevng.c:destroy_modem() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2
ofonod[1540]: src/modem.c:ofono_modem_remove() 0x104d40
ofonod[1540]: src/modem.c:modem_unregister() 0x104d40
ofonod[1540]: plugins/telit.c:telit_remove() 0x104d40
ofonod[1540]: src/modem.c:unregister_property() property 0x111c28
ofonod[1540]: src/modem.c:unregister_property() property 0x104d20
ofonod[1540]: src/modem.c:unregister_property() property 0x104058
ofonod[1540]: src/modem.c:emit_modem_removed() 0x104d40
ofonod[1540]: src/modem.c:call_modemwatches() 0x104d40 added:0
ofonod[1540]: plugins/hfp_ag.c:modem_watch() modem: 0x104d40, added: 0
ofonod[1540]: plugins/dun_gw.c:modem_watch() modem: 0x104d40, added: 0
ofonod[1540]: plugins/smart-messaging.c:modem_watch() modem: 0x104d40, =

added: 0
ofonod[1540]: plugins/push-notification.c:modem_watch() modem: 0x104d40, =

added: 0
ofonod[1540]: plugins/udevng.c:destroy_modem() /dev/ttyACM0
ofonod[1540]: plugins/udevng.c:destroy_modem() /dev/ttyACM1
ofonod[1540]: plugins/udev.c:udev_event() subsystem tty remove
ofonod[1540]: plugins/udev.c:remove_modem() =

/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2/2-1.2:1.0/tty/ttyACM0
ofonod[1540]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[1540]: plugins/udevng.c:remove_device() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2/2-1.2:1.0
ofonod[1540]: plugins/udevng.c:remove_device() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2
usb 2-1.2: new full speed USB device number 6 using fsl-ehci
cdc_acm 2-1.2:1.0: This device cannot do calls on its own. It is not a =

modem.
cdc_acm 2-1.2:1.0: ttyACM0: USB ACM device
cdc_acm 2-1.2:1.2: This device cannot do calls on its own. It is not a =

modem.
cdc_acm 2-1.2:1.2: ttyACM1: USB ACM device
ofonod[1540]: plugins/udevng.c:check_usb_device() usb [1bc7:0022]
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [(null):(null)]
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [(null):(null)]
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [(null):(null)]
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0022]
ofonod[1540]: plugins/udevng.c:add_device() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2
ofonod[1540]: plugins/udevng.c:add_device() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2/2-1.2:1.0/tty/ttyACM0
ofonod[1540]: plugins/udevng.c:add_device() /dev/ttyACM0 (telit) 2/2/0 =

[00] =3D=3D> (null) Telit Modem Port
ofonod[1540]: plugins/udev.c:udev_event() subsystem tty add
ofonod[1540]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [(null):(null)]
ofonod[1540]: plugins/udev.c:udev_event() subsystem tty add
ofonod[1540]: plugins/udev.c:udev_event() subsystem tty finished
ofonod[1540]: plugins/udevng.c:check_usb_device() cdc_acm [1bc7:0022]
ofonod[1540]: plugins/udevng.c:add_device() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2
ofonod[1540]: plugins/udevng.c:add_device() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2/2-1.2:1.2/tty/ttyACM1
ofonod[1540]: plugins/udevng.c:add_device() /dev/ttyACM1 (telit) 2/2/0 =

[02] =3D=3D> (null) Telit Serial Port
ofonod[1540]: plugins/udevng.c:check_modem_list()
ofonod[1540]: plugins/udevng.c:create_modem() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2
ofonod[1540]: plugins/udevng.c:create_modem() driver=3Dtelit
ofonod[1540]: src/modem.c:ofono_modem_create() name: (null), type: telit
ofonod[1540]: plugins/udevng.c:setup_telit() =

/sys/devices/platform/fsl-ehci.1/usb2/2-1/2-1.2
ofonod[1540]: plugins/udevng.c:setup_telit() /dev/ttyACM0 2/2/0 00 =

(null) Telit Modem Port
ofonod[1540]: plugins/udevng.c:setup_telit() /dev/ttyACM1 2/2/0 02 =

(null) Telit Serial Port
ofonod[1540]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyACM0 =

aux=3D/dev/ttyACM1 gps=3D(null) diag=3D(null)
ofonod[1540]: src/modem.c:set_modem_property() modem 0x104d40 property Modem
ofonod[1540]: src/modem.c:set_modem_property() modem 0x104d40 property Aux
ofonod[1540]: src/modem.c:set_modem_property() modem 0x104d40 property GPS
ofonod[1540]: src/modem.c:ofono_modem_register() 0x104d40
ofonod[1540]: plugins/telit.c:telit_probe() 0x104d40
ofonod[1540]: src/modem.c:emit_modem_added() 0x104d40
ofonod[1540]: src/modem.c:call_modemwatches() 0x104d40 added:1
ofonod[1540]: plugins/hfp_ag.c:modem_watch() modem: 0x104d40, added: 1
ofonod[1540]: plugins/dun_gw.c:modem_watch() modem: 0x104d40, added: 1
ofonod[1540]: plugins/smart-messaging.c:modem_watch() modem: 0x104d40, =

added: 1
ofonod[1540]: plugins/push-notification.c:modem_watch() modem: 0x104d40, =

added: 1
ofonod[1540]: plugins/telit.c:telit_enable() 0x104d40
ofonod[1540]: src/modem.c:get_modem_property() modem 0x104d40 property Modem
ofonod[1540]: plugins/telit.c:open_device() Modem /dev/ttyACM0
ofonod[1540]: src/modem.c:get_modem_property() modem 0x104d40 property Aux
ofonod[1540]: plugins/telit.c:open_device() Aux /dev/ttyACM1
ofonod[1540]: Aux: > ATE0 +CMEE=3D1\r
ofonod[1540]: Aux: < ATE0 +CMEE=3D1\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT#QSS=3D0\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CFUN=3D1\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: plugins/telit.c:cfun_enable_cb() 0x104d40
ofonod[1540]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[1540]: plugins/telit.c:telit_pre_sim() 0x104d40
ofonod[1540]: Aux: > AT&C0\r
ofonod[1540]: Modem: < \r\n\r\n+PACSP1\r\n
ofonod[1540]: Aux: < \r\n+PACSP1\r\n
ofonod[1540]: src/sim.c:ofono_sim_add_state_watch() 0x116420
ofonod[1540]: src/sim.c:ofono_sim_add_state_watch() 0x116420
ofonod[1540]: src/sim.c:ofono_sim_add_state_watch() 0x116420
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+GCAP\r
ofonod[1540]: Aux: < \r\n+GCAP: +CGSM,+DS,+FCLASS,+MS\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CRC=3D1\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CLIP=3D1\r
ofonod[1540]: plugins/telit.c:telit_set_online() modem 0x104d40 online
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CDIP=3D1\r
ofonod[1540]: Aux: < \r\nERROR\r\n
ofonod[1540]: Aux: > AT+CNAP=3D1\r
ofonod[1540]: Aux: < \r\nERROR\r\n
ofonod[1540]: Aux: > AT+COLP=3D1\r
ofonod[1540]: Aux: < \r\nERROR\r\n
ofonod[1540]: Aux: > AT+CSSN=3D1,1\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+VTD?\r
ofonod[1540]: Aux: < \r\n0\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CCWA=3D1\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: drivers/atmodem/voicecall.c:at_voicecall_initialized() =

voicecall_init: registering to notifications
ofonod[1540]: src/sim.c:ofono_sim_add_state_watch() 0x116420
ofonod[1540]: Aux: > AT#AUTOATT=3D0\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT#QSS=3D2\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT#SIMDET=3D0\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT#SIMDET=3D1\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CGMI\r
ofonod[1540]: Aux: < \r\nTelit\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CFUN=3D1,0\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: src/modem.c:common_online_cb() Online in PRE SIM state
ofonod[1540]: Aux: > AT+CLCC\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CGMM\r
ofonod[1540]: Aux: < \r\nGE910-QUAD\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CGMR\r
ofonod[1540]: Aux: < \r\n13.00.004\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CGSN\r
ofonod[1540]: Aux: < \r\n351732050012700\r\n\r\nOK\r\n
ofonod[1540]: Aux: < \r\n#QSS: 3\r\n
ofonod[1540]: plugins/telit.c:telit_qss_notify() 0x104d40
ofonod[1540]: plugins/telit.c:switch_sim_state_status() 0x104d40, SIM =

status: 3
ofonod[1540]: Aux: > AT+CRSM=3D192,28599\r
ofonod[1540]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1540]: src/voicecall.c:ecc_g2_read_cb() 0
ofonod[1540]: Aux: > AT+CRSM=3D192,28599\r
ofonod[1540]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1540]: src/voicecall.c:ecc_g3_read_cb() 0
ofonod[1540]: Aux: > AT+CRSM=3D192,12258\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,0000000A2FE204000FF0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CRSM=3D176,12258,0,0,10\r
ofonod[1540]: Aux: < \r\n+CRSM: 144,0,98556024010600205260\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 10
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 10
ofonod[1540]: Aux: > AT+CRSM=3D192,28421\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,000000046F05040001F0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CRSM=3D176,28421,0,0,4\r
ofonod[1540]: Aux: < \r\n+CRSM: 144,0,080401FF\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 4
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 4
ofonod[1540]: Aux: > AT+CRSM=3D192,12037\r
ofonod[1540]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CPIN?\r
ofonod[1540]: Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[1540]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[1540]: Aux: > AT#PCT\r
ofonod[1540]: Aux: < \r\n#PCT: 3\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_pct_cb() Note: No password =

required, returning maximum retries:
ofonod[1540]: drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D1, val=
=3D3
ofonod[1540]: drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D4, val=
=3D3
ofonod[1540]: drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D9, val=
=3D10
ofonod[1540]: drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D11, val=
=3D10
ofonod[1540]: Aux: > AT+CRSM=3D192,28590\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,000000016FAE04000AF0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CRSM=3D176,28590,0,0,1\r
ofonod[1540]: Aux: < \r\n+CRSM: 144,0,03\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 1
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 1
ofonod[1540]: Aux: > AT+CRSM=3D192,28589\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,000000046FAD04000AF0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CRSM=3D176,28589,0,0,4\r
ofonod[1540]: Aux: < \r\n+CRSM: 144,0,00000002\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 4
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 4
ofonod[1540]: Aux: > AT+CRSM=3D192,28438\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,000000036F1604001AF0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CRSM=3D176,28438,0,0,3\r
ofonod[1540]: Aux: < \r\n+CRSM: 144,0,013F00\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 3
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 3
ofonod[1540]: Aux: > AT+CRSM=3D192,28472\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,0000000D6F3804001AF0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CRSM=3D176,28472,0,0,13\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,FF3CCF0F0F00FF03000F000000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 13
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 13
ofonod[1540]: Aux: > AT+CRSM=3D192,28474\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,00001C526F3A040011F0220102011D\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CIMI\r
ofonod[1540]: Aux: < \r\n724064200587312\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 724064200587312
ofonod[1540]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[1540]: plugins/telit.c:telit_post_sim() 0x104d40
ofonod[1540]: drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[1540]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[1540]: plugins/telit.c:telit_post_online() 0x104d40
ofonod[1540]: Aux: > AT+CSCS=3D?\r
ofonod[1540]: Aux: < \r\n+CSCS: =

("GSM","IRA","8859-1","PCCP437","UCS2")\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CSMS=3D?\r
ofonod[1540]: Aux: < \r\n+CSMS: (0)\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sms.c:at_csms_query_cb() CSMS query parsed =

successfully
ofonod[1540]: Aux: > AT+CGDCONT=3D?\r
ofonod[1540]: Aux: < \r\n+CGDCONT: (1-5),"IP",,,(0,1),(0,1)\r\n+CGDCONT: =

(1-5),"IPV6",,,(0,1),(0,1)\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CREG=3D?\r
ofonod[1540]: Aux: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CSCS?\r
ofonod[1540]: Aux: < \r\n+CSCS: "IRA"\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CUSD=3D1\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CAOC=3D2\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CCWE=3D1\r
ofonod[1540]: Aux: < \r\n+CME ERROR: 3\r\n
ofonod[1540]: Aux: > AT+CRSM=3D192,28480\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,0000003A6F40040011F0AA0102011D\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CPBS=3D?\r
ofonod[1540]: Aux: < \r\n+CPBS: =

("SM","FD","LD","MC","RC","MB")\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CSMS=3D0\r
ofonod[1540]: Aux: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CGREG=3D?\r
ofonod[1540]: Aux: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CREG=3D2\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CRSM=3D178,28480,1,4,29\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\=
r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 29
ofonod[1540]: Aux: > AT+CSMS?\r
ofonod[1540]: Aux: < \r\n+CSMS: 0,1,1,1\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CGREG=3D2\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CGAUTO=3D0\r
ofonod[1540]: Aux: < \r\nERROR\r\n
ofonod[1540]: Aux: > AT+CGEREP=3D2,1\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CIND=3D?\r
ofonod[1540]: Aux: < \r\n+CIND: =

(("battchg",(0-5,99)),("signal",(0-7,99)),("service",(0,1)),("sounder",(0,1=
)),("message",(0,1)),("call",(0,1)),("roam",
ofonod[1540]: Aux: < =

(0,1)),("smsfull",(0,1)),("rssi",(0-5,99)))\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CRSM=3D178,28480,2,4,29\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\=
r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 29
ofonod[1540]: Aux: > AT+CMGF=3D?\r
ofonod[1540]: Aux: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT#PSNT=3D1\r
ofonod[1540]: Aux: < \r\nERROR\r\n
ofonod[1540]: Aux: > AT+CPSB=3D1\r
ofonod[1540]: Aux: < \r\nERROR\r\n
ofonod[1540]: Aux: > AT+CMER=3D?\r
ofonod[1540]: Aux: < \r\n+CMER: (0-3),(0),(0),(0,2),(0)\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/network-registration.c:build_cmer_string()
ofonod[1540]: Aux: > AT+CRSM=3D192,20256\r
ofonod[1540]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CPMS=3D?\r
ofonod[1540]: Aux: < \r\n+CPMS: ("SM"),("SM"),("SM")\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CMER=3D3,0,0,2\r
ofonod[1540]: Aux: < \r\nOK\r\n\r\n+CIEV: battchg,5\r\n\r\n+CIEV: =

signal,0\r\n\r\n+CIEV: service,0\r\n\r\n+CIEV: sounder,0\r\n\r\n+CIEV: =

message,0\r\n\r\n+CIEV: call,0\r\n\r\n+CIE
ofonod[1540]: Aux: < V: roam,0\r\n\r\n+CIEV: smsfull,0\r\n\r\n+CIEV: =

rssi,4\r\n
ofonod[1540]: src/sim.c:ofono_sim_add_spn_watch() 0x116420
ofonod[1540]: src/network.c:__ofono_netreg_add_status_watch() 0x1116a0
ofonod[1540]: Aux: > AT+CRSM=3D192,28618\r
ofonod[1540]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1540]: Unable to read waiting messages numbers from SIM
ofonod[1540]: Aux: > AT+CMGF=3D0\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CREG?\r
ofonod[1540]: Aux: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
ofonod[1540]: src/network.c:ofono_netreg_status_notify() /telit_1 status =

2 tech -1
ofonod[1540]: src/network.c:current_operator_callback() 0x1116a0, (nil)
ofonod[1540]: src/gprs.c:netreg_status_changed() 2
ofonod[1540]: Aux: > AT+CRSM=3D192,28617\r
ofonod[1540]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1540]: Unable to read mailbox identifies from SIM
ofonod[1540]: Aux: > AT+CPMS=3D"SM","SM","SM"\r
ofonod[1540]: Aux: < \r\n+CPMS: 0,15,0,15,0,15\r\n\r\nOK\r\n
ofonod[1540]: Aux: > AT+CRSM=3D192,28433\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,000000016F11040011F0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CNMI=3D?\r
ofonod[1540]: Aux: < \r\n+CNMI: (0-3),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[1540]: Aux: > AT+CRSM=3D176,28433,0,0,1\r
ofonod[1540]: Aux: < \r\n+CRSM: 144,0,55\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 1
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 1
ofonod[1540]: Aux: > AT+CNMI=3D2,1,2,1,0\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: src/network.c:__ofono_netreg_add_status_watch() 0x1116a0
ofonod[1540]: src/sms.c:sms_restore_tx_queue()
ofonod[1540]: plugins/push-notification.c:sms_watch() registered
ofonod[1540]: plugins/smart-messaging.c:sms_watch() registered
ofonod[1540]: Aux: > AT+CRSM=3D192,28435\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,000000016F13040011F0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CMGL=3D4\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: drivers/atmodem/sms.c:at_cmgl_done()
ofonod[1540]: Aux: > AT+CGSMS=3D3\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+CRSM=3D176,28435,0,0,1\r
ofonod[1540]: Aux: < \r\n+CRSM: 144,0,00\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 1
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 1
ofonod[1540]: Aux: > AT+CRSM=3D192,28613\r
ofonod[1540]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1540]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39, =

toread: 17
ofonod[1540]: Aux: > AT+CRSM=3D192,28437\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,000000166F15040011F0AA01020000\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CRSM=3D176,28437,0,0,22\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,01F802F803F804F005FE0600070008B309FCC0FDD500\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 22
ofonod[1540]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: =

0, tocopy: 22
ofonod[1540]: Aux: > AT+CRSM=3D192,28439\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,0000001A6F17040011F0AA0102011A\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, =

00, 15
ofonod[1540]: Aux: > AT+CRSM=3D178,28439,1,4,26\r
ofonod[1540]: Aux: < \r\n+CRSM: =

144,0,436169786120506F7374616C03815A55FFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, =

00, 26
ofonod[1540]: 3GPP MBDN not provided, parsing CPHS..
ofonod[1540]: Aux: < \r\n+CREG: 1,"0411","AE77"\r\n\r\n+CIEV: =

service,1\r\n\r\n+CIEV: roam,0\r\n
ofonod[1540]: src/network.c:ofono_netreg_status_notify() /telit_1 status =

1 tech -1
ofonod[1540]: src/gprs.c:netreg_status_changed() 1
ofonod[1540]: Aux: > AT+COPS=3D3,2\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+COPS?\r
ofonod[1540]: Aux: < \r\n+COPS: 0,2,"72406"\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/network-registration.c:cops_numeric_cb() =

Cops numeric got mcc: 724, mnc: 06
ofonod[1540]: Aux: > AT+CIND?\r
ofonod[1540]: Aux: < \r\n+CIND: 5,0,1,0,0,0,0,0,4\r\n\r\nOK\r\n
ofonod[1540]: src/network.c:ofono_netreg_strength_notify() strength 80
ofonod[1540]: Aux: > AT+CGATT=3D1\r
ofonod[1540]: Aux: < \r\nOK\r\n\r\n+CGREG: 1,"0411","AE77"\r\n
ofonod[1540]: src/gprs.c:gprs_attach_callback() /telit_1 error =3D 0
ofonod[1540]: src/gprs.c:ofono_gprs_status_notify() /telit_1 status 1
ofonod[1540]: Aux: > AT+COPS=3D3,0\r
ofonod[1540]: Aux: < \r\nOK\r\n
ofonod[1540]: Aux: > AT+COPS?\r
ofonod[1540]: Aux: < \r\n+COPS: 0,0,"VIVO"\r\n\r\nOK\r\n
ofonod[1540]: drivers/atmodem/network-registration.c:cops_cb() cops_cb: =

VIVO, 724 06 0
ofonod[1540]: src/network.c:current_operator_callback() 0x1116a0, (nil)
ofonod[1540]: src/gprs.c:netreg_status_changed() 1
ofonod[1540]: Aux: > AT+CGREG?\r
ofonod[1540]: Aux: < \r\n+CGREG: 2,1,"0411","AE77"\r\n\r\nOK\r\n
ofonod[1540]: src/gprs.c:registration_status_cb() /telit_1 error 0 status 1
ofonod[1540]: src/gprs.c:ofono_gprs_status_notify() /telit_1 status 1
ofonod[1540]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() =

cid 1
ofonod[1540]: Modem: > AT+CGDCONT=3D1,"IP","zap.vivo.com.br"\r
ofonod[1540]: Modem: < AT+CGDCONT=3D1,"IP","zap.vivo.com.br"\r
ofonod[1540]: Modem: < \r\nOK\r\n
ofonod[1540]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod[1540]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[1540]: Modem: < AT+CGDATA=3D"PPP",1\r
ofonod[1540]: Modem: < \r\nCONNECT\r\n
ofonod[1540]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
ofonod[1540]: drivers/atmodem/gprs-context.c:setup_ppp()
ofonod[1540]: PPP: lcp: pppcp_generate_event: current state 0:INITIAL
ofonod[1540]: PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
ofonod[1540]: PPP: lcp: pppcp_generate_event: current state 2:CLOSED
ofonod[1540]: PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
ofonod[1540]: PPP: lcp: pppcp_initialize_restart_count: current state =

2:CLOSED
ofonod[1540]: PPP: lcp: pppcp_send_configure_request: current state 2:CLOSED
ofonod[1540]: PPP: gatchat/gatppp.c:ppp_enter_phase() 1
ofonod[1540]: PPP: lcp: pppcp_process_configure_ack: current state 6:REQSENT
ofonod[1540]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
ofonod[1540]: PPP: event: 8 (RCA), action: 27, new_state: 7 (ACKRCVD)
ofonod[1540]: PPP: lcp: pppcp_initialize_restart_count: current state =

6:REQSENT
ofonod[1540]: PPP: lcp: pppcp_process_configure_request: current state =

7:ACKRCVD
ofonod[1540]: PPP: lcp: pppcp_generate_event: current state 7:ACKRCVD
(*)ofonod[1540]: PPP: event: 7 (RCR-), action: 4007, new_state: 7 (ACKRCVD)
ofonod[1540]: PPP: lcp: pppcp_send_configure_nak: current state 7:ACKRCVD
ofonod[1540]: PPP: lcp: pppcp_process_terminate_request: current state =

7:ACKRCVD
ofonod[1540]: PPP: lcp: pppcp_generate_event: current state 7:ACKRCVD
ofonod[1540]: PPP: event: 10 (RTR), action: 10006, new_state: 6 (REQSENT)
ofonod[1540]: PPP: lcp: pppcp_send_terminate_ack: current state 7:ACKRCVD
ofonod[1540]: PPP: gatchat/gatppp.c:sta_sent()
ofonod[1540]: Aux: < \r\n+CIEV: rssi,3\r\n
ofonod[1540]: src/network.c:ofono_netreg_strength_notify() strength 60
ofonod[1540]: Aux: < \r\n+CIEV: rssi,4\r\n
ofonod[1540]: src/network.c:ofono_netreg_strength_notify() strength 80
ofonod[1540]: Aux: < \r\n+CIEV: rssi,3\r\n
ofonod[1540]: src/network.c:ofono_netreg_strength_notify() strength 60
ofonod[1540]: Aux: < \r\n+CIEV: rssi,4\r\n
ofonod[1540]: src/network.c:ofono_netreg_strength_notify() strength 80
ofonod[1540]: PPP: lcp: pppcp_timeout: current state 6:REQSENT
ofonod[1540]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
ofonod[1540]: PPP: event: 4 (TO+), action: 1006, new_state: 6 (REQSENT)
ofonod[1540]: PPP: lcp: pppcp_send_configure_request: current state =

6:REQSENT
ofonod[1540]: PPP: lcp: pppcp_timeout: current state 6:REQSENT
ofonod[1540]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
ofonod[1540]: PPP: event: 5 (TO-), action: 803, new_state: 3 (STOPPED)
ofonod[1540]: PPP: lcp: pppcp_this_layer_finished: current state 3:STOPPED
ofonod[1540]: PPP: gatchat/gatppp.c:ppp_enter_phase() 0
ofonod[1540]: PPP: gatchat/gatppp.c:ppp_dead()
ofonod[1540]: drivers/atmodem/gprs-context.c:ppp_disconnect() Reason: 0
ofonod[1540]: src/gprs.c:pri_activate_callback() 0x119710
ofonod[1540]: src/gprs.c:pri_activate_callback() Activating context =

failed with error: Unknown error type
ofonod[1540]: Modem: < \377}#\300!}!}"} }$\265Z~
ofonod[1540]: Aux: < \r\n+CIEV: rssi,3\r\n
ofonod[1540]: src/network.c:ofono_netreg_strength_notify() strength 60
ofonod[1540]: Aux: < \r\n+CIEV: rssi,4\r\n
ofonod[1540]: src/network.c:ofono_netreg_strength_notify() strength 80



--===============3309927093637209165==--

