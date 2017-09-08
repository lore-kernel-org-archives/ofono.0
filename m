Content-Type: multipart/mixed; boundary="===============7866464547657036285=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: [PATCH 1/1] udev: devnode is not a required modem property
Date: Thu, 07 Sep 2017 23:06:11 -0700
Message-ID: <20170908060611.GE3@computer.craftyguy.net>
In-Reply-To: <20170908031758.32608-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7866464547657036285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,
I have tested the patch, looks like initialization gets a little
further but it seems that ofono gives up and removes the modem. The
'list-modems' test script doesn't show the modem after launch. Here's
the output from "ofonod -nd" using your patch:


localhost:/home/user/ofono# ./src/ofonod -nd
ofonod[18669]: oFono version 1.20
ofonod[18669]: src/plugin.c:__ofono_plugin_init() =

ofonod[18669]: src/gprs-provision.c:ofono_gprs_provision_driver_register() =
driver: 0x63f248 name: GPRS context provisioning
ofonod[18669]: plugins/push-notification.c:push_notification_init() =

ofonod[18669]: plugins/smart-messaging.c:smart_messaging_init() =

ofonod[18669]: plugins/emulator_fuzz.c:emulator_fuzz_init() =

ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63f360, =
name: stktest
ofonod[18669]: src/modem.c:ofono_modem_create() name: stktest, type: stktest
ofonod[18669]: src/modem.c:ofono_modem_register() 0x64f120
ofonod[18669]: plugins/stktest.c:stktest_probe() 0x64f120
ofonod[18669]: src/modem.c:emit_modem_added() 0x64f120
ofonod[18669]: src/modem.c:call_modemwatches() 0x64f120 added:1
ofonod[18669]: plugins/smart-messaging.c:modem_watch() modem: 0x64f120, add=
ed: 1
ofonod[18669]: plugins/push-notification.c:modem_watch() modem: 0x64f120, a=
dded: 1
ofonod[18669]: examples/emulator.c:example_emulator_init() =

ofonod[18669]: examples/emulator.c:modem_watch() modem: 0x64f120, added: 1
ofonod[18669]: src/gprs-provision.c:ofono_gprs_provision_driver_register() =
driver: 0x63f2e4 name: Example GPRS context provisioning
ofonod[18669]: src/nettime.c:ofono_nettime_driver_register() driver: 0x63f2=
b4 name: Example Network Time
ofonod[18669]: src/history.c:ofono_history_driver_register() driver: 0x63f2=
74 name: Example Call History
ofonod[18669]: src/cdma-provision.c:ofono_cdma_provision_driver_register() =
driver: 0x63f21c name: CDMA provisioning
ofonod[18669]: src/gprs-provision.c:ofono_gprs_provision_driver_register() =
driver: 0x63f1f0 name: Provisioning
ofonod[18669]: plugins/upower.c:upower_init() upower init
ofonod[18669]: src/handsfree-audio.c:ofono_handsfree_card_driver_register()=
 driver: 0x63f19c
ofonod[18669]: plugins/hfp_ag_bluez5.c:modem_watch() modem: 0x64f120, added=
: 1
ofonod[18669]: plugins/dun_gw_bluez5.c:dun_gw_init() =

ofonod[18669]: plugins/dun_gw_bluez5.c:modem_watch() modem: 0x64f120, added=
: 1
ofonod[18669]: src/handsfree-audio.c:ofono_handsfree_card_driver_register()=
 driver: 0x63f100
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63f114, =
name: hfp
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63f0b8, =
name: ublox
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63f060, =
name: quectel
ofonod[18669]: plugins/telit.c:telit_init() =

ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63f010, =
name: telit
ofonod[18669]: plugins/connman.c:connman_init() =

