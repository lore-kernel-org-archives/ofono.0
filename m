Content-Type: multipart/mixed; boundary="===============1368285167173485666=="
MIME-Version: 1.0
From: Dresdo Gabriele <Gdresdo@dmd.it>
Subject: Telit ME910C1-WW not detected
Date: Tue, 23 Jul 2019 12:50:06 +0000
Message-ID: <599D0C5744F85B4480C6B0762332A90524D0FE4F@dmdgate08-vm02.DMD06.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1368285167173485666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm new to oFono, I'm trying to setup a Telit ME910C1 with oFono 1.18 in ou=
r embedded system (ARMHF) with Debian stretch kernel 4.9.11 but list-modems=
 returns no results.

I installed ofono packet using apt-get

I can send and receive AT commands to the modem using a terminal connected =
to /dev/ttyUSB1

I paste Log from ofonod -dn. =

 =

Any suggestion will be useful

Thanks

Gabriele



ofonod[592]: oFono version 1.18
ofonod[592]: src/plugin.c:__ofono_plugin_init() =

ofonod[592]: plugins/push-notification.c:push_notification_init() =

ofonod[592]: plugins/smart-messaging.c:smart_messaging_init() =

ofonod[592]: src/cdma-provision.c:ofono_cdma_provision_driver_register() dr=
iver: 0x54c3f868 name: CDMA provisioning
ofonod[592]: src/gprs-provision.c:ofono_gprs_provision_driver_register() dr=
iver: 0x54c3f83c name: Provisioning
ofonod[592]: plugins/upower.c:upower_init() upower init
ofonod[592]: src/handsfree-audio.c:ofono_handsfree_card_driver_register() d=
river: 0x54c3f7e8
ofonod[592]: plugins/dun_gw_bluez5.c:dun_gw_init() =

ofonod[592]: src/handsfree-audio.c:ofono_handsfree_card_driver_register() d=
river: 0x54c3f74c
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f760, =
name: hfp
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f704, =
name: ublox
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f6ac, =
name: quectel
ofonod[592]: plugins/he910.c:he910_init() =

ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f65c, =
name: he910
ofonod[592]: plugins/connman.c:connman_init() =

