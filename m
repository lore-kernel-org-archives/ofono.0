Content-Type: multipart/mixed; boundary="===============3237025096744285377=="
MIME-Version: 1.0
From: vuikian.lai@my.bosch.com
Subject: ofono crashes caused by signal 11
Date: Mon, 16 Dec 2019 03:10:27 +0000
Message-ID: <20191216031027.2883.90778@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3237025096744285377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi oFono-team,

Signal 11 is observed when running oFono on target device.

Nov 16 03:29:50 MVP-V2X daemon.info systemd[1]: Starting Start oFono teleph=
ony service...
Nov 16 03:29:50 MVP-V2X daemon.info ofonod[3405]: oFono version 1.31
Nov 16 03:29:50 MVP-V2X daemon.info systemd[1]: Started Start oFono telepho=
ny service.
Nov 16 03:29:50 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:ofono_c=
onnect()
Nov 16 03:29:50 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:manager=
_get_modems()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/plugin.c:__ofono_plu=
gin_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/push-notificatio=
n.c:push_notification_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/smart-messaging.=
c:smart_messaging_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/upower.c:upower_=
init() upower init
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/handsfree-audio.c:of=
ono_handsfree_card_driver_register() driver: 0x114548
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/dun_gw_bluez5.c:=
dun_gw_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/handsfree-audio.c:of=
ono_handsfree_card_driver_register() driver: 0x1144ac
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1144c0, name: hfp
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/lg.c:lg_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x114464, name: lg
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/xmm7xxx.c:xmm7xx=
x_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x11440c, name: xmm7xxx
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1143bc, name: ublox
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x114344, name: quectel
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/telit.c:telit_in=
it()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1142f4, name: telit
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/connman.c:connma=
n_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/private-network.c:of=
ono_private_network_driver_register() driver: 0x1142c8, name: ConnMan Priva=
te Network
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x114280, name: sim7100
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x114238, name: sim900
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1141f0, name: samsung
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1141a8, name: speedupcdma
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x114158, name: speedup
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x114110, name: alcatel
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1140b8, name: icera
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x114070, name: linktop
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x114028, name: nokiacdma
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113fe0, name: nokia
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113f88, name: gemalto
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113f40, name: cinterion
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113eb8, name: ste
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113e60, name: ifx
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113e18, name: palmpre
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113dc8, name: novatel
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113d80, name: sierra
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113d08, name: huawei
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113cc0, name: zte
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113c60, name: hso
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113c10, name: mbm
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113bc0, name: calypso
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113b78, name: wavecom
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113b30, name: g1
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/cdma-voicecall.c:ofo=
no_cdma_voicecall_driver_register() driver: 0xea294, name: cdmamodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_devinf=
o_driver_register() driver: 0xea2c8, name: cdmamodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/cdma-connman.c:ofono=
_cdma_connman_driver_register() driver: 0xea3bc, name: cdmamodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113a88, name: phonesim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113ab8, name: localhfp
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0x113a6c, name: phonesim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ctm.c:ofono_ctm_driv=
er_register() driver: 0x113a58, name: phonesim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0x113a30, name: phonesim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/phonesim.c:parse=
_config() filename /etc/ofono/phonesim.conf
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0x113a14, name: lgmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe9928, name: xmm7modem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ims.c:ofono_ims_driv=
er_register() driver: 0xe99e0, name: xmm7modem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/netmon.c:ofono_netmo=
n_driver_register() driver: 0xe9b30, name: xmm7modem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/location-reporting.c=
:ofono_location_reporting_driver_register() driver: 0xe976c, name: gemaltom=
odem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xe9818, name: gemaltomodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe9168, name: ubloxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/network.c:ofono_netr=
eg_driver_register() driver: 0xe92ec, name: ubloxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/netmon.c:ofono_netmo=
n_driver_register() driver: 0xe9404, name: ubloxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/lte.c:ofono_lte_driv=
er_register() driver: 0xe95a8, name: ubloxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ussd.c:ofono_ussd_dr=
iver_register() driver: 0xe8f40, name: speedupmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xe8a84, name: hfpmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_devinf=
o_driver_register() driver: 0xe8d50, name: hfpmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/network.c:ofono_netr=
eg_driver_register() driver: 0xe8c50, name: hfpmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-volume.c:ofono_=
call_volume_driver_register() driver: 0xe8cf0, name: hfpmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/handsfree.c:ofono_ha=
ndsfree_driver_register() driver: 0xe8db0, name: hfpmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/siri.c:ofono_siri_dr=
iver_register() driver: 0xe8e98, name: hfpmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/network.c:ofono_netr=
eg_driver_register() driver: 0xe8828, name: dunmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_dr=
iver_register() driver: 0xe88c8, name: dunmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xe8398, name: stemodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe8608, name: stemodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe8484, name: stemodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xe7ae0, name: ifxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/audio-settings.c:ofo=
no_audio_settings_driver_register() driver: 0xe7d80, name: ifxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe7e68, name: ifxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe7ff4, name: ifxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/stk.c:ofono_stk_driv=
er_register() driver: 0xe8244, name: ifxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ctm.c:ofono_ctm_driv=
er_register() driver: 0xe8320, name: ifxmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe78a8, name: hsomodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe79d8, name: hsomodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/location-reporting.c=
:ofono_location_reporting_driver_register() driver: 0xe74d4, name: telitmod=
em
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe76c0, name: telitncmmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe706c, name: mbmmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/stk.c:ofono_stk_driv=
er_register() driver: 0xe7238, name: mbmmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/location-reporting.c=
:ofono_location_reporting_driver_register() driver: 0xe7338, name: mbmmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xe6c78, name: calypsomodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/stk.c:ofono_stk_driv=
er_register() driver: 0xe6ea8, name: calypsomodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ussd.c:ofono_ussd_dr=
iver_register() driver: 0xe6648, name: huaweimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xe66a4, name: huaweimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/audio-settings.c:ofo=
no_audio_settings_driver_register() driver: 0xe684c, name: huaweimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe6a48, name: huaweimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe6930, name: huaweimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/cdma-netreg.c:ofono_=
cdma_netreg_driver_register() driver: 0xe6b64, name: huaweimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe647c, name: iceramodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe65bc, name: iceramodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe634c, name: ztemodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe6280, name: swmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe6170, name: nwmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xe51f0, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_devinf=
o_driver_register() driver: 0xe577c, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-barring.c:ofono=
_call_barring_driver_register() driver: 0xe5508, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-forwarding.c:of=
ono_call_forwarding_driver_register() driver: 0xe3c5c, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-meter.c:ofono_c=
all_meter_driver_register() driver: 0xe3d40, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-settings.c:ofon=
o_call_settings_driver_register() driver: 0xe3118, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/phonebook.c:ofono_ph=
onebook_driver_register() driver: 0xe5544, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ussd.c:ofono_ussd_dr=
iver_register() driver: 0xe5044, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sms.c:ofono_sms_driv=
er_register() driver: 0xe339c, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sim.c:ofono_sim_driv=
er_register() driver: 0xe495c, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sim.c:ofono_sim_driv=
er_register() driver: 0xe49c4, name: atmodem-noef
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/stk.c:ofono_stk_driv=
er_register() driver: 0xe4fc0, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/network.c:ofono_netr=
eg_driver_register() driver: 0xe3f5c, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/cbs.c:ofono_cbs_driv=
er_register() driver: 0xe3a64, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-volume.c:ofono_=
call_volume_driver_register() driver: 0xe5804, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_dr=
iver_register() driver: 0xe59c4, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe5d6c, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gnss.c:ofono_gnss_dr=
iver_register() driver: 0xe5fdc, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/lte.c:ofono_lte_driv=
er_register() driver: 0xe60e8, name: atmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1132f0, name: mbim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_devinf=
o_driver_register() driver: 0xe2444, name: mbim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sim.c:ofono_sim_driv=
er_register() driver: 0xe25e4, name: mbim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/network.c:ofono_netr=
eg_driver_register() driver: 0xe27ac, name: mbim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sms.c:ofono_sms_driv=
er_register() driver: 0xe2a00, name: mbim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_dr=
iver_register() driver: 0xe2bec, name: mbim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe2e00, name: mbim
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113288, name: gobi
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_devinf=
o_driver_register() driver: 0xe0440, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/network.c:ofono_netr=
eg_driver_register() driver: 0xe06c8, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xe04d8, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sim.c:ofono_sim_driv=
er_register() driver: 0xe098c, name: qmimodem-legacy
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sim.c:ofono_sim_driv=
er_register() driver: 0xe0c48, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sms.c:ofono_sms_driv=
er_register() driver: 0xe0fbc, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ussd.c:ofono_ussd_dr=
iver_register() driver: 0xe13ac, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_dr=
iver_register() driver: 0xe154c, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xe17f8, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/lte.c:ofono_lte_driv=
er_register() driver: 0xe1ac4, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xe1c94, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/location-reporting.c=
:ofono_location_reporting_driver_register() driver: 0xe1e18, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/netmon.c:ofono_netmo=
n_driver_register() driver: 0xe1f10, name: qmimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113220, name: u8500
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_devinf=
o_driver_register() driver: 0x113200, name: u8500
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1131b8, name: n900
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113170, name: isiusb
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_devinf=
o_driver_register() driver: 0xdbc08, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/phonebook.c:ofono_ph=
onebook_driver_register() driver: 0xdbb68, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/network.c:ofono_netr=
eg_driver_register() driver: 0xdbd50, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xdc0e4, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sms.c:ofono_sms_driv=
er_register() driver: 0xdc8e0, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/cbs.c:ofono_cbs_driv=
er_register() driver: 0xdcb8c, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sim.c:ofono_sim_driv=
er_register() driver: 0xdcf10, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ussd.c:ofono_ussd_dr=
iver_register() driver: 0xdd204, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-forwarding.c:of=
ono_call_forwarding_driver_register() driver: 0xdd2cc, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-settings.c:ofon=
o_call_settings_driver_register() driver: 0xdd430, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-barring.c:ofono=
_call_barring_driver_register() driver: 0xdd514, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-meter.c:ofono_c=
all_meter_driver_register() driver: 0xdd5f4, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xdd6b8, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_dr=
iver_register() driver: 0xdd830, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xdda10, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/audio-settings.c:ofo=
no_audio_settings_driver_register() driver: 0xddb7c, name: isimodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sim.c:ofono_sim_driv=
er_register() driver: 0xde020, name: wgmodem2.5
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: drivers/rilmodem/rilmode=
m.c:rilmodem_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_devinf=
o_driver_register() driver: 0xd1044, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: drivers/rilmodem/sim.c:r=
il_sim_init()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sim.c:ofono_sim_driv=
er_register() driver: 0xd21d4, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/voicecall.c:ofono_vo=
icecall_driver_register() driver: 0xd14e0, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/sms.c:ofono_sms_driv=
er_register() driver: 0xd27c4, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/network.c:ofono_netr=
eg_driver_register() driver: 0xd1194, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-volume.c:ofono_=
call_volume_driver_register() driver: 0xd16e8, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_dr=
iver_register() driver: 0xd1894, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/gprs.c:ofono_gprs_co=
ntext_driver_register() driver: 0xd1c20, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/ussd.c:ofono_ussd_dr=
iver_register() driver: 0xd2a08, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-settings.c:ofon=
o_call_settings_driver_register() driver: 0xd2a7c, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-forwarding.c:of=
ono_call_forwarding_driver_register() driver: 0xd2afc, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/radio-settings.c:ofo=
no_radio_settings_driver_register() driver: 0xd2cf8, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/call-barring.c:ofono=
_call_barring_driver_register() driver: 0xd2e18, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/netmon.c:ofono_netmo=
n_driver_register() driver: 0xd2f50, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/stk.c:ofono_stk_driv=
er_register() driver: 0xd2fd8, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/cbs.c:ofono_cbs_driv=
er_register() driver: 0xd305c, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/lte.c:ofono_lte_driv=
er_register() driver: 0xd3150, name: rilmodem
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1130e8, name: ril_intel
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x1130a0, name: infineon
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
driver_register() driver: 0x113058, name: ril
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:udev_st=
art()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:enumera=
te_devices()
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_p=
ci_device() pcieport [0x16c3:0xabcd]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() hub [1d6b:0002]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() usb [1d6b:0002]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() usbfs [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() usb [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_acm [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_acm [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_dev=
ice() /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1-1
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_dev=
ice() /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1-1=
/1-1:1.2/tty/ttyACM0
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_dev=
ice() /dev/ttyACM0 (lg) 2/2/1 [02] =3D=3D> (null) (null)
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_acm [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_acm [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_acm [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_dev=
ice() /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1-1
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_dev=
ice() /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1-1=
/1-1:1.4/tty/ttyACM1
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_dev=
ice() /dev/ttyACM1 (lg) 2/2/1 [04] =3D=3D> (null) (null)
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_acm [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() usb [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_ether [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_ether [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_ether [1d74:3300]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() hub [1d6b:0002]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() usb [1d6b:0002]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_ether [040e:fb10]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_ether [040e:fb10]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:check_u=
sb_device() cdc_ether [040e:fb10]
Nov 16 03:29:50 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() /sys/devices/soc0/soc/2100000.aips-bus/21f4000.serial/tty/ttym=
xc4
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() /devices/soc0/soc/2100000.aips-bus/21f4000.serial/tty/ttymxc4
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() /dev/ttymxc4 (sierra)
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:add_ser=
ial_device() Device is missing required OFONO_DRIVER property
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:create_=
modem() /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1=
-1
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:create_=
modem() driver=3Dlg
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
create() name: (null), type: lg
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:setup_l=
g() /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1-1
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:setup_l=
g() /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1-1/1=
-1:1.2/tty/ttyACM0 /dev/ttyACM0 2/2/1 02 (null) (null) tty
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:setup_l=
g() /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1-1/1=
-1:1.4/tty/ttyACM1 /dev/ttyACM1 2/2/1 04 (null) (null) tty
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:setup_l=
g() aux=3D/dev/ttyACM0
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:set_modem_pr=
operty() modem 0x56eec0 property Aux
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:set_modem_pr=
operty() modem 0x56eec0 property SystemPath
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
register() 0x56eec0
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/lg.c:lg_probe() =
0x56eec0
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:emit_modem_a=
dded() 0x56eec0
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:get_modem_pr=
operty() modem 0x56eec0 property SystemPath
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:modem_a=
dded()
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:add_mod=
em() /lg_0
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:add_mod=
em() /lg_0 Online 0
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:add_mod=
em() /lg_0 Powered 0
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:add_mod=
em() /lg_0 Interfaces 0x00
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:add_mod=
em() /lg_0 Type hardware
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:modem_s=
et_powered() /lg_0 powered 1
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:set_pro=
perty() /lg_0 path /lg_0 org.ofono.Modem.Powered
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:call_modemwa=
tches() 0x56eec0 added:1
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/dun_gw_bluez5.c:=
modem_watch() modem: 0x56eec0, added: 1
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/hfp_ag_bluez5.c:=
modem_watch() modem: 0x56eec0, added: 1
Nov 16 03:29:51 MVP-V2X daemon.notice systemd[1]: ofono.service: Main proce=
ss exited, code=3Dexited, status=3D1/FAILURE
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/smart-messaging.=
c:modem_watch() modem: 0x56eec0, added: 1
Nov 16 03:29:51 MVP-V2X daemon.notice systemd[1]: ofono.service: Unit enter=
ed failed state.
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/push-notificatio=
n.c:modem_watch() modem: 0x56eec0, added: 1
Nov 16 03:29:51 MVP-V2X daemon.warn systemd[1]: ofono.service: Failed with =
result 'exit-code'.
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:create_=
modem() /sys/devices/soc0/soc/2100000.aips-bus/21f4000.serial/tty/ttymxc4
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:create_=
modem() driver=3Dsierra
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: src/modem.c:ofono_modem_=
create() name: (null), type: sierra
Nov 16 03:29:51 MVP-V2X daemon.debug ofonod[3405]: plugins/udevng.c:setup_s=
ierra() /sys/devices/soc0/soc/2100000.aips-bus/21f4000.serial/tty/ttymxc4
Nov 16 03:29:51 MVP-V2X daemon.err ofonod[3405]: Aborting (signal 11) [/usr=
/sbin/ofonod]
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:ofono_d=
isconnect()
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:remove_=
modem() /lg_0
Nov 16 03:29:51 MVP-V2X daemon.debug connmand[297]: plugins/ofono.c:manager=
_get_modems_reply()
Nov 16 03:29:51 MVP-V2X daemon.err connmand[297]: Message recipient disconn=
ected from message bus without replying
Nov 16 03:29:51 MVP-V2X daemon.info systemd[1]: ofono.service: Service hold=
-off time over, scheduling restart.
Nov 16 03:29:51 MVP-V2X daemon.info systemd[1]: Stopped =


Crash is observed in "setup_sierra" function in udevng.c. =

I realized that serial device is setup with "struct serial_device_info" in =
"add_serial_device()" but it is de-referenced as "struct device_info" in "s=
etup_sierra()".
It seems to me the serial port is mistakenly treated as serial modem.

How should i proceed further on this topic? There is no compiler option to =
disable serial device detection.
--===============3237025096744285377==--