ofonod[18669]: src/private-network.c:ofono_private_network_driver_register(=
) driver: 0x63efe4, name: ConnMan Private Network
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ef9c, =
name: sim900
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ef54, =
name: samsung
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ef0c, =
name: speedupcdma
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63eebc, =
name: speedup
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ee74, =
name: alcatel
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ee1c, =
name: icera
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63edd4, =
name: linktop
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ed8c, =
name: nokiacdma
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ed44, =
name: nokia
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ecec, =
name: gemalto
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63eca4, =
name: cinterion
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ec1c, =
name: ste
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ebc4, =
name: ifx
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63eb7c, =
name: palmpre
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63eb2c, =
name: novatel
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63eae4, =
name: sierra
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ea6c, =
name: huawei
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63ea24, =
name: zte
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63e9c4, =
name: hso
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63e974, =
name: mbm
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63e924, =
name: calypso
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63e8dc, =
name: wavecom
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63e894, =
name: g1
ofonod[18669]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register() =
driver: 0x63e838, name: cdmamodem
ofonod[18669]: src/modem.c:ofono_devinfo_driver_register() driver: 0x63e860=
, name: cdmamodem
ofonod[18669]: src/cdma-connman.c:ofono_cdma_connman_driver_register() driv=
er: 0x63e880, name: cdmamodem
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63e798, =
name: phonesim
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63e7d0, =
name: localhfp
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
e77c, name: phonesim
ofonod[18669]: src/ctm.c:ofono_ctm_driver_register() driver: 0x63e768, name=
: phonesim
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63e740, name: phonesim
ofonod[18669]: plugins/phonesim.c:parse_config() filename /etc/ofono/phones=
im.conf
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63e718, name: xmm7modem
ofonod[18669]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister() driver: 0x63e6d8, name: gemaltomodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
e65c, name: ubloxmodem
ofonod[18669]: src/netmon.c:ofono_netmon_driver_register() driver: 0x63e688=
, name: ubloxmodem
ofonod[18669]: src/lte.c:ofono_lte_driver_register() driver: 0x63e6a0, name=
: ubloxmodem
ofonod[18669]: src/ussd.c:ofono_ussd_driver_register() driver: 0x63e618, na=
me: speedupmodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63e4d4, name: hfpmodem
ofonod[18669]: src/modem.c:ofono_devinfo_driver_register() driver: 0x63e578=
, name: hfpmodem
ofonod[18669]: src/network.c:ofono_netreg_driver_register() driver: 0x63e52=
c, name: hfpmodem
ofonod[18669]: src/call-volume.c:ofono_call_volume_driver_register() driver=
: 0x63e560, name: hfpmodem
ofonod[18669]: src/handsfree.c:ofono_handsfree_driver_register() driver: 0x=
63e5a8, name: hfpmodem
ofonod[18669]: src/siri.c:ofono_siri_driver_register() driver: 0x63e5e0, na=
me: hfpmodem
ofonod[18669]: src/network.c:ofono_netreg_driver_register() driver: 0x63e44=
c, name: dunmodem
ofonod[18669]: src/gprs.c:ofono_gprs_driver_register() driver: 0x63e470, na=
me: dunmodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63e37c, name: stemodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
e408, name: stemodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63e3cc, name: stemodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63e258, name: ifxmodem
ofonod[18669]: src/audio-settings.c:ofono_audio_settings_driver_register() =
driver: 0x63e2b0, name: ifxmodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63e2c4, name: ifxmodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
e2fc, name: ifxmodem
ofonod[18669]: src/stk.c:ofono_stk_driver_register() driver: 0x63e328, name=
: ifxmodem
ofonod[18669]: src/ctm.c:ofono_ctm_driver_register() driver: 0x63e348, name=
: ifxmodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
e1e4, name: hsomodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63e208, name: hsomodem
ofonod[18669]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister() driver: 0x63e178, name: telitmodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
e1a0, name: telitncmmodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
e0ec, name: mbmmodem
ofonod[18669]: src/stk.c:ofono_stk_driver_register() driver: 0x63e110, name=
: mbmmodem
ofonod[18669]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister() driver: 0x63e130, name: mbmmodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63e054, name: calypsomodem
ofonod[18669]: src/stk.c:ofono_stk_driver_register() driver: 0x63e0a4, name=
: calypsomodem
ofonod[18669]: src/ussd.c:ofono_ussd_driver_register() driver: 0x63df58, na=
me: huaweimodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63df6c, name: huaweimodem
ofonod[18669]: src/audio-settings.c:ofono_audio_settings_driver_register() =
driver: 0x63dfbc, name: huaweimodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63dff4, name: huaweimodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
dfd0, name: huaweimodem
ofonod[18669]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver=
: 0x63e024, name: huaweimodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
dedc, name: iceramodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63df08, name: iceramodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63de84, name: ztemodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
de40, name: swmodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63ddf8, name: nwmodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63dc54, name: atmodem
ofonod[18669]: src/modem.c:ofono_devinfo_driver_register() driver: 0x63dcec=
, name: atmodem
ofonod[18669]: src/call-barring.c:ofono_call_barring_driver_register() driv=
er: 0x63dca4, name: atmodem
ofonod[18669]: src/call-forwarding.c:ofono_call_forwarding_driver_register(=
) driver: 0x63da2c, name: atmodem
ofonod[18669]: src/call-meter.c:ofono_call_meter_driver_register() driver: =
0x63da6c, name: atmodem
ofonod[18669]: src/call-settings.c:ofono_call_settings_driver_register() dr=
iver: 0x63d978, name: atmodem
ofonod[18669]: src/phonebook.c:ofono_phonebook_driver_register() driver: 0x=
63dcd4, name: atmodem
ofonod[18669]: src/ussd.c:ofono_ussd_driver_register() driver: 0x63dc30, na=
me: atmodem
ofonod[18669]: src/sms.c:ofono_sms_driver_register() driver: 0x63d9e8, name=
: atmodem
ofonod[18669]: src/sim.c:ofono_sim_driver_register() driver: 0x63db70, name=
: atmodem
ofonod[18669]: src/sim.c:ofono_sim_driver_register() driver: 0x63dbb8, name=
: atmodem-noef
ofonod[18669]: src/stk.c:ofono_stk_driver_register() driver: 0x63dc08, name=
: atmodem
ofonod[18669]: src/network.c:ofono_netreg_driver_register() driver: 0x63dad=
0, name: atmodem
ofonod[18669]: src/cbs.c:ofono_cbs_driver_register() driver: 0x63da10, name=
: atmodem
ofonod[18669]: src/call-volume.c:ofono_call_volume_driver_register() driver=
: 0x63dd1c, name: atmodem
ofonod[18669]: src/gprs.c:ofono_gprs_driver_register() driver: 0x63dd4c, na=
me: atmodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
dd68, name: atmodem
ofonod[18669]: src/sim-auth.c:ofono_sim_auth_driver_register() driver: 0x63=
dd8c, name: atmodem
ofonod[18669]: src/gnss.c:ofono_gnss_driver_register() driver: 0x63ddac, na=
me: atmodem
ofonod[18669]: src/lte.c:ofono_lte_driver_register() driver: 0x63ddc0, name=
: atmodem
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63d8d8, =
name: gobi
ofonod[18669]: src/modem.c:ofono_devinfo_driver_register() driver: 0x63d718=
, name: qmimodem
ofonod[18669]: src/network.c:ofono_netreg_driver_register() driver: 0x63d78=
0, name: qmimodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63d738, name: qmimodem
ofonod[18669]: src/sim.c:ofono_sim_driver_register() driver: 0x63d7a4, name=
: qmimodem-legacy
ofonod[18669]: src/sim.c:ofono_sim_driver_register() driver: 0x63d7ec, name=
: qmimodem
ofonod[18669]: src/sms.c:ofono_sms_driver_register() driver: 0x63d834, name=
: qmimodem
ofonod[18669]: src/ussd.c:ofono_ussd_driver_register() driver: 0x63d854, na=
me: qmimodem
ofonod[18669]: src/gprs.c:ofono_gprs_driver_register() driver: 0x63d868, na=
me: qmimodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
d87c, name: qmimodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63d898, name: qmimodem
ofonod[18669]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister() driver: 0x63d8c0, name: qmimodem
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63d6b0, =
name: u8500
ofonod[18669]: src/modem.c:ofono_devinfo_driver_register() driver: 0x63d690=
, name: u8500
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63d648, =
name: n900
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63d600, =
name: isiusb
ofonod[18669]: src/modem.c:ofono_devinfo_driver_register() driver: 0x63d3a8=
, name: isimodem
ofonod[18669]: src/phonebook.c:ofono_phonebook_driver_register() driver: 0x=
63d398, name: isimodem
ofonod[18669]: src/network.c:ofono_netreg_driver_register() driver: 0x63d3c=
8, name: isimodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63d3ec, name: isimodem
ofonod[18669]: src/sms.c:ofono_sms_driver_register() driver: 0x63d434, name=
: isimodem
ofonod[18669]: src/cbs.c:ofono_cbs_driver_register() driver: 0x63d454, name=
: isimodem
ofonod[18669]: src/sim.c:ofono_sim_driver_register() driver: 0x63d468, name=
: isimodem
ofonod[18669]: src/ussd.c:ofono_ussd_driver_register() driver: 0x63d4b0, na=
me: isimodem
ofonod[18669]: src/call-forwarding.c:ofono_call_forwarding_driver_register(=
) driver: 0x63d4c4, name: isimodem
ofonod[18669]: src/call-settings.c:ofono_call_settings_driver_register() dr=
iver: 0x63d4e4, name: isimodem
ofonod[18669]: src/call-barring.c:ofono_call_barring_driver_register() driv=
er: 0x63d514, name: isimodem
ofonod[18669]: src/call-meter.c:ofono_call_meter_driver_register() driver: =
0x63d52c, name: isimodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63d554, name: isimodem
ofonod[18669]: src/gprs.c:ofono_gprs_driver_register() driver: 0x63d57c, na=
me: isimodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
d590, name: isimodem
ofonod[18669]: src/audio-settings.c:ofono_audio_settings_driver_register() =
driver: 0x63d5ac, name: isimodem
ofonod[18669]: src/sim.c:ofono_sim_driver_register() driver: 0x63d5b8, name=
: wgmodem2.5
ofonod[18669]: drivers/rilmodem/rilmodem.c:rilmodem_init() =

