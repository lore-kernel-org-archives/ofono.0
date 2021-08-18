Content-Type: multipart/mixed; boundary="===============4943083540755903676=="
MIME-Version: 1.0
From: dburrell@miovision.com
Subject: help debugging ofono logs
Date: Wed, 18 Aug 2021 13:14:09 +0000
Message-ID: <20210818131409.2778.94245@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4943083540755903676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, I have an embedded Linux platform running ofono v1.31 alongside a Quect=
el EC25 mini PCIe cellular modem. We're seeing some odd behaviour but only =
when our units are roaming on Verizon's network in the USA. What we're seei=
ng is that ofono becomes unresponsive on the dbus interface every so often.=
 If we switch the device onto AT&T's network the problem goes away. I have =
some logs of a unit experiencing the problem and am hoping someone with mor=
e knowledge of ofono can help with debugging the attached log to help me un=
derstand what's going on with our unit. In the attached log the problem occ=
urs right near the bottom.
Thanks,
Doug Burrell

Jun 09 14:07:19 CTM000053 ofonod[5208]: oFono version 1.31
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/plugin.c:__ofono_=
plugin_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: Excluding Provisioning Plugin
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs-provision.c:=
ofono_gprs_provision_driver_register() driver: 0x555c516a80 name: GPRS cont=
ext provisioning
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/push-notifica=
tion.c:push_notification_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/smart-messagi=
ng.c:smart_messaging_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/cdma-provision.c:=
ofono_cdma_provision_driver_register() driver: 0x555c516a28 name: CDMA prov=
isioning
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/upower.c:upow=
er_init() upower init
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/handsfree-audio.c=
:ofono_handsfree_card_driver_register() driver: 0x555c516928
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/dun_gw_bluez5=
.c:dun_gw_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/handsfree-audio.c=
:ofono_handsfree_card_driver_register() driver: 0x555c5167f0
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516818, name: hfp
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/xmm7xxx.c:xmm=
7xxx_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516740, name: xmm7xxx
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5166a0, name: ublox
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5165b0, name: quectel
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/telit.c:telit=
_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516510, name: telit
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/connman.c:con=
nman_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/private-network.c=
:ofono_private_network_driver_register() driver: 0x555c5164b8, name: ConnMa=
n Private Network
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516428, name: sim7100
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516398, name: sim900
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516308, name: samsung
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516278, name: speedupcdma
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5161d8, name: speedup
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516148, name: alcatel
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516098, name: icera
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c516008, name: linktop
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515f78, name: nokiacdma
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515ee8, name: nokia
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515e38, name: gemalto
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515da8, name: cinterion
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515c98, name: ste
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515be8, name: ifx
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515b58, name: palmpre
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515ab8, name: novatel
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515a28, name: sierra
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515938, name: huawei
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5158a8, name: zte
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5157e8, name: hso
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515748, name: mbm
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5156a8, name: calypso
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515618, name: wavecom
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515588, name: g1
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/cdma-voicecall.c:=
ofono_cdma_voicecall_driver_register() driver: 0x555c50d230, name: cdmamodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_dev=
info_driver_register() driver: 0x555c50d270, name: cdmamodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/cdma-connman.c:of=
ono_cdma_connman_driver_register() driver: 0x555c50d2b0, name: cdmamodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515438, name: phonesim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c515498, name: localhfp
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c515400, name: phonesim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ctm.c:ofono_ctm_d=
river_register() driver: 0x555c5153d8, name: phonesim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c515388, name: phonesim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/phonesim.c:pa=
rse_config() filename /etc/ofono/phonesim.conf
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50d180, name: xmm7modem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ims.c:ofono_ims_d=
river_register() driver: 0x555c50d1d0, name: xmm7modem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/netmon.c:ofono_ne=
tmon_driver_register() driver: 0x555c50d200, name: xmm7modem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/location-reportin=
g.c:ofono_location_reporting_driver_register() driver: 0x555c50d0b0, name: =
gemaltomodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50d0e0, name: gemaltomodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50d028, name: ubloxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_driver_register() driver: 0x555c5128f8, name: ubloxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/netmon.c:ofono_ne=
tmon_driver_register() driver: 0x555c50d060, name: ubloxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/lte.c:ofono_lte_d=
river_register() driver: 0x555c50d090, name: ubloxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ussd.c:ofono_ussd=
_driver_register() driver: 0x555c50cf30, name: speedupmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50cd78, name: hfpmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_dev=
info_driver_register() driver: 0x555c50ce90, name: hfpmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_driver_register() driver: 0x555c50ce18, name: hfpmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-volume.c:ofo=
no_call_volume_driver_register() driver: 0x555c50ce60, name: hfpmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/handsfree.c:ofono=
_handsfree_driver_register() driver: 0x555c50ced0, name: hfpmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/siri.c:ofono_siri=
_driver_register() driver: 0x555c50cf10, name: hfpmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_driver_register() driver: 0x555c50cd00, name: dunmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_driver_register() driver: 0x555c50cd48, name: dunmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50cbd8, name: stemodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50ccc8, name: stemodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50cc78, name: stemodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50ca40, name: ifxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/audio-settings.c:=
ofono_audio_settings_driver_register() driver: 0x555c50cae0, name: ifxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50caf8, name: ifxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50cb48, name: ifxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/stk.c:ofono_stk_d=
river_register() driver: 0x555c50cb80, name: ifxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ctm.c:ofono_ctm_d=
river_register() driver: 0x555c50cbb0, name: ifxmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50c9b8, name: hsomodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50c9f0, name: hsomodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/location-reportin=
g.c:ofono_location_reporting_driver_register() driver: 0x555c50c950, name: =
telitmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50c980, name: telitncmmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50c8b8, name: mbmmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/stk.c:ofono_stk_d=
river_register() driver: 0x555c50c8f0, name: mbmmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/location-reportin=
g.c:ofono_location_reporting_driver_register() driver: 0x555c50c920, name: =
mbmmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50c7e8, name: calypsomodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/stk.c:ofono_stk_d=
river_register() driver: 0x555c50c888, name: calypsomodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ussd.c:ofono_ussd=
_driver_register() driver: 0x555c50c660, name: huaweimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50c688, name: huaweimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/audio-settings.c:=
ofono_audio_settings_driver_register() driver: 0x555c50c728, name: huaweimo=
dem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50c778, name: huaweimo=
dem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50c740, name: huaweimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/cdma-netreg.c:ofo=
no_cdma_netreg_driver_register() driver: 0x555c50c7c8, name: huaweimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50c5d8, name: iceramodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50c610, name: iceramod=
em
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50c588, name: ztemodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50c550, name: swmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50c500, name: nwmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50c2f0, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_dev=
info_driver_register() driver: 0x555c50c3e0, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-barring.c:of=
ono_call_barring_driver_register() driver: 0x555c50c390, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-forwarding.c=
:ofono_call_forwarding_driver_register() driver: 0x555c50bed8, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-meter.c:ofon=
o_call_meter_driver_register() driver: 0x555c50bf18, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-settings.c:o=
fono_call_settings_driver_register() driver: 0x555c50bde8, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/phonebook.c:ofono=
_phonebook_driver_register() driver: 0x555c50c3c0, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ussd.c:ofono_ussd=
_driver_register() driver: 0x555c50c2c8, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sms.c:ofono_sms_d=
river_register() driver: 0x555c50be70, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_d=
river_register() driver: 0x555c50c0f8, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_d=
river_register() driver: 0x555c50c1c8, name: atmodem-noef
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/stk.c:ofono_stk_d=
river_register() driver: 0x555c50c298, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_driver_register() driver: 0x555c50bf68, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/cbs.c:ofono_cbs_d=
river_register() driver: 0x555c50beb0, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-volume.c:ofo=
no_call_volume_driver_register() driver: 0x555c50c420, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_driver_register() driver: 0x555c50c450, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50c480, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gnss.c:ofono_gnss=
_driver_register() driver: 0x555c50c4b8, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/lte.c:ofono_lte_d=
river_register() driver: 0x555c50c4e0, name: atmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5145e0, name: mbim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_dev=
info_driver_register() driver: 0x555c50bbe8, name: mbim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_d=
river_register() driver: 0x555c50bc28, name: mbim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_driver_register() driver: 0x555c50bcf8, name: mbim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sms.c:ofono_sms_d=
river_register() driver: 0x555c50bd40, name: mbim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_driver_register() driver: 0x555c50bd80, name: mbim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50bdb0, name: mbim
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c514510, name: gobi
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_dev=
info_driver_register() driver: 0x555c50b780, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_driver_register() driver: 0x555c50b860, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50b7c0, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_d=
river_register() driver: 0x555c50b8a8, name: qmimodem-legacy
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_d=
river_register() driver: 0x555c50b978, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sms.c:ofono_sms_d=
river_register() driver: 0x555c50ba48, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ussd.c:ofono_ussd=
_driver_register() driver: 0x555c50ba88, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_driver_register() driver: 0x555c50bab0, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50bae0, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/lte.c:ofono_lte_d=
river_register() driver: 0x555c50bb18, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50bb38, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/location-reportin=
g.c:ofono_location_reporting_driver_register() driver: 0x555c50bb88, name: =
qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/netmon.c:ofono_ne=
tmon_driver_register() driver: 0x555c50bbb8, name: qmimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c514440, name: u8500
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_dev=
info_driver_register() driver: 0x555c514400, name: u8500
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c514370, name: n900
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5142e0, name: isiusb
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_dev=
info_driver_register() driver: 0x555c50ad48, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/phonebook.c:ofono=
_phonebook_driver_register() driver: 0x555c50ad28, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_driver_register() driver: 0x555c50ad88, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50add0, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sms.c:ofono_sms_d=
river_register() driver: 0x555c50ae70, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/cbs.c:ofono_cbs_d=
river_register() driver: 0x555c50aeb0, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_d=
river_register() driver: 0x555c50aed8, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ussd.c:ofono_ussd=
_driver_register() driver: 0x555c50afa8, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-forwarding.c=
:ofono_call_forwarding_driver_register() driver: 0x555c50afd0, name: isimod=
em
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-settings.c:o=
fono_call_settings_driver_register() driver: 0x555c50b010, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-barring.c:of=
ono_call_barring_driver_register() driver: 0x555c50b070, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-meter.c:ofon=
o_call_meter_driver_register() driver: 0x555c50b0a0, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50b0f0, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_driver_register() driver: 0x555c50b140, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50b170, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/audio-settings.c:=
ofono_audio_settings_driver_register() driver: 0x555c50b1a8, name: isimodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_d=
river_register() driver: 0x555c50b1c0, name: wgmodem2.5
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/rilmodem/rilm=
odem.c:rilmodem_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_dev=
info_driver_register() driver: 0x555c50a798, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/rilmodem/sim.=
c:ril_sim_init()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_d=
river_register() driver: 0x555c50a9a0, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ofono=
_voicecall_driver_register() driver: 0x555c50a820, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/sms.c:ofono_sms_d=
river_register() driver: 0x555c50aa70, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_driver_register() driver: 0x555c50a7d8, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-volume.c:ofo=
no_call_volume_driver_register() driver: 0x555c50a8c0, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_driver_register() driver: 0x555c50a8f0, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_context_driver_register() driver: 0x555c50a920, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/ussd.c:ofono_ussd=
_driver_register() driver: 0x555c50aab0, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-settings.c:o=
fono_call_settings_driver_register() driver: 0x555c50aad8, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-forwarding.c=
:ofono_call_forwarding_driver_register() driver: 0x555c50ab38, name: rilmod=
em
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
ofono_radio_settings_driver_register() driver: 0x555c50ab78, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/call-barring.c:of=
ono_call_barring_driver_register() driver: 0x555c50abc8, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/netmon.c:ofono_ne=
tmon_driver_register() driver: 0x555c50abf8, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/stk.c:ofono_stk_d=
river_register() driver: 0x555c50ac28, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/cbs.c:ofono_cbs_d=
river_register() driver: 0x555c50ac58, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/lte.c:ofono_lte_d=
river_register() driver: 0x555c50ac80, name: rilmodem
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5141d0, name: ril_intel
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c514140, name: infineon
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_driver_register() driver: 0x555c5140b0, name: ril
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:udev=
_start()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:enum=
erate_devices()
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_pci_device() pcieport [0x10de:0x0fae]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_pci_device() nvme [0x1987:0x5012]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_pci_device() pcieport [0x10de:0x0faf]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_pci_device() r8168 [0x10ec:0x8168]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_pci_device() (null) [(null):(null)]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() hub [1d6b:0002]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() usb [1d6b:0002]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() option [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() option [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() option [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() option [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() option [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() option [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() option [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() option [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() qmi_wwan [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() qmi_wwan [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
device() /sys/devices/70090000.xusb/usb1/1-2
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
device() /sys/devices/70090000.xusb/usb1/1-2/1-2:1.4/net/wwan0
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
device() wwan0 (quectelqmi) 255/255/255 [04] =3D=3D> (null) (null)
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() qmi_wwan [2c7c:0125]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
device() /sys/devices/70090000.xusb/usb1/1-2
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
device() /sys/devices/70090000.xusb/usb1/1-2/1-2:1.4/usbmisc/cdc-wdm0
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
device() /dev/cdc-wdm0 (quectelqmi) 255/255/255 [04] =3D=3D> (null) (null)
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_usb_device() hub [1d6b:0003]
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:crea=
te_modem() /sys/devices/70090000.xusb/usb1/1-2
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:crea=
te_modem() driver=3Dquectelqmi
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_create() name: (null), type: quectelqmi
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:setu=
p_quectelqmi() /sys/devices/70090000.xusb/usb1/1-2
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:setu=
p_quectelqmi() /dev/cdc-wdm0 255/255/255 04 (null) usbmisc
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:setu=
p_quectelqmi() wwan0 255/255/255 04 (null) net
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:setu=
p_quectelqmi() qmi=3D/dev/cdc-wdm0 net=3Dwwan0
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:setu=
p_quectelqmi() qmi=3D/dev/cdc-wdm0 net=3Dwwan0
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:set_modem=
_property() modem 0x556990d690 property Device
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:set_modem=
_property() modem 0x556990d690 property NetworkInterface
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:setu=
p_quectelqmi() gps=3D(null) aux=3D(null)
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_set_driver() type: gobi
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:set_modem=
_property() modem 0x556990d690 property SystemPath
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:ofono_mod=
em_register() 0x556990d690
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:gobi_p=
robe() 0x556990d690
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:emit_mode=
m_added() 0x556990d690
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property SystemPath
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:call_mode=
mwatches() 0x556990d690 added:1
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/dun_gw_bluez5=
.c:modem_watch() modem: 0x556990d690, added: 1
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/hfp_ag_bluez5=
.c:modem_watch() modem: 0x556990d690, added: 1
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/smart-messagi=
ng.c:modem_watch() modem: 0x556990d690, added: 1
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/push-notifica=
tion.c:modem_watch() modem: 0x556990d690, added: 1
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/hfp_hf_bluez5=
.c:connect_handler() Registering External Profile handler ...
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/bluez5.c:bt_r=
egister_profile() Bluetooth: Registering 0000111e-0000-1000-8000-00805f9b34=
fb (hfp_hf) profile
Jun 09 14:07:19 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/bluez5.c:prof=
ile_register_cb()
Jun 09 14:07:22 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property SystemPath
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:gobi_e=
nable() 0x556990d690
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property Device
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:discov=
er_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:create=
_dms_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:get_ca=
ps_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:get_ca=
ps_cb() service capabilities 4
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:get_ca=
ps_cb() sim supported 2
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:get_ca=
ps_cb() radio =3D 5
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:get_ca=
ps_cb() radio =3D 8
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:get_op=
er_mode_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property AlwaysOnline
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:power_=
reset_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:modem_cha=
nge_state() old state: 0, new state: 1
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:gobi_p=
re_sim() 0x556990d690
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:qmi_devinfo_probe()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property ForceSimLegacy
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_sim_probe()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/voic=
ecall.c:qmi_voicecall_probe()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:create_dms_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:qmi_query_caps()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:create_dms_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/voic=
ecall.c:create_voice_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:get_caps_cb()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:qmi_query_manufacturer()
Jun 09 14:07:25 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:create_uim_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:string_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:qmi_query_model()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:event_registration_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:event_registration_cb() event mask 0x0003
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_card_status_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_a=
dd_state_watch() 0x556991ab70
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_a=
dd_state_watch() 0x556991ab70
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_a=
dd_state_watch() 0x556991ab70
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_a=
dd_state_watch() 0x556991ab70
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_a=
dd_state_watch() 0x556991ab70
Jun 09 14:07:26 CTM000053 ofonod[5208]: Interface org.ofono.AllowedAccessPo=
ints not found on the interface_list
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6fb7 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:string_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:qmi_query_revision()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: Requested file structure differs fr=
om SIM: 6fb7
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ecc_g=
2_read_cb() 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6fb7 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:string_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:qmi_query_serial()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fb7 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/devi=
nfo.c:get_ids_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ecc_g=
3_read_cb() 1
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fb7 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ecc_g=
3_read_cb() 1
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fb7 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ecc_g=
3_read_cb() 1
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fb7 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ecc_g=
3_read_cb() 1
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fb7 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/voicecall.c:ecc_g=
3_read_cb() 1
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x2fe2 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_transparent() file id 0x2fe2 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/simfs.c:sim_fs_op=
_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 10
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6f05 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_transparent() file id 0x6f05 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/simfs.c:sim_fs_op=
_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 10
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x2f05 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_transparent() file id 0x2f05 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/simfs.c:sim_fs_op=
_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 10
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_query_passwd_state()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:query_passwd_state_cb() passwd state 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:sim_pin_que=
ry_cb() sim->pin_type: 0, pin_type: 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_query_pin_retries()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6fae path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6fad path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:query_pin_retries_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_transparent() file id 0x6fad path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/simfs.c:sim_fs_op=
_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 4
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6f16 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6f38 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_transparent() file id 0x6f38 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/simfs.c:sim_fs_op=
_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 14
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6f56 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_transparent() file id 0x6f56 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/simfs.c:sim_fs_op=
_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 2
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_imsi()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_imsi_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_transparent() file id 0x6f07 path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/bluez5.c:bt_r=
egister_profile() Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34=
fb (hfp_ag) profile
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:modem_cha=
nge_state() old state: 1, new state: 2
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:gobi_p=
ost_sim() 0x556990d690
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/lte.=
c:qmimodem_lte_probe() qmimodem lte probe
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/lte.c:ofono_lte_c=
reate() LTE atom created
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/radi=
o-settings.c:qmi_radio_settings_probe()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:qmi_sms_probe()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property ForceSimLegacy
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property AlwaysOnline
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/radi=
o-settings.c:create_dms_cb()
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6fca path len 0
Jun 09 14:07:26 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/bluez5.c:prof=
ile_register_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/radi=
o-settings.c:create_nas_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
radio_load_settings() TechnologyPreference: 4
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
radio_load_settings() GsmBand: 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/src/radio-settings.c:=
radio_load_settings() UmtsBand: 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/radi=
o-settings.c:qmi_set_rat_mode()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/lte.=
c:create_wds_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:create_wms_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fca path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/radi=
o-settings.c:set_system_selection_pref_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/lte.=
c:get_default_profile_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/lte.=
c:get_default_profile_cb() Default profile index: 1
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:set_event_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fca path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/lte.=
c:reset_profile_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/lte.=
c:qmimodem_lte_set_default_attach_info()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb() found 6 routes
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb() type 0 class 0 =3D> type 1 value 3
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb() type 0 class 1 =3D> type 1 value 1
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb() type 0 class 2 =3D> type 0 value 1
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb() type 0 class 3 =3D> type 1 value 1
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb() type 0 class 4 =3D> type 1 value 1
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb() type 0 class 5 =3D> type 1 value 1
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_routes_cb() transfer status report 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fca path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/lte.=
c:modify_profile_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:set_routes_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:qmi_bearer_set() bearer 3
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/src/sms.c:sms_restore=
_tx_queue()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/push-notifica=
tion.c:sms_watch() registered
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/smart-messagi=
ng.c:sms_watch() registered
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:delete_msg()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:delete_msg() delete msg tag 0 mode 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:delete_msg()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:delete_msg() delete msg tag 2 mode 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:delete_msg()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:delete_msg() delete msg tag 0 mode 1
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:delete_msg()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:delete_msg() delete msg tag 2 mode 1
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_protocol()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fca path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/radi=
o-settings.c:qmi_query_rat_mode()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:set_domain_pref_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_protocol_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_protocol_cb() device supports CDMA and WCDMA msg protocol
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_list()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6fc9 path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/radi=
o-settings.c:get_system_selection_pref_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_list_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_list_cb() Err: get msg list mode=3D0 47=3DUNKNOWN
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_list()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fc9 path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/radi=
o-settings.c:get_caps_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_list_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sms.=
c:get_msg_list_cb() msgs found 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fc9 path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fc9 path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fc9 path len 0
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:27 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6f11 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/message-waiting.c=
:mw_cphs_mwis_read_cb() No CPHS MWIS on SIM
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6f40 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6f40 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6f40 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6f40 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x4f20 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6fc7 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fc7 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fc7 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fc7 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_record() file id 0x6fc7 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:read_generic_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property AlwaysOnline
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:gobi_s=
et_online() 0x556990d690 online
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:set_on=
line_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:modem_cha=
nge_state() old state: 2, new state: 3
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:gobi_p=
ost_online() 0x556990d690
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:qmi_netreg_probe()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_probe()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/ussd=
.c:qmi_ussd_probe()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:qmi_gprs_probe()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:qmi_gprs_context_probe()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:create_nas_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:create_nas_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/ussd=
.c:create_voice_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:create_nas_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:create_wds_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/bluez5.c:bt_r=
egister_profile() Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34=
fb (dun_gw) profile
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/bluez5.c:prof=
ile_register_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:create_wda_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:set_event_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:qmi_registration_status()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/sim.c:ofono_sim_a=
dd_spn_watch() 0x556991ab70
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:__ofono=
_netreg_add_status_watch() 0x5569912b70
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:__ofono=
_netreg_add_status_watch() 0x5569912b70
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/simfs.c:sim_fs_op=
_read_block() bufoff: 0, seekoff: 39, toread: 17
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/simfs.c:sim_fs_op=
_read_block() bufoff: 0, seekoff: 39, toread: 34
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:ss_info_notify()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:handle_ss_info()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:extract_ss_info()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:extract_ss_info() radio in use 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_status_notify() /quectelqmi_0 status unregistered (0)
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_detached_notify() /quectelqmi_0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_data_format_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_data_format_cb() expected data set to raw-ip
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:create_wds_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:get_ss_info_cb()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info()
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() serving system status 2
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() radio in use 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() roaming 2 lac -1 cellid -1 tech -1
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_status_notify() /quectelqmi_0 status 2 tech -1 lac -1 ci -1
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:current=
_operator_callback() 0x5569912b70, (nil)
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:netreg_sta=
tus_changed() 2 (searching)
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:gprs_netre=
g_update() attach: 0, driver_attached: 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:qmi_read_attributes() file id 0x6f15 path len 0
Jun 09 14:07:28 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/sim.=
c:get_file_attributes_cb()
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:ss_info_notify()
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:handle_ss_info()
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:extract_ss_info()
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:extract_ss_info() radio in use 8
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_status_notify() /quectelqmi_0 status unregistered (0)
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_detached_notify() /quectelqmi_0
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:ss_info_notify()
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info()
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() serving system status 2
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() radio in use 8
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() 311480 (311:480)
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() roaming 2 lac -1 cellid -1 tech 7
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_status_notify() /quectelqmi_0 status 2 tech 7 lac -1 ci -1
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:current=
_operator_callback() 0x5569912b70, (nil)
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:netreg_sta=
tus_changed() 2 (searching)
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:gprs_netre=
g_update() attach: 0, driver_attached: 0
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:event_notify()
Jun 09 14:07:29 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:event_notify() rat 8 band 121 channel 1025
Jun 09 14:07:30 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:event_notify()
Jun 09 14:07:30 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:event_notify() signal with 100%(-50 dBm) on 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:ss_info_notify()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:handle_ss_info()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:extract_ss_info()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:extract_ss_info() radio in use 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:get_lte_attach_params()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_status_notify() /quectelqmi_0 status registered (1)
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:ss_info_notify()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() serving system status 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() radio in use 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() 311480 (311:480)
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() roaming 1 lac 65534 cellid 14618382 te=
ch 7
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_status_notify() /quectelqmi_0 status 5 tech 7 lac 65534 ci 14618382
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:qmi_current_operator()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:current=
_operator_callback() 0x5569912b70, (nil)
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:netreg_sta=
tus_changed() 5 (roaming)
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:gprs_netre=
g_update() attach: 1, driver_attached: 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:qmi_signal_strength()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:netreg_sta=
tus_changed() 5 (roaming)
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:gprs_netre=
g_update() attach: 1, driver_attached: 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:event_notify()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:event_notify() rat 8 band 121 channel 1025
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:ss_info_notify()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:handle_ss_info()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:extract_ss_info()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:extract_ss_info() radio in use 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:get_lte_attach_params()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_status_notify() /quectelqmi_0 status registered (1)
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:ss_info_notify()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_time_notify() net time 2021-06-09 14:07:31 utcoff 216000 dst 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() serving system status 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() radio in use 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:extract_ss_info() roaming 2 lac -1 cellid -1 tech 7
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_status_notify() /quectelqmi_0 status 5 tech 7 lac 65534 ci 14618382
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:qmi_current_operator()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:current=
_operator_callback() 0x5569912b70, 0x5569901a60
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:qmi_signal_strength()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:netreg_sta=
tus_changed() 5 (roaming)
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:gprs_netre=
g_update() attach: 1, driver_attached: 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:get_default_profile_cb()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:get_default_profile_cb() Default profile index: 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:get_rssi_cb()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:get_rssi_cb() signal with -50 dBm on 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_strength_notify() strength 100
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:get_rssi_cb()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:get_rssi_cb() signal with -50 dBm on 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
.c:get_lte_attach_param_cb()
Jun 09 14:07:31 CTM000053 ofonod[5208]: LTE attach IP type: 0
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:ofono_gprs=
_cid_activated() cid 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:add_contex=
t() Registering new context
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:qmi_gprs_read_settings() cid 1
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 50 on RAT 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -15 on RAT 8
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:start_net_cb()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:start_net_cb() packet handle -2027396912
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify() conn status 2
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify() ip family 4
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb()
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() PDP type 0
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() IP addr: 25.248.124.166
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() Gateway: 25.248.124.165
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() Gateway netmask: 255.255.255.252
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property NetworkInterface
Jun 09 14:07:31 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:pri_read_s=
ettings_callback() 0x55699195e0
Jun 09 14:07:33 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:event_notify()
Jun 09 14:07:33 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netw=
ork-registration.c:event_notify() signal with 80%(-56 dBm) on 8
Jun 09 14:07:33 CTM000053 ofonod[5208]: ../ofono-1.31/src/network.c:ofono_n=
etreg_strength_notify() strength 80
Jun 09 14:07:34 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:gprs_remov=
e_context() Unregistering context: /quectelqmi_0/context52
Jun 09 14:07:34 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:qmi_deactivate_primary() cid 1
Jun 09 14:07:34 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:stop_net_cb()
Jun 09 14:07:34 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:add_contex=
t() Registering new context
Jun 09 14:07:34 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:qmi_activate_primary() cid 1
Jun 09 14:07:34 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify()
Jun 09 14:07:34 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify() conn status 1
Jun 09 14:07:34 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify() ip family 4
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:start_net_cb()
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:start_net_cb() packet handle -2027396912
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify()
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify() conn status 2
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:pkt_status_notify() ip family 4
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb()
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() APN: miovision.iot
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() PDP type 0
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() IP addr: 10.0.8.46
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() Gateway: 10.0.8.45
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() Gateway netmask: 255.255.255.252
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() Primary DNS: 75.153.176.3
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/gprs=
-context.c:get_settings_cb() Secondary DNS: 75.153.176.11
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property NetworkInterface
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/src/gprs.c:pri_activa=
te_callback() 0x556993f460
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:37 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:40 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:40 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:40 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:40 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:40 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:40 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:43 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:43 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:43 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:43 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:43 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:43 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:46 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:46 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:46 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:46 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:46 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:46 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:49 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:49 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:49 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:49 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:49 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:49 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:49 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:50 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_modem_list()
Jun 09 14:07:50 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:51 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_modem_list()
Jun 09 14:07:52 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:52 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:52 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:52 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:52 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:52 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:55 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:55 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:55 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:55 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:55 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:55 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:07:56 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:remo=
ve_device() /sys/devices/sdhci-tegra.2/mmc_host/mmc1/mmc1:0001/mmc1:0001:1/=
net/wlan0
Jun 09 14:07:56 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:add_=
serial_device() Device is missing required OFONO_DRIVER property
Jun 09 14:07:58 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:chec=
k_modem_list()
Jun 09 14:07:58 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:07:58 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:07:58 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:07:58 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:07:58 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:07:58 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84
Jun 09 14:08:01 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 09 14:08:01 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 09 14:08:01 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 09 14:08:01 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 09 14:08:01 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -9 on RAT 8
Jun 09 14:08:01 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -84

During this period, the ofono service is checking signal strength every 3 s=
econds

Jun 10 09:08:10 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 10 09:08:10 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 10 09:08:10 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 10 09:08:10 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 10 09:08:10 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -10 on RAT 8
Jun 10 09:08:10 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -83
Jun 10 09:08:13 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()
Jun 10 09:08:13 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb()
Jun 10 09:08:13 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSSI: 56 on RAT 8
Jun 10 09:08:13 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Bit error rate: 65535 on RAT 8
Jun 10 09:08:13 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() RSRQ: -10 on RAT 8
Jun 10 09:08:13 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:get_rssi_cb() Got LTE RSRP: -83
Jun 10 09:08:20 CTM000053 ofonod[5208]: ../ofono-1.31/drivers/qmimodem/netm=
on.c:qmi_netmon_request_update()

ofono stops responding to dbus requests

Jun 10 09:10:06 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:remo=
ve_device() /sys/devices/virtual/net/tun0
Jun 10 09:12:38 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/udevng.c:remo=
ve_device() /sys/devices/virtual/net/tun1
Jun 10 09:15:39 CTM000053 ofonod[5208]: ../ofono-1.31/src/modem.c:get_modem=
_property() modem 0x556990d690 property AlwaysOnline
Jun 10 09:15:39 CTM000053 ofonod[5208]: ../ofono-1.31/plugins/gobi.c:gobi_s=
et_online() 0x556990d690 offline
-- Reboot --
--===============4943083540755903676==--

