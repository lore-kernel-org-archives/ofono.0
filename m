Content-Type: multipart/mixed; boundary="===============1981288211012328880=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: Re: Problem reconnecting when 3G dongle is re-inserted
Date: Wed, 12 Mar 2014 10:35:13 +0000
Message-ID: <CAK+sfoue_n6P_zGMYrdp-5mgm-UZYivkM+XW6fg4_fszBjLnaA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1981288211012328880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have simplified the process by eliminating connman and focusing on ofono.

I insert the dongle and run the following:

oot(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono /
org.ofono.Manager.GetModems
method return sender=3D:1.86 -> dest=3D:1.93 reply_serial=3D2
   array [
      struct {
         object path "/huawei_0"
         array [
            dict entry(
               string "Online"
               variant                   boolean false
            )
            dict entry(
               string "Powered"
               variant                   boolean false
            )
            dict entry(
               string "Lockdown"
               variant                   boolean false
            )
            dict entry(
               string "Emergency"
               variant                   boolean false
            )
            dict entry(
               string "Interfaces"
               variant                   array [
                  ]
            )
            dict entry(
               string "Features"
               variant                   array [
                  ]
            )
            dict entry(
               string "Type"
               variant                   string "hardware"
            )
         ]
      }
   ]

root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono /huaw=
ei_0
org.ofono.Modem.SetProperty string:"Powered" variant:boolean:true
method return sender=3D:1.86 -> dest=3D:1.95 reply_serial=3D2

root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono /huaw=
ei_0
org.ofono.Modem.SetProperty string:"Online" variant:boolean:true
method return sender=3D:1.86 -> dest=3D:1.96 reply_serial=3D2

root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono /huaw=
ei_0
org.ofono.ConnectionManager.GetContexts
method return sender=3D:1.86 -> dest=3D:1.98 reply_serial=3D2
   array [
      struct {
         object path "/huawei_0/context1"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean false
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string "3Ireland"
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "Settings"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
      struct {
         object path "/huawei_0/context2"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean false
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string "3Ireland"
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "Settings"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
      struct {
         object path "/huawei_0/context3"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean false
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string ""
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "Settings"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
      struct {
         object path "/huawei_0/context4"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean false
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string ""
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "Settings"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
      struct {
         object path "/huawei_0/context5"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean false
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string ""
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "Settings"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
   ]
root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono
/huawei_0/context1 org.ofono.ConnectionContext.SetProperty string:"Active"
variant:boolean:true
Error org.ofono.Error.Failed: Operation failed


The ofono debug is as follows:


ofonod[1560]: oFono version 1.14
ofonod[1560]: /ofono-1.14/src/plugin.c:__ofono_plugin_init()
ofonod[1560]:
/ofono-1.14/plugins/push-notification.c:push_notification_init()
ofonod[1560]: /ofono-1.14/plugins/smart-messaging.c:smart_messaging_init()
ofonod[1560]:
/ofono-1.14/src/cdma-provision.c:ofono_cdma_provision_driver_register()
driver: 0x556c1bb0 name: CDMA provisioning
ofonod[1560]:
/ofono-1.14/src/gprs-provision.c:ofono_gprs_provision_driver_register()
driver: 0x556c1b80 name: Provisioning
ofonod[1560]: /ofono-1.14/plugins/dun_gw_bluez5.c:dun_gw_init()
ofonod[1560]:
/ofono-1.14/src/handsfree-audio.c:ofono_handsfree_card_driver_register()
driver: 0x556c1a50
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1a60, name: hfp
ofonod[1560]: /ofono-1.14/plugins/he910.c:he910_init()
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c19e0, name: he910
ofonod[1560]: /ofono-1.14/plugins/connman.c:connman_init()
ofonod[1560]:
/ofono-1.14/src/private-network.c:ofono_private_network_driver_register()
driver: 0x556c19b0, name: ConnMan Private Network
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1960, name: sim900
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1910, name: samsung
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c18c0, name: speedupcdma
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1870, name: speedup
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1820, name: alcatel
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c17c0, name: icera
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1770, name: linktop
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1720, name: nokiacdma
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c16d0, name: nokia
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1680, name: tc65
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c15f0, name: ste
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1590, name: ifx
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1540, name: palmpre
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c14f0, name: novatel
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c14a0, name: sierra
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1420, name: huawei
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c13d0, name: zte
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1370, name: hso
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1320, name: mbm
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c12d0, name: calypso
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1280, name: wavecom
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1230, name: g1
ofonod[1560]:
/ofono-1.14/src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
driver: 0x556c11a0, name: cdmamodem
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c11c0, name: cdmamodem
ofonod[1560]:
/ofono-1.14/src/cdma-connman.c:ofono_cdma_connman_driver_register() driver:
0x556c11f0, name: cdmamodem
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c111c, name: phonesim
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c1154, name: localhfp
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c1104, name: phonesim
ofonod[1560]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
0x556c10f0, name: phonesim
ofonod[1560]: /ofono-1.14/plugins/phonesim.c:parse_config() filename
/etc/ofono/phonesim.conf
ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c10b0, name: speedupmodem
ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0f50, name: hfpmodem
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c1010, name: hfpmodem
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0fa0, name: hfpmodem
ofonod[1560]:
/ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() driver:
0x556c0fe0, name: hfpmodem
ofonod[1560]: /ofono-1.14/src/handsfree.c:ofono_handsfree_driver_register()
driver: 0x556c1030, name: hfpmodem
ofonod[1560]: /ofono-1.14/src/siri.c:ofono_siri_driver_register() driver:
0x556c1060, name: hfpmodem
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0ec0, name: dunmodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c0ef0, name: dunmodem
ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0df0, name: stemodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0e70, name: stemodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0e40, name: stemodem
ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0cb0, name: ifxmodem
ofonod[1560]:
/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x556c0d00, name: ifxmodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0d20, name: ifxmodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0d50, name: ifxmodem
ofonod[1560]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0d80, name: ifxmodem
ofonod[1560]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
0x556c0db0, name: ifxmodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0c40, name: hsomodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0c60, name: hsomodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0bb0, name: mbmmodem
ofonod[1560]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0be0, name: mbmmodem
ofonod[1560]:
/ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regist=
er()
driver: 0x556c0c00, name: mbmmodem
ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0b20, name: calypsomodem
ofonod[1560]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0b70, name: calypsomodem
ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c0a00, name: huaweimodem
ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c0a20, name: huaweimodem
ofonod[1560]:
/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x556c0a70, name: huaweimodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0ab0, name: huaweimodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0a90, name: huaweimodem
ofonod[1560]:
/ofono-1.14/src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:
0x556c0ae0, name: huaweimodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0970, name: iceramodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c09a0, name: iceramodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0920, name: ztemodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c08e0, name: swmodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0890, name: nwmodem
ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556c06b0, name: atmodem
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556c0760, name: atmodem
ofonod[1560]:
/ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register() driver:
0x556c0710, name: atmodem
ofonod[1560]:
/ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x556c0480, name: atmodem
ofonod[1560]:
/ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
0x556c04b0, name: atmodem
ofonod[1560]:
/ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x556c0390, name: atmodem
ofonod[1560]: /ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x556c0730, name: atmodem
ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c0680, name: atmodem
ofonod[1560]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556c0400, name: atmodem
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0560, name: atmodem
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c05a8, name: atmodem-noef
ofonod[1560]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
0x556c0660, name: atmodem
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556c0500, name: atmodem
ofonod[1560]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
0x556c0460, name: atmodem
ofonod[1560]:
/ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() driver:
0x556c0790, name: atmodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c07d0, name: atmodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0800, name: atmodem
ofonod[1560]: /ofono-1.14/src/sim-auth.c:ofono_sim_auth_driver_register()
driver: 0x556c0820, name: atmodem
ofonod[1560]: /ofono-1.14/src/gnss.c:ofono_gnss_driver_register() driver:
0x556c0840, name: atmodem
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556c01b0, name: gobi
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bff80, name: qmimodem
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556bfff0, name: qmimodem
ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556bffa0, name: qmimodem
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0020, name: qmimodem-legacy
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556c0070, name: qmimodem
ofonod[1560]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556c00c0, name: qmimodem
ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556c00e0, name: qmimodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556c0100, name: qmimodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556c0120, name: qmimodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556c0140, name: qmimodem
ofonod[1560]:
/ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regist=
er()
driver: 0x556c0170, name: qmimodem
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556bff2c, name: u8500
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bff10, name: u8500
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556bfec0, name: n900
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() driver:
0x556bfe70, name: isiusb
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
driver: 0x556bfb90, name: isimodem
ofonod[1560]: /ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register()
driver: 0x556bfb80, name: isimodem
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
driver: 0x556bfbb0, name: isimodem
ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register()
driver: 0x556bfbe0, name: isimodem
ofonod[1560]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
0x556bfc30, name: isimodem
ofonod[1560]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
0x556bfc50, name: isimodem
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556bfc70, name: isimodem
ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
0x556bfcc0, name: isimodem
ofonod[1560]:
/ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register()
driver: 0x556bfce0, name: isimodem
ofonod[1560]:
/ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
driver: 0x556bfd00, name: isimodem
ofonod[1560]:
/ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register() driver:
0x556bfd30, name: isimodem
ofonod[1560]:
/ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
0x556bfd50, name: isimodem
ofonod[1560]:
/ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
driver: 0x556bfd80, name: isimodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
0x556bfdb0, name: isimodem
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
driver: 0x556bfdd0, name: isimodem
ofonod[1560]:
/ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
driver: 0x556bfdf0, name: isimodem
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
0x556bfe00, name: wgmodem2.5
ofonod[1560]: /ofono-1.14/plugins/udevng.c:udev_start()
ofonod[1560]: /ofono-1.14/plugins/udevng.c:enumerate_devices()
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
[(null):(null)]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[0bda:8176]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
[(null):(null)]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
[0bda:8176]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
[(null):(null)]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[12d1:1f01]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[(null):(null)]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0
ofonod[1560]: /ofono-1.14/plugins/udevng.c:remove_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_modem_list()
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
[12d1:1001]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[(null):(null)]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB0
(huawei) 255/255/255 [00] =3D=3D> (null) (null)
ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty finished
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB1
(huawei) 255/255/255 [01] =3D=3D> (null) (null)
ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty finished
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
[12d1:1001]
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB2
(huawei) 255/255/255 [02] =3D=3D> (null) (null)
ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty finished
ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_modem_list()
ofonod[1560]: /ofono-1.14/plugins/udevng.c:create_modem()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1560]: /ofono-1.14/plugins/udevng.c:create_modem() driver=3Dhuawei
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_create() name: (null),
type: huawei
ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei()
/sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB0
255/255/255 00 (null)
ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB1
255/255/255 01 (null)
ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB2
255/255/255 02 (null)
ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyUSB0
pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42a0
property Device
ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42a0
property Modem
ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42a0
property Pcui
ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42a0
property Diag
ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42a0
property NetworkInterface
ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_register() 0x556d42a0
ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_probe() 0x556d42a0
ofonod[1560]: /ofono-1.14/src/modem.c:emit_modem_added() 0x556d42a0
ofonod[1560]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556d42a0 added:1
ofonod[1560]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
0x556d42a0, added: 1
ofonod[1560]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
0x556d42a0, added: 1
ofonod[1560]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
0x556d42a0, added: 1
ofonod[1560]: /ofono-1.14/plugins/push-notification.c:modem_watch() modem:
0x556d42a0, added: 1
ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_enable() 0x556d42a0
ofonod[1560]: /ofono-1.14/src/modem.c:get_modem_property() modem 0x556d42a0
property Modem
ofonod[1560]: /ofono-1.14/plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[1560]: /ofono-1.14/src/modem.c:get_modem_property() modem 0x556d42a0
property Pcui
ofonod[1560]: /ofono-1.14/plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
ofonod[1560]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > ATI\r
ofonod[1560]: PCUI: < \r\nManufacturer: huawei\r\nModel: E303\r\nRevision:
22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
+CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT^RFSWITCH=3D?\r
ofonod[1560]: PCUI: < \r\nERROR\r\n
ofonod[1560]: PCUI: > AT+CFUN=3D1\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: /ofono-1.14/plugins/huawei.c:cfun_enable()
ofonod[1560]: PCUI: > AT^SYSINFO\r
ofonod[1560]: PCUI: < \r\n^SYSINFO:2,3,0,5,1,0,4\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
ofonod[1560]: PCUI: > AT&C0\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CSCS=3D"GSM"\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT^U2DIAG?\r
ofonod[1560]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT^GETPORTMODE\r
ofonod[1560]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA: huawei,\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT^USSDMODE=3D?\r
ofonod[1560]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT^DIALMODE=3D?\r
ofonod[1560]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT^CVOICE=3D?\r
ofonod[1560]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CFUN=3D5\r
ofonod[1560]: PCUI: < \r\n+CGREG: 0\r\n
ofonod[1560]: PCUI: < \r\n+CREG: 0\r\n
ofonod[1560]: PCUI: < \r\nOK\r\n\r\n^SRVST: 0\r\n\r\n^MODE: 0,0\r\n
ofonod[1560]: /ofono-1.14/plugins/huawei.c:cfun_offline()
ofonod[1560]: /ofono-1.14/src/modem.c:modem_change_state() old state: 0,
new state: 1
ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_pre_sim() 0x556d42a0
ofonod[1560]: PCUI: > AT^USSDMODE?\r
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e99c8
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e99c8
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e99c8
ofonod[1560]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT^DIALMODE?\r
ofonod[1560]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT^CVOICE?\r
ofonod[1560]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
ofonod[1560]: Voice channel: 8000 Hz, 16 bits, 20ms period
ofonod[1560]: PCUI: > AT+GCAP\r
ofonod[1560]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\r\=
nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1560]: PCUI: > AT^DDSETEX=3D?\r
ofonod[1560]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CGMI\r
ofonod[1560]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[1560]: PCUI: > AT+CGMM\r
ofonod[1560]: PCUI: < \r\nE303\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\r\=
nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1560]: PCUI: > AT+CGMR\r
ofonod[1560]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[1560]: PCUI: > AT+CGSN\r
ofonod[1560]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\r\=
nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1560]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[1560]: PCUI: > AT+CPIN?\r
ofonod[1560]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb:
READY
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[1560]: PCUI: > AT^CPIN?\r
ofonod[1560]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D9, val=3D10
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D1, val=3D3
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D11, val=3D10
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
counter id=3D4, val=3D3
ofonod[1560]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\r\=
nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1560]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 4
ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 4
ofonod[1560]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\r\=
nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1560]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 10
ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 10
ofonod[1560]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\r\=
nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 30
ofonod[1560]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 1
ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[1560]: PCUI: > AT+CIMI\r
ofonod[1560]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
272050100413580
ofonod[1560]: /ofono-1.14/src/modem.c:modem_change_state() old state: 1,
new state: 2
ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_post_sim() 0x556d42a0
ofonod[1560]:
/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[1560]: /ofono-1.14/src/modem.c:get_modem_property() modem 0x556d42a0
property AlwaysOnline
ofonod[1560]: PCUI: > AT+CRC=3D1\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CLIP=3D1\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+COLP=3D1\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CCWA=3D1\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]:
/ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized()
registering to notifications
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e99c8
ofonod[1560]: /ofono-1.14/plugins/bluez5.c:bt_register_profile() Bluetooth:
Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag) profile
ofonod[1560]: PCUI: > AT^CVOICE=3D?\r
ofonod[1560]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CSCS=3D?\r
ofonod[1560]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT^SYSCFG=3D?\r
ofonod[1560]: PCUI: < \r\n^SYSCFG:
(2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(28=
0000,"GSM850/GSM1900"),(3fffffff,"All
bands")),(0-2),(0-4)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CSMS=3D?\r
ofonod[1560]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
query parsed successfully
ofonod[1560]: PCUI: > AT+CGDCONT=3D?\r
ofonod[1560]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[1560]: PCUI: < \r\n+CGDCONT:
(1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
(1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\r\=
n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1560]: PCUI: > AT+CPBS=3D?\r
ofonod[1560]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CSMS=3D1\r
ofonod[1560]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CGREG=3D?\r
ofonod[1560]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CSMS?\r
ofonod[1560]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CGREG=3D2\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CGAUTO=3D0\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CGEREP=3D2,1\r
ofonod[1560]: PCUI: < \r\nERROR\r\n
ofonod[1560]: /ofono-1.14/plugins/bluez5.c:bt_register_profile() Bluetooth:
Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CMGF=3D?\r
ofonod[1560]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
ofonod[1560]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
unknown return code 1
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CPMS=3D?\r
ofonod[1560]: PCUI: < \r\n+CPMS:
("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CMGF=3D0\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
ofonod[1560]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CNMI=3D?\r
ofonod[1560]: Duplicate EFsdn entries for `Emergency Services'
ofonod[1560]: PCUI: < \r\n+CNMI: (0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
ofonod[1560]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: /ofono-1.14/src/sms.c:sms_restore_tx_queue()
ofonod[1560]: /ofono-1.14/plugins/push-notification.c:sms_watch() registered
ofonod[1560]: /ofono-1.14/plugins/smart-messaging.c:sms_watch() registered
ofonod[1560]: PCUI: > AT+CMGL=3D4\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
ofonod[1560]: PCUI: > AT+CGSMS=3D3\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: /ofono-1.14/src/modem.c:get_modem_property() modem 0x556d42a0
property AlwaysOnline
ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_set_online() modem
0x556d42a0 online
ofonod[1560]: PCUI: > AT+CFUN=3D1\r
ofonod[1560]: PCUI: < \r\n^SIMST:0,0\r\n
ofonod[1560]: /ofono-1.14/plugins/huawei.c:simst_notify() 1 -> 0
ofonod[1560]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
ofonod[1560]: /ofono-1.14/plugins/huawei.c:simst_notify() 0 -> 1
ofonod[1560]: PCUI: > AT^SYSINFO\r
ofonod[1560]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG:
2\r\n\r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
status 2
ofonod[1560]: /ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
ofonod[1560]: /ofono-1.14/src/modem.c:modem_change_state() old state: 2,
new state: 3
ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_post_online() 0x556d42a0
ofonod[1560]: PCUI: > AT+CREG=3D?\r
ofonod[1560]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CSCB=3D?\r
ofonod[1560]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CUSD=3D1\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\r\=
n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1560]: PCUI: > AT+CREG=3D2\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556e99c8
ofonod[1560]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556efbe8
ofonod[1560]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556efbe8
ofonod[1560]: PCUI: > AT+CSCB=3D0\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI: 272050100413580
ofonod[1560]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
0x556efbe8
ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1560]: PCUI: > AT+CREG?\r
ofonod[1560]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
/huawei_0 status 2 tech -1
ofonod[1560]: /ofono-1.14/src/network.c:current_operator_callback()
0x556efbe8, (nil)
ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_location_changed() 2, -1, -1, -1,
(null)(null)
ofonod[1560]: /ofono-1.14/src/gprs.c:netreg_status_changed() 2
ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 6
ofonod[1560]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\r\=
n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 5
ofonod[1560]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb() No
CPHS MWIS on SIM
ofonod[1560]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\r\=
n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 16
ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
seekoff: 39, toread: 17
ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
seekoff: 39, toread: 10
ofonod[1560]: /ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
ofonod[1560]: PCUI: > AT+CSCB=3D0\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
ofonod[1560]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\r\=
n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
crsm_info_cb: 90, 00, 32
ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
ofonod[1560]: PCUI: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
crsm_read_cb: 90, 00, 34
ofonod[1560]: PCUI: < \r\n^MODE: 5,4\r\n
ofonod[1560]: PCUI: < \r\n^RSSI: 13\r\n\r\n^HCSQ:"WCDMA",41,35,53\r\n
ofonod[1560]: PCUI: < \r\n+CREG: 1,"0040","02C10178"\r\n
ofonod[1560]: PCUI: < \r\n^SRVST: 2\r\n
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
/huawei_0 status 1 tech 2
ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
(null)(null)
ofonod[1560]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
ofonod[1560]: PCUI: > AT+COPS=3D3,2\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+COPS?\r
ofonod[1560]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
ofonod[1560]:
/ofono-1.14/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
numeric got mcc: 272, mnc: 05
ofonod[1560]: PCUI: > AT+CSQ\r
ofonod[1560]: PCUI: < \r\n+CSQ: 13,99\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
csq_cb: 13
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 41
ofonod[1560]: PCUI: > AT+CGATT=3D1\r
ofonod[1560]: PCUI: < \r\nOK\r\n\r\n+CGREG: 1,"0040","02C10178"\r\n
ofonod[1560]: /ofono-1.14/src/gprs.c:gprs_attach_callback() /huawei_0 error
=3D 0
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
status 1
ofonod[1560]: PCUI: > AT+COPS=3D3,0\r
ofonod[1560]: PCUI: < \r\nOK\r\n
ofonod[1560]: PCUI: > AT+COPS?\r
ofonod[1560]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/drivers/atmodem/network-registration.c:cops_cb()
cops_cb: 3 IRL, 272 05 2
ofonod[1560]: /ofono-1.14/src/network.c:current_operator_callback()
0x556efbe8, (nil)
ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
27205
ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, 0, 0
ofonod[1560]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
ofonod[1560]: PCUI: > AT+CGREG?\r
ofonod[1560]: PCUI: < \r\n+CGREG: 2,1,"0040","02C10178"\r\n\r\nOK\r\n
ofonod[1560]: /ofono-1.14/src/gprs.c:registration_status_cb() /huawei_0
error 0 status 1
ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
status 1
ofonod[1560]: PCUI: < \r\n^RSSI: 11\r\n\r\n^HCSQ:"WCDMA",38,30,49\r\n
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 35
ofonod[1560]:
/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
ofonod[1560]: /ofono-1.14/src/gprs.c:pri_activate_callback() 0x556eb788
ofonod[1560]: /ofono-1.14/src/gprs.c:pri_activate_callback() Activating
context failed with error: Unknown error type
ofonod[1560]: PCUI: < \r\n^RSSI: 13\r\n\r\n^HCSQ:"WCDMA",42,35,51\r\n
ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
strength 41


If I now restart ofono then activating the same context will work fine.


Homam




On 10 March 2014 18:16, <ofono-request@ofono.org> wrote:

> Send ofono mailing list submissions to
>         ofono(a)ofono.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.ofono.org/mailman/listinfo/ofono
> or, via email, send a message with subject or body 'help' to
>         ofono-request(a)ofono.org
>
> You can reach the person managing the list at
>         ofono-owner(a)ofono.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of ofono digest..."
>
>
> Today's Topics:
>
>    1. Problem reconnecting when 3G dongle is re-inserted (Homam Dabis)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 10 Mar 2014 18:17:04 +0000
> From: Homam Dabis <hdabis@digisoft.tv>
> To: ofono(a)ofono.org
> Subject: Problem reconnecting when 3G dongle is re-inserted
> Message-ID:
>         <CAK+sfotBtysK1yCTt64m3guFwfzWb_=3D
> 4szj0U2b5Wswgt1m1Cg(a)mail.gmail.com>
> Content-Type: text/plain; charset=3D"iso-8859-1"
>
> Hi,
>
> I have the following: Huawei E303 3G USB dongle, connman 1.20 and ofono
> 1.14.
>
> I can connect to a particular APN using connman and ofono.
>
> However, if I remove and re insert the dongle I am unable to reconnect to
> the service. If I restart either connman or ofono then reconnection to
> service is ok.
>
> Connman has the following config:
>
> [General]
> BackgroundScanning=3Dfalse
> DefaultAutoConnectTechnologies=3Dcellular
> PreferredTechnologies=3Dcellular,wifi
> SingleConnectedTechnology=3Dfalse
> TetheringTechnologies=3Dwifi
> PersistentTetheringMode=3Dtrue
>
>
> In ofono the log for connect/remove and reconnect is:
>
> root(a)i100:~# OFONO_AT_DEBUG=3D1 ofonod -n -d  > /ofono.log
> ofonod[30943]: oFono version 1.14
> ofonod[30943]: /ofono-1.14/src/plugin.c:__ofono_plugin_init()
> ofonod[30943]:
> /ofono-1.14/plugins/push-notification.c:push_notification_init()
> ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:smart_messaging_init=
()
> ofonod[30943]:
> /ofono-1.14/src/cdma-provision.c:ofono_cdma_provision_driver_register()
> driver: 0x556c1bb0 name: CDMA provisioning
> ofonod[30943]:
> /ofono-1.14/src/gprs-provision.c:ofono_gprs_provision_driver_register()
> driver: 0x556c1b80 name: Provisioning
> ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:dun_gw_init()
> ofonod[30943]:
> /ofono-1.14/src/handsfree-audio.c:ofono_handsfree_card_driver_register()
> driver: 0x556c1a50
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1a60, name: hfp
> ofonod[30943]: /ofono-1.14/plugins/he910.c:he910_init()
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c19e0, name: he910
> ofonod[30943]: /ofono-1.14/plugins/connman.c:connman_init()
> ofonod[30943]:
> /ofono-1.14/src/private-network.c:ofono_private_network_driver_register()
> driver: 0x556c19b0, name: ConnMan Private Network
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1960, name: sim900
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1910, name: samsung
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c18c0, name: speedupcdma
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1870, name: speedup
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1820, name: alcatel
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c17c0, name: icera
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1770, name: linktop
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1720, name: nokiacdma
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c16d0, name: nokia
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1680, name: tc65
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c15f0, name: ste
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1590, name: ifx
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1540, name: palmpre
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c14f0, name: novatel
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c14a0, name: sierra
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1420, name: huawei
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c13d0, name: zte
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1370, name: hso
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1320, name: mbm
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c12d0, name: calypso
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1280, name: wavecom
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1230, name: g1
> ofonod[30943]:
> /ofono-1.14/src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
> driver: 0x556c11a0, name: cdmamodem
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556c11c0, name: cdmamodem
> ofonod[30943]:
> /ofono-1.14/src/cdma-connman.c:ofono_cdma_connman_driver_register() drive=
r:
> 0x556c11f0, name: cdmamodem
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c111c, name: phonesim
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c1154, name: localhfp
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c1104, name: phonesim
> ofonod[30943]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
> 0x556c10f0, name: phonesim
> ofonod[30943]: /ofono-1.14/plugins/phonesim.c:parse_config() filename
> /etc/ofono/phonesim.conf
> ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556c10b0, name: speedupmodem
> ofonod[30943]:
> /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x556c0f50, name: hfpmodem
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556c1010, name: hfpmodem
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556c0fa0, name: hfpmodem
> ofonod[30943]:
> /ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() driver:
> 0x556c0fe0, name: hfpmodem
> ofonod[30943]:
> /ofono-1.14/src/handsfree.c:ofono_handsfree_driver_register() driver:
> 0x556c1030, name: hfpmodem
> ofonod[30943]: /ofono-1.14/src/siri.c:ofono_siri_driver_register() driver:
> 0x556c1060, name: hfpmodem
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556c0ec0, name: dunmodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
> 0x556c0ef0, name: dunmodem
> ofonod[30943]:
> /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x556c0df0, name: stemodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0e70, name: stemodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0e40, name: stemodem
> ofonod[30943]:
> /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x556c0cb0, name: ifxmodem
> ofonod[30943]:
> /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> driver: 0x556c0d00, name: ifxmodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0d20, name: ifxmodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0d50, name: ifxmodem
> ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> 0x556c0d80, name: ifxmodem
> ofonod[30943]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
> 0x556c0db0, name: ifxmodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0c40, name: hsomodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0c60, name: hsomodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0bb0, name: mbmmodem
> ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> 0x556c0be0, name: mbmmodem
> ofonod[30943]:
>
> /ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
> driver: 0x556c0c00, name: mbmmodem
> ofonod[30943]:
> /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x556c0b20, name: calypsomodem
> ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> 0x556c0b70, name: calypsomodem
> ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556c0a00, name: huaweimodem
> ofonod[30943]:
> /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x556c0a20, name: huaweimodem
> ofonod[30943]:
> /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> driver: 0x556c0a70, name: huaweimodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0ab0, name: huaweimodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0a90, name: huaweimodem
> ofonod[30943]:
> /ofono-1.14/src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:
> 0x556c0ae0, name: huaweimodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0970, name: iceramodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c09a0, name: iceramodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0920, name: ztemodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c08e0, name: swmodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0890, name: nwmodem
> ofonod[30943]:
> /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x556c06b0, name: atmodem
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556c0760, name: atmodem
> ofonod[30943]:
> /ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register() drive=
r:
> 0x556c0710, name: atmodem
> ofonod[30943]:
> /ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register()
> driver: 0x556c0480, name: atmodem
> ofonod[30943]:
> /ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
> 0x556c04b0, name: atmodem
> ofonod[30943]:
> /ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
> driver: 0x556c0390, name: atmodem
> ofonod[30943]:
> /ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register() driver:
> 0x556c0730, name: atmodem
> ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556c0680, name: atmodem
> ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> 0x556c0400, name: atmodem
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556c0560, name: atmodem
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556c05a8, name: atmodem-noef
> ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> 0x556c0660, name: atmodem
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556c0500, name: atmodem
> ofonod[30943]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
> 0x556c0460, name: atmodem
> ofonod[30943]:
> /ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() driver:
> 0x556c0790, name: atmodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
> 0x556c07d0, name: atmodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0800, name: atmodem
> ofonod[30943]: /ofono-1.14/src/sim-auth.c:ofono_sim_auth_driver_register()
> driver: 0x556c0820, name: atmodem
> ofonod[30943]: /ofono-1.14/src/gnss.c:ofono_gnss_driver_register() driver:
> 0x556c0840, name: atmodem
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556c01b0, name: gobi
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556bff80, name: qmimodem
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556bfff0, name: qmimodem
> ofonod[30943]:
> /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x556bffa0, name: qmimodem
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556c0020, name: qmimodem-legacy
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556c0070, name: qmimodem
> ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> 0x556c00c0, name: qmimodem
> ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556c00e0, name: qmimodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
> 0x556c0100, name: qmimodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0120, name: qmimodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0140, name: qmimodem
> ofonod[30943]:
>
> /ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
> driver: 0x556c0170, name: qmimodem
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556bff2c, name: u8500
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556bff10, name: u8500
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556bfec0, name: n900
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> driver: 0x556bfe70, name: isiusb
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556bfb90, name: isimodem
> ofonod[30943]:
> /ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register() driver:
> 0x556bfb80, name: isimodem
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556bfbb0, name: isimodem
> ofonod[30943]:
> /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> 0x556bfbe0, name: isimodem
> ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> 0x556bfc30, name: isimodem
> ofonod[30943]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
> 0x556bfc50, name: isimodem
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556bfc70, name: isimodem
> ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556bfcc0, name: isimodem
> ofonod[30943]:
> /ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register()
> driver: 0x556bfce0, name: isimodem
> ofonod[30943]:
> /ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
> driver: 0x556bfd00, name: isimodem
> ofonod[30943]:
> /ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register() drive=
r:
> 0x556bfd30, name: isimodem
> ofonod[30943]:
> /ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
> 0x556bfd50, name: isimodem
> ofonod[30943]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556bfd80, name: isimodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
> 0x556bfdb0, name: isimodem
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556bfdd0, name: isimodem
> ofonod[30943]:
> /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> driver: 0x556bfdf0, name: isimodem
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556bfe00, name: wgmodem2.5
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:udev_start()
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:enumerate_devices()
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [0bda:8176]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
> [0bda:8176]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
> [0bda:8176]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [12d1:1001]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyU=
SB0
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB0
> (huawei) 255/255/255 [00] =3D=3D> (null) (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyU=
SB1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB1
> (huawei) 255/255/255 [01] =3D=3D> (null) (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyU=
SB2
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB2
> (huawei) 255/255/255 [02] =3D=3D> (null) (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem() driver=3Dhuawei
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_create() name: (null),
> type: huawei
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB0
> 255/255/255 00 (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB1
> 255/255/255 01 (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB2
> 255/255/255 02 (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() mdm=3D/dev/tty=
USB0
> pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556eb380 property Device
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556eb380 property Modem
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556eb380 property Pcui
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556eb380 property Diag
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556eb380 property NetworkInterface
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_register() 0x556eb380
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_probe() 0x556eb380
> ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_added() 0x556eb380
> ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556eb380
> added:1
> ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
> 0x556eb380, added: 1
> ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
> 0x556eb380, added: 1
> ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
> 0x556eb380, added: 1
> ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch() mode=
m:
> 0x556eb380, added: 1
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_enable() 0x556eb380
> ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> 0x556eb380 property Modem
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Modem
> /dev/ttyUSB0
> ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> 0x556eb380 property Pcui
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Pcui /dev/ttyUS=
B2
> ofonod[30943]: Modem: > ATE0 +CMEE=3D1\r
> ofonod[30943]: PCUI: > ATE0 +CMEE=3D1\r
> ofonod[30943]: Modem: < \r\nOK\r\n
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > ATI\r
> ofonod[30943]: PCUI: < \r\nManufacturer: huawei\r\nModel: E303\r\nRevisio=
n:
> 22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
> +CGSM,+DS,+ES\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^RFSWITCH=3D?\r
> ofonod[30943]: PCUI: < \r\nERROR\r\n
> ofonod[30943]: PCUI: > AT+CFUN=3D1\r
> ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
> ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_enable()
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 255 -> 1
> ofonod[30943]: PCUI: > AT^SYSINFO\r
> ofonod[30943]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG:
> 2\r\n\r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 1 -> 1
> ofonod[30943]: Modem: > AT&C0\r
> ofonod[30943]: PCUI: > AT&C0\r
> ofonod[30943]: Modem: < \r\nOK\r\n
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: Modem: > AT+CSCS=3D"GSM"\r
> ofonod[30943]: PCUI: > AT+CSCS=3D"GSM"\r
> ofonod[30943]: Modem: < \r\nOK\r\n
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT^U2DIAG?\r
> ofonod[30943]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^GETPORTMODE\r
> ofonod[30943]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA: huawei,\r\n\r\nOK\r=
\n
> ofonod[30943]: PCUI: > AT^USSDMODE=3D?\r
> ofonod[30943]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^DIALMODE=3D?\r
> ofonod[30943]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
> ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CFUN=3D5\r
> ofonod[30943]: PCUI: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
> ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^MODE: 0,0\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_offline()
> ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 0,
> new state: 1
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_pre_sim() 0x556eb380
> ofonod[30943]: PCUI: > AT^USSDMODE?\r
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dc6=
60
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dc6=
60
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dc6=
60
> ofonod[30943]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^DIALMODE?\r
> ofonod[30943]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^CVOICE?\r
> ofonod[30943]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
> ofonod[30943]: Voice channel: 8000 Hz, 16 bits, 20ms period
> ofonod[30943]: PCUI: > AT+GCAP\r
> ofonod[30943]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT^DDSETEX=3D?\r
> ofonod[30943]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGMI\r
> ofonod[30943]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 10
> ofonod[30943]: PCUI: > AT+CGMM\r
> ofonod[30943]: PCUI: < \r\nE303\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CGMR\r
> ofonod[30943]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 10
> ofonod[30943]: PCUI: > AT+CGSN\r
> ofonod[30943]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 10
> ofonod[30943]: PCUI: > AT+CPIN?\r
> ofonod[30943]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb:
> READY
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
> ofonod[30943]: PCUI: > AT^CPIN?\r
> ofonod[30943]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D9, val=3D10
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D1, val=3D3
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D11, val=3D10
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D4, val=3D3
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 4
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 4
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 10
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 1
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 1
> ofonod[30943]: PCUI: > AT+CIMI\r
> ofonod[30943]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
> 272050100413580
> ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 1,
> new state: 2
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_sim() 0x556eb380
> ofonod[30943]:
> /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
> ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> 0x556eb380 property AlwaysOnline
> ofonod[30943]: PCUI: > AT+CRC=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> 0x556eb380 property AlwaysOnline
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_set_online() modem
> 0x556eb380 online
> ofonod[30943]: PCUI: > AT+CLIP=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+COLP=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CCWA=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]:
> /ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized()
> registering to notifications
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556dc6=
60
> ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
> Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag)
> profile
> ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
> ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSCS=3D?\r
> ofonod[30943]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^SYSCFG=3D?\r
> ofonod[30943]: PCUI: < \r\n^SYSCFG:
>
> (2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(=
280000,"GSM850/GSM1900"),(3fffffff,"All
> bands")),(0-2),(0-4)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSMS=3D?\r
> ofonod[30943]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
> query parsed successfully
> ofonod[30943]: PCUI: > AT+CGDCONT=3D?\r
> ofonod[30943]: PCUI: < \r\n+CGDCONT:
> (1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
> (1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CFUN=3D1\r
> ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 1 -> 0
> ofonod[30943]: RegisterProfile() replied an error:
> org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> unknown return code 1
> ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 0 -> 1
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CPBS=3D?\r
> ofonod[30943]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSMS=3D1\r
> ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGREG=3D?\r
> ofonod[30943]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^SYSINFO\r
> ofonod[30943]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
> ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 2,
> new state: 3
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_online() 0x556eb3=
80
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CSMS?\r
> ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGREG=3D2\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGAUTO=3D0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGEREP=3D2,1\r
> ofonod[30943]: PCUI: < \r\nERROR\r\n
> ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
> Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw)
> profile
> ofonod[30943]: PCUI: > AT+CREG=3D?\r
> ofonod[30943]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSCB=3D?\r
> ofonod[30943]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CUSD=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CMGF=3D?\r
> ofonod[30943]: RegisterProfile() replied an error:
> org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> unknown return code 1
> ofonod[30943]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CREG=3D2\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556dc660
> ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556dcf18
> ofonod[30943]: PCUI: > AT+CSCB=3D0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI:
> 272050100413580
> ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556dcf18
> ofonod[30943]: PCUI: > AT+CPMS=3D?\r
> ofonod[30943]: PCUI: < \r\n+CPMS:
> ("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CREG?\r
> ofonod[30943]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> /huawei_0 status 2 tech -1
> ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
> 0x556dcf18, (nil)
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 2, -1, -1, -1,
> (null)(null)
> ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 2
> ofonod[30943]: PCUI: > AT+CMGF=3D0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
> ofonod[30943]: PCUI: < \r\n^MODE: 5,4\r\n
> ofonod[30943]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CNMI=3D?\r
> ofonod[30943]: PCUI: < \r\n+CNMI:
> (0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
> ofonod[30943]: Duplicate EFsdn entries for `Emergency Services'
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556dcf18
> ofonod[30943]: /ofono-1.14/src/sms.c:sms_restore_tx_queue()
> ofonod[30943]: /ofono-1.14/plugins/push-notification.c:sms_watch()
> registered
> ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:sms_watch() register=
ed
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CMGL=3D4\r
> ofonod[30943]: PCUI: < \r\n^RSSI: 13\r\n\r\n^HCSQ:"WCDMA",42,34,49\r\n
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
> ofonod[30943]: PCUI: > AT+CGSMS=3D3\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb() No
> CPHS MWIS on SIM
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> seekoff: 39, toread: 17
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> seekoff: 39, toread: 10
> ofonod[30943]: /ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
> ofonod[30943]: PCUI: > AT+CSCB=3D0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
> ofonod[30943]: PCUI: < \r\n^SRVST: 2\r\n\r\n+CGREG: 1,"0040","02C1155A"\r=
\n
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
> status 1
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]:
> /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid=
 1
> ofonod[30943]: Modem: > AT+CGDCONT=3D1,"IP","3Ireland"\r
> ofonod[30943]: Modem: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:at_cgdcont_cb()
> ok 1
> ofonod[30943]: Modem: > ATD*99***1#\r
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
> ofonod[30943]: Modem: < \r\nCONNECT\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:at_cgdata_cb() =
ok
> 1
> ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:setup_ppp()
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: < \r\n+CREG: 1,"0040","02C1155A"\r\n
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> /huawei_0 status 1 tech 2
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
> (null)(null)
> ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> ofonod[30943]: PCUI: > AT+COPS=3D3,2\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+COPS?\r
> ofonod[30943]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
> ofonod[30943]:
> /ofono-1.14/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
> numeric got mcc: 272, mnc: 05
> ofonod[30943]: PCUI: > AT+CSQ\r
> ofonod[30943]: PCUI: < \r\n+CSQ: 13,99\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
> csq_cb: 13
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> strength 41
> ofonod[30943]: PCUI: > AT+COPS=3D3,0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+COPS?\r
> ofonod[30943]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/network-registration.c:cops_cb=
()
> cops_cb: 3 IRL, 272 05 2
> ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
> 0x556dcf18, (nil)
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
> 27205
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, 0, 0
> ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> ofonod[30943]: PCUI: < \r\n^RSSI: 10\r\n\r\n^HCSQ:"WCDMA",37,28,47\r\n
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> strength 32
>
>
>
> Homam
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> ofonod[30943]: PCUI: < \r\n^RSSI: 12\r\n\r\n^HCSQ:"WCDMA",42,33,47\r\n
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> strength 38
> ofonod[30943]: PCUI: < \r\n^MODE: 5,7\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:ppp_connect()
> ofonod[30943]: IP: 10.205.206.243
> ofonod[30943]: DNS: 172.30.224.65, 172.30.224.65
> ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() 0x556e65a8
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net add
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net
> finished
>
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> ofonod[30943]: PCUI: <
>
> \r\n^DSFLOWRPT:00000002,000001ED,0000029E,00000000000003A6,00000000000004=
D4,00000000,00000000\r\n
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> ofonod[30943]: PCUI: <
>
> \r\n^DSFLOWRPT:00000004,00000000,00000000,00000000000003A6,00000000000004=
D4,00000000,00000000\r\n
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyU=
SB0
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_remove() 0x556eb380
> ofonod[30943]: /ofono-1.14/src/modem.c:modem_unregister() 0x556eb380
> ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 3,
> new state: 0
> ofonod[30943]: /ofono-1.14/src/modem.c:flush_atoms()
> ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_remove() atom:
> 0x556e5950
> ofonod[30943]: /ofono-1.14/src/call-barring.c:call_barring_remove() atom:
> 0x556e56b8
> ofonod[30943]: /ofono-1.14/src/call-settings.c:call_settings_remove() ato=
m:
> 0x556e55d0
> ofonod[30943]: /ofono-1.14/src/call-forwarding.c:call_forwarding_remove()
> atom: 0x556e54f8
> ofonod[30943]: /ofono-1.14/src/ussd.c:ussd_remove() atom: 0x556e5438
> ofonod[30943]:
> /ofono-1.14/src/network.c:__ofono_netreg_remove_status_watch() 0x556dcf18
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_remove() atom: 0x556e52c8
> ofonod[30943]:
> /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_detach_shutdown() cid 1
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_remove_spn_watch()
> 0x556dc660
> ofonod[30943]: /ofono-1.14/src/network.c:netreg_remove() atom: 0x556ddb88
> ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_context_unregister() 0x556e46a=
8,
> 0x556dd840
> ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_context_remove() atom:
> 0x556e46c8
> ofonod[30943]:
> /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_remove()
> ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_unregister_profile()
> Bluetooth: Unregistering profile /bluetooth/profile/dun_gw
> ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_unregister() 0x556dd840
> ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_remove() atom: 0x556dd8a8
> ofonod[30943]:
> /ofono-1.14/plugins/push-notification.c:push_notification_cleanup()
> 0x556df190
> ofonod[30943]:
> /ofono-1.14/plugins/smart-messaging.c:smart_messaging_cleanup() 0x556df160
> ofonod[30943]: /ofono-1.14/src/sms.c:sms_remove() atom: 0x556dd780
> ofonod[30943]: /ofono-1.14/src/radio-settings.c:radio_settings_remove()
> atom: 0x556ddbf8
> ofonod[30943]: /ofono-1.14/src/phonebook.c:phonebook_remove() atom:
> 0x556ddb08
> ofonod[30943]: /ofono-1.14/src/audio-settings.c:audio_settings_remove()
> atom: 0x556dda28
> ofonod[30943]: /ofono-1.14/src/voicecall.c:voicecall_remove() atom:
> 0x556d68c8
> ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_unregister_profile()
> Bluetooth: Unregistering profile /bluetooth/profile/hfp_ag
> ofonod[30943]: /ofono-1.14/src/sim.c:sim_remove() atom: 0x556dc788
> ofonod[30943]: /ofono-1.14/src/modem.c:devinfo_remove() atom: 0x556dd070
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_disable() 0x556eb380
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_remove() 0x556eb380
> ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> 0x556eb128
> ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> 0x556eb2b0
> ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> 0x556eb108
> ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> 0x556eb440
> ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> 0x556eb0d0
> ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_removed() 0x556eb380
> ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556eb380
> added:0
> ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
> 0x556eb380, added: 0
> ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
> 0x556eb380, added: 0
> ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
> 0x556eb380, added: 0
> ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch() mode=
m:
> 0x556eb380, added: 0
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB0
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB2
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty remo=
ve
> ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
> /devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty remo=
ve
> ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
> /devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyU=
SB1
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty remo=
ve
> ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
> /devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[30943]: UnregisterProfile() replied an error:
> org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> unknown return code 1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net remo=
ve
> ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
> /devices/virtual/net/ppp0
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net
> finished
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyU=
SB2
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/virtual/net/ppp0
> ofonod[30943]: UnregisterProfile() replied an error:
> org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> unknown return code 1
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [12d1:1f01]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [12d1:1001]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyU=
SB1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB1
> (huawei) 255/255/255 [01] =3D=3D> (null) (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyU=
SB0
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB0
> (huawei) 255/255/255 [00] =3D=3D> (null) (null)
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyU=
SB2
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB2
> (huawei) 255/255/255 [02] =3D=3D> (null) (null)
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem() driver=3Dhuawei
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_create() name: (null),
> type: huawei
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB0
> 255/255/255 00 (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB1
> 255/255/255 01 (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB2
> 255/255/255 02 (null)
> ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() mdm=3D/dev/tty=
USB0
> pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556dd280 property Device
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556dd280 property Modem
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556dd280 property Pcui
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556dd280 property Diag
> ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> 0x556dd280 property NetworkInterface
> ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_register() 0x556dd280
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_probe() 0x556dd280
> ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_added() 0x556dd280
> ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556dd280
> added:1
> ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
> 0x556dd280, added: 1
> ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
> 0x556dd280, added: 1
> ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
> 0x556dd280, added: 1
> ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch() mode=
m:
> 0x556dd280, added: 1
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_enable() 0x556dd280
> ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> 0x556dd280 property Modem
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Modem
> /dev/ttyUSB0
> ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> 0x556dd280 property Pcui
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Pcui /dev/ttyUS=
B2
> ofonod[30943]: PCUI: > ATE0 +CMEE=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > ATI\r
> ofonod[30943]: PCUI: < \r\nManufacturer: huawei\r\nModel: E303\r\nRevisio=
n:
> 22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
> +CGSM,+DS,+ES\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^RFSWITCH=3D?\r
> ofonod[30943]: PCUI: < \r\nERROR\r\n
> ofonod[30943]: PCUI: > AT+CFUN=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_enable()
> ofonod[30943]: PCUI: > AT^SYSINFO\r
> ofonod[30943]: PCUI: < \r\n^SYSINFO:2,3,0,5,1,0,4\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
> ofonod[30943]: PCUI: > AT&C0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSCS=3D"GSM"\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT^U2DIAG?\r
> ofonod[30943]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^GETPORTMODE\r
> ofonod[30943]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA: huawei,\r\n\r\nOK\r=
\n
> ofonod[30943]: PCUI: > AT^USSDMODE=3D?\r
> ofonod[30943]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^DIALMODE=3D?\r
> ofonod[30943]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
> ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CFUN=3D5\r
> ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SRVST: 0\r\n\r\n^MODE: 0,0\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_offline()
> ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 0,
> new state: 1
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_pre_sim() 0x556dd280
> ofonod[30943]: PCUI: > AT^USSDMODE?\r
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e76=
28
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e76=
28
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e76=
28
> ofonod[30943]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^DIALMODE?\r
> ofonod[30943]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^CVOICE?\r
> ofonod[30943]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
> ofonod[30943]: Voice channel: 8000 Hz, 16 bits, 20ms period
> ofonod[30943]: PCUI: > AT+GCAP\r
> ofonod[30943]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT^DDSETEX=3D?\r
> ofonod[30943]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGMI\r
> ofonod[30943]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 10
> ofonod[30943]: PCUI: > AT+CGMM\r
> ofonod[30943]: PCUI: < \r\nE303\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CGMR\r
> ofonod[30943]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 10
> ofonod[30943]: PCUI: > AT+CGSN\r
> ofonod[30943]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 10
> ofonod[30943]: PCUI: > AT+CPIN?\r
> ofonod[30943]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb:
> READY
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
> ofonod[30943]: PCUI: > AT^CPIN?\r
> ofonod[30943]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D9, val=3D10
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D1, val=3D3
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D11, val=3D10
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D4, val=3D3
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 4
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 4
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 10
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\=
r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[30943]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 1
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: =
0,
> dataoff: 0, tocopy: 1
> ofonod[30943]: PCUI: > AT+CIMI\r
> ofonod[30943]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
> 272050100413580
> ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 1,
> new state: 2
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_sim() 0x556dd280
> ofonod[30943]:
> /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
> ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> 0x556dd280 property AlwaysOnline
> ofonod[30943]: PCUI: > AT+CRC=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CLIP=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+COLP=3D1\r
> ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> 0x556dd280 property AlwaysOnline
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_set_online() modem
> 0x556dd280 online
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CCWA=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]:
> /ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized()
> registering to notifications
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e76=
28
> ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
> Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag)
> profile
> ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
> ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSCS=3D?\r
> ofonod[30943]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT^SYSCFG=3D?\r
> ofonod[30943]: PCUI: < \r\n^SYSCFG:
>
> (2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(=
280000,"GSM850/GSM1900"),(3fffffff,"All
> bands")),(0-2),(0-4)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSMS=3D?\r
> ofonod[30943]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
> query parsed successfully
> ofonod[30943]: PCUI: > AT+CGDCONT=3D?\r
> ofonod[30943]: PCUI: < \r\n+CGDCONT:
> (1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
> (1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CFUN=3D1\r
> ofonod[30943]: RegisterProfile() replied an error:
> org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> unknown return code 1
> ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 1 -> 0
> ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 0 -> 1
> ofonod[30943]: PCUI: > AT+CPBS=3D?\r
> ofonod[30943]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSMS=3D1\r
> ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGREG=3D?\r
> ofonod[30943]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT^SYSINFO\r
> ofonod[30943]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
> ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: 2,
> new state: 3
> ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_online() 0x556dd2=
80
> ofonod[30943]: PCUI: > AT+CSMS?\r
> ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGREG=3D2\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGAUTO=3D0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CGEREP=3D2,1\r
> ofonod[30943]: PCUI: < \r\nERROR\r\n
> ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
> Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw)
> profile
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CREG=3D?\r
> ofonod[30943]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSCB=3D?\r
> ofonod[30943]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CUSD=3D1\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: RegisterProfile() replied an error:
> org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> unknown return code 1
> ofonod[30943]: PCUI: > AT+CMGF=3D?\r
> ofonod[30943]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CREG=3D2\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556e7628
> ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556e70d8
> ofonod[30943]: PCUI: > AT+CSCB=3D0\r
> ofonod[30943]: PCUI: < \r\n^MODE: 5,4\r\n
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI:
> 272050100413580
> ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556e70d8
> ofonod[30943]: PCUI: > AT+CPMS=3D?\r
> ofonod[30943]: PCUI: < \r\n+CPMS:
> ("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CREG?\r
> ofonod[30943]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> /huawei_1 status 2 tech -1
> ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
> 0x556e70d8, (nil)
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 2, -1, -1, -1,
> (null)(null)
> ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 2
> ofonod[30943]: PCUI: > AT+CMGF=3D0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
> ofonod[30943]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n\r\n^RSSI:
> 13\r\n\r\n^HCSQ:"WCDMA",40,34,53\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CNMI=3D?\r
> ofonod[30943]: PCUI: < \r\n+CNMI:
> (0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
> ofonod[30943]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
> ofonod[30943]: Duplicate EFsdn entries for `Emergency Services'
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556e70d8
> ofonod[30943]: /ofono-1.14/src/sms.c:sms_restore_tx_queue()
> ofonod[30943]: /ofono-1.14/plugins/push-notification.c:sms_watch()
> registered
> ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:sms_watch() register=
ed
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CMGL=3D4\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
> ofonod[30943]: PCUI: > AT+CGSMS=3D3\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb() No
> CPHS MWIS on SIM
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> seekoff: 39, toread: 17
> ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> seekoff: 39, toread: 10
> ofonod[30943]: /ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
> ofonod[30943]: PCUI: > AT+CSCB=3D0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
> ofonod[30943]: PCUI: < \r\n^SRVST: 2\r\n\r\n+CGREG:
> 1,"0040","02C10178"\r\n\r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_1
> status 1
> ofonod[30943]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\=
r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
> ofonod[30943]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[30943]: PCUI: < \r\n+CREG: 1,"0040","02C10178"\r\n
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> /huawei_1 status 1 tech 2
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
> (null)(null)
> ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> ofonod[30943]: PCUI: > AT+COPS=3D3,2\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+COPS?\r
> ofonod[30943]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
> ofonod[30943]:
> /ofono-1.14/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
> numeric got mcc: 272, mnc: 05
> ofonod[30943]: PCUI: > AT+CSQ\r
> ofonod[30943]: PCUI: < \r\n+CSQ: 13,99\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
> csq_cb: 13
> ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> strength 41
> ofonod[30943]: PCUI: > AT+COPS=3D3,0\r
> ofonod[30943]: PCUI: < \r\nOK\r\n
> ofonod[30943]: PCUI: > AT+COPS?\r
> ofonod[30943]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
> ofonod[30943]: /ofono-1.14/drivers/atmodem/network-registration.c:cops_cb=
()
> cops_cb: 3 IRL, 272 05 2
> ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
> 0x556e70d8, (nil)
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
> 27205
> ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, 0, 0
> ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> ofonod[30943]:
> /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid=
 1
> ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() 0x556eb070
> ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() Activating
> context failed with error: Unknown error type
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <
> http://lists.ofono.org/pipermail/ofono/attachments/20140310/2195a8b0/atta=
chment.html
> >
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>
>
> ------------------------------
>
> End of ofono Digest, Vol 59, Issue 7
> ************************************
>



-- =

Homam Dabis | Software Consultant
m: +353 86 881 4018
skype: hdabis1

--===============1981288211012328880==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgc2ltcGxpZmllZCB0
aGUgcHJvY2VzcyBieSBlbGltaW5hdGluZyBjb25ubWFuIGFuZCBmb2N1c2luZyBvbiBvZm9uby48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgaW5zZXJ0IHRoZSBkb25nbGUgYW5kIHJ1biB0aGUg
Zm9sbG93aW5nOjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5vb3RAc21wODY3MDp+IyBk
YnVzLXNlbmQgLS1zeXN0ZW0gLS1wcmludC1yZXBseSAtLWRlc3Q9b3JnLm9mb25vIC8gb3JnLm9m
b25vLk1hbmFnZXIuR2V0TW9kZW1zPC9kaXY+CjxkaXY+bWV0aG9kIHJldHVybiBzZW5kZXI9OjEu
ODYgLSZndDsgZGVzdD06MS45MyByZXBseV9zZXJpYWw9MjwvZGl2PjxkaXY+oCCgYXJyYXkgWzwv
ZGl2PjxkaXY+oCCgIKAgc3RydWN0IHs8L2Rpdj48ZGl2PqAgoCCgIKAgoG9iamVjdCBwYXRoICZx
dW90Oy9odWF3ZWlfMCZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgYXJyYXkgWzwvZGl2PjxkaXY+
oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj4KPGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcg
JnF1b3Q7T25saW5lJnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCg
IKAgoCCgIKAgoCCgIGJvb2xlYW4gZmFsc2U8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48
ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJp
bmcgJnF1b3Q7UG93ZXJlZCZxdW90OzwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQg
oCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxzZTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwv
ZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAg
oHN0cmluZyAmcXVvdDtMb2NrZG93biZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFy
aWFudCCgIKAgoCCgIKAgoCCgIKAgoCBib29sZWFuIGZhbHNlPC9kaXY+CjxkaXY+oCCgIKAgoCCg
IKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAg
oCCgIKAgoHN0cmluZyAmcXVvdDtFbWVyZ2VuY3kmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCg
IKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxzZTwvZGl2PjxkaXY+oCCg
IKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj4KPGRpdj6g
IKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7SW50ZXJmYWNlcyZxdW90OzwvZGl2PjxkaXY+oCCg
IKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBhcnJheSBbPC9kaXY+PGRpdj6g
IKAgoCCgIKAgoCCgIKAgoCBdPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAg
oCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90
O0ZlYXR1cmVzJnF1b3Q7PC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCg
IKAgoCCgIKAgoCBhcnJheSBbPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgoCBdPC9kaXY+PGRp
dj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2Pjxk
aXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O1R5cGUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCg
IKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90O2hhcmR3YXJl
JnF1b3Q7PC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgXTwvZGl2
PjxkaXY+oCCgIKAgfTwvZGl2PjxkaXY+oCCgXTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+cm9v
dEBzbXA4NjcwOn4jIGRidXMtc2VuZCAtLXN5c3RlbSAtLXByaW50LXJlcGx5IC0tZGVzdD1vcmcu
b2Zvbm8gL2h1YXdlaV8wIG9yZy5vZm9uby5Nb2RlbS5TZXRQcm9wZXJ0eSBzdHJpbmc6JnF1b3Q7
UG93ZXJlZCZxdW90OyB2YXJpYW50OmJvb2xlYW46dHJ1ZTwvZGl2Pgo8ZGl2Pm1ldGhvZCByZXR1
cm4gc2VuZGVyPToxLjg2IC0mZ3Q7IGRlc3Q9OjEuOTUgcmVwbHlfc2VyaWFsPTI8L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PnJvb3RAc21wODY3MDp+IyBkYnVzLXNlbmQgLS1zeXN0ZW0gLS1wcmlu
dC1yZXBseSAtLWRlc3Q9b3JnLm9mb25vIC9odWF3ZWlfMCBvcmcub2Zvbm8uTW9kZW0uU2V0UHJv
cGVydHkgc3RyaW5nOiZxdW90O09ubGluZSZxdW90OyB2YXJpYW50OmJvb2xlYW46dHJ1ZTwvZGl2
Pgo8ZGl2Pm1ldGhvZCByZXR1cm4gc2VuZGVyPToxLjg2IC0mZ3Q7IGRlc3Q9OjEuOTYgcmVwbHlf
c2VyaWFsPTI8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnJvb3RAc21wODY3MDp+IyBkYnVzLXNl
bmQgLS1zeXN0ZW0gLS1wcmludC1yZXBseSAtLWRlc3Q9b3JnLm9mb25vIC9odWF3ZWlfMCBvcmcu
b2Zvbm8uQ29ubmVjdGlvbk1hbmFnZXIuR2V0Q29udGV4dHM8L2Rpdj48ZGl2Pm1ldGhvZCByZXR1
cm4gc2VuZGVyPToxLjg2IC0mZ3Q7IGRlc3Q9OjEuOTggcmVwbHlfc2VyaWFsPTI8L2Rpdj4KPGRp
dj6gIKBhcnJheSBbPC9kaXY+PGRpdj6gIKAgoCBzdHJ1Y3QgezwvZGl2PjxkaXY+oCCgIKAgoCCg
b2JqZWN0IHBhdGggJnF1b3Q7L2h1YXdlaV8wL2NvbnRleHQxJnF1b3Q7PC9kaXY+PGRpdj6gIKAg
oCCgIKBhcnJheSBbPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+
oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O05hbWUmcXVvdDs8L2Rpdj48ZGl2PgqgIKAgoCCg
IKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtJbnRlcm5ldCZx
dW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBl
bnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtBY3RpdmUmcXVvdDs8
L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVh
biBmYWxzZTwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRp
Y3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7VHlwZSZxdW90
OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBzdHJp
bmcgJnF1b3Q7aW50ZXJuZXQmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2
PqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5n
ICZxdW90O1Byb3RvY29sJnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAg
oCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtpcCZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCg
IKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAg
oCCgIKAgoHN0cmluZyAmcXVvdDtBY2Nlc3NQb2ludE5hbWUmcXVvdDs8L2Rpdj4KPGRpdj6gIKAg
oCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDszSXJlbGFu
ZCZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGlj
dCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtVc2VybmFtZSZx
dW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBz
dHJpbmcgJnF1b3Q7JnF1b3Q7PC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCg
IKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVv
dDtQYXNzd29yZCZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCg
IKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7JnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9k
aXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgIKAg
oHN0cmluZyAmcXVvdDtTZXR0aW5ncyZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFy
aWFudCCgIKAgoCCgIKAgoCCgIKAgoCBhcnJheSBbPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAg
oCBdPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVu
dHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O0lQdjYuU2V0dGluZ3Mm
cXVvdDs8L2Rpdj4KPGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCg
IGFycmF5IFs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoCCgIF08L2Rpdj48ZGl2PqAgoCCgIKAg
oCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAgoF08L2Rpdj48ZGl2PqAgoCCgIH08L2Rpdj48ZGl2PqAg
oCCgIHN0cnVjdCB7PC9kaXY+PGRpdj6gIKAgoCCgIKBvYmplY3QgcGF0aCAmcXVvdDsvaHVhd2Vp
XzAvY29udGV4dDImcXVvdDs8L2Rpdj4KPGRpdj6gIKAgoCCgIKBhcnJheSBbPC9kaXY+PGRpdj6g
IKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZx
dW90O05hbWUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCg
IKAgoCCgIKAgc3RyaW5nICZxdW90O0ludGVybmV0JnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAg
oCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2Pgo8ZGl2PqAgoCCgIKAg
oCCgIKAgoHN0cmluZyAmcXVvdDtBY3RpdmUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAg
oHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxzZTwvZGl2PjxkaXY+oCCgIKAg
oCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCg
IKAgoCCgIKAgoHN0cmluZyAmcXVvdDtUeXBlJnF1b3Q7PC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAg
oCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7aW50ZXJuZXQmcXVvdDs8
L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50cnko
PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7UHJvdG9jb2wmcXVvdDs8L2Rp
dj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZx
dW90O2lwJnF1b3Q7PC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCg
IKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtBY2Nl
c3NQb2ludE5hbWUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAg
oCCgIKAgoCCgIKAgc3RyaW5nICZxdW90OzNJcmVsYW5kJnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCg
IKAgoCApPC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCg
IKAgoCCgIKAgoHN0cmluZyAmcXVvdDtVc2VybmFtZSZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCg
IKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7JnF1b3Q7PC9kaXY+
PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2
PjxkaXY+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtQYXNzd29yZCZxdW90OzwvZGl2Pjxk
aXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7
JnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0
IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O1NldHRpbmdzJnF1
b3Q7PC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBh
cnJheSBbPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgoCBdPC9kaXY+PGRpdj6gIKAgoCCgIKAg
oCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCg
IKAgoCCgc3RyaW5nICZxdW90O0lQdjYuU2V0dGluZ3MmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAg
oCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYXJyYXkgWzwvZGl2Pgo8ZGl2PqAgoCCg
IKAgoCCgIKAgoCCgIF08L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAg
oF08L2Rpdj48ZGl2PqAgoCCgIH08L2Rpdj48ZGl2PqAgoCCgIHN0cnVjdCB7PC9kaXY+PGRpdj6g
IKAgoCCgIKBvYmplY3QgcGF0aCAmcXVvdDsvaHVhd2VpXzAvY29udGV4dDMmcXVvdDs8L2Rpdj48
ZGl2PqAgoCCgIKAgoGFycmF5IFs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPC9k
aXY+CjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O05hbWUmcXVvdDs8L2Rpdj48ZGl2
PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90O0lu
dGVybmV0JnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKAg
oCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O0FjdGl2
ZSZxdW90OzwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCg
IKAgYm9vbGVhbiBmYWxzZTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAg
oCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtU
eXBlJnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAg
oCCgIHN0cmluZyAmcXVvdDtpbnRlcm5ldCZxdW90OzwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgICk8
L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCg
IKBzdHJpbmcgJnF1b3Q7UHJvdG9jb2wmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZh
cmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90O2lwJnF1b3Q7PC9kaXY+PGRpdj6g
IKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2Pgo8ZGl2
PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtBY2Nlc3NQb2ludE5hbWUmcXVvdDs8L2Rpdj48
ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90
OyZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGlj
dCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtVc2VybmFtZSZx
dW90OzwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAg
c3RyaW5nICZxdW90OyZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCg
IKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVv
dDtQYXNzd29yZCZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCg
IKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7JnF1b3Q7PC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgKTwv
ZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAg
oHN0cmluZyAmcXVvdDtTZXR0aW5ncyZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFy
aWFudCCgIKAgoCCgIKAgoCCgIKAgoCBhcnJheSBbPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAg
oCBdPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgZGljdCBl
bnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtJUHY2LlNldHRpbmdz
JnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCg
IGFycmF5IFs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoCCgIF08L2Rpdj48ZGl2PqAgoCCgIKAg
oCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAgoF08L2Rpdj4KPGRpdj6gIKAgoCB9PC9kaXY+PGRpdj6g
IKAgoCBzdHJ1Y3QgezwvZGl2PjxkaXY+oCCgIKAgoCCgb2JqZWN0IHBhdGggJnF1b3Q7L2h1YXdl
aV8wL2NvbnRleHQ0JnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKBhcnJheSBbPC9kaXY+PGRpdj6g
IKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZx
dW90O05hbWUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCg
IKAgoCCgIKAgc3RyaW5nICZxdW90O0ludGVybmV0JnF1b3Q7PC9kaXY+CjxkaXY+oCCgIKAgoCCg
IKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAg
oCCgIKAgoHN0cmluZyAmcXVvdDtBY3RpdmUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAg
oHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxzZTwvZGl2PjxkaXY+oCCgIKAg
oCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj4KPGRpdj6gIKAg
oCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7VHlwZSZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAg
oCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7aW50ZXJuZXQmcXVvdDs8
L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50cnko
PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7UHJvdG9jb2wmcXVvdDs8L2Rp
dj4KPGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAm
cXVvdDtpcCZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCg
IKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtBY2Nl
c3NQb2ludE5hbWUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAg
oCCgIKAgoCCgIKAgc3RyaW5nICZxdW90OyZxdW90OzwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgICk8
L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCg
IKBzdHJpbmcgJnF1b3Q7VXNlcm5hbWUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZh
cmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90OyZxdW90OzwvZGl2PjxkaXY+oCCg
IKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj4KPGRpdj6g
IKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7UGFzc3dvcmQmcXVvdDs8L2Rpdj48ZGl2PqAgoCCg
IKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90OyZxdW90Ozwv
ZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8
L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtTZXR0aW5ncyZxdW90OzwvZGl2
Pgo8ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYXJyYXkgWzwv
ZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgIKAgXTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2
PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0
cmluZyAmcXVvdDtJUHY2LlNldHRpbmdzJnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKB2
YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIGFycmF5IFs8L2Rpdj4KPGRpdj6gIKAgoCCgIKAgoCCg
IKAgoCBdPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKBdPC9kaXY+
PGRpdj6gIKAgoCB9PC9kaXY+PGRpdj6gIKAgoCBzdHJ1Y3QgezwvZGl2PjxkaXY+oCCgIKAgoCCg
b2JqZWN0IHBhdGggJnF1b3Q7L2h1YXdlaV8wL2NvbnRleHQ1JnF1b3Q7PC9kaXY+PGRpdj6gIKAg
oCCgIKBhcnJheSBbPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2Pgo8ZGl2
PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtOYW1lJnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCg
IKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtJbnRlcm5ldCZx
dW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBl
bnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtBY3RpdmUmcXVvdDs8
L2Rpdj4KPGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIGJvb2xl
YW4gZmFsc2U8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRp
Y3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7VHlwZSZxdW90
OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBzdHJp
bmcgJnF1b3Q7aW50ZXJuZXQmcXVvdDs8L2Rpdj4KPGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRp
dj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5n
ICZxdW90O1Byb3RvY29sJnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAg
oCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtpcCZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCg
IKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj4KPGRpdj6gIKAgoCCg
IKAgoCCgIKBzdHJpbmcgJnF1b3Q7QWNjZXNzUG9pbnROYW1lJnF1b3Q7PC9kaXY+PGRpdj6gIKAg
oCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDsmcXVvdDs8
L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50cnko
PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7VXNlcm5hbWUmcXVvdDs8L2Rp
dj4KPGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAm
cXVvdDsmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2PqAgoCCgIKAgoCCg
IGRpY3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7UGFzc3dv
cmQmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCg
IKAgc3RyaW5nICZxdW90OyZxdW90OzwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2
PqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcg
JnF1b3Q7U2V0dGluZ3MmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCg
IKAgoCCgIKAgoCCgIKAgYXJyYXkgWzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgIKAgXTwvZGl2
PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPC9k
aXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7SVB2Ni5TZXR0aW5ncyZxdW90Ozwv
ZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBhcnJheSBb
PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgoCBdPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9k
aXY+PGRpdj6gIKAgoCCgIKBdPC9kaXY+CjxkaXY+oCCgIKAgfTwvZGl2PjxkaXY+oCCgXTwvZGl2
PjxkaXY+cm9vdEBzbXA4NjcwOn4jIGRidXMtc2VuZCAtLXN5c3RlbSAtLXByaW50LXJlcGx5IC0t
ZGVzdD1vcmcub2Zvbm8gL2h1YXdlaV8wL2NvbnRleHQxIG9yZy5vZm9uby5Db25uZWN0aW9uQ29u
dGV4dC5TZXRQcm9wZXJ0eSBzdHJpbmc6JnF1b3Q7QWN0aXZlJnF1b3Q7IHZhcmlhbnQ6Ym9vbGVh
bjp0cnVlPC9kaXY+PGRpdj5FcnJvciBvcmcub2Zvbm8uRXJyb3IuRmFpbGVkOiBPcGVyYXRpb24g
ZmFpbGVkPC9kaXY+CjxkaXY+PGJyPjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhl
IG9mb25vIGRlYnVnIGlzIGFzIGZvbGxvd3M6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48ZGl2Pm9mb25vZFsxNTYwXTogb0Zvbm8gdmVyc2lvbiAxLjE0PC9kaXY+PGRp
dj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9wbHVnaW4uYzpfX29mb25vX3BsdWdpbl9p
bml0KCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3B1c2gt
bm90aWZpY2F0aW9uLmM6cHVzaF9ub3RpZmljYXRpb25faW5pdCgpoDwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOnNtYXJ0X21lc3Nh
Z2luZ19pbml0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9jZG1h
LXByb3Zpc2lvbi5jOm9mb25vX2NkbWFfcHJvdmlzaW9uX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg1NTZjMWJiMCBuYW1lOiBDRE1BIHByb3Zpc2lvbmluZzwvZGl2Pgo8ZGl2Pm9mb25vZFsx
NTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMtcHJvdmlzaW9uLmM6b2Zvbm9fZ3Byc19wcm92aXNp
b25fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxYjgwIG5hbWU6IFByb3Zpc2lvbmlu
ZzwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2R1bl9nd19ibHVl
ejUuYzpkdW5fZ3dfaW5pdCgpoDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9z
cmMvaGFuZHNmcmVlLWF1ZGlvLmM6b2Zvbm9faGFuZHNmcmVlX2NhcmRfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDU1NmMxYTUwPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YzFhNjAsIG5hbWU6IGhmcDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVn
aW5zL2hlOTEwLmM6aGU5MTBfaW5pdCgpoDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NTU2YzE5ZTAsIG5hbWU6IGhlOTEwPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL2Nvbm5tYW4uYzpjb25ubWFuX2luaXQoKaA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYw
XTogL29mb25vLTEuMTQvc3JjL3ByaXZhdGUtbmV0d29yay5jOm9mb25vX3ByaXZhdGVfbmV0d29y
a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE5YjAsIG5hbWU6IENvbm5NYW4gUHJp
dmF0ZSBOZXR3b3JrPC9kaXY+PGRpdj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE5NjAsIG5h
bWU6IHNpbTkwMDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE5MTAsIG5hbWU6
IHNhbXN1bmc8L2Rpdj48ZGl2PgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMThjMCwgbmFtZTog
c3BlZWR1cGNkbWE8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVt
LmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxODcwLCBuYW1l
OiBzcGVlZHVwPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE4MjAsIG5hbWU6
IGFsY2F0ZWw8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxN2MwLCBuYW1lOiBp
Y2VyYTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zv
bm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNzcwLCBuYW1lOiBsaW5r
dG9wPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTcyMCwgbmFtZTogbm9raWFj
ZG1hPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9u
b19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzE2ZDAsIG5hbWU6IG5va2lh
PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTY4MCwgbmFtZTogdGM2NTwvZGl2
PjxkaXY+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1f
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNWYwLCBuYW1lOiBzdGU8L2Rpdj48ZGl2
Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxNTkwLCBuYW1lOiBpZng8L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDU1NmMxNTQwLCBuYW1lOiBwYWxtcHJlPC9kaXY+CjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NTU2YzE0ZjAsIG5hbWU6IG5vdmF0ZWw8L2Rpdj48ZGl2Pm9mb25vZFsx
NTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDU1NmMxNGEwLCBuYW1lOiBzaWVycmE8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2
MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg1NTZjMTQyMCwgbmFtZTogaHVhd2VpPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg1NTZjMTNkMCwgbmFtZTogenRlPC9kaXY+PGRpdj4Kb2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4NTU2YzEzNzAsIG5hbWU6IGhzbzwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YzEzMjAsIG5hbWU6IG1ibTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzEyZDAs
IG5hbWU6IGNhbHlwc288L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMTI4MCwg
bmFtZTogd2F2ZWNvbTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzEyMzAsIG5h
bWU6IGcxPC9kaXY+PGRpdj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvY2RtYS12b2lj
ZWNhbGwuYzpvZm9ub19jZG1hX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NTU2YzExYTAsIG5hbWU6IGNkbWFtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZjMTFjMCwgbmFtZTogY2RtYW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9zcmMvY2RtYS1jb25ubWFuLmM6b2Zvbm9fY2RtYV9jb25ubWFuX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMTFmMCwgbmFtZTogY2RtYW1vZGVtPC9kaXY+PGRpdj5vZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMTExYywgbmFtZTogcGhvbmVzaW08L2Rpdj4KPGRpdj5vZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMTE1NCwgbmFtZTogbG9jYWxoZnA8L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxMTA0LCBuYW1lOiBwaG9uZXNpbTwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2N0bS5jOm9mb25vX2N0bV9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzEwZjAsIG5hbWU6IHBob25lc2ltPC9kaXY+PGRpdj5vZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvcGhvbmVzaW0uYzpwYXJzZV9jb25maWcoKSBm
aWxlbmFtZSAvZXRjL29mb25vL3Bob25lc2ltLmNvbmY8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg1NTZjMTBiMCwgbmFtZTogc3BlZWR1cG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMGY1MCwgbmFtZTogaGZwbW9kZW08L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzEwMTAsIG5hbWU6IGhmcG1vZGVtPC9kaXY+CjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBmYTAsIG5hbWU6IGhmcG1vZGVtPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9jYWxsLXZvbHVtZS5jOm9mb25vX2NhbGxfdm9s
dW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGZlMCwgbmFtZTogaGZwbW9kZW08
L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9oYW5kc2ZyZWUuYzpvZm9u
b19oYW5kc2ZyZWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxMDMwLCBuYW1lOiBo
ZnBtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2lyaS5jOm9m
b25vX3NpcmlfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMxMDYwLCBuYW1lOiBoZnBt
b2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpv
Zm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZWMwLCBuYW1lOiBk
dW5tb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9m
b25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwZWYwLCBuYW1lOiBkdW5t
b2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5j
Om9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBkZjAsIG5h
bWU6IHN0ZW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGU3
MCwgbmFtZTogc3RlbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Ny
Yy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg1NTZjMGU0MCwgbmFtZTogc3RlbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYw
XTogL29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBjYjAsIG5hbWU6IGlmeG1vZGVtPC9kaXY+CjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvYXVkaW8tc2V0dGluZ3MuYzpvZm9ub19hdWRpb19z
ZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBkMDAsIG5hbWU6IGlmeG1v
ZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5n
cy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZj
MGQyMCwgbmFtZTogaWZ4bW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZjMGQ1MCwgbmFtZTogaWZ4bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YzBkODAsIG5hbWU6IGlmeG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9zcmMvY3RtLmM6b2Zvbm9fY3RtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGRi
MCwgbmFtZTogaWZ4bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3Jj
L2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1
NmMwYzQwLCBuYW1lOiBoc29tb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEu
MTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOiAweDU1NmMwYzYwLCBuYW1lOiBoc29tb2RlbTwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBiYjAsIG5hbWU6IG1ibW1vZGVtPC9kaXY+CjxkaXY+
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMGJlMCwgbmFtZTogbWJtbW9kZW08L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2xvY2F0aW9uLXJlcG9ydGluZy5jOm9mb25vX2xvY2F0
aW9uX3JlcG9ydGluZ19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBjMDAsIG5hbWU6
IG1ibW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2Vj
YWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMGIy
MCwgbmFtZTogY2FseXBzb21vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3NyYy9zdGsuYzpvZm9ub19zdGtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwYjcw
LCBuYW1lOiBjYWx5cHNvbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3NyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBh
MDAsIG5hbWU6IGh1YXdlaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
OiAweDU1NmMwYTIwLCBuYW1lOiBodWF3ZWltb2RlbTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvc3JjL2F1ZGlvLXNldHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwYTcwLCBuYW1lOiBodWF3ZWltb2RlbTwvZGl2
PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9u
b19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzBhYjAsIG5h
bWU6IGh1YXdlaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMv
Z3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2
YzBhOTAsIG5hbWU6IGh1YXdlaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0x
LjE0L3NyYy9jZG1hLW5ldHJlZy5jOm9mb25vX2NkbWFfbmV0cmVnX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg1NTZjMGFlMCwgbmFtZTogaHVhd2VpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2Rb
MTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDk3MCwgbmFtZTogaWNlcmFtb2RlbTwvZGl2PjxkaXY+
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRp
b19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA5YTAsIG5hbWU6IGlj
ZXJhbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9yYWRpby1z
ZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZjMDkyMCwgbmFtZTogenRlbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCkgZHJp
dmVyOiAweDU1NmMwOGUwLCBuYW1lOiBzd21vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA4OTAsIG5hbWU6IG53bW9kZW08L2Rpdj48ZGl2
Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2Fs
bF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA2YjAsIG5hbWU6IGF0bW9kZW08L2Rp
dj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2Rldmlu
Zm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNzYwLCBuYW1lOiBhdG1vZGVtPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9jYWxsLWJhcnJpbmcuYzpvZm9u
b19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNzEwLCBuYW1l
OiBhdG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvY2FsbC1m
b3J3YXJkaW5nLmM6b2Zvbm9fY2FsbF9mb3J3YXJkaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg1NTZjMDQ4MCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9zcmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOiAweDU1NmMwNGIwLCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9zcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0dGluZ3Nf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwMzkwLCBuYW1lOiBhdG1vZGVtPC9kaXY+
PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9waG9uZWJvb2suYzpvZm9ub19waG9u
ZWJvb2tfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNzMwLCBuYW1lOiBhdG1vZGVt
PC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdXNzZC5jOm9mb25vX3Vz
c2RfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNjgwLCBuYW1lOiBhdG1vZGVtPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpvZm9ub19zbXNfZHJp
dmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwNDAwLCBuYW1lOiBhdG1vZGVtPC9kaXY+PGRp
dj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDU2MCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg1NTZjMDVhOCwgbmFtZTogYXRtb2RlbS1ub2VmPC9kaXY+PGRpdj4Kb2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjogMHg1NTZjMDY2MCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NTU2YzA1MDAsIG5hbWU6IGF0bW9kZW08L2Rpdj48ZGl2PgpvZm9ub2Rb
MTU2MF06IC9vZm9uby0xLjE0L3NyYy9jYnMuYzpvZm9ub19jYnNfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOiAweDU1NmMwNDYwLCBuYW1lOiBhdG1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L3NyYy9jYWxsLXZvbHVtZS5jOm9mb25vX2NhbGxfdm9sdW1lX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDc5MCwgbmFtZTogYXRtb2RlbTwvZGl2Pgo8ZGl2Pm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMDdkMCwgbmFtZTogYXRtb2RlbTwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzA4MDAsIG5hbWU6IGF0bW9kZW08L2Rpdj4KPGRpdj5v
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zaW0tYXV0aC5jOm9mb25vX3NpbV9hdXRoX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDgyMCwgbmFtZTogYXRtb2RlbTwvZGl2Pjxk
aXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ25zcy5jOm9mb25vX2duc3NfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwODQwLCBuYW1lOiBhdG1vZGVtPC9kaXY+CjxkaXY+
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAxYjAsIG5hbWU6IGdvYmk8L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZmODAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+CjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZmZjAsIG5hbWU6IHFtaW1vZGVtPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxf
ZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZmEwLCBuYW1lOiBxbWltb2RlbTwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YzAwMjAsIG5hbWU6IHFtaW1vZGVtLWxlZ2FjeTwv
ZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZjMDA3MCwgbmFtZTogcW1pbW9kZW08L2Rpdj4K
PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwMGMwLCBuYW1lOiBxbWltb2RlbTwvZGl2PjxkaXY+
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwMGUwLCBuYW1lOiBxbWltb2RlbTwvZGl2PjxkaXY+Cm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZjMDEwMCwgbmFtZTogcW1pbW9kZW08L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwMTIwLCBuYW1lOiBxbWltb2RlbTwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFk
aW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmMwMTQwLCBuYW1lOiBx
bWltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbG9jYXRpb24t
cmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0aW5nX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg1NTZjMDE3MCwgbmFtZTogcW1pbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg1NTZiZmYyYywgbmFtZTogdTg1MDA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YmZmMTAsIG5hbWU6IHU4NTAwPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
IDB4NTU2YmZlYzAsIG5hbWU6IG45MDA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEu
MTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1
NmJmZTcwLCBuYW1lOiBpc2l1c2I8L2Rpdj48ZGl2PgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3NyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1
NmJmYjkwLCBuYW1lOiBpc2ltb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9zcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjogMHg1NTZiZmI4MCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9v
Zm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjogMHg1NTZiZmJiMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NTU2YmZiZTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc21zLmM6b2Zvbm9fc21zX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjogMHg1NTZiZmMzMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYw
XTogL29mb25vLTEuMTQvc3JjL2Nicy5jOm9mb25vX2Nic19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2
ZXI6IDB4NTU2YmZjNTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj4Kb2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjog
MHg1NTZiZmM3MCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1
NTZiZmNjMCwgbmFtZTogaXNpbW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEu
MTQvc3JjL2NhbGwtZm9yd2FyZGluZy5jOm9mb25vX2NhbGxfZm9yd2FyZGluZ19kcml2ZXJfcmVn
aXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZjZTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+CjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0
dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOiAweDU1NmJmZDAwLCBuYW1lOiBpc2ltb2Rl
bTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvY2FsbC1iYXJyaW5nLmM6
b2Zvbm9fY2FsbF9iYXJyaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmQzMCwg
bmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9j
YWxsLW1ldGVyLmM6b2Zvbm9fY2FsbF9tZXRlcl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4
NTU2YmZkNTAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0x
LjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjogMHg1NTZiZmQ4MCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5vZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6IDB4NTU2YmZkYjAsIG5hbWU6IGlzaW1vZGVtPC9kaXY+PGRpdj5vZm9ub2Rb
MTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmRkMCwgbmFtZTogaXNpbW9kZW08L2Rpdj4KPGRpdj5v
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlv
X3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjogMHg1NTZiZmRmMCwgbmFtZTogaXNp
bW9kZW08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25v
X3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6IDB4NTU2YmZlMDAsIG5hbWU6IHdnbW9kZW0y
LjU8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6
dWRldl9zdGFydCgpoDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5z
L3VkZXZuZy5jOmVudW1lcmF0ZV9kZXZpY2VzKCmgPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9v
Zm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIGh1YiBbKG51bGwp
OihudWxsKV08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYiBbMGJkYTo4MTc2XTwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBy
dGw4MTkyY3UgWyhudWxsKToobnVsbCldPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0x
LjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHJ0bDgxOTJjdSBbMGJkYTo4
MTc2XTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcu
YzpjaGVja191c2JfZGV2aWNlKCkgaHViIFsobnVsbCk6KG51bGwpXTwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1
c2IgWzEyZDE6MWYwMV08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFsobnVsbCk6KG51bGwpXTwvZGl2Pgo8
ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2
aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzIt
MToxLjA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcu
YzpyZW1vdmVfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0x
L3VzYjIvMi0xPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3Vk
ZXZuZy5jOmNoZWNrX21vZGVtX2xpc3QoKaA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiIFsxMmQxOjEwMDFd
PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hl
Y2tfdXNiX2RldmljZSgpIG9wdGlvbiBbKG51bGwpOihudWxsKV08L2Rpdj4KPGRpdj5vZm9ub2Rb
MTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9w
dGlvbiBbKG51bGwpOihudWxsKV08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
cGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uIFsobnVsbCk6KG51bGwp
XTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNo
ZWNrX3VzYl9kZXZpY2UoKSBvcHRpb24gWzEyZDE6MTAwMV08L2Rpdj4KPGRpdj5vZm9ub2RbMTU2
MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNl
cy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvc3lzL2Rldmlj
ZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEvMi0xOjEuMC90dHlVU0IwL3R0
eS90dHlVU0IwPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3Vk
ZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjAgKGh1YXdlaSkgMjU1LzI1NS8yNTUgWzAw
XSA9PSZndDsgKG51bGwpIChudWxsKTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBhZGQ8L2Rpdj48ZGl2
Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1
YnN5c3RlbSB0dHkgZmluaXNoZWQ8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbiBbMTJkMToxMDAxXTwv
ZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9k
ZXZpY2UoKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8
L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRf
ZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0x
LzItMToxLjEvdHR5VVNCMS90dHkvdHR5VVNCMTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL2Rldi90dHlVU0IxIChodWF3
ZWkpIDI1NS8yNTUvMjU1IFswMV0gPT0mZ3Q7IChudWxsKSAobnVsbCk8L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3Rl
bSB0dHkgYWRkPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
di5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGZpbmlzaGVkPC9kaXY+CjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBv
cHRpb24gWzEyZDE6MTAwMV08L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1
Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1l
aGNpLWhjZC0xL3VzYjIvMi0xPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gt
ZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4yL3R0eVVTQjIvdHR5L3R0eVVTQjI8L2Rpdj4KPGRp
dj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgp
IC9kZXYvdHR5VVNCMiAoaHVhd2VpKSAyNTUvMjU1LzI1NSBbMDJdID09Jmd0OyAobnVsbCkgKG51
bGwpPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVk
ZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IGFkZDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBmaW5pc2hl
ZDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpj
aGVja19tb2RlbV9saXN0KCmgPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCkgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3Rhbmdv
eC1laGNpLWhjZC0xL3VzYjIvMi0xPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCkgZHJpdmVyPWh1YXdlaTwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRl
KCkgbmFtZTogKG51bGwpLCB0eXBlOiBodWF3ZWk8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvc3lzL2RldmljZXMvcGxh
dGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjAg
MjU1LzI1NS8yNTUgMDAgKG51bGwpPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIC9kZXYvdHR5VVNCMSAyNTUvMjU1LzI1
NSAwMSAobnVsbCk8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91
ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjIgMjU1LzI1NS8yNTUgMDIgKG51bGwp
PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6c2V0
dXBfaHVhd2VpKCkgbWRtPS9kZXYvdHR5VVNCMCBwY3VpPS9kZXYvdHR5VVNCMiBkaWFnPShudWxs
KSBxbWk9KG51bGwpIG5ldD0obnVsbCk8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0x
LjE0L3NyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZDQyYTAgcHJv
cGVydHkgRGV2aWNlPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZDQyYTAgcHJvcGVydHkgTW9kZW08
L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVt
X3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZkNDJhMCBwcm9wZXJ0eSBQY3VpPC9kaXY+CjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBt
b2RlbSAweDU1NmQ0MmEwIHByb3BlcnR5IERpYWc8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZkNDJh
MCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJmYWNlPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9u
by0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX3JlZ2lzdGVyKCkgMHg1NTZkNDJhMDwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlf
cHJvYmUoKSAweDU1NmQ0MmEwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDU1NmQ0MmEwPC9kaXY+PGRpdj5vZm9ub2Rb
MTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmNhbGxfbW9kZW13YXRjaGVzKCkgMHg1NTZk
NDJhMCBhZGRlZDoxPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5z
L2hmcF9hZ19ibHVlejUuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDU1NmQ0MmEwLCBhZGRlZDog
MTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2R1bl9nd19ibHVl
ejUuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDU1NmQ0MmEwLCBhZGRlZDogMTwvZGl2PjxkaXY+
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOm1vZGVt
X3dhdGNoKCkgbW9kZW06IDB4NTU2ZDQyYTAsIGFkZGVkOiAxPC9kaXY+CjxkaXY+b2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6bW9kZW1fd2F0Y2go
KSBtb2RlbTogMHg1NTZkNDJhMCwgYWRkZWQ6IDE8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfZW5hYmxlKCkgMHg1NTZkNDJhMDwvZGl2
PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbSAweDU1NmQ0MmEwIHByb3BlcnR5IE1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOm9wZW5fZGV2aWNlKCkgTW9kZW0g
L2Rldi90dHlVU0IwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZDQyYTAgcHJvcGVydHkgUGN1aTwv
ZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOm9wZW5f
ZGV2aWNlKCkgUGN1aSAvZGV2L3R0eVVTQjI8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6
ICZndDsgQVRFMCArQ01FRT0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBc
clxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVRJXHI8L2Rpdj48
ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuTWFudWZhY3R1cmVyOiBodWF3ZWlcclxu
TW9kZWw6IEUzMDNcclxuUmV2aXNpb246IDIyLjMxOC4wNS4wMC4wMFxyXG5JTUVJOiA4NjI1NjYw
MjAwMDU2OTdcclxuK0dDQVA6ICtDR1NNLCtEUywrRVNcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5SRlNXSVRDSD0/XHI8L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogUENVSTogJmx0OyBcclxuRVJST1JcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IFBDVUk6ICZndDsgQVQrQ0ZVTj0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0
OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMv
aHVhd2VpLmM6Y2Z1bl9lbmFibGUoKaA8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZn
dDsgQVReU1lTSU5GT1xyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbl5T
WVNJTkZPOjIsMywwLDUsMSwwLDRcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOnN5c2luZm9fZW5hYmxlX2NiKCkgMjU1IC0m
Z3Q7IDE8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCZhbXA7QzBccjwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9u
b2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1NDUz0mcXVvdDtHU00mcXVvdDtccjwvZGl2PjxkaXY+
b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYw
XTogUENVSTogJmd0OyBBVF5VMkRJQUc/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTog
Jmx0OyBcclxuXlUyRElBRzogMTE5XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTU2
MF06IFBDVUk6ICZndDsgQVReR0VUUE9SVE1PREVccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQ
Q1VJOiAmbHQ7IFxyXG5eR0VUUE9SVE1PREU6IFRZUEU6IFdDRE1BOiBodWF3ZWksXHJcblxyXG5P
S1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5VU1NETU9ERT0/XHI8
L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuXlVTU0RNT0RFOiAoMC0xKVxy
XG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUXkRJQUxN
T0RFPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5eRElBTE1PREU6
ICgwLTIpLCgwLTI1NSlcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmZ3Q7IEFUXkNWT0lDRT0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBc
clxuXkNWT0lDRTogKDApXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBD
VUk6ICZndDsgQVQrQ0ZVTj01XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBc
clxuK0NHUkVHOiAwXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JFRzogMFxyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxu
XHJcbl5TUlZTVDogMFxyXG5cclxuXk1PREU6IDAsMFxyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTU2
MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6Y2Z1bl9vZmZsaW5lKCmgPC9kaXY+PGRp
dj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0
ZSgpIG9sZCBzdGF0ZTogMCwgbmV3IHN0YXRlOiAxPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9v
Zm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3ByZV9zaW0oKSAweDU1NmQ0MmEwPC9k
aXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUXlVTU0RNT0RFP1xyPC9kaXY+PGRp
dj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRl
X3dhdGNoKCkgMHg1NTZlOTljODwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9z
cmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZTk5Yzg8L2Rpdj48ZGl2
PgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRl
X3dhdGNoKCkgMHg1NTZlOTljODwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxy
XG5eVVNTRE1PREU6IDFcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmZ3Q7IEFUXkRJQUxNT0RFP1xyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsg
XHJcbl5ESUFMTU9ERTozLDJcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTog
UENVSTogJmd0OyBBVF5DVk9JQ0U/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0
OyBcclxuXkNWT0lDRTogMSwgODAwMCwgMTYsIDIwXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxNTYwXTogVm9pY2UgY2hhbm5lbDogODAwMCBIeiwgMTYgYml0cywgMjBtcyBwZXJpb2Q8
L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtHQ0FQXHI8L2Rpdj4KPGRpdj5v
Zm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VTXHJcblxyXG5P
S1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwxMjI1
OCwwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006
IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDIyRkUyQTUwMzgwMDE3MThBMDEwNThCMDMyRjA2
MDM4MDAyMDAwQTg4MDExMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkg
Y3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZn
dDsgQVReRERTRVRFWD0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxu
XkREU0VURVg6ICgyKVxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmZ3Q7IEFUK0NHTUlccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5o
dWF3ZWlcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTc2LDEyMjU4LDAsMCwxMFxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs5ODUzMDMwNTAxMDcwODUzMDVGNiZxdW90O1xyXG5c
clxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDEwPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9y
ZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPC9kaXY+PGRp
dj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ0dNTVxyPC9kaXY+CjxkaXY+b2Zvbm9kWzE1
NjBdOiBQQ1VJOiAmbHQ7IFxyXG5FMzAzXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsx
NTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQyMSwwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9m
b25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEy
MTgzMDI2RjA1QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDQ4MDAyMDAwQTg4MDExMCZxdW90O1xy
XG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMw
PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ0dNUlxyPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbjIyLjMxOC4wNS4wMC4wMFxyXG5cclxuT0tcclxu
PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg0MjEsMCww
LDEwXHI8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQs
MCwmcXVvdDs2NTZFRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNt
X3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYw
XTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZv
ZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTA8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBD
VUk6ICZndDsgQVQrQ0dTTlxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJc
bjg2MjU2NjAyMDAwNTY5N1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xOTIsMTIwMzcsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2
MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyMkYw
NUE1MDM4MDAxNzE4QTAxMDU4QjAzMkYwNjA0ODAwMjAwMEE4ODAxMjgmcXVvdDtcclxuXHJcbk9L
XHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2Pjxk
aXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2LDEyMDM3LDAsMCwxMFxyPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2
NTZFRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2Ni
KCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDEwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9u
by0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBk
YXRhb2ZmOiAwLCB0b2NvcHk6IDEwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsg
QVQrQ1BJTj9ccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NQSU46
IFJFQURZXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2NwaW5fY2IoKSBjcnNtX3Bpbl9jYjogUkVBRFk8L2Rp
dj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X3Bpbl9yZXRyaWVzX3F1ZXJ5KCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7
IEFUXkNQSU4/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuXkNQSU46
IFJFQURZLCwxMCwzLDEwLDNcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeSBj
b3VudGVyIGlkPTksIHZhbD0xMDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD0x
LCB2YWw9MzwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeSBjb3VudGVyIGlkPTExLCB2YWw9MTA8L2Rp
dj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1
YXdlaV9jcGluX2NiKCkgcmV0cnkgY291bnRlciBpZD00LCB2YWw9MzwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODU5MCwwLDAsMjU1XHI8L2Rpdj48ZGl2
Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7
XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNN
PTE5MiwyODU4OSwwLDAsMjU1XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBc
clxuK0NSU006IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RkFEQTUwMzgwMDE3MThBMDEw
NThCMDM2RjA2MDY4MDAyMDAwNDg4MDExOCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9p
bmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg1ODksMCwwLDRccjwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDImcXVvdDtcclxu
XHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA0PC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9y
ZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDQ8L2Rpdj48ZGl2
Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQzOCwwLDAsMjU1XHI8L2Rp
dj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90
OyZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsg
QVQrQ1JTTT0xOTIsMjg0NzIsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6
ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyNkYzOEE1MDM4MDAx
NzE4QTAxMDU4QjAzNkYwNjAyODAwMjAwMEE4ODAxMjAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2LDI4NDcyLDAsMCwxMFxyPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs3RUVFMTExQzI3
RjY1OTAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDEwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Ny
Yy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAw
LCB0b2NvcHk6IDEwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0x
OTIsMjg1MDIsMCwwLDI1NVxyPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxy
XG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGNTZBNTAzODAwMTcxOEEwMTA1
OEIwMzZGMDYwNzgwMDIwMDAxODgwMTI4JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5m
b19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTog
UENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODUwMiwwLDAsMVxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2
MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMCZxdW90O1xyXG5cclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTwvZGl2Pgo8ZGl2
Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxv
Y2tfY2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NJTUlccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmbHQ7IFxyXG4yNzIwNTAxMDA0MTM1ODBcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2NpbWlfY2IoKSBj
aW1pX2NiOiAyNzIwNTAxMDA0MTM1ODA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEu
MTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAxLCBuZXcgc3Rh
dGU6IDI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWku
YzpodWF3ZWlfcG9zdF9zaW0oKSAweDU1NmQ0MmEwPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRfZ3Byc19jb250ZXh0
X3Byb2JlKCmgPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
OmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZDQyYTAgcHJvcGVydHkgQWx3YXlzT25s
aW5lPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JDPTFccjwvZGl2Pgo8
ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2Rb
MTU2MF06IFBDVUk6ICZndDsgQVQrQ0xJUD0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENV
STogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQr
Q09MUD0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9k
aXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NDV0E9MVxyPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2h1YXdlaW1vZGVtL3ZvaWNlY2FsbC5jOmh1YXdlaV92b2lj
ZWNhbGxfaW5pdGlhbGl6ZWQoKSByZWdpc3RlcmluZyB0byBub3RpZmljYXRpb25zPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0
ZV93YXRjaCgpIDB4NTU2ZTk5Yzg8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
cGx1Z2lucy9ibHVlejUuYzpidF9yZWdpc3Rlcl9wcm9maWxlKCkgQmx1ZXRvb3RoOiBSZWdpc3Rl
cmluZyAwMDAwMTExZi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIgKGhmcF9hZykgcHJvZmls
ZTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5DVk9JQ0U9P1xyPC9kaXY+
PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbl5DVk9JQ0U6ICgwKVxyXG5cclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1NDUz0/XHI8L2Rpdj48
ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NTQ1M6ICgmcXVvdDtJUkEmcXVvdDss
JnF1b3Q7VUNTMiZxdW90OywmcXVvdDtHU00mcXVvdDspXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRp
dj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVReU1lTQ0ZHPT9ccjwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5eU1lTQ0ZHOiAoMiwxMywxNCwxNiksKDAtMyksKCgyMDAw
MDAwNDAwMzgwLCZxdW90O0dTTTkwMC9HU00xODAwL1dDRE1BOTAwL1dDRE1BMjEwMCZxdW90Oyks
KDI4MDAwMCwmcXVvdDtHU004NTAvR1NNMTkwMCZxdW90OyksKDNmZmZmZmZmLCZxdW90O0FsbCBi
YW5kcyZxdW90OykpLCgwLTIpLCgwLTQpXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2Rb
MTU2MF06IFBDVUk6ICZndDsgQVQrQ1NNUz0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENV
STogJmx0OyBcclxuK0NTTVM6ICgwLDEpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsx
NTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmF0X2NzbXNfcXVlcnlfY2Io
KSBDU01TIHF1ZXJ5IHBhcnNlZCBzdWNjZXNzZnVsbHk8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06
IFBDVUk6ICZndDsgQVQrQ0dEQ09OVD0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUmVnaXN0
ZXJQcm9maWxlKCkgcmVwbGllZCBhbiBlcnJvcjogb3JnLmZyZWVkZXNrdG9wLkRCdXMuRXJyb3Iu
U3Bhd24uQ2hpbGRFeGl0ZWQsIExhdW5jaCBoZWxwZXIgZXhpdGVkIHdpdGggdW5rbm93biByZXR1
cm4gY29kZSAxPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDR0RDT05U
OiAoMS0xMSksJnF1b3Q7SVAmcXVvdDssLCwoMC0yKSwoMC0zKSwoMCwxKSwoMCwxKVxyXG4rQ0dE
Q09OVDogKDEtMTEpLCZxdW90O1BQUCZxdW90OywsLCgwLTIpLCgwLTMpLCgwLDEpLCgwLDEpXHJc
blxyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTkyLDI4NDgwLDAsMCwyNTVccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7
IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAyMjA2ODMwMjZGNDBBNTAzODAw
MTcxOEEwMTA1OEIwMzZGMDYwNTgwMDIwMENDODgwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+
PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX2luZm9fY2IoKSBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzI8L2Rpdj4KPGRpdj5vZm9ub2Rb
MTU2MF06IFBDVUk6ICZndDsgQVQrQ1BCUz0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENV
STogJmx0OyBcclxuK0NQQlM6ICgmcXVvdDtTTSZxdW90OywmcXVvdDtFTiZxdW90OywmcXVvdDtP
TiZxdW90OywmcXVvdDtGRCZxdW90OylcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NTTVM9MVxyPC9kaXY+PGRpdj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1NNUzogMSwxLDFcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NHUkVHPT9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ0dSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsx
NTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCwxLDQsMzRccjwvZGl2Pgo8ZGl2Pm9m
b25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzRENzkyMDRFNzU2
RDYyNjU3MkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYwNzkxNTM4MzEzOTc3ODQ4RkZGRkZGRkZGRkZG
JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAs
IDAwLCAzNDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDU01TP1xyPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDU01TOiAxLDEsMSwxXHJcblxy
XG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDR1JFRz0yXHI8
L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ0dBVVRPPTBccjwvZGl2Pgo8ZGl2Pm9mb25vZFsx
NTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6
ICZndDsgQVQrQ0dFUkVQPTIsMVxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsg
XHJcbkVSUk9SXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5z
L2JsdWV6NS5jOmJ0X3JlZ2lzdGVyX3Byb2ZpbGUoKSBCbHVldG9vdGg6IFJlZ2lzdGVyaW5nIDAw
MDAxMTAzLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiAoZHVuX2d3KSBwcm9maWxlPC9kaXY+
CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgwLDIsNCwzNFxy
PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVv
dDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsg
QVQrQ01HRj0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NNR0Y6
ICgwLDEpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBB
VCtDUlNNPTE3OCwyODQ4MCwzLDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBSZWdpc3Rl
clByb2ZpbGUoKSByZXBsaWVkIGFuIGVycm9yOiBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5T
cGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhlbHBlciBleGl0ZWQgd2l0aCB1bmtub3duIHJldHVy
biBjb2RlIDE8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAx
NDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRf
Y2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBD
VUk6ICZndDsgQVQrQ1BNUz0/XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBc
clxuK0NQTVM6ICgmcXVvdDtTTSZxdW90OywmcXVvdDtNRSZxdW90OyksKCZxdW90O1NNJnF1b3Q7
LCZxdW90O01FJnF1b3Q7KSwoJnF1b3Q7U00mcXVvdDssJnF1b3Q7TUUmcXVvdDspXHJcblxyXG5P
S1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4
MCw0LDQsMzRccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006
IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVh
ZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTog
UENVSTogJmd0OyBBVCtDTUdGPTBccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7
IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3
OCwyODQ4MCw1LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8
ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Ny
c21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NQTVM9JnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDssJnF1
b3Q7TUUmcXVvdDtccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BN
UzogMCwyMCwwLDIwLDAsMjBcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTog
UENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCw2LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0
PC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NOTUk9P1xyPC9kaXY+PGRp
dj5vZm9ub2RbMTU2MF06IER1cGxpY2F0ZSBFRnNkbiBlbnRyaWVzIGZvciBgRW1lcmdlbmN5IFNl
cnZpY2VzJiMzOTs8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NOTUk6
ICgwLTIpLCgwLTMpLCgwLDIpLCgwLTIpLCgwLDEpXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmJ1aWxkX2NubWlf
c3RyaW5nKCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NOTUk9MSwx
LDIsMSwwXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpzbXNfcmVzdG9yZV90
eF9xdWV1ZSgpoDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3B1
c2gtbm90aWZpY2F0aW9uLmM6c21zX3dhdGNoKCkgcmVnaXN0ZXJlZDwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzpzbXNfd2F0Y2go
KSByZWdpc3RlcmVkPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ01HTD00
XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zbXMuYzphdF9jbWds
X2RvbmUoKaA8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ0dTTVM9M1xy
PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHko
KSBtb2RlbSAweDU1NmQ0MmEwIHByb3BlcnR5IEFsd2F5c09ubGluZTwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9zZXRfb25saW5lKCkg
bW9kZW0gMHg1NTZkNDJhMCBvbmxpbmU8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZn
dDsgQVQrQ0ZVTj0xXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuXlNJ
TVNUOjAsMFxyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9o
dWF3ZWkuYzpzaW1zdF9ub3RpZnkoKSAxIC0mZ3Q7IDA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTog
UENVSTogJmx0OyBcclxuT0tcclxuXHJcbl5TSU1TVDoxLDBcclxuPC9kaXY+CjxkaXY+b2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOnNpbXN0X25vdGlmeSgpIDAgLSZn
dDsgMTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0lORk9ccjwvZGl2
PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JFRzogMlxyXG5cclxuK0NHUkVH
OiAyXHJcblxyXG5eU1lTSU5GTzowLDMsMCwwLDEsMCwwXHJcblxyXG5PS1xyXG48L2Rpdj4KPGRp
dj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19zdGF0dXNf
bm90aWZ5KCkgL2h1YXdlaV8wIHN0YXR1cyAyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9u
by0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c3lzaW5mb19vbmxpbmVfY2IoKSAxIC0mZ3Q7IDE8L2Rp
dj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdl
X3N0YXRlKCkgb2xkIHN0YXRlOiAyLCBuZXcgc3RhdGU6IDM8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2
MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3Bvc3Rfb25saW5lKCkgMHg1
NTZkNDJhMDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSRUc9P1xyPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAoMC0yKVxyXG5cclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1NDQj0/XHI8L2Rp
dj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDU0NCOigwLDEpXHJcblxyXG5P
S1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDVVNEPTFccjwvZGl2
PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxOCwwLDAsMjU1XHI8L2Rpdj4KPGRp
dj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2MjFFODIw
NTQyMjEwMDA2MDU4MzAyNkZDQUE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA1ODAwMjAwMUU4ODAw
JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAs
IDAwLCAzMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUkVHPTJccjwv
ZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3BuX3dhdGNo
KCkgMHg1NTZlOTljODwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0
d29yay5jOl9fb2Zvbm9fbmV0cmVnX2FkZF9zdGF0dXNfd2F0Y2goKSAweDU1NmVmYmU4PC9kaXY+
CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOl9fb2Zvbm9fbmV0
cmVnX2FkZF9zdGF0dXNfd2F0Y2goKSAweDU1NmVmYmU4PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IFBDVUk6ICZndDsgQVQrQ1NDQj0wXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0
OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9jYnMu
YzpjYnNfZ290X2ltc2koKSBHb3QgSU1TSTogMjcyMDUwMTAwNDEzNTgwPC9kaXY+CjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOl9fb2Zvbm9fbmV0cmVnX2FkZF9z
dGF0dXNfd2F0Y2goKSAweDU1NmVmYmU4PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZn
dDsgQVQrQ1JTTT0xNzgsMjg2MTgsMSw0LDZccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5P
S1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2Rl
bS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNjwvZGl2Pjxk
aXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSRUc/XHI8L2Rpdj48ZGl2Pm9mb25vZFsx
NTYwXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDIsMlxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1
c19ub3RpZnkoKSAvaHVhd2VpXzAgc3RhdHVzIDIgdGVjaCAtMTwvZGl2Pgo8ZGl2Pm9mb25vZFsx
NTYwXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpjdXJyZW50X29wZXJhdG9yX2NhbGxiYWNr
KCkgMHg1NTZlZmJlOCwgKG5pbCk8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
c3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMiwgLTEsIC0xLCAtMSwgKG51bGwpKG51
bGwpPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6bmV0cmVn
X3N0YXR1c19jaGFuZ2VkKCkgMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBB
VCtDUlNNPTE3OCwyODYxOCwyLDQsNlxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJc
bjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8L2Rpdj4KPGRpdj5v
Zm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMyw0LDZccjwvZGl2Pjxk
aXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAw
MDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9j
YjogOTAsIDAwLCA2PC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTc4LDI4NjE4LDQsNCw2XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxu
K0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+
PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNjwvZGl2Pgo8ZGl2Pm9mb25vZFsx
NTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOCw1LDQsNlxyPC9kaXY+PGRpdj5vZm9u
b2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMDAwMDAm
cXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9k
cml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwg
MDAsIDY8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2
MTcsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNN
OiAxNDQsMCwmcXVvdDs2MjFFODIwNTQyMjEwMDA1MDU4MzAyNkZDOUE1MDM4MDAxNzE4QTAxMDU4
QjAzNkYwNjAyODAwMjAwMTk4ODAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19j
YigpIGNyc21faW5mb19jYjogOTAsIDAwLCAzMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENV
STogJmd0OyBBVCtDUlNNPTE3OCwyODYxNywxLDQsNVxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxy
XG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCA1PC9kaXY+
CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDIsNCw1XHI8
L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90
OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQr
Q1JTTT0xNzgsMjg2MTcsMyw0LDVccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7
IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNTwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNyw0LDQsNVxyPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAw
JnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAs
IDAwLCA1PC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4
NjE3LDUsNCw1XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006
IDE0NCwwLCZxdW90OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg0MzMsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2
MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tc
clxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tZXNzYWdlLXdhaXRp
bmcuYzptd19jcGhzX213aXNfcmVhZF9jYigpIE5vIENQSFMgTVdJUyBvbiBTSU08L2Rpdj4KPGRp
dj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTksMCwwLDI1NVxyPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2
MjFFODIwNTQyMjEwMDEwMDU4MzAyNkZDQkE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA1ODAwMjAw
NTA4ODAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19j
YjogOTAsIDAwLCAzMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNN
PTE3OCwyODYxOSwxLDQsMTZccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxy
XG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVv
dDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAs
IDE2PC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5
LDIsNCwxNlxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAx
NDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxu
T0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2Rl
bS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4K
PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMyw0LDE2XHI8
L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90
O0ZGMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rp
dj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjwvZGl2Pgo8ZGl2Pm9mb25v
ZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOSw0LDQsMTZccjwvZGl2PjxkaXY+
b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkYwMEZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE2PC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQ
Q1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDUsNCwxNlxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2
MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMTY8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLCBzZWVrb2ZmOiAz
OSwgdG9yZWFkOiAxNzwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2lt
ZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9jaygpIGJ1Zm9mZjogMCwgc2Vla29mZjogMzksIHRvcmVh
ZDogMTA8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L2Nicy5jOmF0X2Nic19zZXRfdG9waWNzKCmgPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmZ3Q7IEFUK0NTQ0I9MFxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJc
bk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9MCwmcXVv
dDswLDUwLDIxNCw0MzUyLTQzNTYmcXVvdDtccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmbHQ7IFxyXG5PS1xyXG48L2Rpdj48ZGl2PgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQr
Q1JTTT0xOTIsMjg0MzcsMCwwLDI1NVxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+PGRp
dj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTUsMCwwLDI1NVxyPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2
MjFFODIwNTQyMjEwMDIyMDU4MzAyNkZDN0E1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjAyODAwMjAw
QUE4ODAwJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKSBjcnNtX2luZm9f
Y2I6IDkwLCAwMCwgMzI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNN
PTE3OCwyODYxNSwxLDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxy
XG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NEQ2MTY5NkNGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRjA3OTE1MzgzMzMzMzEzMTdGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDIsNCwzNFxyPC9kaXY+PGRpdj5v
Zm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDtGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5
MCwgMDAsIDM0PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgs
Mjg2MTUsMyw0LDM0XHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NS
U006IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48L2Rpdj4KPGRp
dj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNt
X3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8L2Rpdj48ZGl2Pm9mb25vZFsxNTYw
XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSw0LDQsMzRccjwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVv
dDtcclxuXHJcbk9LXHJcbjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAw
LCAzNDwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1
LDUsNCwzNFxyPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAx
NDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPC9kaXY+CjxkaXY+b2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBD
VUk6ICZsdDsgXHJcbl5NT0RFOiA1LDRcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6
ICZsdDsgXHJcbl5SU1NJOiAxM1xyXG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDssNDEsMzUs
NTNcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JFRzogMSwm
cXVvdDswMDQwJnF1b3Q7LCZxdW90OzAyQzEwMTc4JnF1b3Q7XHJcbjwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5eU1JWU1Q6IDJcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2
MF06IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnko
KSAvaHVhd2VpXzAgc3RhdHVzIDEgdGVjaCAyPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAxLCAtMSwgLTEsIDIsIChu
dWxsKShudWxsKTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5j
Om5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDE8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTog
Jmd0OyBBVCtDT1BTPTMsMlxyPC9kaXY+PGRpdj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxy
XG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDT1BTP1xyPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDT1BTOiAwLDIsJnF1b3Q7Mjcy
MDUmcXVvdDssMlxyXG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0x
LjE0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNvcHNfbnVtZXJpY19j
YigpIENvcHMgbnVtZXJpYyBnb3QgbWNjOiAyNzIsIG1uYzogMDU8L2Rpdj4KPGRpdj5vZm9ub2Rb
MTU2MF06IFBDVUk6ICZndDsgQVQrQ1NRXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogUENVSTog
Jmx0OyBcclxuK0NTUTogMTMsOTlcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjc3Ff
Y2IoKSBjc3FfY2I6IDEzPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9u
ZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDQxPC9kaXY+
CjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NHQVRUPTFccjwvZGl2PjxkaXY+b2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG5cclxuK0NHUkVHOiAxLCZxdW90OzAwNDAm
cXVvdDssJnF1b3Q7MDJDMTAxNzgmcXVvdDtcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9v
Zm9uby0xLjE0L3NyYy9ncHJzLmM6Z3Byc19hdHRhY2hfY2FsbGJhY2soKSAvaHVhd2VpXzAgZXJy
b3IgPSAwPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9m
b25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9odWF3ZWlfMCBzdGF0dXMgMTwvZGl2PjxkaXY+b2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM9MywwXHI8L2Rpdj48ZGl2Pm9mb25vZFsxNTYw
XTogUENVSTogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZn
dDsgQVQrQ09QUz9ccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NP
UFM6IDAsMCwmcXVvdDszIElSTCZxdW90OywyXHJcblxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9u
LmM6Y29wc19jYigpIGNvcHNfY2I6IDMgSVJMLCAyNzIgMDUgMjwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2so
KSAweDU1NmVmYmU4LCAobmlsKTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
c3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMSwgLTEsIC0xLCAyLCAyNzIwNTwvZGl2
PjxkaXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2No
YW5nZWQoKSAxLCAwLCAwPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9n
cHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTYwXTog
UENVSTogJmd0OyBBVCtDR1JFRz9ccjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7
IFxyXG4rQ0dSRUc6IDIsMSwmcXVvdDswMDQwJnF1b3Q7LCZxdW90OzAyQzEwMTc4JnF1b3Q7XHJc
blxyXG5PS1xyXG48L2Rpdj48ZGl2Pm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMu
YzpyZWdpc3RyYXRpb25fc3RhdHVzX2NiKCkgL2h1YXdlaV8wIGVycm9yIDAgc3RhdHVzIDE8L2Rp
dj4KPGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19z
dGF0dXNfbm90aWZ5KCkgL2h1YXdlaV8wIHN0YXR1cyAxPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06
IFBDVUk6ICZsdDsgXHJcbl5SU1NJOiAxMVxyXG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDss
MzgsMzAsNDlcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9uZXR3
b3JrLmM6b2Zvbm9fbmV0cmVnX3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDM1PC9kaXY+Cjxk
aXY+b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0
LmM6YXRfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5KCkgY2lkIDE8L2Rpdj48ZGl2Pm9mb25vZFsxNTYw
XTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSAweDU1NmVi
Nzg4PC9kaXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6cHJpX2Fj
dGl2YXRlX2NhbGxiYWNrKCkgQWN0aXZhdGluZyBjb250ZXh0IGZhaWxlZCB3aXRoIGVycm9yOiBV
bmtub3duIGVycm9yIHR5cGU8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJc
bl5SU1NJOiAxM1xyXG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDssNDIsMzUsNTFcclxuPC9k
aXY+PGRpdj5vZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0
cmVnX3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDQxPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9k
aXY+PGRpdj48YnI+PC9kaXY+CjxkaXY+SWYgSSBub3cgcmVzdGFydCBvZm9ubyB0aGVuIGFjdGl2
YXRpbmcgdGhlIHNhbWUgY29udGV4dCB3aWxsIHdvcmsgZmluZS48L2Rpdj48ZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2V4dHJhIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+SG9tYW08L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9leHRyYSI+PGJyPgo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5P
biAxMCBNYXJjaCAyMDE0IDE4OjE2LCAgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWls
dG86b2Zvbm8tcmVxdWVzdEBvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9uby1yZXF1ZXN0
QG9mb25vLm9yZzwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13
aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1z
dHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5TZW5kIG9mb25vIG1haWxpbmcgbGlzdCBzdWJt
aXNzaW9ucyB0bzxicj4KoCCgIKAgoCA8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5v
Zm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YnI+ClRvIHN1YnNjcmliZSBvciB1bnN1YnNjcmliZSB2
aWEgdGhlIFdvcmxkIFdpZGUgV2ViLCB2aXNpdDxicj4KoCCgIKAgoCA8YSBocmVmPSJodHRwczov
L2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+
aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48YnI+Cm9y
LCB2aWEgZW1haWwsIHNlbmQgYSBtZXNzYWdlIHdpdGggc3ViamVjdCBvciBib2R5ICYjMzk7aGVs
cCYjMzk7IHRvPGJyPgqgIKAgoCCgIDxhIGhyZWY9Im1haWx0bzpvZm9uby1yZXF1ZXN0QG9mb25v
Lm9yZyI+b2Zvbm8tcmVxdWVzdEBvZm9uby5vcmc8L2E+PGJyPgo8YnI+CllvdSBjYW4gcmVhY2gg
dGhlIHBlcnNvbiBtYW5hZ2luZyB0aGUgbGlzdCBhdDxicj4KoCCgIKAgoCA8YSBocmVmPSJtYWls
dG86b2Zvbm8tb3duZXJAb2Zvbm8ub3JnIj5vZm9uby1vd25lckBvZm9uby5vcmc8L2E+PGJyPgo8
YnI+CldoZW4gcmVwbHlpbmcsIHBsZWFzZSBlZGl0IHlvdXIgU3ViamVjdCBsaW5lIHNvIGl0IGlz
IG1vcmUgc3BlY2lmaWM8YnI+CnRoYW4gJnF1b3Q7UmU6IENvbnRlbnRzIG9mIG9mb25vIGRpZ2Vz
dC4uLiZxdW90Ozxicj4KPGJyPgo8YnI+ClRvZGF5JiMzOTtzIFRvcGljczo8YnI+Cjxicj4KoCCg
MS4gUHJvYmxlbSByZWNvbm5lY3Rpbmcgd2hlbiAzRyBkb25nbGUgaXMgcmUtaW5zZXJ0ZWQgKEhv
bWFtIERhYmlzKTxicj4KPGJyPgo8YnI+Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Cjxicj4KTWVzc2FnZTog
MTxicj4KRGF0ZTogTW9uLCAxMCBNYXIgMjAxNCAxODoxNzowNCArMDAwMDxicj4KRnJvbTogSG9t
YW0gRGFiaXMgJmx0OzxhIGhyZWY9Im1haWx0bzpoZGFiaXNAZGlnaXNvZnQudHYiPmhkYWJpc0Bk
aWdpc29mdC50djwvYT4mZ3Q7PGJyPgpUbzogPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9y
ZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KU3ViamVjdDogUHJvYmxlbSByZWNvbm5lY3Rpbmcg
d2hlbiAzRyBkb25nbGUgaXMgcmUtaW5zZXJ0ZWQ8YnI+Ck1lc3NhZ2UtSUQ6PGJyPgqgIKAgoCCg
ICZsdDtDQUsrc2ZvdEJ0eXNLMXlDVHQ2NG0zZ3VGd2Z6V2JfPTxhIGhyZWY9Im1haWx0bzo0c3pq
MFUyYjVXc3dndDFtMUNnQG1haWwuZ21haWwuY29tIj40c3pqMFUyYjVXc3dndDFtMUNnQG1haWwu
Z21haWwuY29tPC9hPiZndDs8YnI+CkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD0m
cXVvdDtpc28tODg1OS0xJnF1b3Q7PGJyPgo8YnI+CkhpLDxicj4KPGJyPgpJIGhhdmUgdGhlIGZv
bGxvd2luZzogSHVhd2VpIEUzMDMgM0cgVVNCIGRvbmdsZSwgY29ubm1hbiAxLjIwIGFuZCBvZm9u
bzxicj4KMS4xNC48YnI+Cjxicj4KSSBjYW4gY29ubmVjdCB0byBhIHBhcnRpY3VsYXIgQVBOIHVz
aW5nIGNvbm5tYW4gYW5kIG9mb25vLjxicj4KPGJyPgpIb3dldmVyLCBpZiBJIHJlbW92ZSBhbmQg
cmUgaW5zZXJ0IHRoZSBkb25nbGUgSSBhbSB1bmFibGUgdG8gcmVjb25uZWN0IHRvPGJyPgp0aGUg
c2VydmljZS4gSWYgSSByZXN0YXJ0IGVpdGhlciBjb25ubWFuIG9yIG9mb25vIHRoZW4gcmVjb25u
ZWN0aW9uIHRvPGJyPgpzZXJ2aWNlIGlzIG9rLjxicj4KPGJyPgpDb25ubWFuIGhhcyB0aGUgZm9s
bG93aW5nIGNvbmZpZzo8YnI+Cjxicj4KW0dlbmVyYWxdPGJyPgpCYWNrZ3JvdW5kU2Nhbm5pbmc9
ZmFsc2U8YnI+CkRlZmF1bHRBdXRvQ29ubmVjdFRlY2hub2xvZ2llcz1jZWxsdWxhcjxicj4KUHJl
ZmVycmVkVGVjaG5vbG9naWVzPWNlbGx1bGFyLHdpZmk8YnI+ClNpbmdsZUNvbm5lY3RlZFRlY2hu
b2xvZ3k9ZmFsc2U8YnI+ClRldGhlcmluZ1RlY2hub2xvZ2llcz13aWZpPGJyPgpQZXJzaXN0ZW50
VGV0aGVyaW5nTW9kZT10cnVlPGJyPgo8YnI+Cjxicj4KSW4gb2Zvbm8gdGhlIGxvZyBmb3IgY29u
bmVjdC9yZW1vdmUgYW5kIHJlY29ubmVjdCBpczo8YnI+Cjxicj4Kcm9vdEBpMTAwOn4jIE9GT05P
X0FUX0RFQlVHPTEgb2Zvbm9kIC1uIC1kIKAmZ3Q7IC9vZm9uby5sb2c8YnI+Cm9mb25vZFszMDk0
M106IG9Gb25vIHZlcnNpb24gMS4xNDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3Jj
L3BsdWdpbi5jOl9fb2Zvbm9fcGx1Z2luX2luaXQoKTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9v
Zm9uby0xLjE0L3BsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzpwdXNoX25vdGlmaWNhdGlvbl9p
bml0KCk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvc21hcnQtbWVzc2Fn
aW5nLmM6c21hcnRfbWVzc2FnaW5nX2luaXQoKTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9u
by0xLjE0L3NyYy9jZG1hLXByb3Zpc2lvbi5jOm9mb25vX2NkbWFfcHJvdmlzaW9uX2RyaXZlcl9y
ZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzFiYjAgbmFtZTogQ0RNQSBwcm92aXNpb25pbmc8
YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4xNC9zcmMvZ3Bycy1wcm92aXNpb24uYzpv
Zm9ub19ncHJzX3Byb3Zpc2lvbl9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMx
YjgwIG5hbWU6IFByb3Zpc2lvbmluZzxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy9kdW5fZ3dfYmx1ZXo1LmM6ZHVuX2d3X2luaXQoKTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+
Ci9vZm9uby0xLjE0L3NyYy9oYW5kc2ZyZWUtYXVkaW8uYzpvZm9ub19oYW5kc2ZyZWVfY2FyZF9k
cml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxYTUwPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxi
cj4KZHJpdmVyOiAweDU1NmMxYTYwLCBuYW1lOiBoZnA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvaGU5MTAuYzpoZTkxMF9pbml0KCk8YnI+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpk
cml2ZXI6IDB4NTU2YzE5ZTAsIG5hbWU6IGhlOTEwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9wbHVnaW5zL2Nvbm5tYW4uYzpjb25ubWFuX2luaXQoKTxicj4Kb2Zvbm9kWzMwOTQzXTo8
YnI+Ci9vZm9uby0xLjE0L3NyYy9wcml2YXRlLW5ldHdvcmsuYzpvZm9ub19wcml2YXRlX25ldHdv
cmtfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMTliMCwgbmFtZTogQ29ubk1h
biBQcml2YXRlIE5ldHdvcms8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzE5NjAs
IG5hbWU6IHNpbTkwMDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMTkxMCwgbmFt
ZTogc2Ftc3VuZzxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zv
bm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMThjMCwgbmFtZTog
c3BlZWR1cGNkbWE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzE4NzAsIG5hbWU6
IHNwZWVkdXA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25v
X21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzE4MjAsIG5hbWU6IGFs
Y2F0ZWw8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzE3YzAsIG5hbWU6IGljZXJh
PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9k
cml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxNzcwLCBuYW1lOiBsaW5rdG9wPGJy
PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxNzIwLCBuYW1lOiBub2tpYWNkbWE8YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzE2ZDAsIG5hbWU6IG5va2lhPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVn
aXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxNjgwLCBuYW1lOiB0YzY1PGJyPgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KTxicj4KZHJpdmVyOiAweDU1NmMxNWYwLCBuYW1lOiBzdGU8YnI+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpk
cml2ZXI6IDB4NTU2YzE1OTAsIG5hbWU6IGlmeDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjog
MHg1NTZjMTU0MCwgbmFtZTogcGFsbXByZTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1
NTZjMTRmMCwgbmFtZTogbm92YXRlbDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3Jj
L21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZj
MTRhMCwgbmFtZTogc2llcnJhPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxNDIw
LCBuYW1lOiBodWF3ZWk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzEzZDAsIG5h
bWU6IHp0ZTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMTM3MCwgbmFtZTogaHNv
PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9k
cml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxMzIwLCBuYW1lOiBtYm08YnI+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9y
ZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzEyZDAsIG5hbWU6IGNhbHlwc288YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzEyODAsIG5hbWU6IHdhdmVjb208YnI+Cm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rl
cigpPGJyPgpkcml2ZXI6IDB4NTU2YzEyMzAsIG5hbWU6IGcxPGJyPgpvZm9ub2RbMzA5NDNdOjxi
cj4KL29mb25vLTEuMTQvc3JjL2NkbWEtdm9pY2VjYWxsLmM6b2Zvbm9fY2RtYV92b2ljZWNhbGxf
ZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMTFhMCwgbmFtZTogY2RtYW1vZGVt
PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19kZXZpbmZv
X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzExYzAsIG5hbWU6IGNkbWFtb2Rl
bTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9jZG1hLWNvbm5tYW4uYzpv
Zm9ub19jZG1hX2Nvbm5tYW5fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMTFm
MCwgbmFtZTogY2RtYW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxMTFj
LCBuYW1lOiBwaG9uZXNpbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVt
LmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMTE1NCwg
bmFtZTogbG9jYWxoZnA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6
b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzEx
MDQsIG5hbWU6IHBob25lc2ltPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY3Rt
LmM6b2Zvbm9fY3RtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzEwZjAsIG5h
bWU6IHBob25lc2ltPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3Bob25l
c2ltLmM6cGFyc2VfY29uZmlnKCkgZmlsZW5hbWU8YnI+Ci9ldGMvb2Zvbm8vcGhvbmVzaW0uY29u
Zjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzEwYjAsIG5hbWU6IHNwZWVkdXBtb2Rl
bTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9u
b192b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMGY1MCwgbmFt
ZTogaGZwbW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9m
b25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMTAxMCwgbmFt
ZTogaGZwbW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6
b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBmYTAsIG5h
bWU6IGhmcG1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQvc3JjL2NhbGwt
dm9sdW1lLmM6b2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4K
MHg1NTZjMGZlMCwgbmFtZTogaGZwbW9kZW08YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8t
MS4xNC9zcmMvaGFuZHNmcmVlLmM6b2Zvbm9faGFuZHNmcmVlX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjo8YnI+CjB4NTU2YzEwMzAsIG5hbWU6IGhmcG1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvc2lyaS5jOm9mb25vX3NpcmlfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
Ojxicj4KMHg1NTZjMTA2MCwgbmFtZTogaGZwbW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpk
cml2ZXI6IDB4NTU2YzBlYzAsIG5hbWU6IGR1bm1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxi
cj4KMHg1NTZjMGVmMCwgbmFtZTogZHVubW9kZW08YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zv
bm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjo8YnI+CjB4NTU2YzBkZjAsIG5hbWU6IHN0ZW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0
ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwZTcwLCBuYW1lOiBzdGVtb2RlbTxicj4Kb2Zvbm9kWzMw
OTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3Nl
dHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBlNDAsIG5hbWU6IHN0
ZW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5j
Om9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwY2Iw
LCBuYW1lOiBpZnhtb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9h
dWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJy
Pgpkcml2ZXI6IDB4NTU2YzBkMDAsIG5hbWU6IGlmeG1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOjxi
cj4KL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3Nf
ZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMGQyMCwgbmFtZTogaWZ4bW9kZW08
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250
ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBkNTAsIG5hbWU6IGlmeG1v
ZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6b2Zvbm9fc3RrX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzBkODAsIG5hbWU6IGlmeG1vZGVtPGJy
PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY3RtLmM6b2Zvbm9fY3RtX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzBkYjAsIG5hbWU6IGlmeG1vZGVtPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2
ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwYzQwLCBuYW1lOiBoc29tb2RlbTxicj4K
b2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25v
X3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBjNjAs
IG5hbWU6IGhzb21vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5j
Om9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMw
YmIwLCBuYW1lOiBtYm1tb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3N0
ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwYmUwLCBu
YW1lOiBtYm1tb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9sb2Nh
dGlvbi1yZXBvcnRpbmcuYzpvZm9ub19sb2NhdGlvbl9yZXBvcnRpbmdfZHJpdmVyX3JlZ2lzdGVy
KCk8YnI+CmRyaXZlcjogMHg1NTZjMGMwMCwgbmFtZTogbWJtbW9kZW08YnI+Cm9mb25vZFszMDk0
M106PGJyPgovb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzBiMjAsIG5hbWU6IGNhbHlwc29tb2RlbTxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwYjcwLCBuYW1lOiBjYWx5cHNvbW9kZW08YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwYTAwLCBuYW1lOiBodWF3ZWltb2RlbTxicj4K
b2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2lj
ZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMGEyMCwgbmFtZTogaHVh
d2VpbW9kZW08YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4xNC9zcmMvYXVkaW8tc2V0
dGluZ3MuYzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVy
OiAweDU1NmMwYTcwLCBuYW1lOiBodWF3ZWltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9v
Zm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZl
cl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBhYjAsIG5hbWU6IGh1YXdlaW1vZGVtPGJy
PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4
dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwYTkwLCBuYW1lOiBodWF3ZWlt
b2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9jZG1hLW5ldHJlZy5j
Om9mb25vX2NkbWFfbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzBh
ZTAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
Z3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAw
eDU1NmMwOTcwLCBuYW1lOiBpY2VyYW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25v
LTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3Jl
Z2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMDlhMCwgbmFtZTogaWNlcmFtb2RlbTxicj4Kb2Zv
bm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3Jh
ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzA5MjAsIG5h
bWU6IHp0ZW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9m
b25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwOGUw
LCBuYW1lOiBzd21vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQvc3JjL3Jh
ZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+
CmRyaXZlcjogMHg1NTZjMDg5MCwgbmFtZTogbndtb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+
Ci9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMDZiMCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0
ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwNzYwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMzA5
NDNdOjxicj4KL29mb25vLTEuMTQvc3JjL2NhbGwtYmFycmluZy5jOm9mb25vX2NhbGxfYmFycmlu
Z19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwNzEwLCBuYW1lOiBhdG1vZGVt
PGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQvc3JjL2NhbGwtZm9yd2FyZGluZy5j
Om9mb25vX2NhbGxfZm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1
NmMwNDgwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQv
c3JjL2NhbGwtbWV0ZXIuYzpvZm9ub19jYWxsX21ldGVyX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4NTU2YzA0YjAsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFszMDk0M106PGJyPgov
b2Zvbm8tMS4xNC9zcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0dGluZ3NfZHJpdmVy
X3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMDM5MCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zv
bm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9waG9uZWJvb2suYzpvZm9ub19waG9uZWJv
b2tfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMDczMCwgbmFtZTogYXRtb2Rl
bTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzA2ODAsIG5hbWU6IGF0bW9kZW08YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMDQwMCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6PGJyPgoweDU1NmMwNTYwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4NTU2YzA1YTgsIG5hbWU6IGF0bW9kZW0tbm9lZjxicj4Kb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
PGJyPgoweDU1NmMwNjYwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJp
dmVyOiAweDU1NmMwNTAwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvY2JzLmM6b2Zvbm9fY2JzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4
NTU2YzA0NjAsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4x
NC9zcmMvY2FsbC12b2x1bWUuYzpvZm9ub19jYWxsX3ZvbHVtZV9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6PGJyPgoweDU1NmMwNzkwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
Ojxicj4KMHg1NTZjMDdkMCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+
CmRyaXZlcjogMHg1NTZjMDgwMCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL3NpbS1hdXRoLmM6b2Zvbm9fc2ltX2F1dGhfZHJpdmVyX3JlZ2lzdGVyKCk8
YnI+CmRyaXZlcjogMHg1NTZjMDgyMCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL2duc3MuYzpvZm9ub19nbnNzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4NTU2YzA4NDAsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2
ZXI6IDB4NTU2YzAxYjAsIG5hbWU6IGdvYmk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjog
MHg1NTZiZmY4MCwgbmFtZTogcW1pbW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6
IDB4NTU2YmZmZjAsIG5hbWU6IHFtaW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25v
LTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6PGJyPgoweDU1NmJmZmEwLCBuYW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
PGJyPgoweDU1NmMwMDIwLCBuYW1lOiBxbWltb2RlbS1sZWdhY3k8YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
Ojxicj4KMHg1NTZjMDA3MCwgbmFtZTogcW1pbW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4K
MHg1NTZjMDBjMCwgbmFtZTogcW1pbW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1
NmMwMGUwLCBuYW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3Jj
L2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzAx
MDAsIG5hbWU6IHFtaW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3By
cy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1
NmMwMTIwLCBuYW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0
L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3Rl
cigpPGJyPgpkcml2ZXI6IDB4NTU2YzAxNDAsIG5hbWU6IHFtaW1vZGVtPGJyPgpvZm9ub2RbMzA5
NDNdOjxicj4KL29mb25vLTEuMTQvc3JjL2xvY2F0aW9uLXJlcG9ydGluZy5jOm9mb25vX2xvY2F0
aW9uX3JlcG9ydGluZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwMTcwLCBu
YW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZiZmYyYywgbmFt
ZTogdTg1MDA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25v
X2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZiZmYxMCwgbmFtZTog
dTg1MDA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YmZlYzAsIG5hbWU6IG45MDA8
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2Ry
aXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YmZlNzAsIG5hbWU6IGlzaXVzYjxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2
ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmJmYjkwLCBuYW1lOiBpc2ltb2RlbTxicj4K
b2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9waG9uZWJvb2suYzpvZm9ub19waG9u
ZWJvb2tfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZiZmI4MCwgbmFtZTogaXNp
bW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9f
bmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YmZiYjAsIG5hbWU6IGlz
aW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5j
Om9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmJmYmUw
LCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Ntcy5j
Om9mb25vX3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmJmYzMwLCBuYW1l
OiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOm9mb25v
X2Nic19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmJmYzUwLCBuYW1lOiBpc2lt
b2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmJmYzcwLCBuYW1lOiBpc2ltb2RlbTxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YmZjYzAsIG5hbWU6IGlzaW1vZGVtPGJyPgpv
Zm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQvc3JjL2NhbGwtZm9yd2FyZGluZy5jOm9mb25v
X2NhbGxfZm9yd2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmJmY2Uw
LCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9j
YWxsLXNldHRpbmdzLmM6b2Zvbm9fY2FsbF9zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxicj4K
ZHJpdmVyOiAweDU1NmJmZDAwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+
Ci9vZm9uby0xLjE0L3NyYy9jYWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZiZmQzMCwgbmFtZTogaXNpbW9kZW08YnI+Cm9m
b25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4xNC9zcmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxf
bWV0ZXJfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZiZmQ1MCwgbmFtZTogaXNp
bW9kZW08YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGlu
Z3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAw
eDU1NmJmZDgwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2
YmZkYjAsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
Z3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAw
eDU1NmJmZGQwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0x
LjE0L3NyYy9hdWRpby1zZXR0aW5ncy5jOm9mb25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdp
c3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YmZkZjAsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjo8YnI+CjB4NTU2YmZlMDAsIG5hbWU6IHdnbW9kZW0yLjU8YnI+Cm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6dWRldl9zdGFydCgpPGJyPgpvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmVudW1lcmF0ZV9kZXZpY2VzKCk8
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNi
X2RldmljZSgpIGh1Yjxicj4KWyhudWxsKToobnVsbCldPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2I8YnI+ClswYmRh
OjgxNzZdPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNo
ZWNrX3VzYl9kZXZpY2UoKSBydGw4MTkyY3U8YnI+ClsobnVsbCk6KG51bGwpXTxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkg
cnRsODE5MmN1PGJyPgpbMGJkYTo4MTc2XTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
cGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcnRsODE5MmN1PGJyPgpbMGJkYTo4
MTc2XTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgaHViPGJyPgpbKG51bGwpOihudWxsKV08YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYjxicj4K
WzEyZDE6MTAwMV08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5n
LmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KWyhudWxsKToobnVsbCldPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2Uo
KSBvcHRpb248YnI+ClsxMmQxOjEwMDFdPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKTxicj4KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3Rh
bmdveC1laGNpLWhjZC0xL3VzYjIvMi0xPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKTxicj4KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3Rh
bmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjAvdHR5VVNCMC90dHkvdHR5VVNCMDxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCkg
L2Rldi90dHlVU0IwPGJyPgooaHVhd2VpKSAyNTUvMjU1LzI1NSBbMDBdID09Jmd0OyAobnVsbCkg
KG51bGwpPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNo
ZWNrX3VzYl9kZXZpY2UoKSBvcHRpb248YnI+ClsobnVsbCk6KG51bGwpXTxicj4Kb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0
aW9uPGJyPgpbMTJkMToxMDAxXTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzphZGRfZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gt
ZWhjaS1oY2QtMS91c2IyLzItMTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzphZGRfZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gt
ZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4xL3R0eVVTQjEvdHR5L3R0eVVTQjE8YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYv
dHR5VVNCMTxicj4KKGh1YXdlaSkgMjU1LzI1NS8yNTUgWzAxXSA9PSZndDsgKG51bGwpIChudWxs
KTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191
c2JfZGV2aWNlKCkgb3B0aW9uPGJyPgpbKG51bGwpOihudWxsKV08YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxi
cj4KWzEyZDE6MTAwMV08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
dm5nLmM6YWRkX2RldmljZSgpPGJyPgovc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2kt
aGNkLTEvdXNiMi8yLTE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
dm5nLmM6YWRkX2RldmljZSgpPGJyPgovc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2kt
aGNkLTEvdXNiMi8yLTEvMi0xOjEuMi90dHlVU0IyL3R0eS90dHlVU0IyPGJyPgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVT
QjI8YnI+CihodWF3ZWkpIDI1NS8yNTUvMjU1IFswMl0gPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVt
KCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjcmVhdGVfbW9k
ZW0oKSBkcml2ZXI9aHVhd2VpPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9jcmVhdGUoKSBuYW1lOiAobnVsbCksPGJyPgp0eXBlOiBodWF3ZWk8
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVh
d2VpKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzIt
MTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9o
dWF3ZWkoKSAvZGV2L3R0eVVTQjA8YnI+CjI1NS8yNTUvMjU1IDAwIChudWxsKTxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2
L3R0eVVTQjE8YnI+CjI1NS8yNTUvMjU1IDAxIChudWxsKTxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAvZGV2L3R0eVVTQjI8YnI+
CjI1NS8yNTUvMjU1IDAyIChudWxsKTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSBtZG09L2Rldi90dHlVU0IwPGJyPgpwY3VpPS9k
ZXYvdHR5VVNCMiBkaWFnPShudWxsKSBxbWk9KG51bGwpIG5ldD0obnVsbCk8YnI+Cm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVt
PGJyPgoweDU1NmViMzgwIHByb3BlcnR5IERldmljZTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08YnI+CjB4NTU2ZWIz
ODAgcHJvcGVydHkgTW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtPGJyPgoweDU1NmViMzgwIHByb3BlcnR5IFBj
dWk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9tb2RlbV9w
cm9wZXJ0eSgpIG1vZGVtPGJyPgoweDU1NmViMzgwIHByb3BlcnR5IERpYWc8YnI+Cm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVt
PGJyPgoweDU1NmViMzgwIHByb3BlcnR5IE5ldHdvcmtJbnRlcmZhY2U8YnI+Cm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX3JlZ2lzdGVyKCkgMHg1NTZl
YjM4MDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3
ZWlfcHJvYmUoKSAweDU1NmViMzgwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
bW9kZW0uYzplbWl0X21vZGVtX2FkZGVkKCkgMHg1NTZlYjM4MDxicj4Kb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL21vZGVtLmM6Y2FsbF9tb2RlbXdhdGNoZXMoKSAweDU1NmViMzgwPGJy
PgphZGRlZDoxPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2hmcF9hZ19i
bHVlejUuYzptb2RlbV93YXRjaCgpIG1vZGVtOjxicj4KMHg1NTZlYjM4MCwgYWRkZWQ6IDE8YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvZHVuX2d3X2JsdWV6NS5jOm1vZGVt
X3dhdGNoKCkgbW9kZW06PGJyPgoweDU1NmViMzgwLCBhZGRlZDogMTxicj4Kb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzptb2RlbV93YXRjaCgpIG1v
ZGVtOjxicj4KMHg1NTZlYjM4MCwgYWRkZWQ6IDE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3BsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzptb2RlbV93YXRjaCgpIG1vZGVtOjxicj4K
MHg1NTZlYjM4MCwgYWRkZWQ6IDE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdp
bnMvaHVhd2VpLmM6aHVhd2VpX2VuYWJsZSgpIDB4NTU2ZWIzODA8YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtPGJyPgow
eDU1NmViMzgwIHByb3BlcnR5IE1vZGVtPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL2h1YXdlaS5jOm9wZW5fZGV2aWNlKCkgTW9kZW0gL2Rldi90dHlVU0IwPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBt
b2RlbTxicj4KMHg1NTZlYjM4MCBwcm9wZXJ0eSBQY3VpPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOm9wZW5fZGV2aWNlKCkgUGN1aSAvZGV2L3R0eVVTQjI8
YnI+Cm9mb25vZFszMDk0M106IE1vZGVtOiAmZ3Q7IEFURTAgK0NNRUU9MVxyPGJyPgpvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFURTAgK0NNRUU9MVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBNb2Rl
bTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xy
XG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVRJXHI8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbk1hbnVmYWN0dXJlcjogaHVhd2VpXHJcbk1vZGVsOiBFMzAzXHJcblJl
dmlzaW9uOjxicj4KMjIuMzE4LjA1LjAwLjAwXHJcbklNRUk6IDg2MjU2NjAyMDAwNTY5N1xyXG4r
R0NBUDo8YnI+CitDR1NNLCtEUywrRVNcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVF5SRlNXSVRDSD0/XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbkVSUk9SXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDRlVOPTFccjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXlNJTVNUOjAsMFxyXG48YnI+Cm9mb25v
ZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcblxyXG5eU0lNU1Q6MSwwXHJcbjxicj4Kb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX2VuYWJsZSgpPGJy
PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOnNpbXN0X25vdGlm
eSgpIDI1NSAtJmd0OyAxPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0lORk9c
cjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDJcclxuXHJcbitDR1JF
Rzo8YnI+CjJcclxuXHJcbl5TWVNJTkZPOjAsMywwLDAsMSwwLDBcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpzeXNpbmZvX2VuYWJs
ZV9jYigpIDEgLSZndDsgMTxicj4Kb2Zvbm9kWzMwOTQzXTogTW9kZW06ICZndDsgQVQmYW1wO0Mw
XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQmYW1wO0MwXHI8YnI+Cm9mb25vZFsz
MDk0M106IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogTW9kZW06ICZndDsgQVQrQ1NDUz0mcXVv
dDtHU00mcXVvdDtccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU0NTPSZxdW90
O0dTTSZxdW90O1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBNb2RlbTogJmx0OyBcclxuT0tcclxuPGJy
PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVReVTJESUFHP1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5eVTJESUFHOiAxMTlcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0
OyBBVF5HRVRQT1JUTU9ERVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eR0VU
UE9SVE1PREU6IFRZUEU6IFdDRE1BOiBodWF3ZWksXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZndDsgQVReVVNTRE1PREU9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG5eVVNTRE1PREU6ICgwLTEpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0
M106IFBDVUk6ICZndDsgQVReRElBTE1PREU9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG5eRElBTE1PREU6ICgwLTIpLCgwLTI1NSlcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVF5DVk9JQ0U9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG5eQ1ZPSUNFOiAoMClcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDRlVOPTVccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
K0NSRUc6IDBcclxuXHJcbitDR1JFRzogMFxyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbk9LXHJcblxyXG5eTU9ERTogMCwwXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX29mZmxpbmUoKTxicj4Kb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAw
LDxicj4KbmV3IHN0YXRlOiAxPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5z
L2h1YXdlaS5jOmh1YXdlaV9wcmVfc2ltKCkgMHg1NTZlYjM4MDxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVF5VU1NETU9ERT9ccjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2goKSAweDU1NmRjNjYwPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRj
aCgpIDB4NTU2ZGM2NjA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpv
Zm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg1NTZkYzY2MDxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuXlVTU0RNT0RFOiAxXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0
M106IFBDVUk6ICZndDsgQVReRElBTE1PREU/XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbl5ESUFMTU9ERTozLDJcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVF5DVk9JQ0U/XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5D
Vk9JQ0U6IDEsIDgwMDAsIDE2LCAyMFxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBW
b2ljZSBjaGFubmVsOiA4MDAwIEh6LCAxNiBiaXRzLCAyMG1zIHBlcmlvZDxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtHQ0FQXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VTXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMTIyNTgsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDIy
RkUyQTUwMzgwMDE3MThBMDEwNThCMDMyRjA2MDM4MDAyMDAwQTg4MDExMCZxdW90O1xyXG5cclxu
T0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAzMDxicj4Kb2Zv
bm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5ERFNFVEVYPT9ccjxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuXkREU0VURVg6ICgyKVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHTUlccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuaHVhd2VpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q1JTTT0xNzYsMTIyNTgsMCwwLDEwXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bitDUlNNOiAxNDQsMCwmcXVvdDs5ODUzMDMwNTAxMDcwODUzMDVGNiZxdW90O1xyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAxMDxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2Io
KSBidWZvZmY6IDAsPGJyPgpkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmZ3Q7IEFUK0NHTU1ccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
RTMwM1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTkyLDI4NDIxLDAsMCwyNTVccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NS
U006PGJyPgoxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyNkYwNUE1MDM4MDAxNzE4QTAxMDU4
QjAzNkYwNjA0ODAwMjAwMEE4ODAxMTAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigp
PGJyPgpjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ0dNUlxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4yMi4zMTguMDUu
MDAuMDBcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNN
PTE3NiwyODQyMSwwLDAsMTBccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NS
U006IDE0NCwwLCZxdW90OzY1NkVGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDEwPGJyPgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1
Zm9mZjogMCw8YnI+CmRhdGFvZmY6IDAsIHRvY29weTogMTA8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ0dTTlxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG44NjI1
NjYwMjAwMDU2OTdcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDUlNNPTE5MiwxMjAzNywwLDAsMjU1XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjJGMDVBNTAzODAwMTcx
OEEwMTA1OEIwMzJGMDYwNDgwMDIwMDBBODgwMTI4JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2lu
Zm9fY2IoKTxicj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NSU009MTc2LDEyMDM3LDAsMCwxMFxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7NjU2RUZGRkZGRkZGRkZGRkZGRkYmcXVv
dDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MTA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9y
ZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLDxicj4KZGF0YW9mZjogMCwgdG9jb3B5OiAxMDxicj4K
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUElOP1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1BJTjogUkVBRFlcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2NwaW5fY2IoKSBjcnNtX3Bp
bl9jYjo8YnI+ClJFQURZPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfcGluX3JldHJpZXNfcXVlcnkoKTxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVF5DUElOP1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eQ1BJ
TjogUkVBRFksLDEwLDMsMTAsM1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4K
Y291bnRlciBpZD05LCB2YWw9MTA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzpodWF3ZWlfY3Bpbl9jYigpIHJldHJ5PGJyPgpjb3VudGVyIGlkPTEs
IHZhbD0zPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4KY291bnRlciBpZD0xMSwgdmFsPTEwPGJyPgpv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2Nw
aW5fY2IoKSByZXRyeTxicj4KY291bnRlciBpZD00LCB2YWw9Mzxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODU5MCwwLDAsMjU1XHI8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tcclxu
PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NTg5LDAsMCwyNTVc
cjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVv
dDs2MjFDODIwMjQxMjE4MzAyNkZBREE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA2ODAwMjAwMDQ4
ODAxMTgmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgpjcnNtX2luZm9fY2I6
IDkwLCAwMCwgMzA8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg1
ODksMCwwLDRccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCww
LCZxdW90OzAwMDAwMDAyJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3Jz
bV9yZWFkX2NiOiA5MCwgMDAsIDQ8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9z
aW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLDxicj4KZGF0YW9mZjog
MCwgdG9jb3B5OiA0PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4
NDM4LDAsMCwyNTVccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDEw
NiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVQrQ1JTTT0xOTIsMjg0NzIsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RjM4QTUw
MzgwMDE3MThBMDEwNThCMDM2RjA2MDI4MDAyMDAwQTg4MDEyMCZxdW90O1xyXG5cclxuT0tcclxu
PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAzMDxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODQ3MiwwLDAsMTBccjxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzdFRUUxMTFDMjdGNjU5MDAw
MDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2Ry
aXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5
MCwgMDAsIDEwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1f
ZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCw8YnI+CmRhdGFvZmY6IDAsIHRvY29weTog
MTA8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1MDIsMCwwLDI1
NVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZx
dW90OzYyMUM4MjAyNDEyMTgzMDI2RjU2QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDc4MDAyMDAw
MTg4MDEyOCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19j
YjogOTAsIDAwLCAzMDxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3Niwy
ODUwMiwwLDAsMVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0
LDAsJnF1b3Q7MDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3Jl
YWRfY2I6IDkwLCAwMCwgMTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZz
LmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJyPgpkYXRhb2ZmOiAwLCB0
b2NvcHk6IDE8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0lNSVxyPGJyPgpvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4yNzIwNTAxMDA0MTM1ODBcclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Np
bWlfY2IoKSBjaW1pX2NiOjxicj4KMjcyMDUwMTAwNDEzNTgwPGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3RhdGU6IDEs
PGJyPgpuZXcgc3RhdGU6IDI8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMv
aHVhd2VpLmM6aHVhd2VpX3Bvc3Rfc2ltKCkgMHg1NTZlYjM4MDxicj4Kb2Zvbm9kWzMwOTQzXTo8
YnI+Ci9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9ncHJzX2Nv
bnRleHRfcHJvYmUoKTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6
Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08YnI+CjB4NTU2ZWIzODAgcHJvcGVydHkgQWx3YXlz
T25saW5lPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSQz0xXHI8YnI+Cm9mb25v
ZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08YnI+CjB4NTU2ZWIz
ODAgcHJvcGVydHkgQWx3YXlzT25saW5lPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9zZXRfb25saW5lKCkgbW9kZW08YnI+CjB4NTU2ZWIzODAg
b25saW5lPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NMSVA9MVxyPGJyPgpvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVQrQ09MUD0xXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJc
bjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDQ1dBPTFccjxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25v
LTEuMTQvZHJpdmVycy9odWF3ZWltb2RlbS92b2ljZWNhbGwuYzpodWF3ZWlfdm9pY2VjYWxsX2lu
aXRpYWxpemVkKCk8YnI+CnJlZ2lzdGVyaW5nIHRvIG5vdGlmaWNhdGlvbnM8YnI+Cm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkg
MHg1NTZkYzY2MDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9ibHVlejUu
YzpidF9yZWdpc3Rlcl9wcm9maWxlKCk8YnI+CkJsdWV0b290aDogUmVnaXN0ZXJpbmcgMDAwMDEx
MWYtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIChoZnBfYWcpIHByb2ZpbGU8YnI+Cm9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVReQ1ZPSUNFPT9ccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuXkNWT0lDRTogKDApXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1NDUz0/XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bitDU0NTOiAoJnF1b3Q7SVJBJnF1b3Q7LCZxdW90O1VDUzImcXVvdDssJnF1b3Q7R1NNJnF1b3Q7
KVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0NGRz0/
XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5TWVNDRkc6PGJyPgooMiwxMywx
NCwxNiksKDAtMyksKCgyMDAwMDAwNDAwMzgwLCZxdW90O0dTTTkwMC9HU00xODAwL1dDRE1BOTAw
L1dDRE1BMjEwMCZxdW90OyksKDI4MDAwMCwmcXVvdDtHU004NTAvR1NNMTkwMCZxdW90OyksKDNm
ZmZmZmZmLCZxdW90O0FsbDxicj4KYmFuZHMmcXVvdDspKSwoMC0yKSwoMC00KVxyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTTVM9P1xyPGJyPgpvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NNUzogKDAsMSlcclxuXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmF0X2NzbXNfcXVl
cnlfY2IoKSBDU01TPGJyPgpxdWVyeSBwYXJzZWQgc3VjY2Vzc2Z1bGx5PGJyPgpvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHRENPTlQ9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ0dEQ09OVDo8YnI+CigxLTExKSwmcXVvdDtJUCZxdW90OywsLCgwLTIpLCgwLTMp
LCgwLDEpLCgwLDEpXHJcbitDR0RDT05UOjxicj4KKDEtMTEpLCZxdW90O1BQUCZxdW90OywsLCgw
LTIpLCgwLTMpLCgwLDEpLCgwLDEpXHJcblxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmZ3Q7IEFUK0NGVU49MVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5eU0lNU1Q6MCwwXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9o
dWF3ZWkuYzpzaW1zdF9ub3RpZnkoKSAxIC0mZ3Q7IDA8YnI+Cm9mb25vZFszMDk0M106IFJlZ2lz
dGVyUHJvZmlsZSgpIHJlcGxpZWQgYW4gZXJyb3I6PGJyPgpvcmcuZnJlZWRlc2t0b3AuREJ1cy5F
cnJvci5TcGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhlbHBlciBleGl0ZWQgd2l0aDxicj4KdW5r
bm93biByZXR1cm4gY29kZSAxPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xy
XG5cclxuXlNJTVNUOjEsMFxyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdp
bnMvaHVhd2VpLmM6c2ltc3Rfbm90aWZ5KCkgMCAtJmd0OyAxPGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDgwLDAsMCwyNTVccjxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuK0NSRUc6IDJcclxuXHJcbitDR1JFRzogMlxyXG48YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIx
MDAyMjA2ODMwMjZGNDBBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgwMDIwMENDODgwMCZxdW90
O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAz
Mjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUEJTPT9ccjxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NQQlM6ICgmcXVvdDtTTSZxdW90OywmcXVvdDtFTiZxdW90
OywmcXVvdDtPTiZxdW90OywmcXVvdDtGRCZxdW90OylcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVCtDU01TPTFccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NTTVM6IDEsMSwxXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ0dSRUc9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q0dSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVReU1lTSU5GT1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eU1lTSU5GTzow
LDMsMCwwLDEsMCwwXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvaHVhd2VpLmM6c3lzaW5mb19vbmxpbmVfY2IoKSAxIC0mZ3Q7IDE8YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9s
ZCBzdGF0ZTogMiw8YnI+Cm5ldyBzdGF0ZTogMzxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcG9zdF9vbmxpbmUoKSAweDU1NmViMzgwPGJyPgpv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgwLDEsNCwzNFxyPGJyPgpv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90OzRENzky
MDRFNzU2RDYyNjU3MkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYwNzkxNTM4MzEzOTc3ODQ4RkZGRkZG
RkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2Ni
OiA5MCwgMDAsIDM0PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTTVM/XHI8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU01TOiAxLDEsMSwxXHJcblxyXG5PS1xy
XG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dSRUc9MlxyPGJyPgpvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ0dBVVRPPTBccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxu
PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHRVJFUD0yLDFccjxicj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuRVJST1JcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2JsdWV6NS5jOmJ0X3JlZ2lzdGVyX3Byb2ZpbGUoKTxicj4KQmx1ZXRv
b3RoOiBSZWdpc3RlcmluZyAwMDAwMTEwMy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIgKGR1
bl9ndykgcHJvZmlsZTxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUkVHPT9ccjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSRUc6ICgwLTIpXHJcblxyXG5PS1xy
XG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NDQj0/XHI8YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDU0NCOigwLDEpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1VTRD0xXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6
ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3
OCwyODQ4MCwyLDQsMzRccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006
PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVCtDTUdGPT9ccjxicj4Kb2Zvbm9kWzMwOTQzXTogUmVnaXN0ZXJQcm9maWxlKCkg
cmVwbGllZCBhbiBlcnJvcjo8YnI+Cm9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLlNwYXduLkNo
aWxkRXhpdGVkLCBMYXVuY2ggaGVscGVyIGV4aXRlZCB3aXRoPGJyPgp1bmtub3duIHJldHVybiBj
b2RlIDE8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDTUdGOiAoMCwxKVxyXG5c
clxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSRUc9MlxyPGJyPgpv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3Nwbl93YXRjaCgpIDB4NTU2ZGM2NjA8
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRy
ZWdfYWRkX3N0YXR1c193YXRjaCgpPGJyPgoweDU1NmRjZjE4PGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NTQ0I9MFxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5P
S1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYnMuYzpjYnNfZ290X2lt
c2koKSBHb3QgSU1TSTo8YnI+CjI3MjA1MDEwMDQxMzU4MDxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCk8
YnI+CjB4NTU2ZGNmMTg8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1BNUz0/XHI8
YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUE1TOjxicj4KKCZxdW90O1NNJnF1
b3Q7LCZxdW90O01FJnF1b3Q7KSwoJnF1b3Q7U00mcXVvdDssJnF1b3Q7TUUmcXVvdDspLCgmcXVv
dDtTTSZxdW90OywmcXVvdDtNRSZxdW90OylcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCwzLDQsMzRccjxicj4Kb2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90
O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAz
NDxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUkVHP1xyPGJyPgpvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JFRzogMiwyXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3Rp
ZnkoKTxicj4KL2h1YXdlaV8wIHN0YXR1cyAyIHRlY2ggLTE8YnI+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpPGJyPgow
eDU1NmRjZjE4LCAobmlsKTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5j
OmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMiwgLTEsIC0xLCAtMSw8YnI+CihudWxsKShudWxsKTxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2No
YW5nZWQoKSAyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NNR0Y9MFxyPGJyPgpv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsNCw0LDM0XHI8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxu
XHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1BNUz0mcXVvdDtNRSZxdW90OywmcXVvdDtN
RSZxdW90OywmcXVvdDtNRSZxdW90O1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5eTU9ERTogNSw0XHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NQTVM6
IDAsMjAsMCwyMCwwLDIwXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ1JTTT0xNzgsMjg0ODAsNSw0LDM0XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9L
XHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+Cm9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ05NST0/XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6
ICZsdDsgXHJcbitDTk1JOjxicj4KKDAtMiksKDAtMyksKDAsMiksKDAtMiksKDAsMSlcclxuXHJc
bk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Nt
cy5jOmJ1aWxkX2NubWlfc3RyaW5nKCk8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q1JTTT0xNzgsMjg0ODAsNiw0LDM0XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Ny
c21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+Cm9mb25vZFszMDk0
M106IFBDVUk6ICZndDsgQVQrQ05NST0xLDEsMiwxLDBccjxicj4Kb2Zvbm9kWzMwOTQzXTogRHVw
bGljYXRlIEVGc2RuIGVudHJpZXMgZm9yIGBFbWVyZ2VuY3kgU2VydmljZXMmIzM5Ozxicj4Kb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvbmV0d29yay5jOl9fb2Zvbm9fbmV0cmVnX2FkZF9zdGF0dXNfd2F0Y2goKTxi
cj4KMHg1NTZkY2YxODxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Ntcy5jOnNt
c19yZXN0b3JlX3R4X3F1ZXVlKCk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdp
bnMvcHVzaC1ub3RpZmljYXRpb24uYzpzbXNfd2F0Y2goKTxicj4KcmVnaXN0ZXJlZDxicj4Kb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzpzbXNfd2F0
Y2goKSByZWdpc3RlcmVkPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTky
LDI4NjE4LDAsMCwyNTVccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006
PGJyPgoxNDQsMCwmcXVvdDs2MjFFODIwNTQyMjEwMDA2MDU4MzAyNkZDQUE1MDM4MDAxNzE4QTAx
MDU4QjAzNkYwNjA1ODAwMjAwMUU4ODAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2Io
KTxicj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NNR0w9NFxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eUlNTSTog
MTNcclxuXHJcbl5IQ1NROiZxdW90O1dDRE1BJnF1b3Q7LDQyLDM0LDQ5XHJcbjxicj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9kcml2ZXJzL2F0bW9kZW0vc21zLmM6YXRfY21nbF9kb25lKCk8YnI+Cm9mb25vZFszMDk0
M106IFBDVUk6ICZndDsgQVQrQ0dTTVM9M1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7
IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2
MTgsMSw0LDZccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCww
LCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+
CmNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTc4LDI4NjE4LDIsNCw2XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
cmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNjxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOCwzLDQsNlxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxy
XG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8YnI+Cm9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsNCw0LDZccjxicj4Kb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAw
MCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAs
IDAwLCA2PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE4LDUs
NCw2XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVv
dDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgNjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNN
PTE5MiwyODYxNywwLDAsMjU1XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
UlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAwNTA1ODMwMjZGQzlBNTAzODAwMTcx
OEEwMTA1OEIwMzZGMDYwMjgwMDIwMDE5ODgwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZv
X2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAzMjxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVCtDUlNNPTE3OCwyODYxNywxLDQsNVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCA1PGJyPgpvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDIsNCw1XHI8YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7
XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRt
b2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8
YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsMyw0LDVccjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAw
MDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6
IDkwLCAwMCwgNTxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYx
Nyw0LDQsNVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNy
c21fcmVhZF9jYjogOTAsIDAwLCA1PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTc4LDI4NjE3LDUsNCw1XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
UlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRf
Y2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVQrQ1JTTT0xOTIsMjg0MzMsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTA2LDEzMCwmcXVvdDsmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21lc3NhZ2Utd2FpdGluZy5jOm13X2NwaHNf
bXdpc19yZWFkX2NiKCkgTm88YnI+CkNQSFMgTVdJUyBvbiBTSU08YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTksMCwwLDI1NVxyPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMTAw
NTgzMDI2RkNCQTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDU4MDAyMDA1MDg4MDAmcXVvdDtcclxu
XHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgpjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzI8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMSw0LDE2XHI8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYw
MEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVh
ZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMiw0LDE2XHI8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3Jl
YWRfY2I6IDkwLCAwMCwgMTY8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0x
NzgsMjg2MTksMyw0LDE2XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNN
Ojxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8
YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksNCw0LDE2XHI8
YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7
RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
cmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksNSw0LDE2XHI8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMTY8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9z
aW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLDxicj4Kc2Vla29mZjogMzks
IHRvcmVhZDogMTc8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNp
bV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLDxicj4Kc2Vla29mZjogMzksIHRvcmVhZDog
MTA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9jYnMuYzph
dF9jYnNfc2V0X3RvcGljcygpPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9
MFxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZndDsgQVQrQ1NDQj0wLCZxdW90OzAsNTAsMjE0LDQzNTItNDM1NiZxdW90
O1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg0MzcsMCwwLDI1NVxyPGJyPgpvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTA2LDEzMCwmcXVvdDsmcXVvdDtcclxuXHJc
bk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxNSww
LDAsMjU1XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5TUlZTVDogMlxyXG5c
clxuK0NHUkVHOiAxLCZxdW90OzAwNDAmcXVvdDssJnF1b3Q7MDJDMTE1NUEmcXVvdDtcclxuPGJy
PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVz
X25vdGlmeSgpIC9odWF3ZWlfMDxicj4Kc3RhdHVzIDE8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6
ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAyMjA1ODMwMjZG
QzdBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwMjgwMDIwMEFBODgwMCZxdW90O1xyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAzMjxicj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwxLDQsMzRccjxicj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDs0RDYxNjk2Q0ZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGMDc5MTUzODMzMzMzMTMxN0ZGRkZGRkZGRkZG
RiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAs
IDAwLCAzNDxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwy
LDQsMzRccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQs
MCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+
CmNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDUlNNPTE3OCwyODYxNSwzLDQsMzRccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxu
PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSw0LDQsMzRccjxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZx
dW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAw
LCAzNDxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9n
cHJzLWNvbnRleHQuYzphdF9ncHJzX2FjdGl2YXRlX3ByaW1hcnkoKSBjaWQgMTxicj4Kb2Zvbm9k
WzMwOTQzXTogTW9kZW06ICZndDsgQVQrQ0dEQ09OVD0xLCZxdW90O0lQJnF1b3Q7LCZxdW90OzNJ
cmVsYW5kJnF1b3Q7XHI8YnI+Cm9mb25vZFszMDk0M106IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRl
eHQuYzphdF9jZ2Rjb250X2NiKCk8YnI+Cm9rIDE8YnI+Cm9mb25vZFszMDk0M106IE1vZGVtOiAm
Z3Q7IEFURCo5OSoqKjEjXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0x
NzgsMjg2MTUsNSw0LDM0XHI8YnI+Cm9mb25vZFszMDk0M106IE1vZGVtOiAmbHQ7IFxyXG5DT05O
RUNUXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL2dw
cnMtY29udGV4dC5jOmF0X2NnZGF0YV9jYigpIG9rPGJyPgoxPGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6c2V0dXBfcHBwKCk8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRf
Y2I6IDkwLCAwMCwgMzQ8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAx
LCZxdW90OzAwNDAmcXVvdDssJnF1b3Q7MDJDMTE1NUEmcXVvdDtcclxuPGJyPgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5
KCk8YnI+Ci9odWF3ZWlfMCBzdGF0dXMgMSB0ZWNoIDI8YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9jYnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDEsIC0xLCAtMSwgMiw8YnI+
CihudWxsKShudWxsKTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpu
ZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAxPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NPUFM9MywyXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDT1BTP1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ09QUzogMCwyLCZxdW90OzI3MjA1JnF1b3Q7LDJcclxuXHJcbk9LXHJc
bjxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9uZXR3
b3JrLXJlZ2lzdHJhdGlvbi5jOmNvcHNfbnVtZXJpY19jYigpIENvcHM8YnI+Cm51bWVyaWMgZ290
IG1jYzogMjcyLCBtbmM6IDA1PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTUVxy
PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NROiAxMyw5OVxyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vbmV0d29y
ay1yZWdpc3RyYXRpb24uYzpjc3FfY2IoKTxicj4KY3NxX2NiOiAxMzxicj4Kb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5
KCk8YnI+CnN0cmVuZ3RoIDQxPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM9
MywwXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVCtDT1BTP1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ09QUzogMCwwLCZxdW90OzMgSVJMJnF1b3Q7LDJcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0
cmF0aW9uLmM6Y29wc19jYigpPGJyPgpjb3BzX2NiOiAzIElSTCwgMjcyIDA1IDI8YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxs
YmFjaygpPGJyPgoweDU1NmRjZjE4LCAobmlsKTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMSwgLTEsIC0xLCAyLDxicj4KMjcy
MDU8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYnMuYzpjYnNfbG9jYXRpb25f
Y2hhbmdlZCgpIDEsIDAsIDA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMTxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuXlJTU0k6IDEwXHJcblxyXG5eSENTUTomcXVvdDtXQ0RNQSZxdW90OywzNywyOCw0N1xy
XG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0
cmVnX3N0cmVuZ3RoX25vdGlmeSgpPGJyPgpzdHJlbmd0aCAzMjxicj4KPGJyPgo8YnI+Cjxicj4K
SG9tYW08YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxi
cj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+
Cjxicj4KPGJyPgo8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5SU1NJOiAxMlxy
XG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDssNDIsMzMsNDdcclxuPGJyPgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3Rp
ZnkoKTxicj4Kc3RyZW5ndGggMzg8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5N
T0RFOiA1LDdcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vZ3Bycy1jb250ZXh0LmM6cHBwX2Nvbm5lY3QoKTxicj4Kb2Zvbm9kWzMwOTQzXTogSVA6IDEw
LjIwNS4yMDYuMjQzPGJyPgpvZm9ub2RbMzA5NDNdOiBETlM6IDE3Mi4zMC4yMjQuNjUsIDE3Mi4z
MC4yMjQuNjU8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6cHJpX2Fj
dGl2YXRlX2NhbGxiYWNrKCkgMHg1NTZlNjVhODxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSBuZXQgYWRkPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lz
dGVtIG5ldDxicj4KZmluaXNoZWQ8YnI+Cjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
cGx1Z2lucy91ZGV2bmcuYzpjaGVja19tb2RlbV9saXN0KCk8YnI+Cjxicj4KPGJyPgo8YnI+Cjxi
cj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+
Cjxicj4KPGJyPgo8YnI+Cjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0Ozxicj4KXHJcbl5E
U0ZMT1dSUFQ6MDAwMDAwMDIsMDAwMDAxRUQsMDAwMDAyOUUsMDAwMDAwMDAwMDAwMDNBNiwwMDAw
MDAwMDAwMDAwNEQ0LDAwMDAwMDAwLDAwMDAwMDAwXHJcbjxicj4KPGJyPgo8YnI+Cjxicj4KPGJy
Pgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4K
PGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDs8YnI+Clxy
XG5eRFNGTE9XUlBUOjAwMDAwMDA0LDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwMDAwMDAzQTYs
MDAwMDAwMDAwMDAwMDRENCwwMDAwMDAwMCwwMDAwMDAwMFxyXG48YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6cmVtb3ZlX2RldmljZSgpPGJyPgovc3lzL2Rl
dmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEvMi0xOjEuMC90dHlVU0Iw
L3R0eS90dHlVU0IwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZu
Zy5jOmRlc3Ryb3lfbW9kZW0oKTxicj4KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNp
LWhjZC0xL3VzYjIvMi0xPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0u
YzpvZm9ub19tb2RlbV9yZW1vdmUoKSAweDU1NmViMzgwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvbW9kZW0uYzptb2RlbV91bnJlZ2lzdGVyKCkgMHg1NTZlYjM4MDxicj4Kb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkg
b2xkIHN0YXRlOiAzLDxicj4KbmV3IHN0YXRlOiAwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzpmbHVzaF9hdG9tcygpPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbWVzc2FnZS13YWl0aW5nLmM6bXdfcmVtb3ZlKCkgYXRvbTo8YnI+CjB4NTU2ZTU5
NTA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYWxsLWJhcnJpbmcuYzpjYWxs
X2JhcnJpbmdfcmVtb3ZlKCkgYXRvbTo8YnI+CjB4NTU2ZTU2Yjg8YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9jYWxsLXNldHRpbmdzLmM6Y2FsbF9zZXR0aW5nc19yZW1vdmUoKSBh
dG9tOjxicj4KMHg1NTZlNTVkMDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nh
bGwtZm9yd2FyZGluZy5jOmNhbGxfZm9yd2FyZGluZ19yZW1vdmUoKTxicj4KYXRvbTogMHg1NTZl
NTRmODxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Vzc2QuYzp1c3NkX3JlbW92
ZSgpIGF0b206IDB4NTU2ZTU0Mzg8YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4xNC9z
cmMvbmV0d29yay5jOl9fb2Zvbm9fbmV0cmVnX3JlbW92ZV9zdGF0dXNfd2F0Y2goKSAweDU1NmRj
ZjE4PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX3JlbW92ZSgp
IGF0b206IDB4NTU2ZTUyYzg8YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRfZ3Byc19kZXRhY2hfc2h1dGRvd24oKSBjaWQg
MTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9yZW1v
dmVfc3BuX3dhdGNoKCkgMHg1NTZkYzY2MDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL25ldHdvcmsuYzpuZXRyZWdfcmVtb3ZlKCkgYXRvbTogMHg1NTZkZGI4ODxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpncHJzX2NvbnRleHRfdW5yZWdpc3Rlcigp
IDB4NTU2ZTQ2YTgsPGJyPgoweDU1NmRkODQwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvZ3Bycy5jOmdwcnNfY29udGV4dF9yZW1vdmUoKSBhdG9tOiAweDU1NmU0NmM4PGJyPgpv
Zm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4
dC5jOmF0X2dwcnNfY29udGV4dF9yZW1vdmUoKTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9ibHVlejUuYzpidF91bnJlZ2lzdGVyX3Byb2ZpbGUoKTxicj4KQmx1ZXRvb3Ro
OiBVbnJlZ2lzdGVyaW5nIHByb2ZpbGUgL2JsdWV0b290aC9wcm9maWxlL2R1bl9ndzxicj4Kb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpncHJzX3VucmVnaXN0ZXIoKSAweDU1
NmRkODQwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOmdwcnNfcmVt
b3ZlKCkgYXRvbTogMHg1NTZkZDhhODxicj4Kb2Zvbm9kWzMwOTQzXTo8YnI+Ci9vZm9uby0xLjE0
L3BsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzpwdXNoX25vdGlmaWNhdGlvbl9jbGVhbnVwKCk8
YnI+CjB4NTU2ZGYxOTA8YnI+Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4xNC9wbHVnaW5z
L3NtYXJ0LW1lc3NhZ2luZy5jOnNtYXJ0X21lc3NhZ2luZ19jbGVhbnVwKCkgMHg1NTZkZjE2MDxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Ntcy5jOnNtc19yZW1vdmUoKSBhdG9t
OiAweDU1NmRkNzgwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0
dGluZ3MuYzpyYWRpb19zZXR0aW5nc19yZW1vdmUoKTxicj4KYXRvbTogMHg1NTZkZGJmODxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Bob25lYm9vay5jOnBob25lYm9va19yZW1v
dmUoKSBhdG9tOjxicj4KMHg1NTZkZGIwODxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL2F1ZGlvLXNldHRpbmdzLmM6YXVkaW9fc2V0dGluZ3NfcmVtb3ZlKCk8YnI+CmF0b206IDB4
NTU2ZGRhMjg8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzp2
b2ljZWNhbGxfcmVtb3ZlKCkgYXRvbTo8YnI+CjB4NTU2ZDY4Yzg8YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvYmx1ZXo1LmM6YnRfdW5yZWdpc3Rlcl9wcm9maWxlKCk8YnI+
CkJsdWV0b290aDogVW5yZWdpc3RlcmluZyBwcm9maWxlIC9ibHVldG9vdGgvcHJvZmlsZS9oZnBf
YWc8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpzaW1fcmVtb3ZlKCkg
YXRvbTogMHg1NTZkYzc4ODxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVt
LmM6ZGV2aW5mb19yZW1vdmUoKSBhdG9tOiAweDU1NmRkMDcwPGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9kaXNhYmxlKCkgMHg1NTZlYjM4MDxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcmVt
b3ZlKCkgMHg1NTZlYjM4MDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVt
LmM6dW5yZWdpc3Rlcl9wcm9wZXJ0eSgpIHByb3BlcnR5PGJyPgoweDU1NmViMTI4PGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzp1bnJlZ2lzdGVyX3Byb3BlcnR5KCkg
cHJvcGVydHk8YnI+CjB4NTU2ZWIyYjA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOnVucmVnaXN0ZXJfcHJvcGVydHkoKSBwcm9wZXJ0eTxicj4KMHg1NTZlYjEwODxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6dW5yZWdpc3Rlcl9wcm9w
ZXJ0eSgpIHByb3BlcnR5PGJyPgoweDU1NmViNDQwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzp1bnJlZ2lzdGVyX3Byb3BlcnR5KCkgcHJvcGVydHk8YnI+CjB4NTU2
ZWIwZDA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmVtaXRfbW9k
ZW1fcmVtb3ZlZCgpIDB4NTU2ZWIzODA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOmNhbGxfbW9kZW13YXRjaGVzKCkgMHg1NTZlYjM4MDxicj4KYWRkZWQ6MDxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9oZnBfYWdfYmx1ZXo1LmM6bW9kZW1f
d2F0Y2goKSBtb2RlbTo8YnI+CjB4NTU2ZWIzODAsIGFkZGVkOiAwPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2R1bl9nd19ibHVlejUuYzptb2RlbV93YXRjaCgpIG1vZGVt
Ojxicj4KMHg1NTZlYjM4MCwgYWRkZWQ6IDA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CjB4NTU2
ZWIzODAsIGFkZGVkOiAwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3B1
c2gtbm90aWZpY2F0aW9uLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CjB4NTU2ZWIzODAsIGFk
ZGVkOiAwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmRl
c3Ryb3lfbW9kZW0oKSAvZGV2L3R0eVVTQjA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6ZGVzdHJveV9tb2RlbSgpIC9kZXYvdHR5VVNCMTxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpkZXN0cm95X21vZGVtKCkgL2Rl
di90dHlVU0IyPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzp1
ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSByZW1vdmU8YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvdWRldi5jOnJlbW92ZV9tb2RlbSgpPGJyPgovZGV2aWNlcy9wbGF0Zm9y
bS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4wL3R0eVVTQjAvdHR5L3R0eVVTQjA8
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQo
KSBzdWJzeXN0ZW0gdHR5PGJyPgpmaW5pc2hlZDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0
Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4wPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBy
ZW1vdmU8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnJlbW92
ZV9tb2RlbSgpPGJyPgovZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzIt
MS8yLTE6MS4xL3R0eVVTQjEvdHR5L3R0eVVTQjE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5PGJyPgpmaW5pc2hl
ZDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVf
ZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2Iy
LzItMS8yLTE6MS4xL3R0eVVTQjEvdHR5L3R0eVVTQjE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IHJlbW92ZTxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6cmVtb3ZlX21vZGVt
KCk8YnI+Ci9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMTox
LjIvdHR5VVNCMi90dHkvdHR5VVNCMjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHk8YnI+CmZpbmlzaGVkPGJyPgpv
Zm9ub2RbMzA5NDNdOiBVbnJlZ2lzdGVyUHJvZmlsZSgpIHJlcGxpZWQgYW4gZXJyb3I6PGJyPgpv
cmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5TcGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhlbHBl
ciBleGl0ZWQgd2l0aDxicj4KdW5rbm93biByZXR1cm4gY29kZSAxPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnJlbW92ZV9kZXZpY2UoKTxicj4KL3N5cy9k
ZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjE8YnI+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJz
eXN0ZW0gbmV0IHJlbW92ZTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91
ZGV2LmM6cmVtb3ZlX21vZGVtKCk8YnI+Ci9kZXZpY2VzL3ZpcnR1YWwvbmV0L3BwcDA8YnI+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJz
eXN0ZW0gbmV0PGJyPgpmaW5pc2hlZDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90
YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4yL3R0eVVTQjIvdHR5L3R0eVVTQjI8YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6cmVtb3ZlX2Rldmlj
ZSgpPGJyPgovc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEv
Mi0xOjEuMjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpy
ZW1vdmVfZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2Qt
MS91c2IyLzItMTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcu
YzpyZW1vdmVfZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy92aXJ0dWFsL25ldC9wcHAwPGJyPgpv
Zm9ub2RbMzA5NDNdOiBVbnJlZ2lzdGVyUHJvZmlsZSgpIHJlcGxpZWQgYW4gZXJyb3I6PGJyPgpv
cmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5TcGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhlbHBl
ciBleGl0ZWQgd2l0aDxicj4KdW5rbm93biByZXR1cm4gY29kZSAxPGJyPgo8YnI+Cjxicj4KPGJy
Pgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4K
PGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdp
bnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYjxicj4KWzEyZDE6MWYwMV08YnI+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2Rldmlj
ZSgpIHVzYjxicj4KWyhudWxsKToobnVsbCldPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXZuZy5jOnJlbW92ZV9kZXZpY2UoKTxicj4KL3N5cy9kZXZpY2VzL3BsYXRm
b3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjA8YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6cmVtb3ZlX2RldmljZSgpPGJyPgovc3lzL2Rl
dmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8YnI+Cm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfbW9kZW1fbGlzdCgpPGJyPgpv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZp
Y2UoKSB1c2I8YnI+ClsxMmQxOjEwMDFdPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb248YnI+ClsobnVsbCk6KG51
bGwpXTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVj
a191c2JfZGV2aWNlKCkgb3B0aW9uPGJyPgpbKG51bGwpOihudWxsKV08YnI+Cm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlv
bjxicj4KWyhudWxsKToobnVsbCldPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVn
aW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBhZGQ8YnI+Cm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5
PGJyPgpmaW5pc2hlZDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2
bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uPGJyPgpbMTJkMToxMDAxXTxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCk8YnI+Ci9z
eXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCk8YnI+Ci9z
eXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4xL3R0
eVVTQjEvdHR5L3R0eVVTQjE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMv
dWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMTxicj4KKGh1YXdlaSkgMjU1LzI1NS8y
NTUgWzAxXSA9PSZndDsgKG51bGwpIChudWxsKTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uPGJyPgpbMTJkMTox
MDAxXTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRf
ZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2Iy
LzItMTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRf
ZGV2aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2Iy
LzItMS8yLTE6MS4wL3R0eVVTQjAvdHR5L3R0eVVTQjA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMDxicj4KKGh1
YXdlaSkgMjU1LzI1NS8yNTUgWzAwXSA9PSZndDsgKG51bGwpIChudWxsKTxicj4Kb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0
dHkgYWRkPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzp1ZGV2
X2V2ZW50KCkgc3Vic3lzdGVtIHR0eTxicj4KZmluaXNoZWQ8YnI+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4K
WzEyZDE6MTAwMV08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5n
LmM6YWRkX2RldmljZSgpPGJyPgovc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNk
LTEvdXNiMi8yLTE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5n
LmM6YWRkX2RldmljZSgpPGJyPgovc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNk
LTEvdXNiMi8yLTEvMi0xOjEuMi90dHlVU0IyL3R0eS90dHlVU0IyPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjI8
YnI+CihodWF3ZWkpIDI1NS8yNTUvMjU1IFswMl0gPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJz
eXN0ZW0gdHR5IGFkZDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2
LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHk8YnI+CmZpbmlzaGVkPGJyPgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX21vZGVtX2xpc3QoKTxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjcmVhdGVfbW9kZW0o
KTxicj4KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xPGJy
PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNyZWF0ZV9tb2Rl
bSgpIGRyaXZlcj1odWF3ZWk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IChudWxsKSw8YnI+CnR5cGU6IGh1YXdlaTxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3
ZWkoKTxicj4KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0x
PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1
YXdlaSgpIC9kZXYvdHR5VVNCMDxicj4KMjU1LzI1NS8yNTUgMDAgKG51bGwpPGJyPgpvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIC9kZXYv
dHR5VVNCMTxicj4KMjU1LzI1NS8yNTUgMDEgKG51bGwpPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIC9kZXYvdHR5VVNCMjxicj4K
MjU1LzI1NS8yNTUgMDIgKG51bGwpPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVn
aW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIG1kbT0vZGV2L3R0eVVTQjA8YnI+CnBjdWk9L2Rl
di90dHlVU0IyIGRpYWc9KG51bGwpIHFtaT0obnVsbCkgbmV0PShudWxsKTxicj4Kb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08
YnI+CjB4NTU2ZGQyODAgcHJvcGVydHkgRGV2aWNlPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KMHg1NTZkZDI4
MCBwcm9wZXJ0eSBNb2RlbTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVt
LmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08YnI+CjB4NTU2ZGQyODAgcHJvcGVydHkgUGN1
aTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3By
b3BlcnR5KCkgbW9kZW08YnI+CjB4NTU2ZGQyODAgcHJvcGVydHkgRGlhZzxicj4Kb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08
YnI+CjB4NTU2ZGQyODAgcHJvcGVydHkgTmV0d29ya0ludGVyZmFjZTxicj4Kb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fcmVnaXN0ZXIoKSAweDU1NmRk
MjgwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdl
aV9wcm9iZSgpIDB4NTU2ZGQyODA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9t
b2RlbS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDU1NmRkMjgwPGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpjYWxsX21vZGVtd2F0Y2hlcygpIDB4NTU2ZGQyODA8YnI+
CmFkZGVkOjE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaGZwX2FnX2Js
dWV6NS5jOm1vZGVtX3dhdGNoKCkgbW9kZW06PGJyPgoweDU1NmRkMjgwLCBhZGRlZDogMTxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9kdW5fZ3dfYmx1ZXo1LmM6bW9kZW1f
d2F0Y2goKSBtb2RlbTo8YnI+CjB4NTU2ZGQyODAsIGFkZGVkOiAxPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOm1vZGVtX3dhdGNoKCkgbW9k
ZW06PGJyPgoweDU1NmRkMjgwLCBhZGRlZDogMTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOm1vZGVtX3dhdGNoKCkgbW9kZW06PGJyPgow
eDU1NmRkMjgwLCBhZGRlZDogMTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy9odWF3ZWkuYzpodWF3ZWlfZW5hYmxlKCkgMHg1NTZkZDI4MDxicj4Kb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08YnI+CjB4
NTU2ZGQyODAgcHJvcGVydHkgTW9kZW08YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Bs
dWdpbnMvaHVhd2VpLmM6b3Blbl9kZXZpY2UoKSBNb2RlbSAvZGV2L3R0eVVTQjA8YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1v
ZGVtPGJyPgoweDU1NmRkMjgwIHByb3BlcnR5IFBjdWk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6b3Blbl9kZXZpY2UoKSBQY3VpIC9kZXYvdHR5VVNCMjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVEUwICtDTUVFPTFccjxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUSVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5NYW51ZmFjdHVyZXI6IGh1
YXdlaVxyXG5Nb2RlbDogRTMwM1xyXG5SZXZpc2lvbjo8YnI+CjIyLjMxOC4wNS4wMC4wMFxyXG5J
TUVJOiA4NjI1NjYwMjAwMDU2OTdcclxuK0dDQVA6PGJyPgorQ0dTTSwrRFMsK0VTXHJcblxyXG5P
S1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReUkZTV0lUQ0g9P1xyPGJyPgpv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5FUlJPUlxyXG48YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ0ZVTj0xXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpj
ZnVuX2VuYWJsZSgpPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0lORk9ccjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXlNZU0lORk86MiwzLDAsNSwxLDAsNFxy
XG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdl
aS5jOnN5c2luZm9fZW5hYmxlX2NiKCkgMjU1IC0mZ3Q7IDE8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQmYW1wO0MwXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9L
XHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU0NTPSZxdW90O0dTTSZxdW90
O1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZndDsgQVReVTJESUFHP1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG5eVTJESUFHOiAxMTlcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVF5HRVRQT1JUTU9ERVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5eR0VUUE9SVE1PREU6IFRZUEU6IFdDRE1BOiBodWF3ZWksXHJcblxyXG5PS1xyXG48YnI+Cm9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVReVVNTRE1PREU9P1xyPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG5eVVNTRE1PREU6ICgwLTEpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVReRElBTE1PREU9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG5eRElBTE1PREU6ICgwLTIpLCgwLTI1NSlcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5DVk9JQ0U9P1xyPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG5eQ1ZPSUNFOiAoMClcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDRlVOPTVccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuT0tcclxuXHJcbl5TUlZTVDogMFxyXG5cclxuXk1PREU6IDAsMFxyXG48YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6Y2Z1bl9vZmZsaW5lKCk8YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0
ZSgpIG9sZCBzdGF0ZTogMCw8YnI+Cm5ldyBzdGF0ZTogMTxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcHJlX3NpbSgpIDB4NTU2ZGQyODA8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReVVNTRE1PREU/XHI8YnI+Cm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg1
NTZlNzYyODxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3Np
bV9hZGRfc3RhdGVfd2F0Y2goKSAweDU1NmU3NjI4PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZTc2Mjg8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5VU1NETU9ERTogMVxyXG5cclxuT0tcclxu
PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkRJQUxNT0RFP1xyPGJyPgpvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eRElBTE1PREU6MywyXHJcblxyXG5PS1xyXG48YnI+Cm9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVReQ1ZPSUNFP1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG5eQ1ZPSUNFOiAxLCA4MDAwLCAxNiwgMjBcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogVm9pY2UgY2hhbm5lbDogODAwMCBIeiwgMTYgYml0cywgMjBtcyBwZXJp
b2Q8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrR0NBUFxyPGJyPgpvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rR0NBUDogK0NHU00sK0RTLCtFU1xyXG5cclxuT0tcclxuPGJy
PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDEyMjU4LDAsMCwyNTVccjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDs2
MjFDODIwMjQxMjE4MzAyMkZFMkE1MDM4MDAxNzE4QTAxMDU4QjAzMkYwNjAzODAwMjAwMEE4ODAx
MTAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgpjcnNtX2luZm9fY2I6IDkw
LCAwMCwgMzA8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReRERTRVRFWD0/XHI8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5ERFNFVEVYOiAoMilcclxuXHJcbk9LXHJc
bjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR01JXHI8YnI+Cm9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbmh1YXdlaVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2LDEyMjU4LDAsMCwxMFxyPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7OTg1MzAzMDUwMTA3MDg1MzA1RjYm
cXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAw
MCwgMTA8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19v
cF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLDxicj4KZGF0YW9mZjogMCwgdG9jb3B5OiAxMDxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR01NXHI8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbkUzMDNcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVCtDUlNNPTE5MiwyODQyMSwwLDAsMjU1XHI8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGMDVB
NTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNDgwMDIwMDBBODgwMTEwJnF1b3Q7XHJcblxyXG5PS1xy
XG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9jcnNtX2luZm9fY2IoKTxicj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPGJyPgpvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHTVJccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuMjIuMzE4LjA1LjAwLjAwXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg0MjEsMCwwLDEwXHI8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs2NTZFRkZGRkZGRkZGRkZGRkZGRiZxdW90
O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAx
MDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3Jl
YWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJyPgpkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPGJyPgpv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHU05ccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuODYyNTY2MDIwMDA1Njk3XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0
M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMTIwMzcsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgz
MDIyRjA1QTUwMzgwMDE3MThBMDEwNThCMDMyRjA2MDQ4MDAyMDAwQTg4MDEyOCZxdW90O1xyXG5c
clxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAzMDxicj4K
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwxMjAzNywwLDAsMTBccjxicj4K
b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzY1NkVGRkZG
RkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDEwPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2lt
ZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCw8YnI+CmRhdGFvZmY6IDAs
IHRvY29weTogMTA8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1BJTj9ccjxicj4K
b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NQSU46IFJFQURZXHJcblxyXG5PS1xyXG48
YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cGluX2NiKCkgY3JzbV9waW5fY2I6PGJyPgpSRUFEWTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X3Bpbl9yZXRyaWVzX3F1ZXJ5KCk8YnI+Cm9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVReQ1BJTj9ccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuXkNQSU46IFJFQURZLCwxMCwzLDEwLDNcclxuXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGlu
X2NiKCkgcmV0cnk8YnI+CmNvdW50ZXIgaWQ9OSwgdmFsPTEwPGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxi
cj4KY291bnRlciBpZD0xLCB2YWw9Mzxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnk8YnI+CmNvdW50ZXIgaWQ9
MTEsIHZhbD0xMDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnk8YnI+CmNvdW50ZXIgaWQ9NCwgdmFsPTM8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1OTAsMCwwLDI1NVxyPGJy
PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTA2LDEzMCwmcXVvdDsmcXVv
dDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5
MiwyODU4OSwwLDAsMjU1XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNN
Ojxicj4KMTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGQURBNTAzODAwMTcxOEEwMTA1OEIw
MzZGMDYwNjgwMDIwMDA0ODgwMTE4JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKTxi
cj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc2LDI4NTg5LDAsMCw0XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCA0PGJyPgpvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjog
MCw8YnI+CmRhdGFvZmY6IDAsIHRvY29weTogNDxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0
OyBBVCtDUlNNPTE5MiwyODQzOCwwLDAsMjU1XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDcyLDAsMCwyNTVccjxicj4Kb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDs2MjFDODIw
MjQxMjE4MzAyNkYzOEE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjAyODAwMjAwMEE4ODAxMjAmcXVv
dDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgpjcnNtX2luZm9fY2I6IDkwLCAwMCwg
MzA8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg0NzIsMCwwLDEw
XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDs3
RUVFMTExQzI3RjY1OTAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+
CmNyc21fcmVhZF9jYjogOTAsIDAwLCAxMDxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJyPgpkYXRh
b2ZmOiAwLCB0b2NvcHk6IDEwPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTkyLDI4NTAyLDAsMCwyNTVccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NS
U006PGJyPgoxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyNkY1NkE1MDM4MDAxNzE4QTAxMDU4
QjAzNkYwNjA3ODAwMjAwMDE4ODAxMjgmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigp
PGJyPgpjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ1JTTT0xNzYsMjg1MDIsMCwwLDFccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRf
Y2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLDxi
cj4KZGF0YW9mZjogMCwgdG9jb3B5OiAxPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NJTUlccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuMjcyMDUwMTAwNDEzNTgw
XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRt
b2RlbS9zaW0uYzphdF9jaW1pX2NiKCkgY2ltaV9jYjo8YnI+CjI3MjA1MDEwMDQxMzU4MDxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRl
KCkgb2xkIHN0YXRlOiAxLDxicj4KbmV3IHN0YXRlOiAyPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wb3N0X3NpbSgpIDB4NTU2ZGQyODA8YnI+
Cm9mb25vZFszMDk0M106PGJyPgovb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250
ZXh0LmM6YXRfZ3Byc19jb250ZXh0X3Byb2JlKCk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtPGJyPgoweDU1NmRkMjgw
IHByb3BlcnR5IEFsd2F5c09ubGluZTxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
UkM9MVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0xJUD0xXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6
ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDT0xQPTFc
cjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3By
b3BlcnR5KCkgbW9kZW08YnI+CjB4NTU2ZGQyODAgcHJvcGVydHkgQWx3YXlzT25saW5lPGJyPgpv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9zZXRfb25s
aW5lKCkgbW9kZW08YnI+CjB4NTU2ZGQyODAgb25saW5lPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0NXQT0x
XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMw
OTQzXTo8YnI+Ci9vZm9uby0xLjE0L2RyaXZlcnMvaHVhd2VpbW9kZW0vdm9pY2VjYWxsLmM6aHVh
d2VpX3ZvaWNlY2FsbF9pbml0aWFsaXplZCgpPGJyPgpyZWdpc3RlcmluZyB0byBub3RpZmljYXRp
b25zPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2Fk
ZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZTc2Mjg8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3BsdWdpbnMvYmx1ZXo1LmM6YnRfcmVnaXN0ZXJfcHJvZmlsZSgpPGJyPgpCbHVldG9vdGg6IFJl
Z2lzdGVyaW5nIDAwMDAxMTFmLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiAoaGZwX2FnKSBw
cm9maWxlPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkNWT0lDRT0/XHI8YnI+Cm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5DVk9JQ0U6ICgwKVxyXG5cclxuT0tcclxuPGJy
PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ1M9P1xyPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1NDUzogKCZxdW90O0lSQSZxdW90OywmcXVvdDtVQ1MyJnF1b3Q7
LCZxdW90O0dTTSZxdW90OylcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVF5TWVNDRkc9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eU1lT
Q0ZHOjxicj4KKDIsMTMsMTQsMTYpLCgwLTMpLCgoMjAwMDAwMDQwMDM4MCwmcXVvdDtHU005MDAv
R1NNMTgwMC9XQ0RNQTkwMC9XQ0RNQTIxMDAmcXVvdDspLCgyODAwMDAsJnF1b3Q7R1NNODUwL0dT
TTE5MDAmcXVvdDspLCgzZmZmZmZmZiwmcXVvdDtBbGw8YnI+CmJhbmRzJnF1b3Q7KSksKDAtMiks
KDAtNClcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU01T
PT9ccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NTTVM6ICgwLDEpXHJcblxy
XG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
bXMuYzphdF9jc21zX3F1ZXJ5X2NiKCkgQ1NNUzxicj4KcXVlcnkgcGFyc2VkIHN1Y2Nlc3NmdWxs
eTxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR0RDT05UPT9ccjxicj4Kb2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NHRENPTlQ6PGJyPgooMS0xMSksJnF1b3Q7SVAmcXVv
dDssLCwoMC0yKSwoMC0zKSwoMCwxKSwoMCwxKVxyXG4rQ0dEQ09OVDo8YnI+CigxLTExKSwmcXVv
dDtQUFAmcXVvdDssLCwoMC0yKSwoMC0zKSwoMCwxKSwoMCwxKVxyXG5cclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQ4MCwwLDAsMjU1XHI8
YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7
NjIxRTgyMDU0MjIxMDAyMjA2ODMwMjZGNDBBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgwMDIw
MENDODgwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19j
YjogOTAsIDAwLCAzMjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDRlVOPTFccjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUmVnaXN0ZXJQcm9maWxlKCkgcmVwbGllZCBhbiBlcnJvcjo8YnI+
Cm9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLlNwYXduLkNoaWxkRXhpdGVkLCBMYXVuY2ggaGVs
cGVyIGV4aXRlZCB3aXRoPGJyPgp1bmtub3duIHJldHVybiBjb2RlIDE8YnI+Cm9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbl5TSU1TVDowLDBcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOnNpbXN0X25vdGlmeSgpIDEgLSZndDsgMDxicj4Kb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuXHJcbl5TSU1TVDoxLDBcclxuPGJyPgpv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOnNpbXN0X25vdGlmeSgp
IDAgLSZndDsgMTxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUEJTPT9ccjxicj4K
b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NQQlM6ICgmcXVvdDtTTSZxdW90OywmcXVv
dDtFTiZxdW90OywmcXVvdDtPTiZxdW90OywmcXVvdDtGRCZxdW90OylcclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU01TPTFccjxicj4Kb2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NTTVM6IDEsMSwxXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZndDsgQVQrQ0dSRUc9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ0dSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsMSw0LDM0XHI8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NEQ3OTIwNEU3NTZENjI2NTcyRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRjA3OTE1MzgzMTM5Nzc4NDhGRkZGRkZGRkZGRkYmcXVvdDtcclxu
XHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+
Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReU1lTSU5GT1xyPGJyPgpvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG5eU1lTSU5GTzowLDMsMCwwLDEsMCwwXHJcblxyXG5PS1xyXG48YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c3lzaW5mb19vbmxp
bmVfY2IoKSAxIC0mZ3Q7IDE8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMiw8YnI+Cm5ldyBzdGF0ZTogMzxi
cj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcG9z
dF9vbmxpbmUoKSAweDU1NmRkMjgwPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NT
TVM/XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU01TOiAxLDEsMSwxXHJc
blxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dSRUc9MlxyPGJy
PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ0dBVVRPPTBccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHRVJFUD0yLDFccjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuRVJST1JcclxuPGJyPgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2JsdWV6NS5jOmJ0X3JlZ2lzdGVyX3Byb2ZpbGUoKTxi
cj4KQmx1ZXRvb3RoOiBSZWdpc3RlcmluZyAwMDAwMTEwMy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIgKGR1bl9ndykgcHJvZmlsZTxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
UlNNPTE3OCwyODQ4MCwyLDQsMzRccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
K0NSU006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJy
PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Jz
bV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4Kb2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDUkVHPT9ccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuK0NSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ1NDQj0/XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU0NCOigw
LDEpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1VTRD0x
XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMw
OTQzXTogUmVnaXN0ZXJQcm9maWxlKCkgcmVwbGllZCBhbiBlcnJvcjo8YnI+Cm9yZy5mcmVlZGVz
a3RvcC5EQnVzLkVycm9yLlNwYXduLkNoaWxkRXhpdGVkLCBMYXVuY2ggaGVscGVyIGV4aXRlZCB3
aXRoPGJyPgp1bmtub3duIHJldHVybiBjb2RlIDE8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ01HRj0/XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDTUdGOiAo
MCwxKVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTc4LDI4NDgwLDMsNCwzNFxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTo8YnI+CjE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3Jl
YWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgpvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUK0NSRUc9MlxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5P
S1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1f
YWRkX3Nwbl93YXRjaCgpIDB4NTU2ZTc2Mjg8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpPGJyPgoweDU1
NmU3MGQ4PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9MFxyPGJyPgpvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eTU9ERTogNSw0XHJcbjxicj4Kb2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvY2JzLmM6Y2JzX2dvdF9pbXNpKCkgR290IElNU0k6PGJyPgoyNzIwNTAxMDA0MTM1ODA8YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdf
YWRkX3N0YXR1c193YXRjaCgpPGJyPgoweDU1NmU3MGQ4PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmZ3Q7IEFUK0NQTVM9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BN
Uzo8YnI+CigmcXVvdDtTTSZxdW90OywmcXVvdDtNRSZxdW90OyksKCZxdW90O1NNJnF1b3Q7LCZx
dW90O01FJnF1b3Q7KSwoJnF1b3Q7U00mcXVvdDssJnF1b3Q7TUUmcXVvdDspXHJcblxyXG5PS1xy
XG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsNCw0LDM0
XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1
b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JF
Rz9ccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDIsMlxyXG5cclxu
T0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25v
X25ldHJlZ19zdGF0dXNfbm90aWZ5KCk8YnI+Ci9odWF3ZWlfMSBzdGF0dXMgMiB0ZWNoIC0xPGJy
PgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOmN1cnJlbnRfb3BlcmF0
b3JfY2FsbGJhY2soKTxicj4KMHg1NTZlNzBkOCwgKG5pbCk8YnI+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9jYnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDIsIC0xLCAtMSwgLTEs
PGJyPgoobnVsbCkobnVsbCk8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0
OyBBVCtDTUdGPTBccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJy
PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgwLDUsNCwzNFxyPGJy
PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90O0ZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFk
X2NiOiA5MCwgMDAsIDM0PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NQTVM9JnF1
b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDtccjxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NQTVM6IDAsMjAsMCwyMCwwLDIwXHJcblxyXG5PS1xyXG5c
clxuXlJTU0k6PGJyPgoxM1xyXG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDssNDAsMzQsNTNc
clxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgwLDYsNCwz
NFxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZx
dW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3Jz
bV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NO
TUk9P1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ05NSTo8YnI+CigwLTIp
LCgwLTMpLCgwLDIpLCgwLTIpLCgwLDEpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zbXMuYzpidWlsZF9jbm1pX3N0cmluZygpPGJy
PgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NOTUk9MSwxLDIsMSwwXHI8YnI+Cm9mb25v
ZFszMDk0M106IER1cGxpY2F0ZSBFRnNkbiBlbnRyaWVzIGZvciBgRW1lcmdlbmN5IFNlcnZpY2Vz
JiMzOTs8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3Rh
dHVzX3dhdGNoKCk8YnI+CjB4NTU2ZTcwZDg8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9zbXMuYzpzbXNfcmVzdG9yZV90eF9xdWV1ZSgpPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6c21zX3dhdGNoKCk8YnI+CnJlZ2lz
dGVyZWQ8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvc21hcnQtbWVzc2Fn
aW5nLmM6c21zX3dhdGNoKCkgcmVnaXN0ZXJlZDxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0
OyBBVCtDUlNNPTE5MiwyODYxOCwwLDAsMjU1XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAwNjA1ODMwMjZGQ0FB
NTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgwMDIwMDFFODgwMCZxdW90O1xyXG5cclxuT0tcclxu
PGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAzMjxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDTUdMPTRccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vc21zLmM6YXRfY21nbF9kb25lKCk8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q0dTTVM9M1xyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMSw0LDZccjxicj4Kb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAw
MCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAs
IDAwLCA2PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE4LDIs
NCw2XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVv
dDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgNjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNN
PTE3OCwyODYxOCwzLDQsNlxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRf
Y2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDY8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsNCw0LDZccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAwMDAwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgpvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE4LDUsNCw2XHI8YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMDAwMDAmcXVv
dDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
Njxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxNywwLDAsMjU1
XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1
b3Q7NjIxRTgyMDU0MjIxMDAwNTA1ODMwMjZGQzlBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwMjgw
MDIwMDE5ODgwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5m
b19jYjogOTAsIDAwLCAzMjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3
OCwyODYxNywxLDQsNVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8
YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCA1PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc4LDI4NjE3LDIsNCw1XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNt
X3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsMyw0LDVccjxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJc
bk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Np
bS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNTxicj4Kb2Zv
bm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNyw0LDQsNVxyPGJyPgpvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZx
dW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAw
LCA1PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDUsNCw1
XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDsw
MTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFk
X2NiOiA5MCwgMDAsIDU8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIs
Mjg0MzMsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTog
MTA2LDEzMCwmcXVvdDsmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL21lc3NhZ2Utd2FpdGluZy5jOm13X2NwaHNfbXdpc19yZWFkX2NiKCkgTm88
YnI+CkNQSFMgTVdJUyBvbiBTSU08YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JT
TT0xOTIsMjg2MTksMCwwLDI1NVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMTAwNTgzMDI2RkNCQTUwMzgwMDE3
MThBMDEwNThCMDM2RjA2MDU4MDAyMDA1MDg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5m
b19jYigpPGJyPgpjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzI8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMSw0LDE2XHI8YnI+Cm9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3Jl
YWRfY2I6IDkwLCAwMCwgMTY8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0x
NzgsMjg2MTksMiw0LDE2XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNN
Ojxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8
YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMyw0LDE2XHI8
YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7
RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
cmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksNCw0LDE2XHI8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMTY8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JT
TT0xNzgsMjg2MTksNSw0LDE2XHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
UlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVv
dDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MTY8YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9y
ZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLDxicj4Kc2Vla29mZjogMzksIHRvcmVhZDogMTc8YnI+Cm9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2Nr
KCkgYnVmb2ZmOiAwLDxicj4Kc2Vla29mZjogMzksIHRvcmVhZDogMTA8YnI+Cm9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9jYnMuYzphdF9jYnNfc2V0X3RvcGljcygp
PGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9MFxyPGJyPgpvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ1NDQj0wLCZxdW90OzAsNTAsMjE0LDQzNTItNDM1NiZxdW90O1xyPGJyPgpvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ1JTTT0xOTIsMjg0MzcsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7
IFxyXG5eU1JWU1Q6IDJcclxuXHJcbitDR1JFRzo8YnI+CjEsJnF1b3Q7MDA0MCZxdW90OywmcXVv
dDswMkMxMDE3OCZxdW90O1xyXG5cclxuK0NSU006IDEwNiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxy
XG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9f
Z3Byc19zdGF0dXNfbm90aWZ5KCkgL2h1YXdlaV8xPGJyPgpzdGF0dXMgMTxicj4Kb2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxNSwwLDAsMjU1XHI8YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIx
MDAyMjA1ODMwMjZGQzdBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwMjgwMDIwMEFBODgwMCZxdW90
O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAz
Mjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwxLDQsMzRc
cjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVv
dDs0RDYxNjk2Q0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGMDc5MTUzODMzMzMzMTMx
N0ZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21f
cmVhZF9jYjogOTAsIDAwLCAzNDxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNN
PTE3OCwyODYxNSwyLDQsMzRccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NS
U006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwzLDQsMzRccjxicj4Kb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xy
XG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSw0LDQsMzRccjxi
cj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDtG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVh
ZF9jYjogOTAsIDAwLCAzNDxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3
OCwyODYxNSw1LDQsMzRccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006
PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFk
X2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4Kb2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuK0NSRUc6IDEsJnF1b3Q7MDA0MCZxdW90OywmcXVvdDswMkMxMDE3OCZxdW90
O1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9f
bmV0cmVnX3N0YXR1c19ub3RpZnkoKTxicj4KL2h1YXdlaV8xIHN0YXR1cyAxIHRlY2ggMjxicj4K
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2Vk
KCkgMSwgLTEsIC0xLCAyLDxicj4KKG51bGwpKG51bGwpPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDE8YnI+Cm9mb25vZFsz
MDk0M106IFBDVUk6ICZndDsgQVQrQ09QUz0zLDJccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM/XHI8
YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDT1BTOiAwLDIsJnF1b3Q7MjcyMDUm
cXVvdDssMlxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19udW1lcmljX2NiKCkg
Q29wczxicj4KbnVtZXJpYyBnb3QgbWNjOiAyNzIsIG1uYzogMDU8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1NRXHI8YnI+Cm9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
U1E6IDEzLDk5XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2Ry
aXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNzcV9jYigpPGJyPgpjc3FfY2I6
IDEzPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25l
dHJlZ19zdHJlbmd0aF9ub3RpZnkoKTxicj4Kc3RyZW5ndGggNDE8YnI+Cm9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ09QUz0zLDBccjxicj4Kb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM/XHI8YnI+Cm9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDT1BTOiAwLDAsJnF1b3Q7MyBJUkwmcXVvdDss
MlxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjb3BzX2NiKCk8YnI+CmNvcHNfY2I6IDMgSVJM
LCAyNzIgMDUgMjxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpj
dXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCk8YnI+CjB4NTU2ZTcwZDgsIChuaWwpPGJyPgpvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAx
LCAtMSwgLTEsIDIsPGJyPgoyNzIwNTxicj4Kb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3Jj
L2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMSwgMCwgMDxicj4Kb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAxPGJyPgpvZm9u
b2RbMzA5NDNdOjxicj4KL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5j
OmF0X2dwcnNfYWN0aXZhdGVfcHJpbWFyeSgpIGNpZCAxPGJyPgpvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvZ3Bycy5jOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIDB4NTU2ZWIwNzA8YnI+
Cm9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6cHJpX2FjdGl2YXRlX2NhbGxi
YWNrKCkgQWN0aXZhdGluZzxicj4KY29udGV4dCBmYWlsZWQgd2l0aCBlcnJvcjogVW5rbm93biBl
cnJvciB0eXBlPGJyPgotLS0tLS0tLS0tLS0tLSBuZXh0IHBhcnQgLS0tLS0tLS0tLS0tLS08YnI+
CkFuIEhUTUwgYXR0YWNobWVudCB3YXMgc2NydWJiZWQuLi48YnI+ClVSTDogJmx0OzxhIGhyZWY9
Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvcGlwZXJtYWlsL29mb25vL2F0dGFjaG1lbnRzLzIwMTQw
MzEwLzIxOTVhOGIwL2F0dGFjaG1lbnQuaHRtbCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0
cy5vZm9uby5vcmcvcGlwZXJtYWlsL29mb25vL2F0dGFjaG1lbnRzLzIwMTQwMzEwLzIxOTVhOGIw
L2F0dGFjaG1lbnQuaHRtbDwvYT4mZ3Q7PGJyPgo8YnI+Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj4KPGJyPgpTdWJqZWN0OiBEaWdlc3QgRm9vdGVyPGJyPgo8YnI+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5n
IGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9y
ZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGlu
Zm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL29mb25vPC9hPjxicj4KPGJyPgo8YnI+Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj4KPGJyPgpFbmQgb2Ygb2Zvbm8gRGlnZXN0LCBWb2wgNTksIElzc3VlIDc8YnI+
CioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKjxicj4KPC9ibG9ja3F1b3RlPjwv
ZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGRpdj48YnI+PC9kaXY+LS0gPGJyPjxkaXYgZGlyPSJs
dHIiPjxkaXY+SG9tYW0gRGFiaXMgfCBTb2Z0d2FyZSBDb25zdWx0YW50PC9kaXY+PGRpdj5tOiAr
MzUzIDg2IDg4MSA0MDE4PC9kaXY+PGRpdj5za3lwZTogaGRhYmlzMTwvZGl2PjxkaXY+PGltZyBz
cmM9ImNpZDo4MjFBNTUyNy02RjZDLTRFNDctQkQ1MC00MjQwRUE0NTYyODAiPjxicj4KPC9kaXY+
PGRpdj48YnI+PC9kaXY+PHNwYW4+PC9zcGFuPjxzcGFuPjwvc3Bhbj48YnI+PGRpdj48YnI+PC9k
aXY+PC9kaXY+CjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============1981288211012328880==
Content-Type: image/png
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="BAC7E76C-8B6C-463B-8B8E-8703BA6787AC6.png"

iVBORw0KGgoAAAANSUhEUgAAAMQAAAAyCAYAAAADbXRvAAAEJGlDQ1BJQ0MgUHJvZmlsZQAAOBGF
Vd9v21QUPolvUqQWPyBYR4eKxa9VU1u5GxqtxgZJk6XtShal6dgqJOQ6N4mpGwfb6baqT3uBNwb8
AUDZAw9IPCENBmJ72fbAtElThyqqSUh76MQPISbtBVXhu3ZiJ1PEXPX6yznfOec7517bRD1fabWa
GVWIlquunc8klZOnFpSeTYrSs9RLA9Sr6U4tkcvNEi7BFffO6+EdigjL7ZHu/k72I796i9zRiSJP
wG4VHX0Z+AxRzNRrtksUvwf7+Gm3BtzzHPDTNgQCqwKXfZwSeNHHJz1OIT8JjtAq6xWtCLwGPLzY
Zi+3YV8DGMiT4VVuG7oiZpGzrZJhcs/hL49xtzH/Dy6bdfTsXYNY+5yluWO4D4neK/ZUvok/17X0
HPBLsF+vuUlhfwX4j/rSfAJ4H1H0qZJ9dN7nR19frRTeBt4Fe9FwpwtN+2p1MXscGLHR9SXrmMgj
ONd1ZxKzpBeA71b4tNhj6JGoyFNp4GHgwUp9qplfmnFW5oTdy7NamcwCI49kv6fN5IAHgD+0rbyo
Bc3SOjczohbyS1drbq6pQdqumllRC/0ymTtej8gpbbuVwpQfyw66dqEZyxZKxtHpJn+tZnpnEdrY
BbueF9qQn93S7HQGGHnYP7w6L+YGHNtd1FJitqPAR+hERCNOFi1i1alKO6RQnjKUxL1GNjwlMsiE
hcPLYTEiT9ISbN15OY/jx4SMshe9LaJRpTvHr3C/ybFYP1PZAfwfYrPsMBtnE6SwN9ib7AhLwTrB
DgUKcm06FSrTfSj187xPdVQWOk5Q8vxAfSiIUc7Z7xr6zY/+hpqwSyv0I0/QMTRb7RMgBxNodTfS
Pqdraz/sDjzKBrv4zu2+a2t0/HHzjd2Lbcc2sG7GtsL42K+xLfxtUgI7YHqKlqHK8HbCCXgjHT1c
AdMlDetv4FnQ2lLasaOl6vmB0CMmwT/IPszSueHQqv6i/qluqF+oF9TfO2qEGTumJH0qfSv9KH0n
fS/9TIp0Wboi/SRdlb6RLgU5u++9nyXYe69fYRPdil1o1WufNSdTTsp75BfllPy8/LI8G7AUuV8e
k6fkvfDsCfbNDP0dvRh0CrNqTbV7LfEEGDQPJQadBtfGVMWEq3QWWdufk6ZSNsjG2PQjp3ZcnOWW
ing6noonSInvi0/Ex+IzAreevPhe+CawpgP1/pMTMDo64G0sTCXIM+KdOnFWRfQKdJvQzV1+Bt8O
okmrdtY2yhVX2a+qrykJfMq4Ml3VR4cVzTQVz+UoNne4vcKLoyS+gyKO6EHe+75Fdt0Mbe5bRIf/
wjvrVmhbqBN97RD1vxrahvBOfOYzoosH9bq94uejSOQGkVM6sN/7HelL4t10t9F4gPdVzydEOx83
Gv+uNxo7XyL/FtFl8z9ZAHF4bBsrEwAAHG1JREFUeAHtXQl8VcXVn7n3viVkBSpVEAVREFmSAGqt
tkCtRSEJ0LohfoJI0Vq1LlCx9ZNitWhBaPX7KggIpRVbqkIWEbUSlkpFkSSAG6KASFFEISGQ9959
907/5+Ytd3vJI2QhgfkR7syZM2e2c2bmnFkeF0KwxnR86FCFrRmiCzFNr4su59OllP4bO9dU1RwQ
O0sDdeE2VVysDFrafrFtWaip8mkJunzA8NO8QpmE/h2O/HtzxtpTOQTjh7gQnwrON3Gu/zOkqytF
xatHWqKMJ2KeaJvGFYiU3NHddD28knN+d6C86DW3SnsGFAyWNLGEcXYWY7wGODOD5UXT3HCbCubP
yRsmmLQILHJGpAwPowyPNVV+zUnX37/gKp2Lv3LOOtSXL3r/iODSMLWs8M36cE+GeKlJKslZb8HE
q/7sgsl2+jx7WCrX2Iu1wkCxIgV/D/n6F9xgx22qMO+f114X0gu1whArwwx/dl5BU+XZXHT9/Yb3
0CXxQjLCQGXCzOELy0e3NVf5TvR8mkYgIrUWXMz05eSPNjeCInmyORcdzTDDL4kfOmBNBPAzNhBl
SLOT1zm/wg5rbWFdku8Hk7ezl5tmAsB2Y81kWZ5iCVUqNr1eacc/WcNK01ecz+bXXlskli3TKC9F
l/ZhOndmK9gBJ7BpIDoTXxpjo408GAnw1u0wM5DOEHeYqvHv52qHI/NFaWmY9CZv9ru9sVYeDmG4
kTF9eRy5+XwZk585X9ak0805HpwzcY053BL+ZhAI0U35MHgpKreOKlhTUbTTm50/Hx3301iFBd8j
c/HHWLiJPcEtL2/1ZRc8z7gYE8+K7whJ4XnxcOvz8e9em+JlrIul5JyVhMpLno7CIsaO9xCmv5kY
rORoHH29Ofl3YBY5NwrDEmJvoKJ4ZjTcWF+uy1N1iY2z0cOY1LKuGQSCMVkSA1FNQyCouuqWklvR
8CvR8LkYvr5UJXmpKFt+qDmbIrRl4I3e7M2kR2QLoX+hegJLW/vSIeVoTQdjGrY0JC+3BG2B6Mwd
Awt2NQarwdEw5vIK+BtdIKL0T7RvswgEGrW9ueKwbAHEVkT+zFHN5o+MlC8hQ/prE05wxcNE2FoX
SLsVcCpUVwtgRmwGd6pTmqGRT2XRGC3QPALRGCU9ReNUCzRDC5wSiGZo5FNZtJ4WOC4dgg8a5BGb
Nqmtp7qNU1Le+8cdfb5gR6zOfZLCqgKh1H1t7ehH47SUlUr7exZnwaTSTeM8HYo7TK5Wo1LG5IWj
rCkSh7y6+s6B2bftTYxRf0zmvQtpJ/8iHGPxVj0xoYhSJC0Q3twROTCVXQ2b9sVI1w8V6uhlZyjY
eCND9zc4qrEbFptyxvknRLgu580uuAVNkW/GCbHg2PrO1PDzR6Z7fPposoIIwS/A91vIk8yGlUzw
L9C+FdhwWxeU971en6C6lSFYUZSwQ2AVuwhWsZ+insO9PtEZxz4Y/dOhsnqVGg3t8AnaYZ3EeWFQ
+c+r9eVPdfcOyM/mutEOoM0vEGhTzkQa9geq0T4HkN97MA1vQgOvCFaUJNxNRt4zQK4TGOzbRNfi
OL8eJuYcCywSEEybEap4eaMvt2AU09mlyD8dUeebcWH96I70K8wwsz/EcF6q4qX9Zlgivy6F70aj
TbOKQRwb21NJ74moXPl/pLwjnjp5X8YdSzpynzoLKcaCZzxo81XwJycQ1GlorD9wJg1B59hkGmTg
wJiQNEHSlkvSUb8T/UBopAWPt/NYwqYA73ut16sEpnp8bArySqMoML4JgwBG+Epkf78n3Hk/OvGP
Ic0/K/HI7VIGK0UjxPte2cGreP6ETryutvK2fGvTkFD2RNl6YsCY6FU7/w7hX9dGOf/3Zo+4mHFp
FmheFos1tS06KAvwLOR3Lr4jUdnfYu9mLZP4lFBZ0TuxNBEPeuVnSJOJPrBHISx6gU4vlwiQlRcb
cJ2NQvuNMxjVxq0IZiDO2lcmYn4uwOQt4fgYftdT94kn7wweS+6Ypbpxn7YaabrX9idaiLPY/lOd
OoQ3O28c1/nbaJQhx5JpY+IapzaVmvUo9nS34xZueYE5OqETH/XKgTcpvRtOMjCe/eNOEIa3gHtd
MvhRHLBlcdRv//py83/JmbwBbRoXBjuSSxjCNhi7y//G+bAWYkCXQrUsqEOmJzXvWIrAb33GI3iY
ZqHu0XQYhz4//FlGrL8SLpl82XnXY3mw2H3UiZJr2q+x86rJqyDJAxqUExeDvJr8Cj9v+KXi45XH
NJJQfl6mzsfnPJe892JU/gizIY4/sdMwMJ+PMvoMPOy6q1uKN7qkYVia/Bq4j0RmMzeU+mAyzofN
8Wfne5pi97i+zI83XtLZGp2zLLRZOmbSwZjWe1hoClFoCZsC4MUMDDRDTSA0vxiH8ItmWF3+zFTl
FrRfjhkHNOeLZdfE9jNdBaJdv1FdhSTNx0hrTosQx1pdLMa08obQxQ5J8dRoPJwpCakTCjcQCN+H
AP0gxhyW1Mce8BwNPOoqDIJvAfxFLOV2YB0fhlKUhXL1RHmvRC59LDlxNtDXTrkTMFozJu18A0Zd
gDwsp1+ht3wtSXxMoKzwdTMhugOifJ12IeJGYhbbj7awNhyQjSPvQjxiTkd+ogkBeY4Lvg6JdjJJ
05kuS1zSeyDu+2jTG8BAtByNOfTDY57ckRuiR7ZVpeZsv+7NCutyV4kJzKZxB9x5jGtz45C4T5VD
Oykka+yhsMznovzpkPE5AJnakO9CO9wTT2X1BWQtKf2BUkXOKq0hPxTaxaBrEYjK2RNHUZyb49On
KxmVXT7DOu+MWDwXV6VPmdvp8MzbkioDhMFaDyhRYQ9fEKMHj6tAaLL+MJjLWKtHkdGwG1UpnC82
r/wqCrN9iUkeMxhJ1+iczHE5OsbMZZkYOe4E17Heuz1UURRb88UjMd5wPsWTnTcezLUATBZbDqIh
bgfeMQmE0LXvY1ljdUI8ECgrsggDIdChOXz+HfkjkMWhXBzLz/+zACkgeKGaEr5JvLWyyhHH2GbA
/sEHXfGgV/UvBfMMj+GgbpIQRC+XYJEjJ5W4i4IGoqLEHZZZXwTLXy6PQ5y+o9uKPgOU/hh0lQMQ
QJMTlcGy4hUmQIt4xbRpYQjRQmT+YLwAXJF0ha4N/CEOc/dl3LPwUi6xnuZYVLPwyOMT/mOGxZgm
CiQlEv6x0TB9IQz71aAyog5hiKFLgh+NBY7Do8syMbFVYDl7JFTuLgyUFY3MofLiRRCGxRQ2ue4p
A0acbQrX64VQdbUjYfQnpj9m58vOvwKJ+loSCvYulP5rEwhDDJWYPaSljIbwbIkBaz05ntz8ITZY
mw5KElsAZrTMvpzx8clUWuLiZgeeJBwzp0MgPIoHFgVhsfhgNJolPnjpawfBJgSAIa8xk4dQHgop
7HEzLJEfuG/b48Jh5ZgEAm0QstNA43e3w5IJowdvtOOh4e9PbAGzYhMelL+pVihmREHHt08ed3DW
LbtR21XmGqNts9vf92y2GWb3nz7lL6mA2Qwj4pPKJyb+047rEAg08mA7kixLz9lhTRk2RnMuLCM0
prcVYlNRcrMPZ04FWsZh42NzjmUflmuzGmS1EmyILevPA1tKyPSXtAtuHfgqNBPLfQ0IyZCkCbQR
RCyEn7FXBRf4x9lh5nCNHvwJ9Ey7CjAX7Ql5sjonk3DW34rCdh/ZXGhZZ9niGz2oh+UcO1GU3dVy
Y8drrHCIhV4xFF4rwZ5eXX4H110xiybnDAGyCTdSrnVTvOuiSKdzoYqsteBw0YOuw1pgbTxwOP3z
EqyN91mqycVYUrotMFMAA8cEU5C8IRgaFttgRtAhEGA8y8iM5ccnbgmbFMbFBXb6uAi/1Q5ryrCx
ay6xyS55nM0ksQLK5wa6zE8KswtODOTR+DmxQMwjPop5j8Uj2Md2dA+XutthbTlMyjUWiwutdeSd
0qs6k4XR4bJ++UwPzA72Vc+yqlmTDjiQAXAIBHr3W2ZEWJsqzeFm8XPsjtocjkQctIGaPIhd4cXI
xGEqpYwhBpcISayE9Wgzjk5cR1czCW53XMin22EYZBpUF/SNoxMlxnFk4+Rybsq1xKTxbq0gwrID
jjNoc91wCebaiRZkwd1MghaUxg5gqeIQCFkLNXs5qF7B8uL/BfOPgAi8n6CetLz7mzd70xZ/bh7w
bE6KbNhZwNjPaYDDXXRHOgilvwGkWnWSBMp1ftYDT1uWj1hGYRy1XlPFoLKtas4tbyZqgPoFgrdA
g3ObuTVR6ZsJHigrXhmqGNgPI/tNUMM+TZBtHwhyiTenYJ79nnIC/AaAodafckYLuCjXXhH0jjE3
T+bhLpdDa7aqAII9bcax+x0CgU6ttiAJnmkJN0tAWMuAPDWutEA54pUlpRZ7IH/BnkBvKMS3QzC+
iMfGfVhiTvJsD8TNw7qLxcs4iBdPk6wPywJHG+CsWSDZ9G0Jz1Cuma0PbLMBDtZMMNcZo8kRJez/
qxlm9zsEAh2634Lk9oaSBaHxA5ILs2G50OBDeo1ZQtoTCFWUPB1KTTkHQjEDtKHkWR12h+/15ozM
JSiWNFaLCGBoY8vUbk2dOAQzYUd7LJ7UsfaXHaGNhkm5xui/yFa9i+h5G4LV3r1go23xS79+cmyd
S2+HQKC7tpuJYMbo3XRLAHNOcT/ytJSBYlDQi+IYLe8TG5bVBCuKfwXhvRKCYR2lsYPHhP4zKqWq
cJclFu/VoBpw50FDVeg7G0SrDSTCGTrHzrUk5PFUNZ1rN6AXfOSPOswQdS6XCM8pEByXfEyOjlx7
ttcMNIGa3Iszum85MtH5UAfsBADUVBS/gXsKDksUrLE46IgZYlMRLvrwPbaiDqnPXGvDh1VrOmSP
DbHABf9EbClpkMXKQqeVBg7NvvlTML1tt1ncSMo0tvHHW6sl3jn4xC1lVpgz5BAItLotAyPRTc6k
7hCNhbLsMRgwHTqBHcccrt5a+CWYaJMZBtYahiPpfa2wEySk64X2koB54+ZWLuxt2sXfP+8H9jR1
hX05m67EtGMxsULFttOti0SbjANvWQ56wvDRJbOqy61Y6VxorjBuOP7JHE7kdwhEoFfKGrvCiJ2+
if6cEZaTggkJCtkxkuO06TFv7qGzF1jyoGUIk5ZGDh9aolo6gCO46Y4yiLhugaL/zR6vM/Y43QS0
w93CuM/hg4I4wx6HdnXQteMcdxg7osdKA6ZOnjH52csy7l04rv09C4YYI7adCHcaTjr9/E9pdrT6
wpXV4SLwq+VIC4RitjWdOJheHV5mhbmHHJU1XnLj/I8WdKzFhJBXpvTPO8cCtwU8uXnfxbmS6VYw
V0NcKbXC6g+pR8KLIeW7LJhc9MMNtgqYNu+kZ/fNcTx3dJYnp+AyX07BQ1Bqf2WOa6g/Wd0JLHOD
Iw8e342GrvG647Qq7mngLvYLON7tsByZadHRDG87+SUsAaxHagTbrJYVrzHjNoYfzGzRh3ByoVuy
gkv5n3b/s+kQhHXog/WgtViXeGlG5ZkbIxf640UU3GEMCPh9t8UR4r4Ody/onz5loevqQMybpGLw
fDaObfj8lrDgS/bOm3TUAksQcD3/ERLBp7zch2lHdIulw7kZnfH3cGQBvzsg4ZyP2EWXWTBypXNJ
xuO5+lVQcgrQcRYhw9JhSUOeqaQbbp6cvAmg+U8bzTOxdHgS5/6fxLHqALblgyinB0Ntu1hZG8Fj
3OOWAztwN/tfyL8wJDyl9sv0xhVTHr4XU9cd9ixxDH55FEbnlnBB6C5JY6WY54Aec/ke1f8pHjBY
Cl1tneDyTry8F8aVHVx817sJXRriwYUkYFutUrgXoku69a5IjOTxeWDJ2gNGjjn40z1yYA5uL04m
QwJF8O5D/b6MjCE610fAALJcrShaHU0QUsUvUMPLomHjy9kgkPwl/FNN8LdN/ggam5l534LBWAls
glosU05IN1jIvCsuMb0EpJ/Y01CYlGvB9Km2to2hCsn9glQMweRxFQg6x4NXKcagMNSBcWmDH7CJ
KOxEo9HA+7VfvZYk1lZWx/fhUtEDVljyIbW8pBR3kG+CyWCJTShqiRjlaZqNQ68UuAp50qYOMeQY
L1fp8syXqO8+MEEA7XAahLA7hNEyAERqtzuo+edG/MZH3Vy0FsL1IPAfNcNBrwPCeGCY34FBBV4i
R+0IyXG0J8AUw8UUtaxkQ22ocf9HrmBugT6OO+R3u+dozXgcUfkUuad5M9O6ggFltAGVhY5WI03M
9Yn5TB7MNBZ4VWbG6syqqj2oqWXjDBTzkD/+iHptS0TIXNn13jkpe2bfYwhlBGZ8SLnGDPQ8Ao6Z
GjPV2sonJn1oxq/L79aZBj5upb3FJakABa7TblsH8b1M14Ylc6moDhoMt7Wew0j0QzTQrrrwGj2O
ixvtNMG83wYsB0zwHQhLDzchxfp1P96mycd+hcOQgGdufofj9VPA/MT5DXEa0t8TKC+2rZEbQso9
DS4tvYiY3fZYsCfNwH3Bot3wxehd68Afo+h9rmgYbfJRzG/2CG45mCimXRPC8ppmuaTaAsuidod5
5nAzSbMfs8AvUDYXXTU5ZTpKK6FAEALdHZa5kg1vcTRBEl8NTLEQS4wB9Ox8Evj1otBMEao8jB1i
/lNM6euRAMuKhG4nYioSxiYRETFxdkkCNY6CIRCM/rxHCeXUVe9ARdEsKMOXoC7r4onr96FNS5Hm
IqT/Q/3YDcegjUcsQ69BO3+TDBUISnt/6PTBUVxc6aTylUXDke/7uqw+ZoOxqtkTCzG40D7Op/Y4
S1hgt1+wV5BXwjLR6dWwrn8P6f5BPVGbXuyvzExfYaFVTwAzSiRtPYi4A4CXJcR1GKkvhiT2Qar2
mNXwsw6YQbjxqNYWLB42qLrnH/a1tp00pt7RyDbWiBSvpqY8EF2j2vHtYXqNw1NzpBeOMuDBMO6F
KlOtcekbNaTsppt93tyC8ajYInM6vPYw1KyEupUhVFF8tzmNf+DIc3VNh7mTo6FxJF1gY8y02QMG
rUa4AjpNKZZ1zwW3FCU9NVM+hhmZ81HwDkC79kNfdECnp6Jtj2CfAp0vtkLIaD1dVNdDZdEykwXO
I3seiobpizZaFagoXGWGJeNvlz38zDBXsMRj16N+mY40tAfC2RrMdcWhNP9r5r6juwkZVV1+hDTd
Ye7cczgjfRXNCA4aEQBZobKqug7GAweXgGZn1DkNvHYQ310S08sPZXo2imnjA4nS2+Hpdy06TfJo
F4LHDkPoaABN2iUtEElTPAEQkxGIhhaThJHVqD5WHaxpyNM2Dc23pdLRbOnLfvtcTdCrgJIHek6l
2k7/uL674C1V3uPN11WpPl6iLZ+eQ9/FOGtxzjvSlugkA5GRsCZJ9FaPFvkdje2oCP21eVenDtFq
ay/0XHvZ5bBu2byxx9vDdOkHViFXM58dN5kw3a6jmSsZ3GPFoZ/Bggn66mTT0btbqNtMOz4px6D1
NL2ha487WcJtTiCMB4QFu9ncgVjrfx3YutLFAmHGsvrxiPFn2FT6wgpteEiXtX2ypn/eEArYbJxK
m44J0+I34aDnnJkw3hZRE5aOwtD1gQ3M2Lv5GtbtW5mmJlzvO9K0McAJvWTCiHohlJz7YJ5/A/t9
G0O+vR+4vapN61xvbtn5TNNuhJJ7l1nxre0v8ZK931IHjOysCpaHLa6OoS2DHseNt5Gk2Oq6eB1P
Uf5bUuRKIVQvbdD5lKNDIVQDoKQdYFzfgkeCh8CQsV/tmbKEffUV9x5KpXeTemGV9iF2pfEb0XiY
rH/+j6EY9kbZv8QzfHskRdmhCd1Lu9/KR0e/KzMO0y0PK2Ht+eptL3+R1nfE6apHugn51KgBvlh8
WHiYymwoyoo3D8p2Z/yOdodARUmRPzd/OOheiHdE1poNBYRPO/i60K5H+Q6pldWL/empl0FZ3Rkd
EDAzjGmXGlqjqcoBwqfTBVC8h8L7nhBFK2A8OUS6EZXTuz2IPRhxDnZfS9WKkvV0hMSXJl+OvLMN
+in6c21NlzihlWp6iAuHDUup4yJOw/dzMN7X0BDAMNwHsx2eX+Rn45sWRbJ8YbLjutYnyhDROCwN
SkHnY1hQVsMSQlYNzCpiIUba6WCgqyUmX4JOz8JJ1nK88vB75DcD+GPBmO2FxJ+C9fxWpHlObV89
13swbRqsXdvRmHdDFqbBvt4D+eQj7V9hhXkY1qPfwh6nMh3vinK2FDReRJmn40svc18ean/4Iu/B
9G3I58+gg5Fe9ITF6woqq/HYsy6/DO9W4K7GTSkUl01G2Z6C70HsFd2m6/oIbJHuwmbgAjzw/D7o
zoZpdxCEVIL/bZQ9B3sg443ZU+MvYllwBe6XLMdmwghcKngXJw8mw5Kl4rrs33Es5hAuQmUZN/8E
Owt1XY7nAGmX+X7MKpkYmH4Ba+Ic1OtHKI8WLC/6HypnW3GtbcmEPmRnoyMGYJNsMITgOwj3SSgM
iARj3G4XBuo8bHBVomOXwpz5N9AbD+Z6DYzxDZj+LcwAIwgn5gR/n14EBHPNRcqtkccHFgL3XOMZ
S5hcIbgdMeJ3IBiEYhDKN5/wwLiruMzi52i4HsJM8wk2PheEevmnglnPUQ6l4vch8DicxD9A2jeQ
dghmJkPAjY1N5A/axbRJiYLjVUXxOvAOoizrMXrnRcsJYRiGuK9Qr10QrFdBOz+ohZbgm2fQ09kE
DADzmCQDhJ9I1sVR1B1F17NC4ZTlUTr0Vi3qerNH5+NDZYXPIO/fIG4invCnTbQyo16S9nvk1Tea
pq18W5tAJN3u6PEjYLxx+I3mZ+tLBCbxgoG+jVGvG2aIN9Hrr7mmkXg4Bscjy+SnnwwAky5HmsNg
/iKCgVmXQBIfxfKEZoPvhbjmSi/+k7iwinHmNfIX4ixjNztYrRItu8OmGe0Kn1ZbVlYO1jbyNPCw
L4TM/RRnCCh+o0JsW4Ufs2GveKQaHMXhVwc9fFGUJt2lUDR5IOAX46AhZgrcIyC3C3fahVCOpPuM
UwpcaFVoT9qptjtUr225E1ogJA1KLaZ0MBeNTEk5dNxB/D0J5agXlh1LkkrE+CowTVfY2Isw4q4P
VxS/mVw6wuK5YOYNisZworWWaYLlA96AkPg51/+MO9jZ9R1fCfu0zRBeDwTqcy5ry5nCS8x7HIDT
U5bdff3yemOjil7wOwvj+stolHWBDtVrIQT0CHQHSdI2ou7fgp7zAQ5crpBlrZBKiDo9g9mHRvRS
48ISAeHokJ7GVTxPLx5GG1/ABv7LsC6JnaUBDBDrvUcCD0JfOQ+HOu/EiV5Xoa6l1Hb+P6GV6sjO
7yAyAyopej+u8T7omLPQWZ3AID4wHUYyjNpcfIl1+i50+Ga1V+qm+MibuKPAOKsNgQNKKOx/xCvX
PKBJfCFG532sz7A7wOS0TGkHBfIzoKwmShH/vwy/YDtwojWkKHyNqum/CStsMYbL/+D870ZP/3cn
AGevzqTp+OWj2b6ckTOQn4Evq/I3mmJ6n1SwpaSY4g72VRiVf63p8iR8/470OygfchCARbg7PYPL
0iX4ua6x3nBnRRdsHoT4QLvKjLuxBitBeacKFTqIzH4C/WQKrmP4mS7NR/LdpBBjtqIToS8QPTxh
X+0N8yJ/RvoZoPsQ6GdgaTmRHlbGoc6lhOPVtOtCivwIaCEfsTp0nv8xZXvgEkQZPKPU1iM+O1Gi
NuBOaKW6tbYvKaaqP3wWMTr98AyWOXdCB7m0tdbnZCr3CT1DtNaOwEzxmDcgb8L+AU68SjJU0amt
tS4nW7n/C6ptvmFkQMaMAAAAAElFTkSuQmCC
--===============1981288211012328880==--