ofonod[18669]: src/modem.c:ofono_devinfo_driver_register() driver: 0x63d14c=
, name: rilmodem
ofonod[18669]: drivers/rilmodem/sim.c:ril_sim_init() =

ofonod[18669]: src/sim.c:ofono_sim_driver_register() driver: 0x63d220, name=
: rilmodem
ofonod[18669]: src/voicecall.c:ofono_voicecall_driver_register() driver: 0x=
63d190, name: rilmodem
ofonod[18669]: src/sms.c:ofono_sms_driver_register() driver: 0x63d268, name=
: rilmodem
ofonod[18669]: src/network.c:ofono_netreg_driver_register() driver: 0x63d16=
c, name: rilmodem
ofonod[18669]: src/call-volume.c:ofono_call_volume_driver_register() driver=
: 0x63d1d8, name: rilmodem
ofonod[18669]: src/gprs.c:ofono_gprs_driver_register() driver: 0x63d1f0, na=
me: rilmodem
ofonod[18669]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x63=
d204, name: rilmodem
ofonod[18669]: src/ussd.c:ofono_ussd_driver_register() driver: 0x63d288, na=
me: rilmodem
ofonod[18669]: src/call-settings.c:ofono_call_settings_driver_register() dr=
iver: 0x63d29c, name: rilmodem
ofonod[18669]: src/call-forwarding.c:ofono_call_forwarding_driver_register(=
) driver: 0x63d2cc, name: rilmodem
ofonod[18669]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x63d2ec, name: rilmodem
ofonod[18669]: src/call-barring.c:ofono_call_barring_driver_register() driv=
er: 0x63d314, name: rilmodem
ofonod[18669]: src/netmon.c:ofono_netmon_driver_register() driver: 0x63d32c=
, name: rilmodem
ofonod[18669]: src/stk.c:ofono_stk_driver_register() driver: 0x63d33c, name=
: rilmodem
ofonod[18669]: src/cbs.c:ofono_cbs_driver_register() driver: 0x63d354, name=
: rilmodem
ofonod[18669]: src/lte.c:ofono_lte_driver_register() driver: 0x63d368, name=
: rilmodem
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63d0e4, =
name: ril_intel
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63d09c, =
name: infineon
ofonod[18669]: src/modem.c:ofono_modem_driver_register() driver: 0x63d054, =
name: ril
ofonod[18669]: plugins/udevng.c:udev_start() =

