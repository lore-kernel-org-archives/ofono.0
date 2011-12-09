Content-Type: multipart/mixed; boundary="===============8958142246025971170=="
MIME-Version: 1.0
From: Renat Zaripov <r.r.zaripov@gmail.com>
Subject: Re: ofono usage on embedded device
Date: Fri, 09 Dec 2011 16:37:23 +0300
Message-ID: <CAGNC_aMO6AXGJkBSLPm+ZCCnSWa9wwvE=RJ6R3tK--eAV9qLgA@mail.gmail.com>
In-Reply-To: <4EE20945.9000805@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8958142246025971170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/12/9 Daniel Wagner <wagi@monom.org>
>
> Hi Sergey,
>
> On 09.12.2011 14:08, Sergey Lapin wrote:
> > I'm interested in c) because somehow we have troubles with udev in our
> > device, systemd detects ttys perfectly while ofono can't find anything
> > and it seems
> > to see no tty devices at all, so we'd like to use systemd to provide
> > ofono with information regarding devices (tty and driver).
> > It is unable to connect to udev monitor also. udev version is 175.
>
> Could you provide some logs?

cat /etc/ydev/rules.d/ofono.rules

KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"atmodem"

ofonod log:

root(a)crux:/# ofonod -nd
ofonod[26058]: oFono version 1.0
ofonod[26058]: src/plugin.c:__ofono_plugin_init()
ofonod[26058]: plugins/push-notification.c:push_notification_init()
ofonod[26058]: plugins/smart-messaging.c:smart_messaging_init()
ofonod[26058]: plugins/connman.c:connman_init()
ofonod[26058]: src/private-network.c:ofono_private_network_driver_register()
driver: 0xe6700, name: ConnMan Private Network
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe66ac, name: sap
ofonod[26058]: plugins/dun_gw.c:dun_gw_init()
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe65d0, name: hfp
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe6568, name: samsung
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe6524, name: speedupcdma
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe64e0, name: speedup
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe649c, name: alcatel
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe642c, name: telit
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe63e8, name: linktop
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe63a4, name: nokiacdma
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe6360, name: nokia
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe631c, name: tc65
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe6298, name: ste
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe624c, name: ifx
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe6208, name: palmpre
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe61bc, name: novatel
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe6178, name: sierra
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe6134, name: huaweicdma
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe60d0, name: huawei
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe608c, name: zte
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe6038, name: hso
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe5fec, name: mbm
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe5fa0, name: calypso
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe5f5c, name: wavecom
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe5f18, name: gobi
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe5ed4, name: g1
ofonod[26058]: src/cdma-netreg.c:ofono_cdma_netreg_driver_register()
driver: 0xe5ec8, name: huaweicdmamodem
ofonod[26058]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0xe5e48, name: cdmamodem
ofonod[26058]: src/modem.c:ofono_devinfo_driver_register() driver:
0xe5e70, name: cdmamodem
ofonod[26058]: src/cdma-connman.c:ofono_cdma_connman_driver_register()
driver: 0xe5e8c, name: cdmamodem
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe5db8, name: phonesim
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe5de4, name: localhfp
ofonod[26058]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0xe5da4, name: phonesim
ofonod[26058]: src/ctm.c:ofono_ctm_driver_register() driver: 0xe5d90,
name: phonesim
ofonod[26058]: plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[26058]: plugins/phonesim.c:create_modem() group phonesim
ofonod[26058]: src/modem.c:ofono_modem_create() name: phonesim, type: phone=
sim
ofonod[26058]: src/modem.c:set_modem_property() modem 0x1142e0 property Add=
ress
ofonod[26058]: src/modem.c:set_modem_property() modem 0x1142e0 property Port
ofonod[26058]: src/modem.c:set_modem_property() modem 0x1142e0 property Mod=
em
ofonod[26058]: plugins/phonesim.c:create_modem() 0x1142e0
ofonod[26058]: src/modem.c:ofono_modem_register() 0x1142e0
ofonod[26058]: plugins/phonesim.c:phonesim_probe() 0x1142e0
ofonod[26058]: src/modem.c:emit_modem_added() 0x1142e0
ofonod[26058]: src/modem.c:call_modemwatches() 0x1142e0 added:1
ofonod[26058]: plugins/hfp_ag.c:modem_watch() modem: 0x1142e0, added: 1
ofonod[26058]: plugins/dun_gw.c:modem_watch() modem: 0x1142e0, added: 1
ofonod[26058]: plugins/smart-messaging.c:modem_watch() modem: 0x1142e0, add=
ed: 1
ofonod[26058]: plugins/push-notification.c:modem_watch() modem:
0x1142e0, added: 1
ofonod[26058]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0xe5cdc, name: hfpmodem
ofonod[26058]: src/network.c:ofono_netreg_driver_register() driver:
0xe5d34, name: hfpmodem
ofonod[26058]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0xe5d68, name: hfpmodem
ofonod[26058]: src/handsfree.c:ofono_handsfree_driver_register()
driver: 0xe5d80, name: hfpmodem
ofonod[26058]: src/network.c:ofono_netreg_driver_register() driver:
0xe5c5c, name: dunmodem
ofonod[26058]: src/gprs.c:ofono_gprs_driver_register() driver:
0xe5c80, name: dunmodem
ofonod[26058]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0xe5b98, name: stemodem
ofonod[26058]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0xe5c20, name: stemodem
ofonod[26058]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0xe5be8, name: stemodem
ofonod[26058]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0xe5a88, name: ifxmodem
ofonod[26058]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0xe5ad8, name: ifxmodem
ofonod[26058]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0xe5aec, name: ifxmodem
ofonod[26058]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0xe5b20, name: ifxmodem
ofonod[26058]: src/stk.c:ofono_stk_driver_register() driver: 0xe5b44,
name: ifxmodem
ofonod[26058]: src/ctm.c:ofono_ctm_driver_register() driver: 0xe5b64,
name: ifxmodem
ofonod[26058]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0xe5a20, name: hsomodem
ofonod[26058]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0xe5a3c, name: hsomodem
ofonod[26058]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0xe59a4, name: mbmmodem
ofonod[26058]: src/stk.c:ofono_stk_driver_register() driver: 0xe59c0,
name: mbmmodem
ofonod[26058]: src/location-reporting.c:ofono_location_reporting_driver_reg=
ister()
driver: 0xe59e0, name: mbmmodem
ofonod[26058]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0xe590c, name: calypsomodem
ofonod[26058]: src/stk.c:ofono_stk_driver_register() driver: 0xe595c,
name: calypsomodem
ofonod[26058]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0xe5848, name: huaweimodem
ofonod[26058]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0xe5898, name: huaweimodem
ofonod[26058]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0xe58c8, name: huaweimodem
ofonod[26058]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0xe58ac, name: huaweimodem
ofonod[26058]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0xe5804, name: nwmodem
ofonod[26058]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0xe5684, name: atmodem
ofonod[26058]: src/modem.c:ofono_devinfo_driver_register() driver:
0xe571c, name: atmodem
ofonod[26058]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0xe56d4, name: atmodem
ofonod[26058]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0xe54e4, name: atmodem
ofonod[26058]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0xe5524, name: atmodem
ofonod[26058]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0xe5430, name: atmodem
ofonod[26058]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0xe5704, name: atmodem
ofonod[26058]: src/ussd.c:ofono_ussd_driver_register() driver:
0xe5660, name: atmodem
ofonod[26058]: src/sms.c:ofono_sms_driver_register() driver: 0xe54a0,
name: atmodem
ofonod[26058]: src/sim.c:ofono_sim_driver_register() driver: 0xe55e8,
name: atmodem
ofonod[26058]: src/stk.c:ofono_stk_driver_register() driver: 0xe5638,
name: atmodem
ofonod[26058]: src/network.c:ofono_netreg_driver_register() driver:
0xe5580, name: atmodem
ofonod[26058]: src/cbs.c:ofono_cbs_driver_register() driver: 0xe54c8,
name: atmodem
ofonod[26058]: src/call-volume.c:ofono_call_volume_driver_register()
driver: 0xe5748, name: atmodem
ofonod[26058]: src/gprs.c:ofono_gprs_driver_register() driver:
0xe5778, name: atmodem
ofonod[26058]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0xe578c, name: atmodem
ofonod[26058]: src/sim-auth.c:ofono_sim_auth_driver_register() driver:
0xe57a8, name: atmodem
ofonod[26058]: src/gnss.c:ofono_gnss_driver_register() driver:
0xe57c8, name: atmodem
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe52bc, name: u8500
ofonod[26058]: src/modem.c:ofono_devinfo_driver_register() driver:
0xe52a0, name: u8500
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe525c, name: n900
ofonod[26058]: src/modem.c:ofono_modem_driver_register() driver:
0xe5218, name: isiusb
ofonod[26058]: src/modem.c:ofono_devinfo_driver_register() driver:
0xe4fd0, name: isimodem
ofonod[26058]: src/phonebook.c:ofono_phonebook_driver_register()
driver: 0xe4fc0, name: isimodem
ofonod[26058]: src/network.c:ofono_netreg_driver_register() driver:
0xe4fec, name: isimodem
ofonod[26058]: src/voicecall.c:ofono_voicecall_driver_register()
driver: 0xe5010, name: isimodem
ofonod[26058]: src/sms.c:ofono_sms_driver_register() driver: 0xe5058,
name: isimodem
ofonod[26058]: src/cbs.c:ofono_cbs_driver_register() driver: 0xe5078,
name: isimodem
ofonod[26058]: src/sim.c:ofono_sim_driver_register() driver: 0xe508c,
name: isimodem
ofonod[26058]: src/ussd.c:ofono_ussd_driver_register() driver:
0xe50d4, name: isimodem
ofonod[26058]: src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0xe50e8, name: isimodem
ofonod[26058]: src/call-settings.c:ofono_call_settings_driver_register()
driver: 0xe5108, name: isimodem
ofonod[26058]: src/call-barring.c:ofono_call_barring_driver_register()
driver: 0xe5138, name: isimodem
ofonod[26058]: src/call-meter.c:ofono_call_meter_driver_register()
driver: 0xe5150, name: isimodem
ofonod[26058]: src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0xe5178, name: isimodem
ofonod[26058]: src/gprs.c:ofono_gprs_driver_register() driver:
0xe519c, name: isimodem
ofonod[26058]: src/gprs.c:ofono_gprs_context_driver_register() driver:
0xe51b0, name: isimodem
ofonod[26058]: src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0xe51c4, name: isimodem
ofonod[26058]: src/sim.c:ofono_sim_driver_register() driver: 0xe51d0,
name: wgmodem2.5
ofonod[26058]: plugins/udevng.c:udev_start()
ofonod[26058]: plugins/udevng.c:enumerate_devices()

--===============8958142246025971170==--

