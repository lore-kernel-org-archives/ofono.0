Content-Type: multipart/mixed; boundary="===============1040416204193540162=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Timeout when powering modem
Date: Mon, 20 Aug 2012 10:35:18 +0200
Message-ID: <5031F6C6.1030509@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1040416204193540162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I constantly get a timeout when trying to power the modem.
This always happens when the modem gets physically connected after ofono =

is already running.
It does not happen if ofono is started after the modem was connected.
Has anybody observed this too?


Debug output:

Aug  8 11:34:03 mx31tt01 daemon.info ofonod[483]: oFono version 1.10
Aug  8 11:34:03 mx31tt01 daemon.notice dbus[411]: [system] Successfully =

activated service 'org.ofono'
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/plugin.c:__ofono_plugin_init()
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

plugins/push-notification.c:push_notification_init()
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

plugins/smart-messaging.c:smart_messaging_init()
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/cdma-provision.c:ofono_cdma_provision_driver_register() driver: =

0xfb64c name: CDMA provisioning
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/gprs-provision.c:ofono_gprs_provision_driver_register() driver: =

0xfb620 name: Provisioning
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

plugins/connman.c:connman_init()
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/private-network.c:ofono_private_network_driver_register() driver: =

0xfb5f4, name: ConnMan Private Network
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

plugins/dun_gw.c:dun_gw_init()
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb544, name: hfp
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb4ec, name: sap
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb480, name: telit
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb414, name: sim900
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb3cc, name: samsung
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb384, name: speedupcdma
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb334, name: speedup
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb2ec, name: alcatel
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb294, name: icera
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb24c, name: linktop
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb204, name: nokiacdma
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb1bc, name: nokia
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb174, name: tc65
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb0ec, name: ste
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb094, name: ifx
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfb04c, name: palmpre
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfaffc, name: novatel
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfafb4, name: sierra
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfaf3c, name: huawei
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfaef4, name: zte
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfae94, name: hso
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfae44, name: mbm
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfadf4, name: calypso
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfadac, name: wavecom
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfad64, name: g1
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register() driver: =

0xfad0c, name: cdmamodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xfad34, name: cdmamodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/cdma-connman.c:ofono_cdma_connman_driver_register() driver: 0xfad50, =

name: cdmamodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfac74, name: phonesim
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xfaca4, name: localhfp
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfac5c, name: =

phonesim
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/ctm.c:ofono_ctm_driver_register() driver: 0xfac48, name: phonesim
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

plugins/phonesim.c:parse_config() filename /etc/ofono/phonesim.conf
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xfac34, name: speedupmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfab28, name: =

hfpmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xfabcc, name: hfpmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/network.c:ofono_netreg_driver_register() driver: 0xfab80, name: hfpmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/call-volume.c:ofono_call_volume_driver_register() driver: 0xfabb4, =

name: hfpmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/handsfree.c:ofono_handsfree_driver_register() driver: 0xfabf8, name: =

hfpmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/network.c:ofono_netreg_driver_register() driver: 0xfaaa8, name: dunmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_driver_register() driver: 0xfaacc, name: dunmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa9e0, name: =

stemodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfaa68, name: =

stemodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfaa30, name: stemodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa8c4, name: =

ifxmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xfa91c, name: ifxmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa930, name: ifxmodem
Aug  8 11:34:03 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa964, name: =

ifxmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/stk.c:ofono_stk_driver_register() driver: 0xfa98c, name: ifxmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/ctm.c:ofono_ctm_driver_register() driver: 0xfa9ac, name: ifxmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa858, name: =

hsomodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa878, name: hsomodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa7d8, name: =

mbmmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/stk.c:ofono_stk_driver_register() driver: 0xfa7f8, name: mbmmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/location-reporting.c:ofono_location_reporting_driver_register() =

driver: 0xfa818, name: mbmmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa740, name: =

calypsomodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/stk.c:ofono_stk_driver_register() driver: 0xfa790, name: calypsomodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xfa64c, name: huaweimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa660, name: =

huaweimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xfa6b0, name: huaweimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa6e4, name: huaweimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa6c4, name: =

huaweimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver: 0xfa710, =

name: huaweimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa5d8, name: =

iceramodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa600, name: iceramodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa584, name: ztemodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa544, name: =

swmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xfa500, name: nwmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xfa37c, name: =

atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xfa414, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-barring.c:ofono_call_barring_driver_register() driver: 0xfa3cc, =