ofonod[18669]: plugins/udevng.c:enumerate_devices() =

ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() /sys/devices/platform/6=
8000000.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[18669]: plugins/udevng.c:add_serial_device() /devices/platform/68000=
000.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[18669]: plugins/udevng.c:add_serial_device() (null) (n900)
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[18669]: plugins/udevng.c:create_modem() /sys/devices/platform/680000=
00.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[18669]: plugins/udevng.c:create_modem() driver=3Dlegacy
ofonod[18669]: src/modem.c:ofono_modem_create() name: (null), type: legacy
ofonod[18669]: plugins/udevng.c:destroy_modem() /sys/devices/platform/68000=
000.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[18669]: src/modem.c:ofono_modem_remove() 0x658f10
ofonod[18669]: src/private-network.c:ofono_private_network_driver_register(=
) driver: 0x63f334, name: Example Private Network Driver




On Fri, Sep 08, 2017 at 05:17:58AM +0200, Jonas Bonn wrote:
>A devnode does not always exist; the Nokia N900, for example, does not
>provide one for its modem.
>
>This patch relaxes the check on device properties to exclude the
>requirement of a devnode.
>
>The "Device" property is not used by the n900 or u8500 drivers, so drop
>setting this property when setting up these devices.
>---
>
>Hi Clayton,
>
>Could you try this patch and see if the N900 is detected?
>
>Thanks,
>Jonas
>
> plugins/udevng.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/plugins/udevng.c b/plugins/udevng.c
>index 518eda8..241fcda 100644
>--- a/plugins/udevng.c
>+++ b/plugins/udevng.c
>@@ -1013,8 +1013,6 @@ static gboolean setup_isi_serial(struct modem_info* =
modem)
> 	if (value)
> 		ofono_modem_set_integer(modem->modem, "Address", atoi(value));
>
>-	ofono_modem_set_string(modem->modem, "Device", info->devnode);
>-
> 	return TRUE;
> }
>
>@@ -1325,7 +1323,7 @@ static void add_serial_device(struct udev_device *de=
v)
>
> 	devnode =3D udev_device_get_devnode(dev);
>
>-	if (!syspath || !devname || !devpath || !devnode)
>+	if (!syspath || !devpath)
> 		return;
>
> 	modem =3D g_hash_table_lookup(modem_list, syspath);
>-- =

>2.9.3
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>https://lists.ofono.org/mailman/listinfo/ofono


--===============7866464547657036285==--

