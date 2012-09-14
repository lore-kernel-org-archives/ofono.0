Content-Type: multipart/mixed; boundary="===============4767454139837569683=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: ofono exits after DBUS error
Date: Fri, 14 Sep 2012 15:41:06 +0200
Message-ID: <CABvLYuB=QD4n3JzOw3AhUvWxPdoUhEPRB8j44Oqz8EXQSA8DzQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4767454139837569683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

It looks like "AT+COPS?" returns an invalid character. I guess this is
passed to DBUS which causes oFono to exit.

ofonod[10318]: PCUI: > AT+COPS=3D3,2\r
ofonod[10318]: PCUI: < \r\nOK\r\n
ofonod[10318]: PCUI: > AT+COPS?\r
ofonod[10318]: PCUI: < \r\n+COPS: 0,2,"20620",2\r\n\r\nOK\r\n
ofonod[10318]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 206, mnc: 20
ofonod[10318]: PCUI: > AT+CSQ\r
ofonod[10318]: PCUI: < \r\n+CSQ: 16,99\r\n\r\nOK\r\n
ofonod[10318]: drivers/atmodem/network-registration.c:csq_cb() csq_cb: 16
ofonod[10318]: src/network.c:ofono_netreg_strength_notify() strength 51
ofonod[10318]: PCUI: > AT+CGATT=3D1\r
ofonod[10318]: PCUI: < \r\n+CREG: 1,12F,9E13\r\n\r\n+CGREG: 1,12F,9E13\r\n
ofonod[10318]: PCUI: < \r\nOK\r\n
ofonod[10318]: src/network.c:ofono_netreg_status_notify() /huawei_1
status 1 tech -1
ofonod[10318]: src/cbs.c:cbs_location_changed() 1, 303, 40467, -1, (null)(n=
ull)
ofonod[10318]: src/gprs.c:netreg_status_changed() 1
ofonod[10318]: src/gprs.c:ofono_gprs_status_notify() /huawei_1 status 1
ofonod[10318]: src/gprs.c:gprs_attach_callback() /huawei_1 error =3D 0
ofonod[10318]: PCUI: > AT+COPS=3D3,0\r
ofonod[10318]: PCUI: < \r\nOK\r\n
ofonod[10318]: PCUI: > AT+COPS?\r
ofonod[10318]: PCUI: < \r\n+COPS: 0,0,"BASE\241",2\r\n\r\nOK\r\n
ofonod[10318]: drivers/atmodem/network-registration.c:cops_cb()
cops_cb: BASE=EF=BF=BD, 206 20 2
ofonod[10318]: src/network.c:current_operator_callback() 0x8bbc410, (nil)
process 10318: arguments to dbus_message_iter_append_basic() were
incorrect, assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
file ../../dbus/dbus-message.c line 2534.
This is normally a bug in some application using the D-Bus library.
ofonod[10318]: src/cbs.c:cbs_location_changed() 1, 303, 40467, -1, 20620
ofonod[10318]: src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[10318]: src/gprs.c:netreg_status_changed() 1
ofonod[10318]: PCUI: > AT+COPS=3D3,2\r
ofonod[10318]: System bus has disconnected!
ofonod[10318]: src/plugin.c:__ofono_plugin_cleanup()
ofonod[10318]: plugins/push-notification.c:push_notification_exit()
ofonod[10318]: plugins/smart-messaging.c:smart_messaging_exit()
ofonod[10318]: src/cdma-provision.c:ofono_cdma_provision_driver_unregister()
driver: 0x816f4c0 name: CDMA provisioning
ofonod[10318]: src/gprs-provision.c:ofono_gprs_provision_driver_unregister()
driver: 0x816f480 name: Provisioning
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f420, name: sim900
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f3c0, name: samsung
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f360, name: speedupcdma
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f300, name: speedup
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f2a0, name: alcatel
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f240, name: icera
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f1e0, name: linktop
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f180, name: nokiacdma
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f120, name: nokia
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f0c0, name: tc65
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816f020, name: ste
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816efc0, name: ifx
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816ef60, name: palmpre
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816ef00, name: novatel
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816eea0, name: sierra
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816ee20, name: huawei
ofonod[10318]: src/modem.c:modem_unregister() 0x8bb4ae8
ofonod[10318]: src/modem.c:modem_change_state() old state: 3, new state: 0
ofonod[10318]: src/modem.c:flush_atoms()
ofonod[10318]: src/ussd.c:ussd_remove() atom: 0x8bb84d0
ofonod[10318]: src/network.c:__ofono_netreg_remove_status_watch() 0x8bbc410
ofonod[10318]: src/cbs.c:cbs_remove() atom: 0x8bbb840
ofonod[10318]: src/sim.c:ofono_sim_remove_spn_watch() 0x8bc8cd8
ofonod[10318]: src/network.c:netreg_remove() atom: 0x8bbb820
ofonod[10318]: src/gprs.c:gprs_context_unregister() 0x8bbb8c0, 0x8bbb790
ofonod[10318]: src/gprs.c:gprs_context_remove() atom: 0x8bbb8e0
ofonod[10318]: drivers/atmodem/gprs-context.c:at_gprs_context_remove()
ofonod[10318]: src/gprs.c:gprs_unregister() 0x8bbb790
ofonod[10318]: src/gprs.c:gprs_remove() atom: 0x8bc9478
ofonod[10318]: plugins/push-notification.c:push_notification_cleanup() 0x8b=
b8bc8
ofonod[10318]: plugins/smart-messaging.c:smart_messaging_cleanup() 0x8bb6f68
ofonod[10318]: src/sms.c:sms_remove() atom: 0x8bb9308
ofonod[10318]: src/radio-settings.c:radio_settings_remove() atom: 0x8bb9218
ofonod[10318]: src/phonebook.c:phonebook_remove() atom: 0x8bb92b8
ofonod[10318]: src/sim.c:sim_remove() atom: 0x8bb8e68
ofonod[10318]: src/modem.c:devinfo_remove() atom: 0x8bc8ef8
ofonod[10318]: plugins/huawei.c:huawei_disable() 0x8bb4ae8
ofonod[10318]: plugins/huawei.c:huawei_remove() 0x8bb4ae8
ofonod[10318]: src/modem.c:unregister_property() property 0x8bb8700
ofonod[10318]: src/modem.c:unregister_property() property 0x8bb54f0
ofonod[10318]: src/modem.c:unregister_property() property 0x8bc9d40
ofonod[10318]: src/modem.c:emit_modem_removed() 0x8bb4ae8
ofonod[10318]: src/modem.c:call_modemwatches() 0x8bb4ae8 added:0
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816edc0, name: zte
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816ed60, name: hso
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816ed00, name: mbm
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816eca0, name: calypso
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816ec40, name: wavecom
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816ebe0, name: gobi
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816eb80, name: g1
ofonod[10318]: src/cdma-voicecall.c:ofono_cdma_voicecall_driver_unregister()
driver: 0x816eb00, name: cdmamodem
ofonod[10318]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x816eb20, name: cdmamodem
ofonod[10318]: src/cdma-connman.c:ofono_cdma_connman_driver_unregister()
driver: 0x816eb44, name: cdmamodem
ofonod[10318]: src/ctm.c:ofono_ctm_driver_unregister() driver:
0x816ea20, name: phonesim
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816ea34, name: phonesim
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816ea60, name: phonesim
ofonod[10318]: src/ussd.c:ofono_ussd_driver_unregister() driver:
0x816e9e0, name: speedupmodem
ofonod[10318]: src/voicecall.c:ofono_voicecall_driver_unregister()
driver: 0x816e8c0, name: hfpmodem
ofonod[10318]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x816e97c, name: hfpmodem
ofonod[10318]: src/network.c:ofono_netreg_driver_unregister() driver:
0x816e920, name: hfpmodem
ofonod[10318]: src/call-volume.c:ofono_call_volume_driver_unregister()
driver: 0x816e954, name: hfpmodem
ofonod[10318]: src/handsfree.c:ofono_handsfree_driver_unregister()
driver: 0x816e998, name: hfpmodem
ofonod[10318]: src/network.c:ofono_netreg_driver_unregister() driver:
0x816e840, name: dunmodem
ofonod[10318]: src/gprs.c:ofono_gprs_driver_unregister() driver:
0x816e86c, name: dunmodem
ofonod[10318]: src/voicecall.c:ofono_voicecall_driver_unregister()
driver: 0x816e760, name: stemodem
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816e7ec, name: stemodem
ofonod[10318]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x816e7c0, name: stemodem
ofonod[10318]: src/stk.c:ofono_stk_driver_unregister() driver:
0x816e6f0, name: ifxmodem
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816e6cc, name: ifxmodem
ofonod[10318]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x816e6a0, name: ifxmodem
ofonod[10318]: src/audio-settings.c:ofono_audio_settings_driver_unregister()
driver: 0x816e670, name: ifxmodem
ofonod[10318]: src/voicecall.c:ofono_voicecall_driver_unregister()
driver: 0x816e620, name: ifxmodem
ofonod[10318]: src/ctm.c:ofono_ctm_driver_unregister() driver:
0x816e718, name: ifxmodem
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816e5a0, name: hsomodem
ofonod[10318]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x816e5c0, name: hsomodem
ofonod[10318]: src/location-reporting.c:ofono_location_reporting_driver_unr=
egister()
driver: 0x816e544, name: mbmmodem
ofonod[10318]: src/stk.c:ofono_stk_driver_unregister() driver:
0x816e524, name: mbmmodem
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816e500, name: mbmmodem
ofonod[10318]: src/stk.c:ofono_stk_driver_unregister() driver:
0x816e4a8, name: calypsomodem
ofonod[10318]: src/voicecall.c:ofono_voicecall_driver_unregister()
driver: 0x816e460, name: calypsomodem
ofonod[10318]: src/cdma-netreg.c:ofono_cdma_netreg_driver_unregister()
driver: 0x816e40c, name: huaweimodem
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816e3bc, name: huaweimodem
ofonod[10318]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x816e3e0, name: huaweimodem
ofonod[10318]: src/audio-settings.c:ofono_audio_settings_driver_unregister()
driver: 0x816e3a8, name: huaweimodem
ofonod[10318]: src/voicecall.c:ofono_voicecall_driver_unregister()
driver: 0x816e360, name: huaweimodem
ofonod[10318]: src/ussd.c:ofono_ussd_driver_unregister() driver:
0x816e340, name: huaweimodem
ofonod[10318]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x816e2e0, name: ztemodem
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816e2a0, name: swmodem
ofonod[10318]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x816e240, name: nwmodem
ofonod[10318]: src/sim-auth.c:ofono_sim_auth_driver_unregister()
driver: 0x816e1cc, name: atmodem
ofonod[10318]: src/stk.c:ofono_stk_driver_unregister() driver:
0x816e05c, name: atmodem
ofonod[10318]: src/sim.c:ofono_sim_driver_unregister() driver:
0x816df60, name: atmodem
ofonod[10318]: src/sim.c:ofono_sim_driver_unregister() driver:
0x816dfc0, name: atmodem-noef
ofonod[10318]: src/sms.c:ofono_sms_driver_unregister() driver:
0x816dde0, name: atmodem
ofonod[10318]: src/ussd.c:ofono_ussd_driver_unregister() driver:
0x816e07c, name: atmodem
ofonod[10318]: src/phonebook.c:ofono_phonebook_driver_unregister()
driver: 0x816e118, name: atmodem
ofonod[10318]: src/call-settings.c:ofono_call_settings_driver_unregister()
driver: 0x816dd60, name: atmodem
ofonod[10318]: src/call-meter.c:ofono_call_meter_driver_unregister()
driver: 0x816dea0, name: atmodem
ofonod[10318]: src/call-forwarding.c:ofono_call_forwarding_driver_unregiste=
r()
driver: 0x816de60, name: atmodem
ofonod[10318]: src/call-barring.c:ofono_call_barring_driver_unregister()
driver: 0x816e0f8, name: atmodem
ofonod[10318]: src/network.c:ofono_netreg_driver_unregister() driver:
0x816df00, name: atmodem
ofonod[10318]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x816e140, name: atmodem
ofonod[10318]: src/voicecall.c:ofono_voicecall_driver_unregister()
driver: 0x816e0a0, name: atmodem
ofonod[10318]: src/cbs.c:ofono_cbs_driver_unregister() driver:
0x816de40, name: atmodem
ofonod[10318]: src/call-volume.c:ofono_call_volume_driver_unregister()
driver: 0x816e164, name: atmodem
ofonod[10318]: src/gprs.c:ofono_gprs_driver_unregister() driver:
0x816e194, name: atmodem
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816e1b8, name: atmodem
ofonod[10318]: src/gnss.c:ofono_gnss_driver_unregister() driver:
0x816e1e4, name: atmodem
ofonod[10318]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x816db20, name: u8500
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816db40, name: u8500
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816dac0, name: n900
ofonod[10318]: src/modem.c:ofono_modem_driver_unregister() driver:
0x816da60, name: isiusb
ofonod[10318]: src/modem.c:ofono_devinfo_driver_unregister() driver:
0x816d750, name: isimodem
ofonod[10318]: src/phonebook.c:ofono_phonebook_driver_unregister()
driver: 0x816d740, name: isimodem
ofonod[10318]: src/network.c:ofono_netreg_driver_unregister() driver:
0x816d780, name: isimodem
ofonod[10318]: src/voicecall.c:ofono_voicecall_driver_unregister()
driver: 0x816d7c0, name: isimodem
ofonod[10318]: src/sms.c:ofono_sms_driver_unregister() driver:
0x816d820, name: isimodem
ofonod[10318]: src/cbs.c:ofono_cbs_driver_unregister() driver:
0x816d840, name: isimodem
ofonod[10318]: src/sim.c:ofono_sim_driver_unregister() driver:
0x816d860, name: isimodem
ofonod[10318]: src/ussd.c:ofono_ussd_driver_unregister() driver:
0x816d8a8, name: isimodem
ofonod[10318]: src/call-forwarding.c:ofono_call_forwarding_driver_unregiste=
r()
driver: 0x816d8c0, name: isimodem
ofonod[10318]: src/call-settings.c:ofono_call_settings_driver_unregister()
driver: 0x816d8e0, name: isimodem
ofonod[10318]: src/call-barring.c:ofono_call_barring_driver_unregister()
driver: 0x816d910, name: isimodem
ofonod[10318]: src/call-meter.c:ofono_call_meter_driver_unregister()
driver: 0x816d940, name: isimodem
ofonod[10318]: src/radio-settings.c:ofono_radio_settings_driver_unregister()
driver: 0x816d980, name: isimodem
ofonod[10318]: src/gprs.c:ofono_gprs_driver_unregister() driver:
0x816d9a4, name: isimodem
ofonod[10318]: src/gprs.c:ofono_gprs_context_driver_unregister()
driver: 0x816d9b8, name: isimodem
ofonod[10318]: src/audio-settings.c:ofono_audio_settings_driver_unregister()
driver: 0x816d9cc, name: isimodem
ofonod[10318]: src/sim.c:ofono_sim_driver_unregister() driver:
0x816d9e0, name: wgmodem2.5
ofonod[10318]: plugins/udevng.c:destroy_modem()
/sys/devices/pci0000:00/0000:00:0b.0/usb1/1-1
ofonod[10318]: src/modem.c:ofono_modem_remove() 0x8bb4ae8
ofonod[10318]: plugins/udevng.c:destroy_modem() /dev/ttyUSB0
ofonod[10318]: plugins/udevng.c:destroy_modem() /dev/ttyUSB1
ofonod[10318]: plugins/udevng.c:destroy_modem() /dev/ttyUSB2
ofonod[10318]: Exit

thanks,
Cedric

--===============4767454139837569683==--