ofonod[592]: src/private-network.c:ofono_private_network_driver_register() =
driver: 0x54c3f630, name: ConnMan Private Network
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f5e8, =
name: sim900
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f5a0, =
name: samsung
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f558, =
name: speedupcdma
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f508, =
name: speedup
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f4c0, =
name: alcatel
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f468, =
name: icera
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f420, =
name: linktop
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f3d8, =
name: nokiacdma
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f390, =
name: nokia
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f348, =
name: cinterion
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f2c0, =
name: ste
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f268, =
name: ifx
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f220, =
name: palmpre
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f1d0, =
name: novatel
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f188, =
name: sierra
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f110, =
name: huawei
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f0c8, =
name: zte
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f068, =
name: hso
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3f018, =
name: mbm
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3efc8, =
name: calypso
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3ef80, =
name: wavecom
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3ef38, =
name: g1
ofonod[592]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register() dr=
iver: 0x54c3eedc, name: cdmamodem
ofonod[592]: src/modem.c:ofono_devinfo_driver_register() driver: 0x54c3ef04=
, name: cdmamodem
ofonod[592]: src/cdma-connman.c:ofono_cdma_connman_driver_register() driver=
: 0x54c3ef24, name: cdmamodem
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3ee3c, =
name: phonesim
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3ee6c, =
name: localhfp
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
ee20, name: phonesim
ofonod[592]: src/ctm.c:ofono_ctm_driver_register() driver: 0x54c3ee0c, name=
: phonesim
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3ede4, name: phonesim
ofonod[592]: plugins/phonesim.c:parse_config() filename /etc/ofono/phonesim=
.conf
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
edc8, name: ubloxmodem
ofonod[592]: src/ussd.c:ofono_ussd_driver_register() driver: 0x54c3ed8c, na=
me: speedupmodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3ec48, name: hfpmodem
ofonod[592]: src/modem.c:ofono_devinfo_driver_register() driver: 0x54c3ecec=
, name: hfpmodem
ofonod[592]: src/network.c:ofono_netreg_driver_register() driver: 0x54c3eca=
0, name: hfpmodem
ofonod[592]: src/call-volume.c:ofono_call_volume_driver_register() driver: =
0x54c3ecd4, name: hfpmodem
ofonod[592]: src/handsfree.c:ofono_handsfree_driver_register() driver: 0x54=
c3ed1c, name: hfpmodem
ofonod[592]: src/siri.c:ofono_siri_driver_register() driver: 0x54c3ed54, na=
me: hfpmodem
ofonod[592]: src/network.c:ofono_netreg_driver_register() driver: 0x54c3ebc=
0, name: dunmodem
ofonod[592]: src/gprs.c:ofono_gprs_driver_register() driver: 0x54c3ebe4, na=
me: dunmodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3eaf0, name: stemodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
eb7c, name: stemodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3eb40, name: stemodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3e9cc, name: ifxmodem
ofonod[592]: src/audio-settings.c:ofono_audio_settings_driver_register() dr=
iver: 0x54c3ea24, name: ifxmodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3ea38, name: ifxmodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
ea70, name: ifxmodem
ofonod[592]: src/stk.c:ofono_stk_driver_register() driver: 0x54c3ea9c, name=
: ifxmodem
ofonod[592]: src/ctm.c:ofono_ctm_driver_register() driver: 0x54c3eabc, name=
: ifxmodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
e958, name: hsomodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3e97c, name: hsomodem
ofonod[592]: src/location-reporting.c:ofono_location_reporting_driver_regis=
ter() driver: 0x54c3e918, name: telitmodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
e88c, name: mbmmodem
ofonod[592]: src/stk.c:ofono_stk_driver_register() driver: 0x54c3e8b0, name=
: mbmmodem
ofonod[592]: src/location-reporting.c:ofono_location_reporting_driver_regis=
ter() driver: 0x54c3e8d0, name: mbmmodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3e7f4, name: calypsomodem
ofonod[592]: src/stk.c:ofono_stk_driver_register() driver: 0x54c3e844, name=
: calypsomodem
ofonod[592]: src/ussd.c:ofono_ussd_driver_register() driver: 0x54c3e6f8, na=
me: huaweimodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3e70c, name: huaweimodem
ofonod[592]: src/audio-settings.c:ofono_audio_settings_driver_register() dr=
iver: 0x54c3e75c, name: huaweimodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3e794, name: huaweimodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
e770, name: huaweimodem
ofonod[592]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver: =
0x54c3e7c4, name: huaweimodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
e67c, name: iceramodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3e6a8, name: iceramodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3e624, name: ztemodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
e5e0, name: swmodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3e598, name: nwmodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3e40c, name: atmodem
ofonod[592]: src/modem.c:ofono_devinfo_driver_register() driver: 0x54c3e4a4=
, name: atmodem
ofonod[592]: src/call-barring.c:ofono_call_barring_driver_register() driver=
: 0x54c3e45c, name: atmodem
ofonod[592]: src/call-forwarding.c:ofono_call_forwarding_driver_register() =
driver: 0x54c3e1e4, name: atmodem
ofonod[592]: src/call-meter.c:ofono_call_meter_driver_register() driver: 0x=
54c3e224, name: atmodem
ofonod[592]: src/call-settings.c:ofono_call_settings_driver_register() driv=
er: 0x54c3e130, name: atmodem
ofonod[592]: src/phonebook.c:ofono_phonebook_driver_register() driver: 0x54=
c3e48c, name: atmodem
ofonod[592]: src/ussd.c:ofono_ussd_driver_register() driver: 0x54c3e3e8, na=
me: atmodem
ofonod[592]: src/sms.c:ofono_sms_driver_register() driver: 0x54c3e1a0, name=
: atmodem
ofonod[592]: src/sim.c:ofono_sim_driver_register() driver: 0x54c3e328, name=
: atmodem
ofonod[592]: src/sim.c:ofono_sim_driver_register() driver: 0x54c3e370, name=
: atmodem-noef
ofonod[592]: src/stk.c:ofono_stk_driver_register() driver: 0x54c3e3c0, name=
: atmodem
ofonod[592]: src/network.c:ofono_netreg_driver_register() driver: 0x54c3e28=
8, name: atmodem
ofonod[592]: src/cbs.c:ofono_cbs_driver_register() driver: 0x54c3e1c8, name=
: atmodem
ofonod[592]: src/call-volume.c:ofono_call_volume_driver_register() driver: =
0x54c3e4d4, name: atmodem
ofonod[592]: src/gprs.c:ofono_gprs_driver_register() driver: 0x54c3e504, na=
me: atmodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
e518, name: atmodem
ofonod[592]: src/sim-auth.c:ofono_sim_auth_driver_register() driver: 0x54c3=
e53c, name: atmodem
ofonod[592]: src/gnss.c:ofono_gnss_driver_register() driver: 0x54c3e55c, na=
me: atmodem
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3e090, =
name: gobi
ofonod[592]: src/modem.c:ofono_devinfo_driver_register() driver: 0x54c3ded0=
, name: qmimodem
ofonod[592]: src/network.c:ofono_netreg_driver_register() driver: 0x54c3df3=
8, name: qmimodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3def0, name: qmimodem
ofonod[592]: src/sim.c:ofono_sim_driver_register() driver: 0x54c3df5c, name=
: qmimodem-legacy
ofonod[592]: src/sim.c:ofono_sim_driver_register() driver: 0x54c3dfa4, name=
: qmimodem
ofonod[592]: src/sms.c:ofono_sms_driver_register() driver: 0x54c3dfec, name=
: qmimodem
ofonod[592]: src/ussd.c:ofono_ussd_driver_register() driver: 0x54c3e00c, na=
me: qmimodem
ofonod[592]: src/gprs.c:ofono_gprs_driver_register() driver: 0x54c3e020, na=
me: qmimodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
e034, name: qmimodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3e050, name: qmimodem
ofonod[592]: src/location-reporting.c:ofono_location_reporting_driver_regis=
ter() driver: 0x54c3e078, name: qmimodem
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3de68, =
name: u8500
ofonod[592]: src/modem.c:ofono_devinfo_driver_register() driver: 0x54c3de48=
, name: u8500
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3de00, =
name: n900
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3ddb8, =
name: isiusb
ofonod[592]: src/modem.c:ofono_devinfo_driver_register() driver: 0x54c3db60=
, name: isimodem
ofonod[592]: src/phonebook.c:ofono_phonebook_driver_register() driver: 0x54=
c3db50, name: isimodem
ofonod[592]: src/network.c:ofono_netreg_driver_register() driver: 0x54c3db8=
0, name: isimodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3dba4, name: isimodem
ofonod[592]: src/sms.c:ofono_sms_driver_register() driver: 0x54c3dbec, name=
: isimodem
ofonod[592]: src/cbs.c:ofono_cbs_driver_register() driver: 0x54c3dc0c, name=
: isimodem
ofonod[592]: src/sim.c:ofono_sim_driver_register() driver: 0x54c3dc20, name=
: isimodem
ofonod[592]: src/ussd.c:ofono_ussd_driver_register() driver: 0x54c3dc68, na=
me: isimodem
ofonod[592]: src/call-forwarding.c:ofono_call_forwarding_driver_register() =
driver: 0x54c3dc7c, name: isimodem
ofonod[592]: src/call-settings.c:ofono_call_settings_driver_register() driv=
er: 0x54c3dc9c, name: isimodem
ofonod[592]: src/call-barring.c:ofono_call_barring_driver_register() driver=
: 0x54c3dccc, name: isimodem
ofonod[592]: src/call-meter.c:ofono_call_meter_driver_register() driver: 0x=
54c3dce4, name: isimodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3dd0c, name: isimodem
ofonod[592]: src/gprs.c:ofono_gprs_driver_register() driver: 0x54c3dd34, na=
me: isimodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
dd48, name: isimodem
ofonod[592]: src/audio-settings.c:ofono_audio_settings_driver_register() dr=
iver: 0x54c3dd64, name: isimodem
ofonod[592]: src/sim.c:ofono_sim_driver_register() driver: 0x54c3dd70, name=
: wgmodem2.5
ofonod[592]: drivers/rilmodem/rilmodem.c:rilmodem_init() =