name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-forwarding.c:ofono_call_forwarding_driver_register() driver: =

0xfa174, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-meter.c:ofono_call_meter_driver_register() driver: 0xfa1b4, =

name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-settings.c:ofono_call_settings_driver_register() driver: =

0xfa0c0, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/phonebook.c:ofono_phonebook_driver_register() driver: 0xfa3fc, name: =

atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xfa358, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sms.c:ofono_sms_driver_register() driver: 0xfa130, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sim.c:ofono_sim_driver_register() driver: 0xfa298, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sim.c:ofono_sim_driver_register() driver: 0xfa2e0, name: atmodem-noef
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/stk.c:ofono_stk_driver_register() driver: 0xfa330, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/network.c:ofono_netreg_driver_register() driver: 0xfa210, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/cbs.c:ofono_cbs_driver_register() driver: 0xfa158, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-volume.c:ofono_call_volume_driver_register() driver: 0xfa440, =

name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_driver_register() driver: 0xfa470, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xfa484, name: =

atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sim-auth.c:ofono_sim_auth_driver_register() driver: 0xfa4a4, name: =

atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gnss.c:ofono_gnss_driver_register() driver: 0xfa4c4, name: atmodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xf9f1c, name: gobi
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xf9db0, name: qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/network.c:ofono_netreg_driver_register() driver: 0xf9e14, name: qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xf9dcc, name: =

qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sim.c:ofono_sim_driver_register() driver: 0xf9e38, name: qmimodem-legacy
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sms.c:ofono_sms_driver_register() driver: 0xf9e80, name: qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xf9ea0, name: qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_driver_register() driver: 0xf9eb4, name: qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xf9ec8, name: =

qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xf9ee0, name: qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/location-reporting.c:ofono_location_reporting_driver_register() =

driver: 0xf9f04, name: qmimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xf9d48, name: u8500
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xf9d2c, name: u8500
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xf9ce4, name: n900
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_driver_register() driver: 0xf9c9c, name: isiusb
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_devinfo_driver_register() driver: 0xf9a50, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/phonebook.c:ofono_phonebook_driver_register() driver: 0xf9a40, name: =

isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/network.c:ofono_netreg_driver_register() driver: 0xf9a6c, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/voicecall.c:ofono_voicecall_driver_register() driver: 0xf9a90, name: =

isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sms.c:ofono_sms_driver_register() driver: 0xf9ad8, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/cbs.c:ofono_cbs_driver_register() driver: 0xf9af8, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sim.c:ofono_sim_driver_register() driver: 0xf9b0c, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/ussd.c:ofono_ussd_driver_register() driver: 0xf9b54, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-forwarding.c:ofono_call_forwarding_driver_register() driver: =

0xf9b68, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-settings.c:ofono_call_settings_driver_register() driver: =

0xf9b88, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-barring.c:ofono_call_barring_driver_register() driver: 0xf9bb8, =

name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/call-meter.c:ofono_call_meter_driver_register() driver: 0xf9bd0, =

name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/radio-settings.c:ofono_radio_settings_driver_register() driver: =

0xf9bf8, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_driver_register() driver: 0xf9c1c, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/gprs.c:ofono_gprs_context_driver_register() driver: 0xf9c30, name: =

isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/audio-settings.c:ofono_audio_settings_driver_register() driver: =

0xf9c48, name: isimodem
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

src/sim.c:ofono_sim_driver_register() driver: 0xf9c54, name: wgmodem2.5
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:udev_start()
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:enumerate_devices()
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() hub [(null):(null)]
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() usb [0424:2514]
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() usb [9710:7830]
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() MOSCHIP usb-ethernet driver =

[(null):(null)]
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() MOSCHIP usb-ethernet driver [9710:7830]
Aug  8 11:34:04 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() hub [(null):(null)]
Aug  8 11:34:04 mx31tt01 daemon.notice dbus[411]: [system] Activating =

service name=3D'org.freedesktop.Gypsy' (using servicehelper)
Aug  8 11:34:04 mx31tt01 daemon.notice dbus[411]: [system] Successfully =

activated service 'org.freedesktop.Gypsy'
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() usb [1bc7:1004]
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() option [(null):(null)]
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() option [(null):(null)]
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() option [(null):(null)]
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() option [(null):(null)]
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udev.c:udev_event() subsystem tty add
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udev.c:udev_event() subsystem tty finished
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() option [1bc7:1004]
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1/1-1.1:1.1/ttyUSB1/tty/ttyUS=
B1
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() /dev/ttyUSB1 (telit) 255/255/255 [01] =3D=3D> =

