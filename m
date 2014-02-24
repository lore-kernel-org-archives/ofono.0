Content-Type: multipart/mixed; boundary="===============8428289686379345183=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: Unable to get list of cellular services using Huwaei E303 dongle
Date: Mon, 24 Feb 2014 14:03:39 +0000
Message-ID: <CAK+sfov2OD_Suq+c-Vnb-s5+-fHOoZGmVmxc4AhbQ4uYxdVcmQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8428289686379345183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

I have an E303 Huawei 3G dongle. Using dbus commands (simulating the Pythin
test scripts), I am able to power on the modem and enable the cellular
technology. However, when I perform GetSerrvices I get the list of services
but not the cellular one.

The sim card is ok as it works on other platforms. Below is the log I get.
Any help appreciated.

ofonod[1659]: oFono version 1.14
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/plugin.c:__ofono_plugin_init()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/push-notification.c:push_notification_in=
it()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/smart-messaging.c:smart_messaging_init()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/cdma-provision.c:ofono_cdma_provision_driver=
_register()
driver: 0x556c1bb0 name: CDMA provisioning
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs-provision.c:ofono_gprs_provision_driver=
_register()
driver: 0x556c1b80 name: Provisioning
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/dun_gw_bluez5.c:dun_gw_init()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/handsfree-audio.c:ofono_handsfree_card_drive=
r_register()
driver: 0x556c1a50
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1a60, name: hfp
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/he910.c:he910_init()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c19e0, name: he910
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/connman.c:connman_init()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/private-network.c:ofono_private_network_driv=
er_register()
driver: 0x556c19b0, name: ConnMan Private Network
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1960, name: sim900
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1910, name: samsung
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c18c0, name: speedupcdma
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1870, name: speedup
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1820, name: alcatel
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c17c0, name: icera
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1770, name: linktop
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1720, name: nokiacdma
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c16d0, name: nokia
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1680, name: tc65
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c15f0, name: ste
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1590, name: ifx
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1540, name: palmpre
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c14f0, name: novatel
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c14a0, name: sierra
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1420, name: huawei
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c13d0, name: zte
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1370, name: hso
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1320, name: mbm
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c12d0, name: calypso
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1280, name: wavecom
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1230, name: g1
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/cdma-voicecall.c:ofono_cdma_voicecall_driver=
_register()
driver: 0x556c11a0, name: cdmamodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c11c0, name: cdmamodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/cdma-connman.c:ofono_cdma_connman_driver_reg=
ister()
driver: 0x556c11f0, name: cdmamodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c111c, name: phonesim
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c1154, name: localhfp
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c1104, name: phonesim
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
0x556c10f0, name: phonesim
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/phonesim.c:parse_config()
filename /etc/ofono/phonesim.conf
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c10b0, name: speedupmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0f50, name: hfpmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c1010, name: hfpmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0fa0, name: hfpmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-volume.c:ofono_call_volume_driver_regis=
ter()
driver: 0x556c0fe0, name: hfpmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/handsfree.c:ofono_handsfree_driver_register()
driver: 0x556c1030, name: hfpmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/siri.c:ofono_siri_driver_register() driver:
0x556c1060, name: hfpmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0ec0, name: dunmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c0ef0, name: dunmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0df0, name: stemodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0e70, name: stemodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556c0e40, name: stemodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0cb0, name: ifxmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver=
_register()
driver: 0x556c0d00, name: ifxmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556c0d20, name: ifxmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0d50, name: ifxmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0d80, name: ifxmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
0x556c0db0, name: ifxmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0c40, name: hsomodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556c0c60, name: hsomodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0bb0, name: mbmmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0be0, name: mbmmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/location-reporting.c:ofono_location_reportin=
g_driver_register()
driver: 0x556c0c00, name: mbmmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0b20, name: calypsomodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0b70, name: calypsomodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c0a00, name: huaweimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0a20, name: huaweimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver=
_register()
driver: 0x556c0a70, name: huaweimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556c0ab0, name: huaweimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0a90, name: huaweimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/cdma-netreg.c:ofono_cdma_netreg_driver_regis=
ter()
driver: 0x556c0ae0, name: huaweimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0970, name: iceramodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556c09a0, name: iceramodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556c0920, name: ztemodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c08e0, name: swmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556c0890, name: nwmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c06b0, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c0760, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-barring.c:ofono_call_barring_driver_reg=
ister()
driver: 0x556c0710, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driv=
er_register()
driver: 0x556c0480, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-meter.c:ofono_call_meter_driver_registe=
r()
driver: 0x556c04b0, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-settings.c:ofono_call_settings_driver_r=
egister()
driver: 0x556c0390, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x556c0730, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c0680, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556c0400, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0560, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c05a8, name: atmodem-noef
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0660, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0500, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
0x556c0460, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-volume.c:ofono_call_volume_driver_regis=
ter()
driver: 0x556c0790, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c07d0, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0800, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim-auth.c:ofono_sim_auth_driver_register()
driver: 0x556c0820, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gnss.c:ofono_gnss_driver_register() driver:
0x556c0840, name: atmodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556c01b0, name: gobi
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bff80, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556bfff0, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556bffa0, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0020, name: qmimodem-legacy
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0070, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556c00c0, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c00e0, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c0100, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0120, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556c0140, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/location-reporting.c:ofono_location_reportin=
g_driver_register()
driver: 0x556c0170, name: qmimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556bff2c, name: u8500
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bff10, name: u8500
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556bfec0, name: n900
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_driver_register()
driver: 0x556bfe70, name: isiusb
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bfb90, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x556bfb80, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556bfbb0, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556bfbe0, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556bfc30, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
0x556bfc50, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556bfc70, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556bfcc0, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driv=
er_register()
driver: 0x556bfce0, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-settings.c:ofono_call_settings_driver_r=
egister()
driver: 0x556bfd00, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-barring.c:ofono_call_barring_driver_reg=
ister()
driver: 0x556bfd30, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/call-meter.c:ofono_call_meter_driver_registe=
r()
driver: 0x556bfd50, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver=
_register()
driver: 0x556bfd80, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556bfdb0, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556bfdd0, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver=
_register()
driver: 0x556bfdf0, name: isimodem
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556bfe00, name: wgmodem2.5
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:udev_start()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:enumerate_devices()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() hub
[(null):(null)]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() usb
[0bda:8176]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
[(null):(null)]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
[0bda:8176]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() hub
[(null):(null)]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() usb
[12d1:1001]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/dev/ttyUSB0 (huawei) 255/255/255 [00] =3D=3D> (null) (null)
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/dev/ttyUSB1 (huawei) 255/255/255 [01] =3D=3D> (null) (null)
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:add_device()
/dev/ttyUSB2 (huawei) 255/255/255 [02] =3D=3D> (null) (null)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:create_modem()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:create_modem()
driver=3Dhuawei
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_create()
name: (null), type: huawei
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:setup_huawei()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:setup_huawei()
/dev/ttyUSB0 255/255/255 00 (null)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:setup_huawei()
/dev/ttyUSB1 255/255/255 01 (null)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:setup_huawei()
/dev/ttyUSB2 255/255/255 02 (null)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/udevng.c:setup_huawei()
mdm=3D/dev/ttyUSB0 pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(nu=
ll)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:set_modem_property()
modem 0x556eaf98 property Device
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:set_modem_property()
modem 0x556eaf98 property Modem
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:set_modem_property()
modem 0x556eaf98 property Pcui
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:set_modem_property()
modem 0x556eaf98 property Diag
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:set_modem_property()
modem 0x556eaf98 property NetworkInterface
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:ofono_modem_register()
0x556eaf98
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:huawei_probe()
0x556eaf98
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:emit_modem_added()
0x556eaf98
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:call_modemwatches()
0x556eaf98 added:1
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
0x556eaf98, added: 1
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
0x556eaf98, added: 1
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
0x556eaf98, added: 1
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/push-notification.c:modem_watch() modem:
0x556eaf98, added: 1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:huawei_enable()
0x556eaf98
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:get_modem_property()
modem 0x556eaf98 property Modem
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:open_device()
Modem /dev/ttyUSB0
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:get_modem_property()
modem 0x556eaf98 property Pcui
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:open_device()
Pcui /dev/ttyUSB2
ofonod[1659]: Modem: > ATE0 +CMEE=3D1\r
ofonod[1659]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[1659]: Modem: < \r\nOK\r\n
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > ATI\r
ofonod[1659]: PCUI: < \r\nManufacturer: huawei\r\nModel: E303\r\nRevision:
22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
+CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT^RFSWITCH=3D?\r
ofonod[1659]: PCUI: < \r\nERROR\r\n
ofonod[1659]: PCUI: > AT+CFUN=3D1\r
ofonod[1659]: PCUI: < \r\n^SIMST:0,0\r\n
ofonod[1659]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:cfun_enable()
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:simst_notify()
255 -> 1
ofonod[1659]: PCUI: > AT^SYSINFO\r
ofonod[1659]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n
ofonod[1659]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 1 -> 1
ofonod[1659]: Modem: > AT&C0\r
ofonod[1659]: PCUI: > AT&C0\r
ofonod[1659]: Modem: < \r\nOK\r\n
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: Modem: > AT+CSCS=3D"GSM"\r
ofonod[1659]: PCUI: > AT+CSCS=3D"GSM"\r
ofonod[1659]: Modem: < \r\nOK\r\n
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT^U2DIAG?\r
ofonod[1659]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT^GETPORTMODE\r
ofonod[1659]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA: huawei,\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT^USSDMODE=3D?\r
ofonod[1659]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT^DIALMODE=3D?\r
ofonod[1659]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT^CVOICE=3D?\r
ofonod[1659]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CFUN=3D5\r
ofonod[1659]: PCUI: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
ofonod[1659]: PCUI: < \r\nOK\r\n\r\n^MODE: 0,0\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:cfun_offline()
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:modem_change_state()
old state: 0, new state: 1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:huawei_pre_sim()
0x556eaf98
ofonod[1659]: PCUI: > AT^USSDMODE?\r
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dcfe8
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dcfe8
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dcfe8
ofonod[1659]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT^DIALMODE?\r
ofonod[1659]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT^CVOICE?\r
ofonod[1659]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
ofonod[1659]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[1659]: PCUI: > AT+GCAP\r
ofonod[1659]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\r\=
nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1659]: PCUI: > AT^DDSETEX=3D?\r
ofonod[1659]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CGMI\r
ofonod[1659]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[1659]: PCUI: > AT+CGMM\r
ofonod[1659]: PCUI: < \r\nE303\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\r\=
nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1659]: PCUI: > AT+CGMR\r
ofonod[1659]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[1659]: PCUI: > AT+CGSN\r
ofonod[1659]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\r\=
nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1659]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[1659]: PCUI: > AT+CPIN?\r
ofonod[1659]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb()
crsm_pin_cb: READY
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[1659]: PCUI: > AT^CPIN?\r
ofonod[1659]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D9, val=3D10
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D1, val=3D3
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D11, val=3D10
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D4, val=3D3
ofonod[1659]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\r\=
nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1659]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 4
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 4
ofonod[1659]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\r\=
nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1659]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[1659]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\r\=
nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1659]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 1
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[1659]: PCUI: > AT+CIMI\r
ofonod[1659]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb()
cimi_cb: 272050100413580
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:modem_change_state()
old state: 1, new state: 2
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:huawei_post_sim()
0x556eaf98
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_p=
robe()
ofonod[1659]: Missing support for TUN/TAP devices
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:get_modem_property()
modem 0x556eaf98 property AlwaysOnline
ofonod[1659]: PCUI: > AT+CRC=3D1\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+CLIP=3D1\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+COLP=3D1\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+CCWA=3D1\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall=
_initialized()
registering to notifications
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dcfe8
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag) profile
ofonod[1659]: PCUI: > AT^CVOICE=3D?\r
ofonod[1659]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CSCS=3D?\r
ofonod[1659]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT^SYSCFG=3D?\r
ofonod[1659]: PCUI: < \r\n^SYSCFG:
(2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(28=
0000,"GSM850/GSM1900"),(3fffffff,"All
bands")),(0-2),(0-4)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CSMS=3D?\r
ofonod[1659]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
query parsed successfully
ofonod[1659]: PCUI: > AT+CGDCONT=3D?\r
ofonod[1659]: PCUI: < \r\n+CGDCONT:
(1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
(1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
ofonod[1659]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\r\=
n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1659]: PCUI: > AT+CPBS=3D?\r
ofonod[1659]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CSMS=3D1\r
ofonod[1659]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CGREG=3D?\r
ofonod[1659]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CSMS?\r
ofonod[1659]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CGREG=3D2\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+CGAUTO=3D0\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+CGEREP=3D2,1\r
ofonod[1659]: PCUI: < \r\nERROR\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/bluez5.c:bt_register_profile()
Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
ofonod[1659]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CMGF=3D?\r
ofonod[1659]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CPMS=3D?\r
ofonod[1659]: PCUI: < \r\n+CPMS:
("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
ofonod[1659]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CMGF=3D0\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
ofonod[1659]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CNMI=3D?\r
ofonod[1659]: PCUI: < \r\n+CNMI: (0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
ofonod[1659]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
ofonod[1659]: Duplicate EFsdn entries for `Emergency Services'
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/sms.c:sms_restore_tx_queue()
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/push-notification.c:sms_watch()
registered
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/smart-messaging.c:sms_watch() registered
ofonod[1659]: PCUI: > AT+CMGL=3D4\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
ofonod[1659]: PCUI: > AT+CGSMS=3D3\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:get_modem_property()
modem 0x556eaf98 property AlwaysOnline
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:huawei_set_online() modem
0x556eaf98 online
ofonod[1659]: PCUI: > AT+CFUN=3D1\r
ofonod[1659]: PCUI: < \r\n^SIMST:0,0\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:simst_notify() 1
-> 0
ofonod[1659]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:simst_notify() 0
-> 1
ofonod[1659]: PCUI: > AT^SYSINFO\r
ofonod[1659]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG:
2\r\n\r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
status 2
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/modem.c:modem_change_state()
old state: 2, new state: 3
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/plugins/huawei.c:huawei_post_online() 0x556eaf98
ofonod[1659]: PCUI: > AT+CREG=3D?\r
ofonod[1659]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CSCB=3D?\r
ofonod[1659]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CUSD=3D1\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\r\=
n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1659]: PCUI: > AT+CREG=3D2\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556dcfe8
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556ea0f8
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556ea0f8
ofonod[1659]: PCUI: > AT+CSCB=3D0\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI:
272050100413580
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556ea0f8
ofonod[1659]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1659]: PCUI: > AT+CREG?\r
ofonod[1659]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_status_notify()
/huawei_0 status 2 tech -1
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:current_operator_callback()
0x556ea0f8, (nil)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/cbs.c:cbs_location_changed()
2, -1, -1, -1, (null)(null)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/gprs.c:netreg_status_changed()
2
ofonod[1659]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1659]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1659]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1659]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1659]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\r\=
n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1659]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1659]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1659]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1659]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1659]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
ofonod[1659]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1659]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb() No
CPHS MWIS on SIM
ofonod[1659]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\r\=
n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1659]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1659]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1659]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1659]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1659]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/simfs.c:sim_fs_op_read_block()
bufoff: 0, seekoff: 39, toread: 17
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/simfs.c:sim_fs_op_read_block()
bufoff: 0, seekoff: 39, toread: 10
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[1659]: PCUI: > AT+CSCB=3D0\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[1659]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\r\=
n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1659]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
ofonod[1659]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1659]: PCUI: < \r\n^MODE: 5,4\r\n
ofonod[1659]: PCUI: < \r\n^RSSI: 12\r\n\r\n^HCSQ:"WCDMA",38,32,53\r\n
ofonod[1659]: PCUI: < \r\n+CREG: 1,"0040","02C10178"\r\n\r\n^SRVST: 2\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_status_notify()
/huawei_0 status 1 tech 2
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/cbs.c:cbs_location_changed()
1, -1, -1, 2, (null)(null)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/gprs.c:netreg_status_changed()
1
ofonod[1659]: PCUI: > AT+COPS=3D3,2\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+COPS?\r
ofonod[1659]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/network-registration.c:cops_nume=
ric_cb()
Cops numeric got mcc: 272, mnc: 05
ofonod[1659]: PCUI: > AT+CSQ\r
ofonod[1659]: PCUI: < \r\n+CSQ: 12,99\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
csq_cb: 12
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 38
ofonod[1659]: PCUI: > AT+CGATT=3D1\r
ofonod[1659]: PCUI: < \r\nOK\r\n\r\n+CGREG: 1,"0040","02C10178"\r\n
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/gprs.c:gprs_attach_callback()
/huawei_0 error =3D 0
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
status 1
ofonod[1659]: PCUI: > AT+COPS=3D3,0\r
ofonod[1659]: PCUI: < \r\nOK\r\n
ofonod[1659]: PCUI: > AT+COPS?\r
ofonod[1659]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/drivers/atmodem/network-registration.c:cops_cb()
cops_cb: 3 IRL, 272 05 2
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:current_operator_callback()
0x556ea0f8, (nil)
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/cbs.c:cbs_location_changed()
1, -1, -1, 2, 27205
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/cbs.c:cbs_location_changed()
1, 0, 0
ofonod[1659]:  /ofono/1.14-r0/ofono-1.14/src/gprs.c:netreg_status_changed()
1
ofonod[1659]: PCUI: > AT+CGREG?\r
ofonod[1659]: PCUI: < \r\n+CGREG: 2,1,"0040","02C10178"\r\n\r\nOK\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:registration_status_cb() /huawei_0
error 0 status 1
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
status 1
ofonod[1659]: PCUI: < \r\n^RSSI: 9\r\n\r\n^HCSQ:"WCDMA",37,27,45\r\n
ofonod[1659]:
 /ofono/1.14-r0/ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 29


Homam

--===============8428289686379345183==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGk8YnIgY2xlYXI9ImFsbCI+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGhh
dmUgYW4gRTMwMyBIdWF3ZWkgM0cgZG9uZ2xlLiBVc2luZyBkYnVzIGNvbW1hbmRzIChzaW11bGF0
aW5nIHRoZSBQeXRoaW4gdGVzdCBzY3JpcHRzKSwgSSBhbSBhYmxlIHRvIHBvd2VyIG9uIHRoZSBt
b2RlbSBhbmQgZW5hYmxlIHRoZSBjZWxsdWxhciB0ZWNobm9sb2d5LiBIb3dldmVyLCB3aGVuIEkg
cGVyZm9ybSBHZXRTZXJydmljZXMgSSBnZXQgdGhlIGxpc3Qgb2Ygc2VydmljZXMgYnV0IG5vdCB0
aGUgY2VsbHVsYXIgb25lLjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBzaW0gY2FyZCBp
cyBvayBhcyBpdCB3b3JrcyBvbiBvdGhlciBwbGF0Zm9ybXMuIEJlbG93IGlzIHRoZSBsb2cgSSBn
ZXQuIEFueSBoZWxwIGFwcHJlY2lhdGVkLqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2IGRpcj0i
bHRyIj48ZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBvRm9ubyB2ZXJzaW9uIDEuMTQ8L2Rpdj48ZGl2
Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3BsdWdpbi5jOl9f
b2Zvbm9fcGx1Z2luX2luaXQoKaA8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4x
NC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzpwdXNoX25vdGlmaWNh
dGlvbl9pbml0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9u
by0xLjE0L3BsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6c21hcnRfbWVzc2FnaW5nX2luaXQoKaA8
L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2Nk
bWEtcHJvdmlzaW9uLmM6b2Zvbm9fY2RtYV9wcm92aXNpb25fZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDU1NmMxYmIwIG5hbWU6IENETUEgcHJvdmlzaW9uaW5nPC9kaXY+CjxkaXY+b2Zvbm9k
WzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy1wcm92aXNpb24uYzpv
Zm9ub19ncHJzX3Byb3Zpc2lvbl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzFiODAg
bmFtZTogUHJvdmlzaW9uaW5nPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1y
MC9vZm9uby0xLjE0L3BsdWdpbnMvZHVuX2d3X2JsdWV6NS5jOmR1bl9nd19pbml0KCmgPC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvaGFuZHNm
cmVlLWF1ZGlvLmM6b2Zvbm9faGFuZHNmcmVlX2NhcmRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDU1NmMxYTUwPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9u
by0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZjMWE2MCwgbmFtZTogaGZwPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEu
MTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2hlOTEwLmM6aGU5MTBfaW5pdCgpoDwvZGl2PjxkaXY+
b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE5ZTAsIG5hbWU6IGhlOTEw
PC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdp
bnMvY29ubm1hbi5jOmNvbm5tYW5faW5pdCgpoDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9v
Zm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3ByaXZhdGUtbmV0d29yay5jOm9mb25vX3ByaXZh
dGVfbmV0d29ya19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE5YjAsIG5hbWU6IENv
bm5NYW4gUHJpdmF0ZSBOZXR3b3JrPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4x
NC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg1NTZjMTk2MCwgbmFtZTogc2ltOTAwPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTld
OiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE5MTAsIG5hbWU6IHNhbXN1bmc8L2Rpdj48ZGl2
Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zv
bm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxOGMwLCBuYW1lOiBzcGVl
ZHVwY2RtYTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEu
MTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1
NmMxODcwLCBuYW1lOiBzcGVlZHVwPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4x
NC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg1NTZjMTgyMCwgbmFtZTogYWxjYXRlbDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5
XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxN2MwLCBuYW1lOiBpY2VyYTwvZGl2PjxkaXY+
b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE3NzAsIG5hbWU6IGxpbmt0
b3A8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTcy
MCwgbmFtZTogbm9raWFjZG1hPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1y
MC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg1NTZjMTZkMCwgbmFtZTogbm9raWE8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTY4MCwgbmFtZTogdGM2NTwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE1ZjAsIG5hbWU6IHN0ZTwvZGl2Pgo8
ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNTkwLCBuYW1lOiBp
Zng8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNTQw
LCBuYW1lOiBwYWxtcHJlPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YzE0ZjAsIG5hbWU6IG5vdmF0ZWw8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9v
Zm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNGEwLCBuYW1lOiBzaWVycmE8L2Rpdj4KPGRpdj5vZm9u
b2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTQyMCwgbmFtZTogaHVhd2VpPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTNkMCwgbmFt
ZTogenRlPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4x
NC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YzEzNzAsIG5hbWU6IGhzbzwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YzEzMjAsIG5hbWU6IG1ibTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9u
by8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDU1NmMxMmQwLCBuYW1lOiBjYWx5cHNvPC9kaXY+PGRpdj5vZm9ub2Rb
MTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTI4MCwgbmFtZTogd2F2ZWNvbTwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVt
LmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxMjMwLCBuYW1l
OiBnMTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9z
cmMvY2RtYS12b2ljZWNhbGwuYzpvZm9ub19jZG1hX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4NTU2YzExYTAsIG5hbWU6IGNkbWFtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsx
NjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5m
b19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzExYzAsIG5hbWU6IGNkbWFtb2RlbTwv
ZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvY2Rt
YS1jb25ubWFuLmM6b2Zvbm9fY2RtYV9jb25ubWFuX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZjMTFmMCwgbmFtZTogY2RtYW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29m
b25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzExMWMsIG5hbWU6IHBob25lc2ltPC9kaXY+PGRpdj5vZm9u
b2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTE1NCwgbmFtZTogbG9jYWxoZnA8
L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9n
cHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZj
MTEwNCwgbmFtZTogcGhvbmVzaW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0
LXIwL29mb25vLTEuMTQvc3JjL2N0bS5jOm9mb25vX2N0bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YzEwZjAsIG5hbWU6IHBob25lc2ltPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCg
L29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL3Bob25lc2ltLmM6cGFyc2VfY29uZmln
KCkgZmlsZW5hbWUgL2V0Yy9vZm9uby9waG9uZXNpbS5jb25mPC9kaXY+PGRpdj5vZm9ub2RbMTY1
OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzEwYjAsIG5hbWU6IHNwZWVkdXBtb2RlbTwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3ZvaWNl
Y2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBm
NTAsIG5hbWU6IGhmcG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1y
MC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDU1NmMxMDEwLCBuYW1lOiBoZnBtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5
XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZmEwLCBuYW1lOiBoZnBtb2RlbTwvZGl2
PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvY2FsbC12
b2x1bWUuYzpvZm9ub19jYWxsX3ZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YzBmZTAsIG5hbWU6IGhmcG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEu
MTQtcjAvb2Zvbm8tMS4xNC9zcmMvaGFuZHNmcmVlLmM6b2Zvbm9faGFuZHNmcmVlX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTAzMCwgbmFtZTogaGZwbW9kZW08L2Rpdj48ZGl2Pm9m
b25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3NpcmkuYzpvZm9ub19z
aXJpX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTA2MCwgbmFtZTogaGZwbW9kZW08
L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9u
ZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGVj
MCwgbmFtZTogZHVubW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIw
L29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg1NTZjMGVmMCwgbmFtZTogZHVubW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZGYwLCBuYW1lOiBzdGVtb2RlbTwvZGl2
PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5j
Om9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBlNzAs
IG5hbWU6IHN0ZW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBlNDAsIG5hbWU6IHN0ZW1vZGVtPC9kaXY+PGRp
dj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwu
YzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwY2IwLCBu
YW1lOiBpZnhtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29m
b25vLTEuMTQvc3JjL2F1ZGlvLXNldHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZDAwLCBuYW1lOiBpZnhtb2RlbTwvZGl2PjxkaXY+
b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGlu
Z3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YzBkMjAsIG5hbWU6IGlmeG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEu
MTQtcjAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBkNTAsIG5hbWU6IGlmeG1vZGVtPC9kaXY+PGRpdj5vZm9u
b2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9zdGsuYzpvZm9ub19zdGtf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZDgwLCBuYW1lOiBpZnhtb2RlbTwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2N0bS5j
Om9mb25vX2N0bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBkYjAsIG5hbWU6IGlm
eG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0
L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZjMGM0MCwgbmFtZTogaHNvbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zv
bm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3Nl
dHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGM2MCwgbmFtZTogaHNvbW9k
ZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3Jj
L2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1
NmMwYmIwLCBuYW1lOiBtYm1tb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8x
LjE0LXIwL29mb25vLTEuMTQvc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6IDB4NTU2YzBiZTAsIG5hbWU6IG1ibW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06
IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9sb2NhdGlvbi1yZXBvcnRpbmcuYzpvZm9u
b19sb2NhdGlvbl9yZXBvcnRpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwYzAw
LCBuYW1lOiBtYm1tb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIw
L29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NTU2YzBiMjAsIG5hbWU6IGNhbHlwc29tb2RlbTwvZGl2PjxkaXY+b2Zv
bm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6b2Zvbm9fc3Rr
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGI3MCwgbmFtZTogY2FseXBzb21vZGVt
PC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMv
dXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwYTAwLCBu
YW1lOiBodWF3ZWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg1NTZjMGEyMCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj4KPGRpdj5vZm9u
b2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9hdWRpby1zZXR0aW5ncy5j
Om9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGE3
MCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0
LXIwL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3Nf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwYWIwLCBuYW1lOiBodWF3ZWltb2RlbTwv
ZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2dw
cnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMw
YTkwLCBuYW1lOiBodWF3ZWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEu
MTQtcjAvb2Zvbm8tMS4xNC9zcmMvY2RtYS1uZXRyZWcuYzpvZm9ub19jZG1hX25ldHJlZ19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBhZTAsIG5hbWU6IGh1YXdlaW1vZGVtPC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5j
Om9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA5NzAs
IG5hbWU6IGljZXJhbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIw
L29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwOWEwLCBuYW1lOiBpY2VyYW1vZGVtPC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8t
c2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4NTU2YzA5MjAsIG5hbWU6IHp0ZW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zv
bm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDhlMCwgbmFtZTogc3dtb2RlbTwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRp
bmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1
NmMwODkwLCBuYW1lOiBud21vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4x
NC1yMC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNmIwLCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+b2Zv
bm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19k
ZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDc2MCwgbmFtZTogYXRtb2Rl
bTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMv
Y2FsbC1iYXJyaW5nLmM6b2Zvbm9fY2FsbF9iYXJyaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg1NTZjMDcxMCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9v
Zm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2NhbGwtZm9yd2FyZGluZy5jOm9mb25vX2NhbGxf
Zm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA0ODAsIG5hbWU6IGF0
bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQv
c3JjL2NhbGwtbWV0ZXIuYzpvZm9ub19jYWxsX21ldGVyX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg1NTZjMDRiMCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9v
Zm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2NhbGwtc2V0dGluZ3MuYzpvZm9ub19jYWxsX3Nl
dHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDM5MCwgbmFtZTogYXRtb2Rl
bTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMv
cGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1
NTZjMDczMCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8x
LjE0LXIwL29mb25vLTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg1NTZjMDY4MCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTld
OiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvc21zLmM6b2Zvbm9fc21zX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDQwMCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2Pm9m
b25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3Np
bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA1NjAsIG5hbWU6IGF0bW9kZW08L2Rp
dj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3NpbS5j
Om9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA1YTgsIG5hbWU6IGF0
bW9kZW0tbm9lZjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25v
LTEuMTQvc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YzA2NjAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0
LXIwL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDU1NmMwNTAwLCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE2
NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6b2Zvbm9fY2JzX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDQ2MCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+
b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvY2FsbC12b2x1bWUu
YzpvZm9ub19jYWxsX3ZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA3OTAs
IG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9v
Zm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4NTU2YzA3ZDAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9u
by8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwODAwLCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+
b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvc2ltLWF1dGguYzpv
Zm9ub19zaW1fYXV0aF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA4MjAsIG5hbWU6
IGF0bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEu
MTQvc3JjL2duc3MuYzpvZm9ub19nbnNzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZj
MDg0MCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0
LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDU1NmMwMWIwLCBuYW1lOiBnb2JpPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZjgwLCBuYW1lOiBxbWltb2RlbTwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpv
Zm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZmYwLCBuYW1lOiBx
bWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4x
NC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg1NTZiZmZhMCwgbmFtZTogcW1pbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDU1NmMwMDIwLCBuYW1lOiBxbWltb2RlbS1sZWdhY3k8L2Rpdj48ZGl2
Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25v
X3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAwNzAsIG5hbWU6IHFtaW1vZGVt
PC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMv
c21zLmM6b2Zvbm9fc21zX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDBjMCwgbmFt
ZTogcW1pbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25v
LTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1
NTZjMDBlMCwgbmFtZTogcW1pbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8v
MS4xNC1yMC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6IDB4NTU2YzAxMDAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTY1
OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250
ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDEyMCwgbmFtZTogcW1pbW9kZW08
L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9y
YWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg1NTZjMDE0MCwgbmFtZTogcW1pbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTog
oC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2xvY2F0aW9uLXJlcG9ydGluZy5jOm9mb25v
X2xvY2F0aW9uX3JlcG9ydGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAxNzAs
IG5hbWU6IHFtaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YmZmMmMsIG5hbWU6IHU4NTAwPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zv
bm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZjEwLCBuYW1lOiB1ODUwMDwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9k
ZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZWMwLCBuYW1lOiBuOTAwPC9kaXY+
PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmU3MCwgbmFtZTog
aXNpdXNiPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4x
NC9zcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1
NTZiZmI5MCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8x
LjE0LXIwL29mb25vLTEuMTQvc3JjL3Bob25lYm9vay5jOm9mb25vX3Bob25lYm9va19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZiODAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXY+
b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9m
b25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZiYjAsIG5hbWU6IGlz
aW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0
L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDU1NmJmYmUwLCBuYW1lOiBpc2ltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9v
Zm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NTU2YmZjMzAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2Rb
MTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9jYnMuYzpvZm9ub19jYnNfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmYzUwLCBuYW1lOiBpc2ltb2RlbTwvZGl2Pgo8
ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3NpbS5jOm9m
b25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZjNzAsIG5hbWU6IGlzaW1v
ZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3Ny
Yy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZjYzAs
IG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvY2FsbC1mb3J3YXJkaW5nLmM6b2Zvbm9fY2FsbF9mb3J3YXJkaW5nX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmNlMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48
ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2NhbGwtc2V0
dGluZ3MuYzpvZm9ub19jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1
NTZiZmQwMCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8v
MS4xNC1yMC9vZm9uby0xLjE0L3NyYy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZDMwLCBuYW1lOiBpc2ltb2RlbTwvZGl2
PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvY2FsbC1t
ZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJm
ZDUwLCBuYW1lOiBpc2ltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0
LXIwL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3Nf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZDgwLCBuYW1lOiBpc2ltb2RlbTwvZGl2
PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5j
Om9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZGIwLCBuYW1lOiBp
c2ltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEu
MTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDU1NmJmZGQwLCBuYW1lOiBpc2ltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29m
b25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvYXVkaW8tc2V0dGluZ3MuYzpvZm9ub19hdWRpb19z
ZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZkZjAsIG5hbWU6IGlzaW1v
ZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9z
cmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmUwMCwg
bmFtZTogd2dtb2RlbTIuNTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnVkZXZfc3RhcnQoKaA8L2Rpdj48ZGl2Pm9mb25v
ZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzplbnVt
ZXJhdGVfZGV2aWNlcygpoDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIw
L29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVs
bCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8t
MS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2IgWzBiZGE6ODE3Nl08
L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcnRsODE5MmN1IFsobnVsbCk6KG51bGwpXTwv
ZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcnRsODE5MmN1IFswYmRhOjgxNzZdPC9kaXY+
PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pgpv
Zm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6
Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMTJkMToxMDAxXTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTld
OiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9k
ZXZpY2UoKSBvcHRpb24gWyhudWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rldmlj
ZSgpIG9wdGlvbiBbMTJkMToxMDAxXTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8x
LjE0LXIwL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZp
Y2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xPC9kaXY+PGRpdj5vZm9ub2Rb
MTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2Rl
dmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8y
LTE6MS4wL3R0eVVTQjAvdHR5L3R0eVVTQjA8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zv
bm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYv
dHR5VVNCMCAoaHVhd2VpKSAyNTUvMjU1LzI1NSBbMDBdID09Jmd0OyAobnVsbCkgKG51bGwpPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMv
dWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbKG51bGwpOihudWxsKV08L2Rpdj4K
PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbMTJkMToxMDAxXTwvZGl2PjxkaXY+b2Zv
bm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFk
ZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8y
LTE8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gt
ZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4xL3R0eVVTQjEvdHR5L3R0eVVTQjE8L2Rpdj48ZGl2
Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcu
YzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IxIChodWF3ZWkpIDI1NS8yNTUvMjU1IFswMV0gPT0m
Z3Q7IChudWxsKSAobnVsbCk8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1y
MC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBb
KG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uIFsxMmQx
OjEwMDFdPC9kaXY+PGRpdj4Kb2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFu
Z294LWVoY2ktaGNkLTEvdXNiMi8yLTE8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8x
LjE0LXIwL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZp
Y2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjIvdHR5VVNCMi90
dHkvdHR5VVNCMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25v
LTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IyIChodWF3ZWkp
IDI1NS8yNTUvMjU1IFswMl0gPT0mZ3Q7IChudWxsKSAobnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFsx
NjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjcmVhdGVf
bW9kZW0oKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8
L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdp
bnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCkgZHJpdmVyPWh1YXdlaTwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9jcmVhdGUoKSBuYW1lOiAobnVsbCksIHR5cGU6IGh1YXdlaTwvZGl2PjxkaXY+b2Zvbm9kWzE2
NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1
YXdlaSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTwv
ZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjAgMjU1LzI1NS8yNTUgMDAgKG51
bGwpPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IxIDI1NS8yNTUvMjU1IDAx
IChudWxsKTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEu
MTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjIgMjU1LzI1NS8y
NTUgMDIgKG51bGwpPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9u
by0xLjE0L3BsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgbWRtPS9kZXYvdHR5VVNCMCBw
Y3VpPS9kZXYvdHR5VVNCMiBkaWFnPShudWxsKSBxbWk9KG51bGwpIG5ldD0obnVsbCk8L2Rpdj4K
PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
OnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWFmOTggcHJvcGVydHkgRGV2aWNlPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWFmOTggcHJvcGVydHkgTW9kZW08
L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9t
b2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWFmOTggcHJvcGVydHkgUGN1
aTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMv
bW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDU1NmVhZjk4IHByb3BlcnR5IERp
YWc8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWFmOTggcHJvcGVydHkg
TmV0d29ya0ludGVyZmFjZTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZWdpc3RlcigpIDB4NTU2ZWFmOTg8
L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdp
bnMvaHVhd2VpLmM6aHVhd2VpX3Byb2JlKCkgMHg1NTZlYWY5ODwvZGl2PjxkaXY+b2Zvbm9kWzE2
NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzplbWl0X21vZGVtX2Fk
ZGVkKCkgMHg1NTZlYWY5ODwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpjYWxsX21vZGVtd2F0Y2hlcygpIDB4NTU2ZWFmOTggYWRk
ZWQ6MTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQv
cGx1Z2lucy9oZnBfYWdfYmx1ZXo1LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg1NTZlYWY5OCwg
YWRkZWQ6IDE8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEu
MTQvcGx1Z2lucy9kdW5fZ3dfYmx1ZXo1LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg1NTZlYWY5
OCwgYWRkZWQ6IDE8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9u
by0xLjE0L3BsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg1
NTZlYWY5OCwgYWRkZWQ6IDE8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIw
L29mb25vLTEuMTQvcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOm1vZGVtX3dhdGNoKCkgbW9k
ZW06IDB4NTU2ZWFmOTgsIGFkZGVkOiAxPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25v
LzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9lbmFibGUoKSAweDU1
NmVhZjk4PC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0
L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZWFmOTggcHJvcGVy
dHkgTW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEu
MTQvcGx1Z2lucy9odWF3ZWkuYzpvcGVuX2RldmljZSgpIE1vZGVtIC9kZXYvdHR5VVNCMDwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVt
LmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZlYWY5OCBwcm9wZXJ0eSBQY3VpPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMv
aHVhd2VpLmM6b3Blbl9kZXZpY2UoKSBQY3VpIC9kZXYvdHR5VVNCMjwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiBNb2RlbTogJmd0OyBBVEUwICtDTUVFPTFccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5
XTogUENVSTogJmd0OyBBVEUwICtDTUVFPTFccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBNb2Rl
bTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJc
bk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUSVxyPC9kaXY+PGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbk1hbnVmYWN0dXJlcjogaHVhd2VpXHJcbk1v
ZGVsOiBFMzAzXHJcblJldmlzaW9uOiAyMi4zMTguMDUuMDAuMDBcclxuSU1FSTogODYyNTY2MDIw
MDA1Njk3XHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VTXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5v
Zm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVReUkZTV0lUQ0g9P1xyPC9kaXY+PGRpdj5vZm9ub2Rb
MTY1OV06IFBDVUk6ICZsdDsgXHJcbkVSUk9SXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQ
Q1VJOiAmZ3Q7IEFUK0NGVU49MVxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsg
XHJcbl5TSU1TVDowLDBcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJc
bk9LXHJcblxyXG5eU0lNU1Q6MSwwXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9u
by8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX2VuYWJsZSgpoDwvZGl2
PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1
YXdlaS5jOnNpbXN0X25vdGlmeSgpIDI1NSAtJmd0OyAxPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZndDsgQVReU1lTSU5GT1xyPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAm
bHQ7IFxyXG4rQ1JFRzogMlxyXG5cclxuK0NHUkVHOiAyXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2
NTldOiBQQ1VJOiAmbHQ7IFxyXG5eU1lTSU5GTzowLDMsMCwwLDEsMCwwXHJcblxyXG5PS1xyXG48
L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lu
cy9odWF3ZWkuYzpzeXNpbmZvX2VuYWJsZV9jYigpIDEgLSZndDsgMTwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNjU5XTogTW9kZW06ICZndDsgQVQmYW1wO0MwXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTog
UENVSTogJmd0OyBBVCZhbXA7QzBccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBNb2RlbTogJmx0
OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBNb2RlbTogJmd0OyBBVCtDU0NTPSZxdW90O0dTTSZx
dW90O1xyPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NTQ1M9JnF1b3Q7
R1NNJnF1b3Q7XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogTW9kZW06ICZsdDsgXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2
Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVF5VMkRJQUc/XHI8L2Rpdj48ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmx0OyBcclxuXlUyRElBRzogMTE5XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVReR0VUUE9SVE1PREVccjwvZGl2PjxkaXY+b2Zv
bm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG5eR0VUUE9SVE1PREU6IFRZUEU6IFdDRE1BOiBodWF3
ZWksXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVF5V
U1NETU9ERT0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuXlVTU0RN
T0RFOiAoMC0xKVxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAm
Z3Q7IEFUXkRJQUxNT0RFPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxy
XG5eRElBTE1PREU6ICgwLTIpLCgwLTI1NSlcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiBQQ1VJOiAmZ3Q7IEFUXkNWT0lDRT0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTog
UENVSTogJmx0OyBcclxuXkNWT0lDRTogKDApXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9u
b2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ0ZVTj01XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTog
UENVSTogJmx0OyBcclxuK0NSRUc6IDBcclxuXHJcbitDR1JFRzogMFxyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuT0tcclxuXHJcbl5NT0RFOiAwLDBcclxuPC9kaXY+
PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvaHVh
d2VpLmM6Y2Z1bl9vZmZsaW5lKCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEu
MTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3Rh
dGU6IDAsIG5ldyBzdGF0ZTogMTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQt
cjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wcmVfc2ltKCkgMHg1NTZlYWY5
ODwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUXlVTU0RNT0RFP1xyPC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6
b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZGNmZTg8L2Rpdj48ZGl2Pm9mb25vZFsx
NjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRf
c3RhdGVfd2F0Y2goKSAweDU1NmRjZmU4PC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8v
MS4xNC1yMC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkg
MHg1NTZkY2ZlODwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuXlVTU0RN
T0RFOiAxXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBB
VF5ESUFMTU9ERT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG5eRElB
TE1PREU6MywyXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0
OyBBVF5DVk9JQ0U/XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbl5D
Vk9JQ0U6IDEsIDgwMDAsIDE2LCAyMFxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1
OV06IFZvaWNlIGNoYW5uZWw6IDgwMDAgSHosIDE2IGJpdHMsIDIwbXMgcGVyaW9kPC9kaXY+PGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrR0NBUFxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1
OV06IFBDVUk6ICZsdDsgXHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VTXHJcblxyXG5PS1xyXG48L2Rp
dj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMTIyNTgsMCwwLDI1
NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwm
cXVvdDs2MjFDODIwMjQxMjE4MzAyMkZFMkE1MDM4MDAxNzE4QTAxMDU4QjAzMkYwNjAzODAwMjAw
MEE4ODAxMTAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29m
b25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZv
X2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQ
Q1VJOiAmZ3Q7IEFUXkREU0VURVg9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZs
dDsgXHJcbl5ERFNFVEVYOiAoMilcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTld
OiBQQ1VJOiAmZ3Q7IEFUK0NHTUlccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7
IFxyXG5odWF3ZWlcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTog
Jmd0OyBBVCtDUlNNPTE3NiwxMjI1OCwwLDAsMTBccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7OTg1MzAzMDUwMTA3MDg1MzA1RjYmcXVv
dDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDEwPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQt
cjAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9m
ZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxMDwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJ
OiAmZ3Q7IEFUK0NHTU1ccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG5F
MzAzXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQr
Q1JTTT0xOTIsMjg0MjEsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyNkYwNUE1MDM4MDAxNzE4
QTAxMDU4QjAzNkYwNjA0ODAwMjAwMEE4ODAxMTAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pjxk
aXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NHTVJccjwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4yMi4zMTguMDUuMDAuMDBcclxuXHJcbk9LXHJcbjwvZGl2
PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2LDI4NDIxLDAsMCwxMFxy
PC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVv
dDs2NTZFRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zv
bm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDEwPC9kaXY+PGRpdj5v
Zm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9m
c19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPC9k
aXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NHU05ccjwvZGl2PjxkaXY+b2Zv
bm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG44NjI1NjYwMjAwMDU2OTdcclxuXHJcbk9LXHJcbjwv
ZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDEyMDM3LDAsMCwy
NTVccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7NjIxQzgyMDI0MTIxODMwMjJGMDVBNTAzODAwMTcxOEEwMTA1OEIwMzJGMDYwNDgwMDIw
MDBBODgwMTI4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2lu
Zm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTog
UENVSTogJmd0OyBBVCtDUlNNPTE3NiwxMjAzNywwLDAsMTBccjwvZGl2PjxkaXY+b2Zvbm9kWzE2
NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjU2RUZGRkZGRkZGRkZGRkZG
RkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8x
LjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
IGNyc21fcmVhZF9jYjogOTAsIDAwLCAxMDwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25v
LzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigp
IGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxMDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5
XTogUENVSTogJmd0OyBBVCtDUElOP1xyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZs
dDsgXHJcbitDUElOOiBSRUFEWVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06
IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcGlu
X2NiKCkgY3JzbV9waW5fY2I6IFJFQURZPC9kaXY+PGRpdj4Kb2Zvbm9kWzE2NTldOiCgL29mb25v
LzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfcGluX3JldHJpZXNf
cXVlcnkoKaA8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVF5DUElOP1xyPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbl5DUElOOiBSRUFEWSwsMTAsMywx
MCwzXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIw
L29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkg
Y291bnRlciBpZD05LCB2YWw9MTA8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4x
NC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzpodWF3ZWlfY3Bpbl9jYigpIHJl
dHJ5IGNvdW50ZXIgaWQ9MSwgdmFsPTM8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8x
LjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkg
cmV0cnkgY291bnRlciBpZD0xMSwgdmFsPTEwPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29m
b25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5f
Y2IoKSByZXRyeSBjb3VudGVyIGlkPTQsIHZhbD0zPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1OTAsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1
OV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tc
clxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NTg5
LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGQURBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYw
NjgwMDIwMDA0ODgwMTE4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5
XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Ny
c21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2Pgo8ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODU4OSwwLDAsNFxyPC9kaXY+PGRpdj5vZm9u
b2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMiZxdW90
O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3Jl
YWRfY2I6IDkwLCAwMCwgNDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIw
L29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6
IDAsIGRhdGFvZmY6IDAsIHRvY29weTogNDwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTkyLDI4NDM4LDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTA2LDEzMCwmcXVvdDsmcXVvdDtcclxuXHJcbk9LXHJcbjwv
ZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQ3MiwwLDAs
MjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCww
LCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RjM4QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDI4MDAy
MDAwQTg4MDEyMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2lu
Zm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg0NzIsMCwwLDEwXHI8L2Rpdj48ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzdFRUUxMTFDMjdGNjU5MDAw
MDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8x
LjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
IGNyc21fcmVhZF9jYjogOTAsIDAwLCAxMDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9u
by8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2Io
KSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTA8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5
XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODUwMiwwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25v
ZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgz
MDI2RjU2QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDc4MDAyMDAwMTg4MDEyOCZxdW90O1xyXG5c
clxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8t
MS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2Ni
OiA5MCwgMDAsIDMwPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ1JTTT0x
NzYsMjg1MDIsMCwwLDFccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTogMTQ0LDAsJnF1b3Q7MDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxPC9kaXY+PGRpdj5vZm9u
b2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19v
cF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDE8L2Rpdj4K
PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ0lNSVxyPC9kaXY+PGRpdj5vZm9ub2Rb
MTY1OV06IFBDVUk6ICZsdDsgXHJcbjI3MjA1MDEwMDQxMzU4MFxyXG5cclxuT0tcclxuPC9kaXY+
PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRt
b2RlbS9zaW0uYzphdF9jaW1pX2NiKCkgY2ltaV9jYjogMjcyMDUwMTAwNDEzNTgwPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpt
b2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3RhdGU6IDEsIG5ldyBzdGF0ZTogMjwvZGl2PjxkaXY+
b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5j
Omh1YXdlaV9wb3N0X3NpbSgpIDB4NTU2ZWFmOTg8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9v
Zm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0
X2dwcnNfY29udGV4dF9wcm9iZSgpoDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogTWlzc2luZyBz
dXBwb3J0IGZvciBUVU4vVEFQIGRldmljZXM8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9u
by8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9k
ZW0gMHg1NTZlYWY5OCBwcm9wZXJ0eSBBbHdheXNPbmxpbmU8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5
XTogUENVSTogJmd0OyBBVCtDUkM9MVxyPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAm
bHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDTElQ
PTFccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48
ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDT0xQPTFccjwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBD
VUk6ICZndDsgQVQrQ0NXQT0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBc
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0x
LjE0L2RyaXZlcnMvaHVhd2VpbW9kZW0vdm9pY2VjYWxsLmM6aHVhd2VpX3ZvaWNlY2FsbF9pbml0
aWFsaXplZCgpIHJlZ2lzdGVyaW5nIHRvIG5vdGlmaWNhdGlvbnM8L2Rpdj4KPGRpdj5vZm9ub2Rb
MTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRk
X3N0YXRlX3dhdGNoKCkgMHg1NTZkY2ZlODwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25v
LzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2JsdWV6NS5jOmJ0X3JlZ2lzdGVyX3Byb2ZpbGUo
KSBCbHVldG9vdGg6IFJlZ2lzdGVyaW5nIDAwMDAxMTFmLTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYiAoaGZwX2FnKSBwcm9maWxlPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7
IEFUXkNWT0lDRT0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuXkNW
T0lDRTogKDApXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0
OyBBVCtDU0NTPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1ND
UzogKCZxdW90O0lSQSZxdW90OywmcXVvdDtVQ1MyJnF1b3Q7LCZxdW90O0dTTSZxdW90Oylcclxu
XHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVF5TWVNDRkc9
P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbl5TWVNDRkc6ICgyLDEz
LDE0LDE2KSwoMC0zKSwoKDIwMDAwMDA0MDAzODAsJnF1b3Q7R1NNOTAwL0dTTTE4MDAvV0NETUE5
MDAvV0NETUEyMTAwJnF1b3Q7KSwoMjgwMDAwLCZxdW90O0dTTTg1MC9HU00xOTAwJnF1b3Q7KSwo
M2ZmZmZmZmYsJnF1b3Q7QWxsIGJhbmRzJnF1b3Q7KSksKDAtMiksKDAtNClcclxuXHJcbk9LXHJc
bjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDU01TPT9ccjwvZGl2Pjxk
aXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NNUzogKDAsMSlcclxuXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc21zLmM6YXRfY3Ntc19xdWVyeV9jYigpIENTTVMgcXVlcnkgcGFyc2VkIHN1
Y2Nlc3NmdWxseTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDR0RDT05U
PT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ0dEQ09OVDogKDEt
MTEpLCZxdW90O0lQJnF1b3Q7LCwsKDAtMiksKDAtMyksKDAsMSksKDAsMSlcclxuK0NHRENPTlQ6
ICgxLTExKSwmcXVvdDtQUFAmcXVvdDssLCwoMC0yKSwoMC0zKSwoMCwxKSwoMCwxKVxyXG5cclxu
XHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE5
MiwyODQ4MCwwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUmVnaXN0ZXJQcm9maWxl
KCkgcmVwbGllZCBhbiBlcnJvcjogb3JnLmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuU3Bhd24uQ2hp
bGRFeGl0ZWQsIExhdW5jaCBoZWxwZXIgZXhpdGVkIHdpdGggdW5rbm93biByZXR1cm4gY29kZSAx
PC9kaXY+PGRpdj4Kb2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1
b3Q7NjIxRTgyMDU0MjIxMDAyMjA2ODMwMjZGNDBBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgw
MDIwMENDODgwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2lu
Zm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzI8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZndDsgQVQrQ1BCUz0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0
OyBcclxuK0NQQlM6ICgmcXVvdDtTTSZxdW90OywmcXVvdDtFTiZxdW90OywmcXVvdDtPTiZxdW90
OywmcXVvdDtGRCZxdW90OylcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQ
Q1VJOiAmZ3Q7IEFUK0NTTVM9MVxyPC9kaXY+PGRpdj4Kb2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7
IFxyXG4rQ1NNUzogMSwxLDFcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQ
Q1VJOiAmZ3Q7IEFUK0NHUkVHPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7
IFxyXG4rQ0dSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTog
UENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCwxLDQsMzRccjwvZGl2Pgo8ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzRENzkyMDRFNzU2RDYyNjU3
MkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYwNzkxNTM4MzEzOTc3ODQ4RkZGRkZGRkZGRkZGJnF1b3Q7
XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVh
ZF9jYjogOTAsIDAwLCAzNDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtD
U01TP1xyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDU01TOiAxLDEs
MSwxXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtD
R1JFRz0yXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuT0tcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ0dBVVRPPTBccjwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1
OV06IFBDVUk6ICZndDsgQVQrQ0dFUkVQPTIsMVxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBD
VUk6ICZsdDsgXHJcbkVSUk9SXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEu
MTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2JsdWV6NS5jOmJ0X3JlZ2lzdGVyX3Byb2ZpbGUoKSBC
bHVldG9vdGg6IFJlZ2lzdGVyaW5nIDAwMDAxMTAzLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRm
YiAoZHVuX2d3KSBwcm9maWxlPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTc4LDI4NDgwLDIsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxu
PC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MzQ8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ01HRj0/XHI8L2Rpdj48
ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NNR0Y6ICgwLDEpXHJcblxyXG5PS1xy
XG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCwz
LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0
LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2PjxkaXY+b2Zv
bm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NQTVM9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZsdDsgXHJcbitDUE1TOiAoJnF1b3Q7U00mcXVvdDssJnF1b3Q7TUUmcXVvdDspLCgm
cXVvdDtTTSZxdW90OywmcXVvdDtNRSZxdW90OyksKCZxdW90O1NNJnF1b3Q7LCZxdW90O01FJnF1
b3Q7KVxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTc4LDI4NDgwLDQsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFJlZ2lzdGVy
UHJvZmlsZSgpIHJlcGxpZWQgYW4gZXJyb3I6IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLlNw
YXduLkNoaWxkRXhpdGVkLCBMYXVuY2ggaGVscGVyIGV4aXRlZCB3aXRoIHVua25vd24gcmV0dXJu
IGNvZGUgMTwvZGl2PjxkaXY+Cm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0
NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25v
ZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2Pgo8ZGl2Pm9m
b25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDTUdGPTBccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTld
OiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0
OyBBVCtDUlNNPTE3OCwyODQ4MCw1LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9L
XHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAs
IDAwLCAzNDwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NQTVM9JnF1b3Q7
TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDtccjwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BNUzogMCwyMCwwLDIwLDAsMjBcclxuXHJcbk9LXHJc
bjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCw2
LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0
LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+CjxkaXY+b2Zv
bm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NOTUk9P1xyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZsdDsgXHJcbitDTk1JOiAoMC0yKSwoMC0zKSwoMCwyKSwoMC0yKSwoMCwxKVxyXG5c
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0x
LjE0L2RyaXZlcnMvYXRtb2RlbS9zbXMuYzpidWlsZF9jbm1pX3N0cmluZygpoDwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDTk1JPTEsMSwyLDEsMFxyPC9kaXY+PGRpdj5v
Zm9ub2RbMTY1OV06IER1cGxpY2F0ZSBFRnNkbiBlbnRyaWVzIGZvciBgRW1lcmdlbmN5IFNlcnZp
Y2VzJiMzOTs8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuT0tcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9zbXMu
YzpzbXNfcmVzdG9yZV90eF9xdWV1ZSgpoDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9u
by8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOnNtc193YXRj
aCgpIHJlZ2lzdGVyZWQ8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29m
b25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzpzbXNfd2F0Y2goKSByZWdpc3RlcmVk
PC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ01HTD00XHI8L2Rpdj4KPGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2
NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc21zLmM6YXRf
Y21nbF9kb25lKCmgPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ0dTTVM9
M1xyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2Pgo8
ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZlYWY5OCBwcm9wZXJ0eSBBbHdheXNPbmxp
bmU8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1
Z2lucy9odWF3ZWkuYzpodWF3ZWlfc2V0X29ubGluZSgpIG1vZGVtIDB4NTU2ZWFmOTggb25saW5l
PC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NGVU49MVxyPC9kaXY+PGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbl5TSU1TVDowLDBcclxuPC9kaXY+PGRpdj5v
Zm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6
c2ltc3Rfbm90aWZ5KCkgMSAtJmd0OyAwPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZs
dDsgXHJcbk9LXHJcblxyXG5eU0lNU1Q6MSwwXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTog
oC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpzaW1zdF9ub3RpZnko
KSAwIC0mZ3Q7IDE8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVF5TWVNJTkZP
XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSRUc6IDJcclxuXHJc
bitDR1JFRzogMlxyXG5cclxuXlNZU0lORk86MCwzLDAsMCwxLDAsMFxyXG5cclxuT0tcclxuPC9k
aXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvZ3By
cy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9odWF3ZWlfMCBzdGF0dXMgMjwvZGl2Pjxk
aXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdl
aS5jOnN5c2luZm9fb25saW5lX2NiKCkgMSAtJmd0OyAxPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06
IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0
ZSgpIG9sZCBzdGF0ZTogMiwgbmV3IHN0YXRlOiAzPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCg
L29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wb3N0X29u
bGluZSgpIDB4NTU2ZWFmOTg8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtD
UkVHPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JFRzogKDAt
MilcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NT
Q0I9P1xyPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NDQjooMCwx
KVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ1VT
RD0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+
PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTgsMCwwLDI1NVxy
PC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1
b3Q7NjIxRTgyMDU0MjIxMDAwNjA1ODMwMjZGQ0FBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgw
MDIwMDFFODgwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2lu
Zm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzI8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZndDsgQVQrQ1JFRz0yXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0
OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9u
by0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3Nwbl93YXRjaCgpIDB4NTU2ZGNmZTg8L2Rp
dj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL25ldHdv
cmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCkgMHg1NTZlYTBmODwvZGl2Pgo8
ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL25ldHdvcmsu
YzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCkgMHg1NTZlYTBmODwvZGl2PjxkaXY+
b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9MFxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1
OV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25v
LzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2dvdF9pbXNpKCkgR290IElNU0k6IDI3
MjA1MDEwMDQxMzU4MDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29m
b25vLTEuMTQvc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCkg
MHg1NTZlYTBmODwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4
LDI4NjE4LDEsNCw2XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NS
U006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8L2Rpdj48
ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUkVHP1xyPC9kaXY+PGRpdj5vZm9ub2Rb
MTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAyLDJcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpv
Zm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgpIC9odWF3ZWlfMCBzdGF0dXMgMiB0ZWNoIC0xPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9uZXR3
b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4NTU2ZWEwZjgsIChuaWwpPC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6
Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAyLCAtMSwgLTEsIC0xLCAobnVsbCkobnVsbCk8L2Rpdj48
ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2dwcnMuYzpu
ZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZn
dDsgQVQrQ1JTTT0xNzgsMjg2MTgsMiw0LDZccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENV
STogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xyXG5cclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkw
LCAwMCwgNjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4
NjE4LDMsNCw2XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUlNN
OiAxNDQsMCwmcXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+
b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8L2Rpdj48ZGl2
Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOCw0LDQsNlxyPC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAw
MDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9v
Zm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVh
ZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsNSw0LDZccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5
XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRf
Y2I6IDkwLCAwMCwgNjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTkyLDI4NjE3LDAsMCwyNTVccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBc
clxuK0NSU006IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMDUwNTgzMDI2RkM5QTUwMzgwMDE3
MThBMDEwNThCMDM2RjA2MDI4MDAyMDAxOTg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pjxk
aXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDEsNCw1XHI8
L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90
OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCg
L29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsMiw0LDVccjwvZGl2PjxkaXY+b2Zvbm9kWzE2
NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRf
Y2I6IDkwLCAwMCwgNTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNN
PTE3OCwyODYxNywzLDQsNVxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJc
bitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48
ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA1PC9kaXY+
CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDQsNCw1XHI8
L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90
OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCg
L29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsNSw0LDVccjwvZGl2PjxkaXY+b2Zvbm9kWzE2
NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRf
Y2I6IDkwLCAwMCwgNTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNN
PTE5MiwyODQzMywwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBc
clxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL21lc3NhZ2Utd2FpdGlu
Zy5jOm13X2NwaHNfbXdpc19yZWFkX2NiKCkgTm8gQ1BIUyBNV0lTIG9uIFNJTTwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxOSwwLDAsMjU1XHI8L2Rp
dj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYy
MUU4MjA1NDIyMTAwMTAwNTgzMDI2RkNCQTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDU4MDAyMDA1
MDg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25v
LzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2Ni
KCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJ
OiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDEsNCwxNlxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3Jl
YWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMiw0LDE2XHI8L2Rpdj48ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGMDBGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5
XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Ny
c21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjwvZGl2Pgo8ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOSwzLDQsMTZccjwvZGl2PjxkaXY+b2Zv
bm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE2PC9kaXY+CjxkaXY+b2Zv
bm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDQsNCwxNlxyPC9kaXY+PGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRjAwRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5v
Zm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksNSw0LDE2XHI8L2Rp
dj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZG
MDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48
ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL3NpbWZz
LmM6c2ltX2ZzX29wX3JlYWRfYmxvY2soKSBidWZvZmY6IDAsIHNlZWtvZmY6IDM5LCB0b3JlYWQ6
IDE3PC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3Ny
Yy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLCBzZWVrb2ZmOiAzOSwg
dG9yZWFkOiAxMDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL2Nicy5jOmF0X2Nic19zZXRfdG9waWNzKCmgPC9kaXY+PGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ1NDQj0wXHI8L2Rpdj48ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6
ICZndDsgQVQrQ1NDQj0wLCZxdW90OzAsNTAsMjE0LDQzNTItNDM1NiZxdW90O1xyPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQzNywwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9m
b25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJc
blxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE5
MiwyODYxNSwwLDAsMjU1XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJc
bitDUlNNOiAxNDQsMCwmcXVvdDs2MjFFODIwNTQyMjEwMDIyMDU4MzAyNkZDN0E1MDM4MDAxNzE4
QTAxMDU4QjAzNkYwNjAyODAwMjAwQUE4ODAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2
Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMjwvZGl2Pgo8
ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwxLDQsMzRccjwv
ZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7
NEQ2MTY5NkNGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRjA3OTE1MzgzMzMzMzEzMTdG
RkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCg
L29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTld
OiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDIsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2Rb
MTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90
O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3Jl
YWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQr
Q1JTTT0xNzgsMjg2MTUsMyw0LDM0XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmx0
OyBcclxuK0NSU006IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48
L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAz
NDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSw0
LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0
LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+CjxkaXY+b2Zv
bm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDUsNCwzNFxyPC9kaXY+PGRp
dj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8v
MS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2Io
KSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6
ICZsdDsgXHJcbl5NT0RFOiA1LDRcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZs
dDsgXHJcbl5SU1NJOiAxMlxyXG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDssMzgsMzIsNTNc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAxLCZxdW90
OzAwNDAmcXVvdDssJnF1b3Q7MDJDMTAxNzgmcXVvdDtcclxuXHJcbl5TUlZTVDogMlxyXG48L2Rp
dj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9uZXR3
b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkoKSAvaHVhd2VpXzAgc3RhdHVzIDEgdGVj
aCAyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3Ny
Yy9jYnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDEsIC0xLCAtMSwgMiwgKG51bGwpKG51bGwp
PC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMv
Z3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDE8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTog
UENVSTogJmd0OyBBVCtDT1BTPTMsMlxyPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZs
dDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM/
XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbitDT1BTOiAwLDIsJnF1
b3Q7MjcyMDUmcXVvdDssMlxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAv
b2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJh
dGlvbi5jOmNvcHNfbnVtZXJpY19jYigpIENvcHMgbnVtZXJpYyBnb3QgbWNjOiAyNzIsIG1uYzog
MDU8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZndDsgQVQrQ1NRXHI8L2Rpdj48ZGl2
Pm9mb25vZFsxNjU5XTogUENVSTogJmx0OyBcclxuK0NTUTogMTIsOTlcclxuXHJcbk9LXHJcbjwv
ZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjc3FfY2IoKSBjc3FfY2I6IDEyPC9kaXY+
PGRpdj4Kb2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvbmV0d29y
ay5jOm9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3RpZnkoKSBzdHJlbmd0aCAzODwvZGl2PjxkaXY+
b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NHQVRUPTFccjwvZGl2PjxkaXY+b2Zvbm9kWzE2
NTldOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG5cclxuK0NHUkVHOiAxLCZxdW90OzAwNDAmcXVvdDss
JnF1b3Q7MDJDMTAxNzgmcXVvdDtcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25v
LzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOmdwcnNfYXR0YWNoX2NhbGxiYWNrKCkgL2h1
YXdlaV8wIGVycm9yID0gMDwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAv
b2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9odWF3ZWlf
MCBzdGF0dXMgMTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM9Myww
XHI8L2Rpdj4KPGRpdj5vZm9ub2RbMTY1OV06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2Pjxk
aXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM/XHI8L2Rpdj48ZGl2Pm9mb25vZFsx
NjU5XTogUENVSTogJmx0OyBcclxuK0NPUFM6IDAsMCwmcXVvdDszIElSTCZxdW90OywyXHJcblxy
XG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIwL29mb25vLTEu
MTQvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19jYigpIGNvcHNf
Y2I6IDMgSVJMLCAyNzIgMDUgMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0
LXIwL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpjdXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCkg
MHg1NTZlYTBmOCwgKG5pbCk8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogoC9vZm9uby8xLjE0LXIw
L29mb25vLTEuMTQvc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMSwgLTEsIC0xLCAy
LCAyNzIwNTwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4x
NC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAxLCAwLCAwPC9kaXY+CjxkaXY+b2Zv
bm9kWzE2NTldOiCgL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm5ldHJlZ19z
dGF0dXNfY2hhbmdlZCgpIDE8L2Rpdj48ZGl2Pm9mb25vZFsxNjU5XTogUENVSTogJmd0OyBBVCtD
R1JFRz9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG4rQ0dSRUc6IDIs
MSwmcXVvdDswMDQwJnF1b3Q7LCZxdW90OzAyQzEwMTc4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rp
dj4KPGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6cmVnaXN0cmF0aW9uX3N0YXR1c19jYigpIC9odWF3ZWlfMCBlcnJvciAwIHN0YXR1cyAxPC9k
aXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6b2Zvbm9fZ3Byc19zdGF0dXNfbm90aWZ5KCkgL2h1YXdlaV8wIHN0YXR1cyAxPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE2NTldOiBQQ1VJOiAmbHQ7IFxyXG5eUlNTSTogOVxyXG5cclxuXkhDU1E6JnF1
b3Q7V0NETUEmcXVvdDssMzcsMjcsNDVcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTY1OV06IKAvb2Zv
bm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0cmVuZ3Ro
X25vdGlmeSgpIHN0cmVuZ3RoIDI5PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+CjxzcGFuPjwv
c3Bhbj48c3Bhbj48L3NwYW4+PGJyPjxkaXY+SG9tYW08L2Rpdj48L2Rpdj4KPC9kaXY+Cg==

--===============8428289686379345183==--