ofonod[592]: src/modem.c:ofono_devinfo_driver_register() driver: 0x54c3d928=
, name: rilmodem
ofonod[592]: drivers/rilmodem/sim.c:ril_sim_init() =

ofonod[592]: src/sim.c:ofono_sim_driver_register() driver: 0x54c3d9fc, name=
: rilmodem
ofonod[592]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x54=
c3d96c, name: rilmodem
ofonod[592]: src/sms.c:ofono_sms_driver_register() driver: 0x54c3da44, name=
: rilmodem
ofonod[592]: src/network.c:ofono_netreg_driver_register() driver: 0x54c3d94=
8, name: rilmodem
ofonod[592]: src/call-volume.c:ofono_call_volume_driver_register() driver: =
0x54c3d9b4, name: rilmodem
ofonod[592]: src/gprs.c:ofono_gprs_driver_register() driver: 0x54c3d9cc, na=
me: rilmodem
ofonod[592]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x54c3=
d9e0, name: rilmodem
ofonod[592]: src/ussd.c:ofono_ussd_driver_register() driver: 0x54c3da64, na=
me: rilmodem
ofonod[592]: src/call-settings.c:ofono_call_settings_driver_register() driv=
er: 0x54c3da78, name: rilmodem
ofonod[592]: src/call-forwarding.c:ofono_call_forwarding_driver_register() =
driver: 0x54c3daa8, name: rilmodem
ofonod[592]: src/radio-settings.c:ofono_radio_settings_driver_register() dr=
iver: 0x54c3dac8, name: rilmodem
ofonod[592]: src/call-barring.c:ofono_call_barring_driver_register() driver=
: 0x54c3daf0, name: rilmodem
ofonod[592]: src/netmon.c:ofono_netmon_driver_register() driver: 0x54c3db08=
, name: rilmodem
ofonod[592]: src/stk.c:ofono_stk_driver_register() driver: 0x54c3db18, name=
: rilmodem
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3d8c0, =
name: ril_sofia3gr
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3d878, =
name: infineon
ofonod[592]: src/modem.c:ofono_modem_driver_register() driver: 0x54c3d830, =
name: ril
ofonod[592]: plugins/udevng.c:udev_start() =