(null) (null)
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() option [1bc7:1004]
Aug  8 11:34:16 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1/1-1.1:1.0/ttyUSB0/tty/ttyUS=
B0
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() /dev/ttyUSB0 (telit) 255/255/255 [00] =3D=3D> =

(null) (null)
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udev.c:udev_event() subsystem tty add
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udev.c:udev_event() subsystem tty finished
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() option [1bc7:1004]
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1/1-1.1:1.3/ttyUSB3/tty/ttyUS=
B3
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() /dev/ttyUSB3 (telit) 255/255/255 [03] =3D=3D> =

(null) (null)
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udev.c:udev_event() subsystem tty add
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udev.c:udev_event() subsystem tty finished
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_usb_device() option [1bc7:1004]
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1/1-1.1:1.2/ttyUSB2/tty/ttyUS=
B2
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:add_device() /dev/ttyUSB2 (telit) 255/255/255 [02] =3D=3D> =

(null) (null)
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udev.c:udev_event() subsystem tty add
Aug  8 11:34:17 mx31tt01 daemon.debug ofonod[483]: =

plugins/udev.c:udev_event() subsystem tty finished
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:check_modem_list()
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:create_modem() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:create_modem() driver=3Dtelit
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_create() name: (null), type: telit
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:setup_telit() =

/sys/devices/platform/mxc-ehci.2/usb1/1-1/1-1.1
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:setup_telit() /dev/ttyUSB0 255/255/255 00 (null)
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:setup_telit() /dev/ttyUSB1 255/255/255 01 (null)
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:setup_telit() /dev/ttyUSB2 255/255/255 02 (null)
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:setup_telit() /dev/ttyUSB3 255/255/255 03 (null)
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/udevng.c:setup_telit() modem=3D/dev/ttyUSB0 aux=3D/dev/ttyUSB3 =

gps=3D/dev/ttyUSB2 diag=3D/dev/ttyUSB1
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:set_modem_property() modem 0x17e35d0 property Modem
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:set_modem_property() modem 0x17e35d0 property Aux
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:set_modem_property() modem 0x17e35d0 property GPS
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:ofono_modem_register() 0x17e35d0
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/telit.c:telit_probe() 0x17e35d0
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:emit_modem_added() 0x17e35d0
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:call_modemwatches() 0x17e35d0 added:1
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/hfp_ag.c:modem_watch() modem: 0x17e35d0, added: 1
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/dun_gw.c:modem_watch() modem: 0x17e35d0, added: 1
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/smart-messaging.c:modem_watch() modem: 0x17e35d0, added: 1
Aug  8 11:34:18 mx31tt01 daemon.debug ofonod[483]: =

plugins/push-notification.c:modem_watch() modem: 0x17e35d0, added: 1
Aug  8 11:34:19 mx31tt01 daemon.debug ofonod[483]: =

plugins/telit.c:telit_enable() 0x17e35d0
Aug  8 11:34:19 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:get_modem_property() modem 0x17e35d0 property Modem
Aug  8 11:34:19 mx31tt01 daemon.debug ofonod[483]: =

plugins/telit.c:open_device() Modem /dev/ttyUSB0
Aug  8 11:34:19 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:get_modem_property() modem 0x17e35d0 property Aux
Aug  8 11:34:19 mx31tt01 daemon.debug ofonod[483]: =

plugins/telit.c:open_device() Aux /dev/ttyUSB3
Aug  8 11:34:19 mx31tt01 daemon.info ofonod[483]: Aux: > ATE0 +CMEE=3D1\r
Aug  8 11:34:19 mx31tt01 daemon.info ofonod[483]: Aux: < ATE0 +CMEE=3D1\r
Aug  8 11:34:19 mx31tt01 daemon.info ofonod[483]: Aux: < \r\nOK\r\n
Aug  8 11:34:19 mx31tt01 daemon.info ofonod[483]: Aux: > AT+CFUN=3D4\r
Aug  8 11:34:39 mx31tt01 daemon.debug ofonod[483]: =

src/modem.c:set_powered_timeout() modem: 0x17e35d0


Regards,
Christopher

--
Scanned by MailScanner.


--===============1040416204193540162==--