ofonod[592]: plugins/udevng.c:enumerate_devices() =

ofonod[592]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[592]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[592]: plugins/udevng.c:check_usb_device() usb [0424:2514]
ofonod[592]: plugins/udevng.c:check_usb_device() usb [1bc7:1101]
ofonod[592]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[592]: plugins/udevng.c:check_usb_device() option [1bc7:1101]
ofonod[592]: plugins/udevng.c:add_device() /sys/devices/soc0/soc/2100000.ai=
ps-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3
ofonod[592]: plugins/udevng.c:add_device() /sys/devices/soc0/soc/2100000.ai=
ps-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3/2-1.3:1.0/ttyUSB0/tty/ttyUSB0
ofonod[592]: plugins/udevng.c:add_device() /dev/ttyUSB0 (telit) 255/255/255=
 [00] =3D=3D> (null) (null)
ofonod[592]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[592]: plugins/udevng.c:check_usb_device() option [1bc7:1101]
ofonod[592]: plugins/udevng.c:add_device() /sys/devices/soc0/soc/2100000.ai=
ps-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3
ofonod[592]: plugins/udevng.c:add_device() /sys/devices/soc0/soc/2100000.ai=
ps-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3/2-1.3:1.1/ttyUSB1/tty/ttyUSB1
ofonod[592]: plugins/udevng.c:add_device() /dev/ttyUSB1 (telit) 255/255/255=
 [01] =3D=3D> (null) (null)
ofonod[592]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[592]: plugins/udevng.c:check_usb_device() option [1bc7:1101]
ofonod[592]: plugins/udevng.c:add_device() /sys/devices/soc0/soc/2100000.ai=
ps-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3
ofonod[592]: plugins/udevng.c:add_device() /sys/devices/soc0/soc/2100000.ai=
ps-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3/2-1.3:1.2/ttyUSB2/tty/ttyUSB2
ofonod[592]: plugins/udevng.c:add_device() /dev/ttyUSB2 (telit) 255/254/255=
 [02] =3D=3D> (null) (null)
ofonod[592]: plugins/udevng.c:check_usb_device() option [(null):(null)]
ofonod[592]: plugins/udevng.c:check_usb_device() option [1bc7:1101]
ofonod[592]: plugins/udevng.c:add_device() /sys/devices/soc0/soc/2100000.ai=
ps-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3
ofonod[592]: plugins/udevng.c:add_device() /sys/devices/soc0/soc/2100000.ai=
ps-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3/2-1.3:1.3/ttyUSB3/tty/ttyUSB3
ofonod[592]: plugins/udevng.c:add_device() /dev/ttyUSB3 (telit) 255/255/255=
 [03] =3D=3D> (null) (null)
ofonod[592]: plugins/udevng.c:check_usb_device() hub [(null):(null)]
ofonod[592]: plugins/udevng.c:create_modem() /sys/devices/soc0/soc/2100000.=
aips-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3
ofonod[592]: plugins/udevng.c:create_modem() driver=3Dtelit
ofonod[592]: src/modem.c:ofono_modem_create() name: (null), type: telit
ofonod[592]: plugins/udevng.c:setup_telit() /sys/devices/soc0/soc/2100000.a=
ips-bus/2184200.usb/ci_hdrc.1/usb2/2-1/2-1.3
ofonod[592]: plugins/udevng.c:setup_telit() /dev/ttyUSB0 255/255/255 00 (nu=
ll)
ofonod[592]: plugins/udevng.c:setup_telit() /dev/ttyUSB1 255/255/255 01 (nu=
ll)
ofonod[592]: plugins/udevng.c:setup_telit() /dev/ttyUSB2 255/254/255 02 (nu=
ll)
ofonod[592]: plugins/udevng.c:setup_telit() /dev/ttyUSB3 255/255/255 03 (nu=
ll)
ofonod[592]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyUSB0 aux=3D/dev=
/ttyUSB3 gps=3D(null) diag=3D/dev/ttyUSB1
ofonod[592]: src/modem.c:set_modem_property() modem 0x55d8e3d8 property Mod=
em
ofonod[592]: src/modem.c:set_modem_property() modem 0x55d8e3d8 property Aux
ofonod[592]: src/modem.c:set_modem_property() modem 0x55d8e3d8 property GPS
ofonod[592]: src/modem.c:ofono_modem_register() 0x55d8e3d8

--===============1368285167173485666==--

