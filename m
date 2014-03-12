Content-Type: multipart/mixed; boundary="===============9101639083990510875=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: Re: Problem reconnecting when 3G dongle is re-inserted
Date: Wed, 12 Mar 2014 16:16:50 +0000
Message-ID: <CAK+sfouWEXtEzg9s25dDf92zHT5ZOcfvTB97Kz9E5R-g9-s+RQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9101639083990510875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In fact it seems that I am unable to do the following:

root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono
/huawei_2/context1 org.ofono.ConnectionContext.SetProperty string:"Active"
variant:boolean:true
method return sender=3D:1.237 -> dest=3D:1.253 reply_serial=3D2

root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono
/huawei_2/context1 org.ofono.ConnectionContext.SetProperty string:"Active"
variant:boolean:false
method return sender=3D:1.237 -> dest=3D:1.256 reply_serial=3D2

root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono
/huawei_2/context1 org.ofono.ConnectionContext.SetProperty string:"Active"
variant:boolean:true
Error org.ofono.Error.Failed: Operation failed

With ofono error log as before.


Homam



On 12 March 2014 10:34, <ofono-request@ofono.org> wrote:

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
>    1. Re: [PATCH] Port ofono test scripts to also work with Python3
>       (Denis Kenzior)
>    2. Re: Problem reconnecting when 3G dongle is re-inserted
>       (Homam Dabis)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 11 Mar 2014 14:44:38 -0500
> From: Denis Kenzior <denkenz@gmail.com>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH] Port ofono test scripts to also work with Python3
> Message-ID: <531F67A6.6020409@gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
>
> Hi Martin,
>
>  >> I'm okay moving to Python 3, but you might want to send this as an
> >> RFC to garner more feedback.
> >
> > That patch is a lot smaller, so it can be applied independently of the
> > other four. What you mean with "send as RFC" other than sending it to
> > the ML for review?
>
> Just means to preceed that patch title with 'RFC:'  But no worries,
> we'll figure it out.
>
> Regards,
> -Denis
>
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 12 Mar 2014 10:35:13 +0000
> From: Homam Dabis <hdabis@digisoft.tv>
> To: ofono(a)ofono.org
> Subject: Re: Problem reconnecting when 3G dongle is re-inserted
> Message-ID:
>         <
> CAK+sfoue_n6P_zGMYrdp-5mgm-UZYivkM+XW6fg4_fszBjLnaA(a)mail.gmail.com>
> Content-Type: text/plain; charset=3D"iso-8859-1"
>
> Hi,
>
> I have simplified the process by eliminating connman and focusing on ofon=
o.
>
> I insert the dongle and run the following:
>
> oot(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono /
> org.ofono.Manager.GetModems
> method return sender=3D:1.86 -> dest=3D:1.93 reply_serial=3D2
>    array [
>       struct {
>          object path "/huawei_0"
>          array [
>             dict entry(
>                string "Online"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Powered"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Lockdown"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Emergency"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Interfaces"
>                variant                   array [
>                   ]
>             )
>             dict entry(
>                string "Features"
>                variant                   array [
>                   ]
>             )
>             dict entry(
>                string "Type"
>                variant                   string "hardware"
>             )
>          ]
>       }
>    ]
>
> root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono
> /huawei_0
> org.ofono.Modem.SetProperty string:"Powered" variant:boolean:true
> method return sender=3D:1.86 -> dest=3D:1.95 reply_serial=3D2
>
> root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono
> /huawei_0
> org.ofono.Modem.SetProperty string:"Online" variant:boolean:true
> method return sender=3D:1.86 -> dest=3D:1.96 reply_serial=3D2
>
> root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono
> /huawei_0
> org.ofono.ConnectionManager.GetContexts
> method return sender=3D:1.86 -> dest=3D:1.98 reply_serial=3D2
>    array [
>       struct {
>          object path "/huawei_0/context1"
>          array [
>             dict entry(
>                string "Name"
>                variant                   string "Internet"
>             )
>             dict entry(
>                string "Active"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Type"
>                variant                   string "internet"
>             )
>             dict entry(
>                string "Protocol"
>                variant                   string "ip"
>             )
>             dict entry(
>                string "AccessPointName"
>                variant                   string "3Ireland"
>             )
>             dict entry(
>                string "Username"
>                variant                   string ""
>             )
>             dict entry(
>                string "Password"
>                variant                   string ""
>             )
>             dict entry(
>                string "Settings"
>                variant                   array [
>                   ]
>             )
>             dict entry(
>                string "IPv6.Settings"
>                variant                   array [
>                   ]
>             )
>          ]
>       }
>       struct {
>          object path "/huawei_0/context2"
>          array [
>             dict entry(
>                string "Name"
>                variant                   string "Internet"
>             )
>             dict entry(
>                string "Active"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Type"
>                variant                   string "internet"
>             )
>             dict entry(
>                string "Protocol"
>                variant                   string "ip"
>             )
>             dict entry(
>                string "AccessPointName"
>                variant                   string "3Ireland"
>             )
>             dict entry(
>                string "Username"
>                variant                   string ""
>             )
>             dict entry(
>                string "Password"
>                variant                   string ""
>             )
>             dict entry(
>                string "Settings"
>                variant                   array [
>                   ]
>             )
>             dict entry(
>                string "IPv6.Settings"
>                variant                   array [
>                   ]
>             )
>          ]
>       }
>       struct {
>          object path "/huawei_0/context3"
>          array [
>             dict entry(
>                string "Name"
>                variant                   string "Internet"
>             )
>             dict entry(
>                string "Active"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Type"
>                variant                   string "internet"
>             )
>             dict entry(
>                string "Protocol"
>                variant                   string "ip"
>             )
>             dict entry(
>                string "AccessPointName"
>                variant                   string ""
>             )
>             dict entry(
>                string "Username"
>                variant                   string ""
>             )
>             dict entry(
>                string "Password"
>                variant                   string ""
>             )
>             dict entry(
>                string "Settings"
>                variant                   array [
>                   ]
>             )
>             dict entry(
>                string "IPv6.Settings"
>                variant                   array [
>                   ]
>             )
>          ]
>       }
>       struct {
>          object path "/huawei_0/context4"
>          array [
>             dict entry(
>                string "Name"
>                variant                   string "Internet"
>             )
>             dict entry(
>                string "Active"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Type"
>                variant                   string "internet"
>             )
>             dict entry(
>                string "Protocol"
>                variant                   string "ip"
>             )
>             dict entry(
>                string "AccessPointName"
>                variant                   string ""
>             )
>             dict entry(
>                string "Username"
>                variant                   string ""
>             )
>             dict entry(
>                string "Password"
>                variant                   string ""
>             )
>             dict entry(
>                string "Settings"
>                variant                   array [
>                   ]
>             )
>             dict entry(
>                string "IPv6.Settings"
>                variant                   array [
>                   ]
>             )
>          ]
>       }
>       struct {
>          object path "/huawei_0/context5"
>          array [
>             dict entry(
>                string "Name"
>                variant                   string "Internet"
>             )
>             dict entry(
>                string "Active"
>                variant                   boolean false
>             )
>             dict entry(
>                string "Type"
>                variant                   string "internet"
>             )
>             dict entry(
>                string "Protocol"
>                variant                   string "ip"
>             )
>             dict entry(
>                string "AccessPointName"
>                variant                   string ""
>             )
>             dict entry(
>                string "Username"
>                variant                   string ""
>             )
>             dict entry(
>                string "Password"
>                variant                   string ""
>             )
>             dict entry(
>                string "Settings"
>                variant                   array [
>                   ]
>             )
>             dict entry(
>                string "IPv6.Settings"
>                variant                   array [
>                   ]
>             )
>          ]
>       }
>    ]
> root(a)smp8670:~# dbus-send --system --print-reply --dest=3Dorg.ofono
> /huawei_0/context1 org.ofono.ConnectionContext.SetProperty string:"Active"
> variant:boolean:true
> Error org.ofono.Error.Failed: Operation failed
>
>
> The ofono debug is as follows:
>
>
> ofonod[1560]: oFono version 1.14
> ofonod[1560]: /ofono-1.14/src/plugin.c:__ofono_plugin_init()
> ofonod[1560]:
> /ofono-1.14/plugins/push-notification.c:push_notification_init()
> ofonod[1560]: /ofono-1.14/plugins/smart-messaging.c:smart_messaging_init()
> ofonod[1560]:
> /ofono-1.14/src/cdma-provision.c:ofono_cdma_provision_driver_register()
> driver: 0x556c1bb0 name: CDMA provisioning
> ofonod[1560]:
> /ofono-1.14/src/gprs-provision.c:ofono_gprs_provision_driver_register()
> driver: 0x556c1b80 name: Provisioning
> ofonod[1560]: /ofono-1.14/plugins/dun_gw_bluez5.c:dun_gw_init()
> ofonod[1560]:
> /ofono-1.14/src/handsfree-audio.c:ofono_handsfree_card_driver_register()
> driver: 0x556c1a50
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1a60, name: hfp
> ofonod[1560]: /ofono-1.14/plugins/he910.c:he910_init()
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c19e0, name: he910
> ofonod[1560]: /ofono-1.14/plugins/connman.c:connman_init()
> ofonod[1560]:
> /ofono-1.14/src/private-network.c:ofono_private_network_driver_register()
> driver: 0x556c19b0, name: ConnMan Private Network
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1960, name: sim900
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1910, name: samsung
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c18c0, name: speedupcdma
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1870, name: speedup
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1820, name: alcatel
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c17c0, name: icera
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1770, name: linktop
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1720, name: nokiacdma
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c16d0, name: nokia
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1680, name: tc65
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c15f0, name: ste
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1590, name: ifx
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1540, name: palmpre
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c14f0, name: novatel
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c14a0, name: sierra
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1420, name: huawei
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c13d0, name: zte
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1370, name: hso
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1320, name: mbm
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c12d0, name: calypso
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1280, name: wavecom
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1230, name: g1
> ofonod[1560]:
> /ofono-1.14/src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
> driver: 0x556c11a0, name: cdmamodem
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556c11c0, name: cdmamodem
> ofonod[1560]:
> /ofono-1.14/src/cdma-connman.c:ofono_cdma_connman_driver_register() drive=
r:
> 0x556c11f0, name: cdmamodem
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c111c, name: phonesim
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c1154, name: localhfp
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c1104, name: phonesim
> ofonod[1560]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
> 0x556c10f0, name: phonesim
> ofonod[1560]: /ofono-1.14/plugins/phonesim.c:parse_config() filename
> /etc/ofono/phonesim.conf
> ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556c10b0, name: speedupmodem
> ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register=
()
> driver: 0x556c0f50, name: hfpmodem
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556c1010, name: hfpmodem
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556c0fa0, name: hfpmodem
> ofonod[1560]:
> /ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() driver:
> 0x556c0fe0, name: hfpmodem
> ofonod[1560]: /ofono-1.14/src/handsfree.c:ofono_handsfree_driver_register=
()
> driver: 0x556c1030, name: hfpmodem
> ofonod[1560]: /ofono-1.14/src/siri.c:ofono_siri_driver_register() driver:
> 0x556c1060, name: hfpmodem
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556c0ec0, name: dunmodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
> 0x556c0ef0, name: dunmodem
> ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register=
()
> driver: 0x556c0df0, name: stemodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0e70, name: stemodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0e40, name: stemodem
> ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register=
()
> driver: 0x556c0cb0, name: ifxmodem
> ofonod[1560]:
> /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> driver: 0x556c0d00, name: ifxmodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0d20, name: ifxmodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0d50, name: ifxmodem
> ofonod[1560]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> 0x556c0d80, name: ifxmodem
> ofonod[1560]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
> 0x556c0db0, name: ifxmodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0c40, name: hsomodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0c60, name: hsomodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0bb0, name: mbmmodem
> ofonod[1560]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> 0x556c0be0, name: mbmmodem
> ofonod[1560]:
>
> /ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
> driver: 0x556c0c00, name: mbmmodem
> ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register=
()
> driver: 0x556c0b20, name: calypsomodem
> ofonod[1560]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> 0x556c0b70, name: calypsomodem
> ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556c0a00, name: huaweimodem
> ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register=
()
> driver: 0x556c0a20, name: huaweimodem
> ofonod[1560]:
> /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> driver: 0x556c0a70, name: huaweimodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0ab0, name: huaweimodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0a90, name: huaweimodem
> ofonod[1560]:
> /ofono-1.14/src/cdma-netreg.c:ofono_cdma_netreg_driver_register() driver:
> 0x556c0ae0, name: huaweimodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0970, name: iceramodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c09a0, name: iceramodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0920, name: ztemodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c08e0, name: swmodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0890, name: nwmodem
> ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register=
()
> driver: 0x556c06b0, name: atmodem
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556c0760, name: atmodem
> ofonod[1560]:
> /ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register() drive=
r:
> 0x556c0710, name: atmodem
> ofonod[1560]:
> /ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register()
> driver: 0x556c0480, name: atmodem
> ofonod[1560]:
> /ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
> 0x556c04b0, name: atmodem
> ofonod[1560]:
> /ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
> driver: 0x556c0390, name: atmodem
> ofonod[1560]: /ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register=
()
> driver: 0x556c0730, name: atmodem
> ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556c0680, name: atmodem
> ofonod[1560]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> 0x556c0400, name: atmodem
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556c0560, name: atmodem
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556c05a8, name: atmodem-noef
> ofonod[1560]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> 0x556c0660, name: atmodem
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556c0500, name: atmodem
> ofonod[1560]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
> 0x556c0460, name: atmodem
> ofonod[1560]:
> /ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() driver:
> 0x556c0790, name: atmodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
> 0x556c07d0, name: atmodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0800, name: atmodem
> ofonod[1560]: /ofono-1.14/src/sim-auth.c:ofono_sim_auth_driver_register()
> driver: 0x556c0820, name: atmodem
> ofonod[1560]: /ofono-1.14/src/gnss.c:ofono_gnss_driver_register() driver:
> 0x556c0840, name: atmodem
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556c01b0, name: gobi
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556bff80, name: qmimodem
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556bfff0, name: qmimodem
> ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register=
()
> driver: 0x556bffa0, name: qmimodem
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556c0020, name: qmimodem-legacy
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556c0070, name: qmimodem
> ofonod[1560]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> 0x556c00c0, name: qmimodem
> ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556c00e0, name: qmimodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
> 0x556c0100, name: qmimodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556c0120, name: qmimodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556c0140, name: qmimodem
> ofonod[1560]:
>
> /ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
> driver: 0x556c0170, name: qmimodem
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556bff2c, name: u8500
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556bff10, name: u8500
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556bfec0, name: n900
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_driver_register() drive=
r:
> 0x556bfe70, name: isiusb
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> driver: 0x556bfb90, name: isimodem
> ofonod[1560]: /ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register=
()
> driver: 0x556bfb80, name: isimodem
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> driver: 0x556bfbb0, name: isimodem
> ofonod[1560]: /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register=
()
> driver: 0x556bfbe0, name: isimodem
> ofonod[1560]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> 0x556bfc30, name: isimodem
> ofonod[1560]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
> 0x556bfc50, name: isimodem
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556bfc70, name: isimodem
> ofonod[1560]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register() driver:
> 0x556bfcc0, name: isimodem
> ofonod[1560]:
> /ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register()
> driver: 0x556bfce0, name: isimodem
> ofonod[1560]:
> /ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
> driver: 0x556bfd00, name: isimodem
> ofonod[1560]:
> /ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register() drive=
r:
> 0x556bfd30, name: isimodem
> ofonod[1560]:
> /ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
> 0x556bfd50, name: isimodem
> ofonod[1560]:
> /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> driver: 0x556bfd80, name: isimodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register() driver:
> 0x556bfdb0, name: isimodem
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> driver: 0x556bfdd0, name: isimodem
> ofonod[1560]:
> /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> driver: 0x556bfdf0, name: isimodem
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> 0x556bfe00, name: wgmodem2.5
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:udev_start()
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:enumerate_devices()
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
> [(null):(null)]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [0bda:8176]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
> [(null):(null)]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
> [0bda:8176]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
> [(null):(null)]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [12d1:1f01]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [(null):(null)]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:remove_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_modem_list()
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> [12d1:1001]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [(null):(null)]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyU=
SB0
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB0
> (huawei) 255/255/255 [00] =3D=3D> (null) (null)
> ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyU=
SB1
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB1
> (huawei) 255/255/255 [01] =3D=3D> (null) (null)
> ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> [12d1:1001]
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device()
>
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyU=
SB2
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB2
> (huawei) 255/255/255 [02] =3D=3D> (null) (null)
> ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> ofonod[1560]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> finished
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:check_modem_list()
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:create_modem()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:create_modem() driver=3Dhuawei
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_create() name: (null),
> type: huawei
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei()
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB0
> 255/255/255 00 (null)
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB1
> 255/255/255 01 (null)
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB2
> 255/255/255 02 (null)
> ofonod[1560]: /ofono-1.14/plugins/udevng.c:setup_huawei() mdm=3D/dev/ttyU=
SB0
> pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
> ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42=
a0
> property Device
> ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42=
a0
> property Modem
> ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42=
a0
> property Pcui
> ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42=
a0
> property Diag
> ofonod[1560]: /ofono-1.14/src/modem.c:set_modem_property() modem 0x556d42=
a0
> property NetworkInterface
> ofonod[1560]: /ofono-1.14/src/modem.c:ofono_modem_register() 0x556d42a0
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_probe() 0x556d42a0
> ofonod[1560]: /ofono-1.14/src/modem.c:emit_modem_added() 0x556d42a0
> ofonod[1560]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556d42a0
> added:1
> ofonod[1560]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
> 0x556d42a0, added: 1
> ofonod[1560]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
> 0x556d42a0, added: 1
> ofonod[1560]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() modem:
> 0x556d42a0, added: 1
> ofonod[1560]: /ofono-1.14/plugins/push-notification.c:modem_watch() modem:
> 0x556d42a0, added: 1
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_enable() 0x556d42a0
> ofonod[1560]: /ofono-1.14/src/modem.c:get_modem_property() modem 0x556d42=
a0
> property Modem
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:open_device() Modem /dev/ttyUS=
B0
> ofonod[1560]: /ofono-1.14/src/modem.c:get_modem_property() modem 0x556d42=
a0
> property Pcui
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
> ofonod[1560]: PCUI: > ATE0 +CMEE=3D1\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > ATI\r
> ofonod[1560]: PCUI: < \r\nManufacturer: huawei\r\nModel: E303\r\nRevision:
> 22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
> +CGSM,+DS,+ES\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT^RFSWITCH=3D?\r
> ofonod[1560]: PCUI: < \r\nERROR\r\n
> ofonod[1560]: PCUI: > AT+CFUN=3D1\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:cfun_enable()
> ofonod[1560]: PCUI: > AT^SYSINFO\r
> ofonod[1560]: PCUI: < \r\n^SYSINFO:2,3,0,5,1,0,4\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
> ofonod[1560]: PCUI: > AT&C0\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CSCS=3D"GSM"\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT^U2DIAG?\r
> ofonod[1560]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT^GETPORTMODE\r
> ofonod[1560]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA: huawei,\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT^USSDMODE=3D?\r
> ofonod[1560]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT^DIALMODE=3D?\r
> ofonod[1560]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT^CVOICE=3D?\r
> ofonod[1560]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CFUN=3D5\r
> ofonod[1560]: PCUI: < \r\n+CGREG: 0\r\n
> ofonod[1560]: PCUI: < \r\n+CREG: 0\r\n
> ofonod[1560]: PCUI: < \r\nOK\r\n\r\n^SRVST: 0\r\n\r\n^MODE: 0,0\r\n
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:cfun_offline()
> ofonod[1560]: /ofono-1.14/src/modem.c:modem_change_state() old state: 0,
> new state: 1
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_pre_sim() 0x556d42a0
> ofonod[1560]: PCUI: > AT^USSDMODE?\r
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e99c8
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e99c8
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e99c8
> ofonod[1560]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT^DIALMODE?\r
> ofonod[1560]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT^CVOICE?\r
> ofonod[1560]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
> ofonod[1560]: Voice channel: 8000 Hz, 16 bits, 20ms period
> ofonod[1560]: PCUI: > AT+GCAP\r
> ofonod[1560]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\=
r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[1560]: PCUI: > AT^DDSETEX=3D?\r
> ofonod[1560]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CGMI\r
> ofonod[1560]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"985303050107085305F6"\r\n\r\nOK\r=
\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
> dataoff: 0, tocopy: 10
> ofonod[1560]: PCUI: > AT+CGMM\r
> ofonod[1560]: PCUI: < \r\nE303\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\=
r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[1560]: PCUI: > AT+CGMR\r
> ofonod[1560]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r=
\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
> dataoff: 0, tocopy: 10
> ofonod[1560]: PCUI: > AT+CGSN\r
> ofonod[1560]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\=
r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[1560]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r=
\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
> dataoff: 0, tocopy: 10
> ofonod[1560]: PCUI: > AT+CPIN?\r
> ofonod[1560]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb:
> READY
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
> ofonod[1560]: PCUI: > AT^CPIN?\r
> ofonod[1560]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D9, val=3D10
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D1, val=3D3
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D11, val=3D10
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> counter id=3D4, val=3D3
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\=
r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[1560]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 4
> ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
> dataoff: 0, tocopy: 4
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\=
r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[1560]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r=
\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 10
> ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
> dataoff: 0, tocopy: 10
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\=
r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 30
> ofonod[1560]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 1
> ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
> dataoff: 0, tocopy: 1
> ofonod[1560]: PCUI: > AT+CIMI\r
> ofonod[1560]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
> 272050100413580
> ofonod[1560]: /ofono-1.14/src/modem.c:modem_change_state() old state: 1,
> new state: 2
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_post_sim() 0x556d42a0
> ofonod[1560]:
> /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
> ofonod[1560]: /ofono-1.14/src/modem.c:get_modem_property() modem 0x556d42=
a0
> property AlwaysOnline
> ofonod[1560]: PCUI: > AT+CRC=3D1\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CLIP=3D1\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+COLP=3D1\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CCWA=3D1\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]:
> /ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized()
> registering to notifications
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch() 0x556e99c8
> ofonod[1560]: /ofono-1.14/plugins/bluez5.c:bt_register_profile() Bluetoot=
h:
> Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag) profile
> ofonod[1560]: PCUI: > AT^CVOICE=3D?\r
> ofonod[1560]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CSCS=3D?\r
> ofonod[1560]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT^SYSCFG=3D?\r
> ofonod[1560]: PCUI: < \r\n^SYSCFG:
>
> (2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(=
280000,"GSM850/GSM1900"),(3fffffff,"All
> bands")),(0-2),(0-4)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CSMS=3D?\r
> ofonod[1560]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
> query parsed successfully
> ofonod[1560]: PCUI: > AT+CGDCONT=3D?\r
> ofonod[1560]: RegisterProfile() replied an error:
> org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> unknown return code 1
> ofonod[1560]: PCUI: < \r\n+CGDCONT:
> (1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
> (1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\=
r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[1560]: PCUI: > AT+CPBS=3D?\r
> ofonod[1560]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CSMS=3D1\r
> ofonod[1560]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CGREG=3D?\r
> ofonod[1560]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CSMS?\r
> ofonod[1560]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CGREG=3D2\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CGAUTO=3D0\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CGEREP=3D2,1\r
> ofonod[1560]: PCUI: < \r\nERROR\r\n
> ofonod[1560]: /ofono-1.14/plugins/bluez5.c:bt_register_profile() Bluetoot=
h:
> Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw) profile
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CMGF=3D?\r
> ofonod[1560]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
> ofonod[1560]: RegisterProfile() replied an error:
> org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> unknown return code 1
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CPMS=3D?\r
> ofonod[1560]: PCUI: < \r\n+CPMS:
> ("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CMGF=3D0\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
> ofonod[1560]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CNMI=3D?\r
> ofonod[1560]: Duplicate EFsdn entries for `Emergency Services'
> ofonod[1560]: PCUI: < \r\n+CNMI:
> (0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
> ofonod[1560]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: /ofono-1.14/src/sms.c:sms_restore_tx_queue()
> ofonod[1560]: /ofono-1.14/plugins/push-notification.c:sms_watch()
> registered
> ofonod[1560]: /ofono-1.14/plugins/smart-messaging.c:sms_watch() registered
> ofonod[1560]: PCUI: > AT+CMGL=3D4\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
> ofonod[1560]: PCUI: > AT+CGSMS=3D3\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: /ofono-1.14/src/modem.c:get_modem_property() modem 0x556d42=
a0
> property AlwaysOnline
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_set_online() modem
> 0x556d42a0 online
> ofonod[1560]: PCUI: > AT+CFUN=3D1\r
> ofonod[1560]: PCUI: < \r\n^SIMST:0,0\r\n
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:simst_notify() 1 -> 0
> ofonod[1560]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:simst_notify() 0 -> 1
> ofonod[1560]: PCUI: > AT^SYSINFO\r
> ofonod[1560]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG:
> 2\r\n\r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
> status 2
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
> ofonod[1560]: /ofono-1.14/src/modem.c:modem_change_state() old state: 2,
> new state: 3
> ofonod[1560]: /ofono-1.14/plugins/huawei.c:huawei_post_online() 0x556d42a0
> ofonod[1560]: PCUI: > AT+CREG=3D?\r
> ofonod[1560]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CSCB=3D?\r
> ofonod[1560]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CUSD=3D1\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\=
r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[1560]: PCUI: > AT+CREG=3D2\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: /ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556e99c8
> ofonod[1560]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556efbe8
> ofonod[1560]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556efbe8
> ofonod[1560]: PCUI: > AT+CSCB=3D0\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI:
> 272050100413580
> ofonod[1560]: /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> 0x556efbe8
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[1560]: PCUI: > AT+CREG?\r
> ofonod[1560]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> /huawei_0 status 2 tech -1
> ofonod[1560]: /ofono-1.14/src/network.c:current_operator_callback()
> 0x556efbe8, (nil)
> ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_location_changed() 2, -1, -1, -1,
> (null)(null)
> ofonod[1560]: /ofono-1.14/src/gprs.c:netreg_status_changed() 2
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 6
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\=
r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 5
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb() No
> CPHS MWIS on SIM
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\=
r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
> 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 16
> ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> seekoff: 39, toread: 17
> ofonod[1560]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> seekoff: 39, toread: 10
> ofonod[1560]: /ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
> ofonod[1560]: PCUI: > AT+CSCB=3D0\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[1560]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\=
r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> crsm_info_cb: 90, 00, 32
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
> ofonod[1560]: PCUI: < \r\n+CRSM:
>
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> crsm_read_cb: 90, 00, 34
> ofonod[1560]: PCUI: < \r\n^MODE: 5,4\r\n
> ofonod[1560]: PCUI: < \r\n^RSSI: 13\r\n\r\n^HCSQ:"WCDMA",41,35,53\r\n
> ofonod[1560]: PCUI: < \r\n+CREG: 1,"0040","02C10178"\r\n
> ofonod[1560]: PCUI: < \r\n^SRVST: 2\r\n
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> /huawei_0 status 1 tech 2
> ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
> (null)(null)
> ofonod[1560]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> ofonod[1560]: PCUI: > AT+COPS=3D3,2\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+COPS?\r
> ofonod[1560]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
> ofonod[1560]:
> /ofono-1.14/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
> numeric got mcc: 272, mnc: 05
> ofonod[1560]: PCUI: > AT+CSQ\r
> ofonod[1560]: PCUI: < \r\n+CSQ: 13,99\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
> csq_cb: 13
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> strength 41
> ofonod[1560]: PCUI: > AT+CGATT=3D1\r
> ofonod[1560]: PCUI: < \r\nOK\r\n\r\n+CGREG: 1,"0040","02C10178"\r\n
> ofonod[1560]: /ofono-1.14/src/gprs.c:gprs_attach_callback() /huawei_0 err=
or
> =3D 0
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
> status 1
> ofonod[1560]: PCUI: > AT+COPS=3D3,0\r
> ofonod[1560]: PCUI: < \r\nOK\r\n
> ofonod[1560]: PCUI: > AT+COPS?\r
> ofonod[1560]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/drivers/atmodem/network-registration.c:cops_cb()
> cops_cb: 3 IRL, 272 05 2
> ofonod[1560]: /ofono-1.14/src/network.c:current_operator_callback()
> 0x556efbe8, (nil)
> ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, 2,
> 27205
> ofonod[1560]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, 0, 0
> ofonod[1560]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> ofonod[1560]: PCUI: > AT+CGREG?\r
> ofonod[1560]: PCUI: < \r\n+CGREG: 2,1,"0040","02C10178"\r\n\r\nOK\r\n
> ofonod[1560]: /ofono-1.14/src/gprs.c:registration_status_cb() /huawei_0
> error 0 status 1
> ofonod[1560]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify() /huawei_0
> status 1
> ofonod[1560]: PCUI: < \r\n^RSSI: 11\r\n\r\n^HCSQ:"WCDMA",38,30,49\r\n
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> strength 35
> ofonod[1560]:
> /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid=
 1
> ofonod[1560]: /ofono-1.14/src/gprs.c:pri_activate_callback() 0x556eb788
> ofonod[1560]: /ofono-1.14/src/gprs.c:pri_activate_callback() Activating
> context failed with error: Unknown error type
> ofonod[1560]: PCUI: < \r\n^RSSI: 13\r\n\r\n^HCSQ:"WCDMA",42,35,51\r\n
> ofonod[1560]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> strength 41
>
>
> If I now restart ofono then activating the same context will work fine.
>
>
> Homam
>
>
>
>
> On 10 March 2014 18:16, <ofono-request@ofono.org> wrote:
>
> > Send ofono mailing list submissions to
> >         ofono(a)ofono.org
> >
> > To subscribe or unsubscribe via the World Wide Web, visit
> >         https://lists.ofono.org/mailman/listinfo/ofono
> > or, via email, send a message with subject or body 'help' to
> >         ofono-request(a)ofono.org
> >
> > You can reach the person managing the list at
> >         ofono-owner(a)ofono.org
> >
> > When replying, please edit your Subject line so it is more specific
> > than "Re: Contents of ofono digest..."
> >
> >
> > Today's Topics:
> >
> >    1. Problem reconnecting when 3G dongle is re-inserted (Homam Dabis)
> >
> >
> > ----------------------------------------------------------------------
> >
> > Message: 1
> > Date: Mon, 10 Mar 2014 18:17:04 +0000
> > From: Homam Dabis <hdabis@digisoft.tv>
> > To: ofono(a)ofono.org
> > Subject: Problem reconnecting when 3G dongle is re-inserted
> > Message-ID:
> >         <CAK+sfotBtysK1yCTt64m3guFwfzWb_=3D
> > 4szj0U2b5Wswgt1m1Cg(a)mail.gmail.com>
> > Content-Type: text/plain; charset=3D"iso-8859-1"
> >
> > Hi,
> >
> > I have the following: Huawei E303 3G USB dongle, connman 1.20 and ofono
> > 1.14.
> >
> > I can connect to a particular APN using connman and ofono.
> >
> > However, if I remove and re insert the dongle I am unable to reconnect =
to
> > the service. If I restart either connman or ofono then reconnection to
> > service is ok.
> >
> > Connman has the following config:
> >
> > [General]
> > BackgroundScanning=3Dfalse
> > DefaultAutoConnectTechnologies=3Dcellular
> > PreferredTechnologies=3Dcellular,wifi
> > SingleConnectedTechnology=3Dfalse
> > TetheringTechnologies=3Dwifi
> > PersistentTetheringMode=3Dtrue
> >
> >
> > In ofono the log for connect/remove and reconnect is:
> >
> > root(a)i100:~# OFONO_AT_DEBUG=3D1 ofonod -n -d  > /ofono.log
> > ofonod[30943]: oFono version 1.14
> > ofonod[30943]: /ofono-1.14/src/plugin.c:__ofono_plugin_init()
> > ofonod[30943]:
> > /ofono-1.14/plugins/push-notification.c:push_notification_init()
> > ofonod[30943]:
> /ofono-1.14/plugins/smart-messaging.c:smart_messaging_init()
> > ofonod[30943]:
> > /ofono-1.14/src/cdma-provision.c:ofono_cdma_provision_driver_register()
> > driver: 0x556c1bb0 name: CDMA provisioning
> > ofonod[30943]:
> > /ofono-1.14/src/gprs-provision.c:ofono_gprs_provision_driver_register()
> > driver: 0x556c1b80 name: Provisioning
> > ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:dun_gw_init()
> > ofonod[30943]:
> > /ofono-1.14/src/handsfree-audio.c:ofono_handsfree_card_driver_register()
> > driver: 0x556c1a50
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1a60, name: hfp
> > ofonod[30943]: /ofono-1.14/plugins/he910.c:he910_init()
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c19e0, name: he910
> > ofonod[30943]: /ofono-1.14/plugins/connman.c:connman_init()
> > ofonod[30943]:
> > /ofono-1.14/src/private-network.c:ofono_private_network_driver_register=
()
> > driver: 0x556c19b0, name: ConnMan Private Network
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1960, name: sim900
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1910, name: samsung
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c18c0, name: speedupcdma
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1870, name: speedup
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1820, name: alcatel
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c17c0, name: icera
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1770, name: linktop
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1720, name: nokiacdma
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c16d0, name: nokia
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1680, name: tc65
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c15f0, name: ste
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1590, name: ifx
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1540, name: palmpre
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c14f0, name: novatel
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c14a0, name: sierra
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1420, name: huawei
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c13d0, name: zte
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1370, name: hso
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1320, name: mbm
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c12d0, name: calypso
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1280, name: wavecom
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1230, name: g1
> > ofonod[30943]:
> > /ofono-1.14/src/cdma-voicecall.c:ofono_cdma_voicecall_driver_register()
> > driver: 0x556c11a0, name: cdmamodem
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> > driver: 0x556c11c0, name: cdmamodem
> > ofonod[30943]:
> > /ofono-1.14/src/cdma-connman.c:ofono_cdma_connman_driver_register()
> driver:
> > 0x556c11f0, name: cdmamodem
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c111c, name: phonesim
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c1154, name: localhfp
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c1104, name: phonesim
> > ofonod[30943]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
> > 0x556c10f0, name: phonesim
> > ofonod[30943]: /ofono-1.14/plugins/phonesim.c:parse_config() filename
> > /etc/ofono/phonesim.conf
> > ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register()
> driver:
> > 0x556c10b0, name: speedupmodem
> > ofonod[30943]:
> > /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> > 0x556c0f50, name: hfpmodem
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> > driver: 0x556c1010, name: hfpmodem
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> > driver: 0x556c0fa0, name: hfpmodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() drive=
r:
> > 0x556c0fe0, name: hfpmodem
> > ofonod[30943]:
> > /ofono-1.14/src/handsfree.c:ofono_handsfree_driver_register() driver:
> > 0x556c1030, name: hfpmodem
> > ofonod[30943]: /ofono-1.14/src/siri.c:ofono_siri_driver_register()
> driver:
> > 0x556c1060, name: hfpmodem
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> > driver: 0x556c0ec0, name: dunmodem
> > ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register()
> driver:
> > 0x556c0ef0, name: dunmodem
> > ofonod[30943]:
> > /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> > 0x556c0df0, name: stemodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c0e70, name: stemodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556c0e40, name: stemodem
> > ofonod[30943]:
> > /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> > 0x556c0cb0, name: ifxmodem
> > ofonod[30943]:
> > /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> > driver: 0x556c0d00, name: ifxmodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556c0d20, name: ifxmodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c0d50, name: ifxmodem
> > ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> > 0x556c0d80, name: ifxmodem
> > ofonod[30943]: /ofono-1.14/src/ctm.c:ofono_ctm_driver_register() driver:
> > 0x556c0db0, name: ifxmodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c0c40, name: hsomodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556c0c60, name: hsomodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c0bb0, name: mbmmodem
> > ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> > 0x556c0be0, name: mbmmodem
> > ofonod[30943]:
> >
> >
> /ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
> > driver: 0x556c0c00, name: mbmmodem
> > ofonod[30943]:
> > /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> > 0x556c0b20, name: calypsomodem
> > ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> > 0x556c0b70, name: calypsomodem
> > ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register()
> driver:
> > 0x556c0a00, name: huaweimodem
> > ofonod[30943]:
> > /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> > 0x556c0a20, name: huaweimodem
> > ofonod[30943]:
> > /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> > driver: 0x556c0a70, name: huaweimodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556c0ab0, name: huaweimodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c0a90, name: huaweimodem
> > ofonod[30943]:
> > /ofono-1.14/src/cdma-netreg.c:ofono_cdma_netreg_driver_register() drive=
r:
> > 0x556c0ae0, name: huaweimodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c0970, name: iceramodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556c09a0, name: iceramodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556c0920, name: ztemodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c08e0, name: swmodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556c0890, name: nwmodem
> > ofonod[30943]:
> > /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> > 0x556c06b0, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> > driver: 0x556c0760, name: atmodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register()
> driver:
> > 0x556c0710, name: atmodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register=
()
> > driver: 0x556c0480, name: atmodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
> > 0x556c04b0, name: atmodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
> > driver: 0x556c0390, name: atmodem
> > ofonod[30943]:
> > /ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register() driver:
> > 0x556c0730, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register()
> driver:
> > 0x556c0680, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> > 0x556c0400, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> > 0x556c0560, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> > 0x556c05a8, name: atmodem-noef
> > ofonod[30943]: /ofono-1.14/src/stk.c:ofono_stk_driver_register() driver:
> > 0x556c0660, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> > driver: 0x556c0500, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
> > 0x556c0460, name: atmodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-volume.c:ofono_call_volume_driver_register() drive=
r:
> > 0x556c0790, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register()
> driver:
> > 0x556c07d0, name: atmodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c0800, name: atmodem
> > ofonod[30943]:
> /ofono-1.14/src/sim-auth.c:ofono_sim_auth_driver_register()
> > driver: 0x556c0820, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/gnss.c:ofono_gnss_driver_register()
> driver:
> > 0x556c0840, name: atmodem
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556c01b0, name: gobi
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> > driver: 0x556bff80, name: qmimodem
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> > driver: 0x556bfff0, name: qmimodem
> > ofonod[30943]:
> > /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> > 0x556bffa0, name: qmimodem
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> > 0x556c0020, name: qmimodem-legacy
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> > 0x556c0070, name: qmimodem
> > ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> > 0x556c00c0, name: qmimodem
> > ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register()
> driver:
> > 0x556c00e0, name: qmimodem
> > ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register()
> driver:
> > 0x556c0100, name: qmimodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556c0120, name: qmimodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556c0140, name: qmimodem
> > ofonod[30943]:
> >
> >
> /ofono-1.14/src/location-reporting.c:ofono_location_reporting_driver_regi=
ster()
> > driver: 0x556c0170, name: qmimodem
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556bff2c, name: u8500
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> > driver: 0x556bff10, name: u8500
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556bfec0, name: n900
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_driver_register()
> > driver: 0x556bfe70, name: isiusb
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_devinfo_driver_register()
> > driver: 0x556bfb90, name: isimodem
> > ofonod[30943]:
> > /ofono-1.14/src/phonebook.c:ofono_phonebook_driver_register() driver:
> > 0x556bfb80, name: isimodem
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_driver_register()
> > driver: 0x556bfbb0, name: isimodem
> > ofonod[30943]:
> > /ofono-1.14/src/voicecall.c:ofono_voicecall_driver_register() driver:
> > 0x556bfbe0, name: isimodem
> > ofonod[30943]: /ofono-1.14/src/sms.c:ofono_sms_driver_register() driver:
> > 0x556bfc30, name: isimodem
> > ofonod[30943]: /ofono-1.14/src/cbs.c:ofono_cbs_driver_register() driver:
> > 0x556bfc50, name: isimodem
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> > 0x556bfc70, name: isimodem
> > ofonod[30943]: /ofono-1.14/src/ussd.c:ofono_ussd_driver_register()
> driver:
> > 0x556bfcc0, name: isimodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-forwarding.c:ofono_call_forwarding_driver_register=
()
> > driver: 0x556bfce0, name: isimodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-settings.c:ofono_call_settings_driver_register()
> > driver: 0x556bfd00, name: isimodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-barring.c:ofono_call_barring_driver_register()
> driver:
> > 0x556bfd30, name: isimodem
> > ofonod[30943]:
> > /ofono-1.14/src/call-meter.c:ofono_call_meter_driver_register() driver:
> > 0x556bfd50, name: isimodem
> > ofonod[30943]:
> > /ofono-1.14/src/radio-settings.c:ofono_radio_settings_driver_register()
> > driver: 0x556bfd80, name: isimodem
> > ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_driver_register()
> driver:
> > 0x556bfdb0, name: isimodem
> > ofonod[30943]:
> /ofono-1.14/src/gprs.c:ofono_gprs_context_driver_register()
> > driver: 0x556bfdd0, name: isimodem
> > ofonod[30943]:
> > /ofono-1.14/src/audio-settings.c:ofono_audio_settings_driver_register()
> > driver: 0x556bfdf0, name: isimodem
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_driver_register() driver:
> > 0x556bfe00, name: wgmodem2.5
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:udev_start()
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:enumerate_devices()
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> > [0bda:8176]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
> > [0bda:8176]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() rtl8192cu
> > [0bda:8176]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() hub
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> > [12d1:1001]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [12d1:1001]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyU=
SB0
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB0
> > (huawei) 255/255/255 [00] =3D=3D> (null) (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [12d1:1001]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyU=
SB1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB1
> > (huawei) 255/255/255 [01] =3D=3D> (null) (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [12d1:1001]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyU=
SB2
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB2
> > (huawei) 255/255/255 [02] =3D=3D> (null) (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem() driver=3Dhua=
wei
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_create() name: (null=
),
> > type: huawei
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB0
> > 255/255/255 00 (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB1
> > 255/255/255 01 (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB2
> > 255/255/255 02 (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei()
> mdm=3D/dev/ttyUSB0
> > pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556eb380 property Device
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556eb380 property Modem
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556eb380 property Pcui
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556eb380 property Diag
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556eb380 property NetworkInterface
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_register() 0x556eb380
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_probe() 0x556eb380
> > ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_added() 0x556eb380
> > ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556eb380
> > added:1
> > ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
> > 0x556eb380, added: 1
> > ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
> > 0x556eb380, added: 1
> > ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() mode=
m:
> > 0x556eb380, added: 1
> > ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch()
> modem:
> > 0x556eb380, added: 1
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_enable() 0x556eb380
> > ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> > 0x556eb380 property Modem
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Modem
> > /dev/ttyUSB0
> > ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> > 0x556eb380 property Pcui
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Pcui
> /dev/ttyUSB2
> > ofonod[30943]: Modem: > ATE0 +CMEE=3D1\r
> > ofonod[30943]: PCUI: > ATE0 +CMEE=3D1\r
> > ofonod[30943]: Modem: < \r\nOK\r\n
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > ATI\r
> > ofonod[30943]: PCUI: < \r\nManufacturer: huawei\r\nModel:
> E303\r\nRevision:
> > 22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
> > +CGSM,+DS,+ES\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^RFSWITCH=3D?\r
> > ofonod[30943]: PCUI: < \r\nERROR\r\n
> > ofonod[30943]: PCUI: > AT+CFUN=3D1\r
> > ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
> > ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_enable()
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 255 -> 1
> > ofonod[30943]: PCUI: > AT^SYSINFO\r
> > ofonod[30943]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG:
> > 2\r\n\r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 1 -> 1
> > ofonod[30943]: Modem: > AT&C0\r
> > ofonod[30943]: PCUI: > AT&C0\r
> > ofonod[30943]: Modem: < \r\nOK\r\n
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: Modem: > AT+CSCS=3D"GSM"\r
> > ofonod[30943]: PCUI: > AT+CSCS=3D"GSM"\r
> > ofonod[30943]: Modem: < \r\nOK\r\n
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^U2DIAG?\r
> > ofonod[30943]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^GETPORTMODE\r
> > ofonod[30943]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA:
> huawei,\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^USSDMODE=3D?\r
> > ofonod[30943]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^DIALMODE=3D?\r
> > ofonod[30943]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
> > ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CFUN=3D5\r
> > ofonod[30943]: PCUI: < \r\n+CREG: 0\r\n\r\n+CGREG: 0\r\n
> > ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^MODE: 0,0\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_offline()
> > ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: =
0,
> > new state: 1
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_pre_sim() 0x556eb380
> > ofonod[30943]: PCUI: > AT^USSDMODE?\r
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch()
> 0x556dc660
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch()
> 0x556dc660
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch()
> 0x556dc660
> > ofonod[30943]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^DIALMODE?\r
> > ofonod[30943]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^CVOICE?\r
> > ofonod[30943]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
> > ofonod[30943]: Voice channel: 8000 Hz, 16 bits, 20ms period
> > ofonod[30943]: PCUI: > AT+GCAP\r
> > ofonod[30943]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT^DDSETEX=3D?\r
> > ofonod[30943]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGMI\r
> > ofonod[30943]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 10
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 10
> > ofonod[30943]: PCUI: > AT+CGMM\r
> > ofonod[30943]: PCUI: < \r\nE303\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CGMR\r
> > ofonod[30943]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 10
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 10
> > ofonod[30943]: PCUI: > AT+CGSN\r
> > ofonod[30943]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 10
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 10
> > ofonod[30943]: PCUI: > AT+CPIN?\r
> > ofonod[30943]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb()
> crsm_pin_cb:
> > READY
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
> > ofonod[30943]: PCUI: > AT^CPIN?\r
> > ofonod[30943]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> > counter id=3D9, val=3D10
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> > counter id=3D1, val=3D3
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> > counter id=3D11, val=3D10
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> > counter id=3D4, val=3D3
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 4
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 4
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 10
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 10
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 1
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 1
> > ofonod[30943]: PCUI: > AT+CIMI\r
> > ofonod[30943]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
> > 272050100413580
> > ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: =
1,
> > new state: 2
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_sim() 0x556eb380
> > ofonod[30943]:
> > /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
> > ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> > 0x556eb380 property AlwaysOnline
> > ofonod[30943]: PCUI: > AT+CRC=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> > 0x556eb380 property AlwaysOnline
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_set_online() modem
> > 0x556eb380 online
> > ofonod[30943]: PCUI: > AT+CLIP=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+COLP=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CCWA=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]:
> >
> /ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized()
> > registering to notifications
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch()
> 0x556dc660
> > ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
> > Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag)
> > profile
> > ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
> > ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSCS=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^SYSCFG=3D?\r
> > ofonod[30943]: PCUI: < \r\n^SYSCFG:
> >
> >
> (2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(=
280000,"GSM850/GSM1900"),(3fffffff,"All
> > bands")),(0-2),(0-4)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSMS=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
> > query parsed successfully
> > ofonod[30943]: PCUI: > AT+CGDCONT=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CGDCONT:
> > (1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
> > (1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CFUN=3D1\r
> > ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 1 -> 0
> > ofonod[30943]: RegisterProfile() replied an error:
> > org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> > unknown return code 1
> > ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 0 -> 1
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CPBS=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSMS=3D1\r
> > ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGREG=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^SYSINFO\r
> > ofonod[30943]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
> > ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: =
2,
> > new state: 3
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_online()
> 0x556eb380
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CSMS?\r
> > ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGREG=3D2\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGAUTO=3D0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGEREP=3D2,1\r
> > ofonod[30943]: PCUI: < \r\nERROR\r\n
> > ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
> > Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw)
> > profile
> > ofonod[30943]: PCUI: > AT+CREG=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSCB=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CUSD=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CMGF=3D?\r
> > ofonod[30943]: RegisterProfile() replied an error:
> > org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> > unknown return code 1
> > ofonod[30943]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CREG=3D2\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556dc6=
60
> > ofonod[30943]:
> /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> > 0x556dcf18
> > ofonod[30943]: PCUI: > AT+CSCB=3D0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI:
> > 272050100413580
> > ofonod[30943]:
> /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> > 0x556dcf18
> > ofonod[30943]: PCUI: > AT+CPMS=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CPMS:
> > ("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CREG?\r
> > ofonod[30943]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> > /huawei_0 status 2 tech -1
> > ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
> > 0x556dcf18, (nil)
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 2, -1, -1,
> -1,
> > (null)(null)
> > ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 2
> > ofonod[30943]: PCUI: > AT+CMGF=3D0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
> > ofonod[30943]: PCUI: < \r\n^MODE: 5,4\r\n
> > ofonod[30943]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CNMI=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CNMI:
> > (0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
> > ofonod[30943]: Duplicate EFsdn entries for `Emergency Services'
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]:
> /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> > 0x556dcf18
> > ofonod[30943]: /ofono-1.14/src/sms.c:sms_restore_tx_queue()
> > ofonod[30943]: /ofono-1.14/plugins/push-notification.c:sms_watch()
> > registered
> > ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:sms_watch()
> registered
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CMGL=3D4\r
> > ofonod[30943]: PCUI: < \r\n^RSSI: 13\r\n\r\n^HCSQ:"WCDMA",42,34,49\r\n
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
> > ofonod[30943]: PCUI: > AT+CGSMS=3D3\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb()
> No
> > CPHS MWIS on SIM
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> > seekoff: 39, toread: 17
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> > seekoff: 39, toread: 10
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
> > ofonod[30943]: PCUI: > AT+CSCB=3D0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n^SRVST: 2\r\n\r\n+CGREG:
> 1,"0040","02C1155A"\r\n
> > ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify()
> /huawei_0
> > status 1
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]:
> > /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_primary()
> cid 1
> > ofonod[30943]: Modem: > AT+CGDCONT=3D1,"IP","3Ireland"\r
> > ofonod[30943]: Modem: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:at_cgdcont_cb=
()
> > ok 1
> > ofonod[30943]: Modem: > ATD*99***1#\r
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
> > ofonod[30943]: Modem: < \r\nCONNECT\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:at_cgdata_cb()
> ok
> > 1
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:setup_ppp()
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: < \r\n+CREG: 1,"0040","02C1155A"\r\n
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> > /huawei_0 status 1 tech 2
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, =
2,
> > (null)(null)
> > ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> > ofonod[30943]: PCUI: > AT+COPS=3D3,2\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+COPS?\r
> > ofonod[30943]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
> > ofonod[30943]:
> > /ofono-1.14/drivers/atmodem/network-registration.c:cops_numeric_cb() Co=
ps
> > numeric got mcc: 272, mnc: 05
> > ofonod[30943]: PCUI: > AT+CSQ\r
> > ofonod[30943]: PCUI: < \r\n+CSQ: 13,99\r\n\r\nOK\r\n
> > ofonod[30943]:
> /ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
> > csq_cb: 13
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> > strength 41
> > ofonod[30943]: PCUI: > AT+COPS=3D3,0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+COPS?\r
> > ofonod[30943]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
> > ofonod[30943]:
> /ofono-1.14/drivers/atmodem/network-registration.c:cops_cb()
> > cops_cb: 3 IRL, 272 05 2
> > ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
> > 0x556dcf18, (nil)
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, =
2,
> > 27205
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, 0, 0
> > ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> > ofonod[30943]: PCUI: < \r\n^RSSI: 10\r\n\r\n^HCSQ:"WCDMA",37,28,47\r\n
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> > strength 32
> >
> >
> >
> > Homam
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > ofonod[30943]: PCUI: < \r\n^RSSI: 12\r\n\r\n^HCSQ:"WCDMA",42,33,47\r\n
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> > strength 38
> > ofonod[30943]: PCUI: < \r\n^MODE: 5,7\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/gprs-context.c:ppp_connect()
> > ofonod[30943]: IP: 10.205.206.243
> > ofonod[30943]: DNS: 172.30.224.65, 172.30.224.65
> > ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() 0x556e65a8
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net add
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net
> > finished
> >
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > ofonod[30943]: PCUI: <
> >
> >
> \r\n^DSFLOWRPT:00000002,000001ED,0000029E,00000000000003A6,00000000000004=
D4,00000000,00000000\r\n
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > ofonod[30943]: PCUI: <
> >
> >
> \r\n^DSFLOWRPT:00000004,00000000,00000000,00000000000003A6,00000000000004=
D4,00000000,00000000\r\n
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyU=
SB0
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_remove() 0x556eb380
> > ofonod[30943]: /ofono-1.14/src/modem.c:modem_unregister() 0x556eb380
> > ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: =
3,
> > new state: 0
> > ofonod[30943]: /ofono-1.14/src/modem.c:flush_atoms()
> > ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_remove() atom:
> > 0x556e5950
> > ofonod[30943]: /ofono-1.14/src/call-barring.c:call_barring_remove() ato=
m:
> > 0x556e56b8
> > ofonod[30943]: /ofono-1.14/src/call-settings.c:call_settings_remove()
> atom:
> > 0x556e55d0
> > ofonod[30943]: /ofono-1.14/src/call-forwarding.c:call_forwarding_remove=
()
> > atom: 0x556e54f8
> > ofonod[30943]: /ofono-1.14/src/ussd.c:ussd_remove() atom: 0x556e5438
> > ofonod[30943]:
> > /ofono-1.14/src/network.c:__ofono_netreg_remove_status_watch() 0x556dcf=
18
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_remove() atom: 0x556e52c8
> > ofonod[30943]:
> > /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_detach_shutdown() cid
> 1
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_remove_spn_watch()
> > 0x556dc660
> > ofonod[30943]: /ofono-1.14/src/network.c:netreg_remove() atom: 0x556ddb=
88
> > ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_context_unregister()
> 0x556e46a8,
> > 0x556dd840
> > ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_context_remove() atom:
> > 0x556e46c8
> > ofonod[30943]:
> > /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_remove()
> > ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_unregister_profile()
> > Bluetooth: Unregistering profile /bluetooth/profile/dun_gw
> > ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_unregister() 0x556dd840
> > ofonod[30943]: /ofono-1.14/src/gprs.c:gprs_remove() atom: 0x556dd8a8
> > ofonod[30943]:
> > /ofono-1.14/plugins/push-notification.c:push_notification_cleanup()
> > 0x556df190
> > ofonod[30943]:
> > /ofono-1.14/plugins/smart-messaging.c:smart_messaging_cleanup()
> 0x556df160
> > ofonod[30943]: /ofono-1.14/src/sms.c:sms_remove() atom: 0x556dd780
> > ofonod[30943]: /ofono-1.14/src/radio-settings.c:radio_settings_remove()
> > atom: 0x556ddbf8
> > ofonod[30943]: /ofono-1.14/src/phonebook.c:phonebook_remove() atom:
> > 0x556ddb08
> > ofonod[30943]: /ofono-1.14/src/audio-settings.c:audio_settings_remove()
> > atom: 0x556dda28
> > ofonod[30943]: /ofono-1.14/src/voicecall.c:voicecall_remove() atom:
> > 0x556d68c8
> > ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_unregister_profile()
> > Bluetooth: Unregistering profile /bluetooth/profile/hfp_ag
> > ofonod[30943]: /ofono-1.14/src/sim.c:sim_remove() atom: 0x556dc788
> > ofonod[30943]: /ofono-1.14/src/modem.c:devinfo_remove() atom: 0x556dd070
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_disable() 0x556eb380
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_remove() 0x556eb380
> > ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> > 0x556eb128
> > ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> > 0x556eb2b0
> > ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> > 0x556eb108
> > ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> > 0x556eb440
> > ofonod[30943]: /ofono-1.14/src/modem.c:unregister_property() property
> > 0x556eb0d0
> > ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_removed() 0x556eb380
> > ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556eb380
> > added:0
> > ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
> > 0x556eb380, added: 0
> > ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
> > 0x556eb380, added: 0
> > ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() mode=
m:
> > 0x556eb380, added: 0
> > ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch()
> modem:
> > 0x556eb380, added: 0
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB0
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:destroy_modem() /dev/ttyUSB2
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> remove
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
> > /devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyUSB0
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> > finished
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> remove
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
> > /devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyUSB1
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> > finished
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyU=
SB1
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> remove
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
> > /devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyUSB2
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> > finished
> > ofonod[30943]: UnregisterProfile() replied an error:
> > org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> > unknown return code 1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net
> remove
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:remove_modem()
> > /devices/virtual/net/ppp0
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem net
> > finished
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyU=
SB2
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> > /sys/devices/virtual/net/ppp0
> > ofonod[30943]: UnregisterProfile() replied an error:
> > org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> > unknown return code 1
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> > [12d1:1f01]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:remove_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() usb
> > [12d1:1001]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [(null):(null)]
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> > finished
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [12d1:1001]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.1/ttyUSB1/tty/ttyU=
SB1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB1
> > (huawei) 255/255/255 [01] =3D=3D> (null) (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [12d1:1001]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.0/ttyUSB0/tty/ttyU=
SB0
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB0
> > (huawei) 255/255/255 [00] =3D=3D> (null) (null)
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> > finished
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_usb_device() option
> > [12d1:1001]
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device()
> >
> >
> /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1/2-1:1.2/ttyUSB2/tty/ttyU=
SB2
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:add_device() /dev/ttyUSB2
> > (huawei) 255/255/255 [02] =3D=3D> (null) (null)
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty add
> > ofonod[30943]: /ofono-1.14/plugins/udev.c:udev_event() subsystem tty
> > finished
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:check_modem_list()
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:create_modem() driver=3Dhua=
wei
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_create() name: (null=
),
> > type: huawei
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei()
> > /sys/devices/platform/tangox-ehci-hcd-1/usb2/2-1
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB0
> > 255/255/255 00 (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB1
> > 255/255/255 01 (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei() /dev/ttyUSB2
> > 255/255/255 02 (null)
> > ofonod[30943]: /ofono-1.14/plugins/udevng.c:setup_huawei()
> mdm=3D/dev/ttyUSB0
> > pcui=3D/dev/ttyUSB2 diag=3D(null) qmi=3D(null) net=3D(null)
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556dd280 property Device
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556dd280 property Modem
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556dd280 property Pcui
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556dd280 property Diag
> > ofonod[30943]: /ofono-1.14/src/modem.c:set_modem_property() modem
> > 0x556dd280 property NetworkInterface
> > ofonod[30943]: /ofono-1.14/src/modem.c:ofono_modem_register() 0x556dd280
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_probe() 0x556dd280
> > ofonod[30943]: /ofono-1.14/src/modem.c:emit_modem_added() 0x556dd280
> > ofonod[30943]: /ofono-1.14/src/modem.c:call_modemwatches() 0x556dd280
> > added:1
> > ofonod[30943]: /ofono-1.14/plugins/hfp_ag_bluez5.c:modem_watch() modem:
> > 0x556dd280, added: 1
> > ofonod[30943]: /ofono-1.14/plugins/dun_gw_bluez5.c:modem_watch() modem:
> > 0x556dd280, added: 1
> > ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:modem_watch() mode=
m:
> > 0x556dd280, added: 1
> > ofonod[30943]: /ofono-1.14/plugins/push-notification.c:modem_watch()
> modem:
> > 0x556dd280, added: 1
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_enable() 0x556dd280
> > ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> > 0x556dd280 property Modem
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Modem
> > /dev/ttyUSB0
> > ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> > 0x556dd280 property Pcui
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:open_device() Pcui
> /dev/ttyUSB2
> > ofonod[30943]: PCUI: > ATE0 +CMEE=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > ATI\r
> > ofonod[30943]: PCUI: < \r\nManufacturer: huawei\r\nModel:
> E303\r\nRevision:
> > 22.318.05.00.00\r\nIMEI: 862566020005697\r\n+GCAP:
> > +CGSM,+DS,+ES\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^RFSWITCH=3D?\r
> > ofonod[30943]: PCUI: < \r\nERROR\r\n
> > ofonod[30943]: PCUI: > AT+CFUN=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_enable()
> > ofonod[30943]: PCUI: > AT^SYSINFO\r
> > ofonod[30943]: PCUI: < \r\n^SYSINFO:2,3,0,5,1,0,4\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
> > ofonod[30943]: PCUI: > AT&C0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSCS=3D"GSM"\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^U2DIAG?\r
> > ofonod[30943]: PCUI: < \r\n^U2DIAG: 119\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^GETPORTMODE\r
> > ofonod[30943]: PCUI: < \r\n^GETPORTMODE: TYPE: WCDMA:
> huawei,\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^USSDMODE=3D?\r
> > ofonod[30943]: PCUI: < \r\n^USSDMODE: (0-1)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^DIALMODE=3D?\r
> > ofonod[30943]: PCUI: < \r\n^DIALMODE: (0-2),(0-255)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
> > ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CFUN=3D5\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SRVST: 0\r\n\r\n^MODE: 0,0\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:cfun_offline()
> > ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: =
0,
> > new state: 1
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_pre_sim() 0x556dd280
> > ofonod[30943]: PCUI: > AT^USSDMODE?\r
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch()
> 0x556e7628
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch()
> 0x556e7628
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch()
> 0x556e7628
> > ofonod[30943]: PCUI: < \r\n^USSDMODE: 1\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^DIALMODE?\r
> > ofonod[30943]: PCUI: < \r\n^DIALMODE:3,2\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^CVOICE?\r
> > ofonod[30943]: PCUI: < \r\n^CVOICE: 1, 8000, 16, 20\r\n\r\nOK\r\n
> > ofonod[30943]: Voice channel: 8000 Hz, 16 bits, 20ms period
> > ofonod[30943]: PCUI: > AT+GCAP\r
> > ofonod[30943]: PCUI: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,12258,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183022FE2A5038001718A01058B032F06038002000A880110"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT^DDSETEX=3D?\r
> > ofonod[30943]: PCUI: < \r\n^DDSETEX: (2)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGMI\r
> > ofonod[30943]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,12258,0,0,10\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"985303050107085305F6"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 10
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 10
> > ofonod[30943]: PCUI: > AT+CGMM\r
> > ofonod[30943]: PCUI: < \r\nE303\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28421,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183026F05A5038001718A01058B036F06048002000A880110"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CGMR\r
> > ofonod[30943]: PCUI: < \r\n22.318.05.00.00\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,28421,0,0,10\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 10
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 10
> > ofonod[30943]: PCUI: > AT+CGSN\r
> > ofonod[30943]: PCUI: < \r\n862566020005697\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,12037,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183022F05A5038001718A01058B032F06048002000A880128"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,12037,0,0,10\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"656EFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 10
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 10
> > ofonod[30943]: PCUI: > AT+CPIN?\r
> > ofonod[30943]: PCUI: < \r\n+CPIN: READY\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cpin_cb()
> crsm_pin_cb:
> > READY
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_pin_retries_query()
> > ofonod[30943]: PCUI: > AT^CPIN?\r
> > ofonod[30943]: PCUI: < \r\n^CPIN: READY,,10,3,10,3\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> > counter id=3D9, val=3D10
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> > counter id=3D1, val=3D3
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> > counter id=3D11, val=3D10
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:huawei_cpin_cb() retry
> > counter id=3D4, val=3D3
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28590,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28589,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183026FADA5038001718A01058B036F060680020004880118"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,28589,0,0,4\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00000002"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 4
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 4
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28438,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28472,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183026F38A5038001718A01058B036F06028002000A880120"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,28472,0,0,10\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"7EEE111C27F659000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 10
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 10
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28502,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621C8202412183026F56A5038001718A01058B036F060780020001880128"\r\n\=
r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 30
> > ofonod[30943]: PCUI: > AT+CRSM=3D176,28502,0,0,1\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"00"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 1
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block_cb() bufoff:
> 0,
> > dataoff: 0, tocopy: 1
> > ofonod[30943]: PCUI: > AT+CIMI\r
> > ofonod[30943]: PCUI: < \r\n272050100413580\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_cimi_cb() cimi_cb:
> > 272050100413580
> > ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: =
1,
> > new state: 2
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_sim() 0x556dd280
> > ofonod[30943]:
> > /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_context_probe()
> > ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> > 0x556dd280 property AlwaysOnline
> > ofonod[30943]: PCUI: > AT+CRC=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CLIP=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+COLP=3D1\r
> > ofonod[30943]: /ofono-1.14/src/modem.c:get_modem_property() modem
> > 0x556dd280 property AlwaysOnline
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_set_online() modem
> > 0x556dd280 online
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CCWA=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]:
> >
> /ofono-1.14/drivers/huaweimodem/voicecall.c:huawei_voicecall_initialized()
> > registering to notifications
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_state_watch()
> 0x556e7628
> > ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
> > Bluetooth: Registering 0000111f-0000-1000-8000-00805f9b34fb (hfp_ag)
> > profile
> > ofonod[30943]: PCUI: > AT^CVOICE=3D?\r
> > ofonod[30943]: PCUI: < \r\n^CVOICE: (0)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSCS=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CSCS: ("IRA","UCS2","GSM")\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT^SYSCFG=3D?\r
> > ofonod[30943]: PCUI: < \r\n^SYSCFG:
> >
> >
> (2,13,14,16),(0-3),((2000000400380,"GSM900/GSM1800/WCDMA900/WCDMA2100"),(=
280000,"GSM850/GSM1900"),(3fffffff,"All
> > bands")),(0-2),(0-4)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSMS=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_csms_query_cb() CSMS
> > query parsed successfully
> > ofonod[30943]: PCUI: > AT+CGDCONT=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CGDCONT:
> > (1-11),"IP",,,(0-2),(0-3),(0,1),(0,1)\r\n+CGDCONT:
> > (1-11),"PPP",,,(0-2),(0-3),(0,1),(0,1)\r\n\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28480,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100220683026F40A5038001718A01058B036F0605800200CC8800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CFUN=3D1\r
> > ofonod[30943]: RegisterProfile() replied an error:
> > org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> > unknown return code 1
> > ofonod[30943]: PCUI: < \r\n^SIMST:0,0\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 1 -> 0
> > ofonod[30943]: PCUI: < \r\nOK\r\n\r\n^SIMST:1,0\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:simst_notify() 0 -> 1
> > ofonod[30943]: PCUI: > AT+CPBS=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CPBS: ("SM","EN","ON","FD")\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSMS=3D1\r
> > ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGREG=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,1,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"4D79204E756D626572FFFFFFFFFFFFFFFFFFFFFF0791538313977848FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT^SYSINFO\r
> > ofonod[30943]: PCUI: < \r\n^SYSINFO:0,3,0,0,1,0,0\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:sysinfo_online_cb() 1 -> 1
> > ofonod[30943]: /ofono-1.14/src/modem.c:modem_change_state() old state: =
2,
> > new state: 3
> > ofonod[30943]: /ofono-1.14/plugins/huawei.c:huawei_post_online()
> 0x556dd280
> > ofonod[30943]: PCUI: > AT+CSMS?\r
> > ofonod[30943]: PCUI: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGREG=3D2\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGAUTO=3D0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CGEREP=3D2,1\r
> > ofonod[30943]: PCUI: < \r\nERROR\r\n
> > ofonod[30943]: /ofono-1.14/plugins/bluez5.c:bt_register_profile()
> > Bluetooth: Registering 00001103-0000-1000-8000-00805f9b34fb (dun_gw)
> > profile
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,2,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CREG=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CREG: (0-2)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSCB=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CSCB:(0,1)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CUSD=3D1\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: RegisterProfile() replied an error:
> > org.freedesktop.DBus.Error.Spawn.ChildExited, Launch helper exited with
> > unknown return code 1
> > ofonod[30943]: PCUI: > AT+CMGF=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,3,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CREG=3D2\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/sim.c:ofono_sim_add_spn_watch() 0x556e76=
28
> > ofonod[30943]:
> /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> > 0x556e70d8
> > ofonod[30943]: PCUI: > AT+CSCB=3D0\r
> > ofonod[30943]: PCUI: < \r\n^MODE: 5,4\r\n
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_got_imsi() Got IMSI:
> > 272050100413580
> > ofonod[30943]:
> /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> > 0x556e70d8
> > ofonod[30943]: PCUI: > AT+CPMS=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CPMS:
> > ("SM","ME"),("SM","ME"),("SM","ME")\r\n\r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,4,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CREG?\r
> > ofonod[30943]: PCUI: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> > /huawei_1 status 2 tech -1
> > ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
> > 0x556e70d8, (nil)
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 2, -1, -1,
> -1,
> > (null)(null)
> > ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 2
> > ofonod[30943]: PCUI: > AT+CMGF=3D0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,5,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CPMS=3D"ME","ME","ME"\r
> > ofonod[30943]: PCUI: < \r\n+CPMS: 0,20,0,20,0,20\r\n\r\nOK\r\n\r\n^RSSI:
> > 13\r\n\r\n^HCSQ:"WCDMA",40,34,53\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28480,6,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CNMI=3D?\r
> > ofonod[30943]: PCUI: < \r\n+CNMI:
> > (0-2),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:build_cnmi_string()
> > ofonod[30943]: PCUI: > AT+CNMI=3D1,1,2,1,0\r
> > ofonod[30943]: Duplicate EFsdn entries for `Emergency Services'
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]:
> /ofono-1.14/src/network.c:__ofono_netreg_add_status_watch()
> > 0x556e70d8
> > ofonod[30943]: /ofono-1.14/src/sms.c:sms_restore_tx_queue()
> > ofonod[30943]: /ofono-1.14/plugins/push-notification.c:sms_watch()
> > registered
> > ofonod[30943]: /ofono-1.14/plugins/smart-messaging.c:sms_watch()
> registered
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28618,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100060583026FCAA5038001718A01058B036F06058002001E8800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CMGL=3D4\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sms.c:at_cmgl_done()
> > ofonod[30943]: PCUI: > AT+CGSMS=3D3\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,1,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,2,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,3,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,4,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28618,5,4,6\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"000000000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 6
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28617,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100050583026FC9A5038001718A01058B036F0602800200198800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,1,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,2,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,3,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,4,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28617,5,4,5\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 144,0,"0100000000"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 5
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28433,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/message-waiting.c:mw_cphs_mwis_read_cb()
> No
> > CPHS MWIS on SIM
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28619,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100100583026FCBA5038001718A01058B036F0605800200508800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,1,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,2,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,3,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,4,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28619,5,4,16\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> > 144,0,"FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 16
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> > seekoff: 39, toread: 17
> > ofonod[30943]: /ofono-1.14/src/simfs.c:sim_fs_op_read_block() bufoff: 0,
> > seekoff: 39, toread: 10
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/cbs.c:at_cbs_set_topics()
> > ofonod[30943]: PCUI: > AT+CSCB=3D0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CSCB=3D0,"0,50,214,4352-4356"\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n^SRVST: 2\r\n\r\n+CGREG:
> > 1,"0040","02C10178"\r\n\r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/src/gprs.c:ofono_gprs_status_notify()
> /huawei_1
> > status 1
> > ofonod[30943]: PCUI: > AT+CRSM=3D192,28615,0,0,255\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"621E8205422100220583026FC7A5038001718A01058B036F0602800200AA8800"\=
r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_info_cb()
> > crsm_info_cb: 90, 00, 32
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,1,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"4D61696CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0791538333331317FFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,2,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,3,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,4,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: > AT+CRSM=3D178,28615,5,4,34\r
> > ofonod[30943]: PCUI: < \r\n+CRSM:
> >
> >
> 144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FF"\r\n\r\nOK\r\n
> > ofonod[30943]: /ofono-1.14/drivers/atmodem/sim.c:at_crsm_read_cb()
> > crsm_read_cb: 90, 00, 34
> > ofonod[30943]: PCUI: < \r\n+CREG: 1,"0040","02C10178"\r\n
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_status_notify()
> > /huawei_1 status 1 tech 2
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, =
2,
> > (null)(null)
> > ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> > ofonod[30943]: PCUI: > AT+COPS=3D3,2\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+COPS?\r
> > ofonod[30943]: PCUI: < \r\n+COPS: 0,2,"27205",2\r\n\r\nOK\r\n
> > ofonod[30943]:
> > /ofono-1.14/drivers/atmodem/network-registration.c:cops_numeric_cb() Co=
ps
> > numeric got mcc: 272, mnc: 05
> > ofonod[30943]: PCUI: > AT+CSQ\r
> > ofonod[30943]: PCUI: < \r\n+CSQ: 13,99\r\n\r\nOK\r\n
> > ofonod[30943]:
> /ofono-1.14/drivers/atmodem/network-registration.c:csq_cb()
> > csq_cb: 13
> > ofonod[30943]: /ofono-1.14/src/network.c:ofono_netreg_strength_notify()
> > strength 41
> > ofonod[30943]: PCUI: > AT+COPS=3D3,0\r
> > ofonod[30943]: PCUI: < \r\nOK\r\n
> > ofonod[30943]: PCUI: > AT+COPS?\r
> > ofonod[30943]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
> > ofonod[30943]:
> /ofono-1.14/drivers/atmodem/network-registration.c:cops_cb()
> > cops_cb: 3 IRL, 272 05 2
> > ofonod[30943]: /ofono-1.14/src/network.c:current_operator_callback()
> > 0x556e70d8, (nil)
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, -1, -1, =
2,
> > 27205
> > ofonod[30943]: /ofono-1.14/src/cbs.c:cbs_location_changed() 1, 0, 0
> > ofonod[30943]: /ofono-1.14/src/gprs.c:netreg_status_changed() 1
> > ofonod[30943]:
> > /ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_primary()
> cid 1
> > ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() 0x556eb070
> > ofonod[30943]: /ofono-1.14/src/gprs.c:pri_activate_callback() Activating
> > context failed with error: Unknown error type
> > -------------- next part --------------
> > An HTML attachment was scrubbed...
> > URL: <
> >
> http://lists.ofono.org/pipermail/ofono/attachments/20140310/2195a8b0/atta=
chment.html
> > >
> >
> > ------------------------------
> >
> > Subject: Digest Footer
> >
> > _______________________________________________
> > ofono mailing list
> > ofono(a)ofono.org
> > https://lists.ofono.org/mailman/listinfo/ofono
> >
> >
> > ------------------------------
> >
> > End of ofono Digest, Vol 59, Issue 7
> > ************************************
> >
>
>
>
> --
> Homam Dabis | Software Consultant
> m: +353 86 881 4018
> skype: hdabis1
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <
> http://lists.ofono.org/pipermail/ofono/attachments/20140312/03376359/atta=
chment.html
> >
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: BAC7E76C-8B6C-463B-8B8E-8703BA6787AC[6].png
> Type: image/png
> Size: 8406 bytes
> Desc: not available
> URL: <
> http://lists.ofono.org/pipermail/ofono/attachments/20140312/03376359/atta=
chment.png
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
> End of ofono Digest, Vol 59, Issue 12
> *************************************
>

--===============9101639083990510875==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SW4gZmFjdCBpdCBzZWVtcyB0aGF0IEkgYW0gdW5hYmxlIHRvIGRvIHRo
ZSBmb2xsb3dpbmc6PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PnJvb3RAc21wODY3MDp+IyBkYnVz
LXNlbmQgLS1zeXN0ZW0gLS1wcmludC1yZXBseSAtLWRlc3Q9b3JnLm9mb25vIC9odWF3ZWlfMi9j
b250ZXh0MSBvcmcub2Zvbm8uQ29ubmVjdGlvbkNvbnRleHQuU2V0UHJvcGVydHkgc3RyaW5nOiZx
dW90O0FjdGl2ZSZxdW90OyB2YXJpYW50OmJvb2xlYW46dHJ1ZTwvZGl2Pgo8ZGl2Pm1ldGhvZCBy
ZXR1cm4gc2VuZGVyPToxLjIzNyAtJmd0OyBkZXN0PToxLjI1MyByZXBseV9zZXJpYWw9MjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+cm9vdEBzbXA4NjcwOn4jIGRidXMtc2VuZCAtLXN5c3RlbSAt
LXByaW50LXJlcGx5IC0tZGVzdD1vcmcub2Zvbm8gL2h1YXdlaV8yL2NvbnRleHQxIG9yZy5vZm9u
by5Db25uZWN0aW9uQ29udGV4dC5TZXRQcm9wZXJ0eSBzdHJpbmc6JnF1b3Q7QWN0aXZlJnF1b3Q7
IHZhcmlhbnQ6Ym9vbGVhbjpmYWxzZTwvZGl2Pgo8ZGl2Pm1ldGhvZCByZXR1cm4gc2VuZGVyPTox
LjIzNyAtJmd0OyBkZXN0PToxLjI1NiByZXBseV9zZXJpYWw9MjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+cm9vdEBzbXA4NjcwOn4jIGRidXMtc2VuZCAtLXN5c3RlbSAtLXByaW50LXJlcGx5IC0t
ZGVzdD1vcmcub2Zvbm8gL2h1YXdlaV8yL2NvbnRleHQxIG9yZy5vZm9uby5Db25uZWN0aW9uQ29u
dGV4dC5TZXRQcm9wZXJ0eSBzdHJpbmc6JnF1b3Q7QWN0aXZlJnF1b3Q7IHZhcmlhbnQ6Ym9vbGVh
bjp0cnVloDwvZGl2Pgo8ZGl2PkVycm9yIG9yZy5vZm9uby5FcnJvci5GYWlsZWQ6IE9wZXJhdGlv
biBmYWlsZWQ8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldpdGggb2Zvbm8gZXJyb3IgbG9nIGFz
IGJlZm9yZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhvbWFtPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPgpPbiAxMiBNYXJjaCAyMDE0IDEwOjM0LCAgPHNwYW4gZGlyPSJs
dHIiPiZsdDs8YSBocmVmPSJtYWlsdG86b2Zvbm8tcmVxdWVzdEBvZm9uby5vcmciIHRhcmdldD0i
X2JsYW5rIj5vZm9uby1yZXF1ZXN0QG9mb25vLm9yZzwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIw
NCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpTZW5kIG9m
b25vIG1haWxpbmcgbGlzdCBzdWJtaXNzaW9ucyB0bzxicj4KoCCgIKAgoCA8YSBocmVmPSJtYWls
dG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YnI+ClRvIHN1YnNj
cmliZSBvciB1bnN1YnNjcmliZSB2aWEgdGhlIFdvcmxkIFdpZGUgV2ViLCB2aXNpdDxicj4KoCCg
IKAgoCA8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29m
b25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0
aW5mby9vZm9ubzwvYT48YnI+Cm9yLCB2aWEgZW1haWwsIHNlbmQgYSBtZXNzYWdlIHdpdGggc3Vi
amVjdCBvciBib2R5ICYjMzk7aGVscCYjMzk7IHRvPGJyPgqgIKAgoCCgIDxhIGhyZWY9Im1haWx0
bzpvZm9uby1yZXF1ZXN0QG9mb25vLm9yZyI+b2Zvbm8tcmVxdWVzdEBvZm9uby5vcmc8L2E+PGJy
Pgo8YnI+CllvdSBjYW4gcmVhY2ggdGhlIHBlcnNvbiBtYW5hZ2luZyB0aGUgbGlzdCBhdDxicj4K
oCCgIKAgoCA8YSBocmVmPSJtYWlsdG86b2Zvbm8tb3duZXJAb2Zvbm8ub3JnIj5vZm9uby1vd25l
ckBvZm9uby5vcmc8L2E+PGJyPgo8YnI+CldoZW4gcmVwbHlpbmcsIHBsZWFzZSBlZGl0IHlvdXIg
U3ViamVjdCBsaW5lIHNvIGl0IGlzIG1vcmUgc3BlY2lmaWM8YnI+CnRoYW4gJnF1b3Q7UmU6IENv
bnRlbnRzIG9mIG9mb25vIGRpZ2VzdC4uLiZxdW90Ozxicj4KPGJyPgo8YnI+ClRvZGF5JiMzOTtz
IFRvcGljczo8YnI+Cjxicj4KoCCgMS4gUmU6IFtQQVRDSF0gUG9ydCBvZm9ubyB0ZXN0IHNjcmlw
dHMgdG8gYWxzbyB3b3JrIHdpdGggUHl0aG9uMzxicj4KoCCgIKAgKERlbmlzIEtlbnppb3IpPGJy
PgqgIKAyLiBSZTogUHJvYmxlbSByZWNvbm5lY3Rpbmcgd2hlbiAzRyBkb25nbGUgaXMgcmUtaW5z
ZXJ0ZWQ8YnI+CqAgoCCgIChIb21hbSBEYWJpcyk8YnI+Cjxicj4KPGJyPgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PGJyPgo8YnI+Ck1lc3NhZ2U6IDE8YnI+CkRhdGU6IFR1ZSwgMTEgTWFyIDIwMTQgMTQ6NDQ6Mzgg
LTA1MDA8YnI+CkZyb206IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56
QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozxicj4KVG86IDxhIGhyZWY9Im1h
aWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+ClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIFBvcnQgb2Zvbm8gdGVzdCBzY3JpcHRzIHRvIGFsc28gd29yayB3aXRoIFB5dGhv
bjM8YnI+Ck1lc3NhZ2UtSUQ6ICZsdDs8YSBocmVmPSJtYWlsdG86NTMxRjY3QTYuNjAyMDQwOUBn
bWFpbC5jb20iPjUzMUY2N0E2LjYwMjA0MDlAZ21haWwuY29tPC9hPiZndDs8YnI+CkNvbnRlbnQt
VHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1JU08tODg1OS0xOyBmb3JtYXQ9Zmxvd2VkPGJyPgo8
YnI+CkhpIE1hcnRpbiw8YnI+Cjxicj4KoCZndDsmZ3Q7IEkmIzM5O20gb2theSBtb3ZpbmcgdG8g
UHl0aG9uIDMsIGJ1dCB5b3UgbWlnaHQgd2FudCB0byBzZW5kIHRoaXMgYXMgYW48YnI+CiZndDsm
Z3Q7IFJGQyB0byBnYXJuZXIgbW9yZSBmZWVkYmFjay48YnI+CiZndDs8YnI+CiZndDsgVGhhdCBw
YXRjaCBpcyBhIGxvdCBzbWFsbGVyLCBzbyBpdCBjYW4gYmUgYXBwbGllZCBpbmRlcGVuZGVudGx5
IG9mIHRoZTxicj4KJmd0OyBvdGhlciBmb3VyLiBXaGF0IHlvdSBtZWFuIHdpdGggJnF1b3Q7c2Vu
ZCBhcyBSRkMmcXVvdDsgb3RoZXIgdGhhbiBzZW5kaW5nIGl0IHRvPGJyPgomZ3Q7IHRoZSBNTCBm
b3IgcmV2aWV3Pzxicj4KPGJyPgpKdXN0IG1lYW5zIHRvIHByZWNlZWQgdGhhdCBwYXRjaCB0aXRs
ZSB3aXRoICYjMzk7UkZDOiYjMzk7IKBCdXQgbm8gd29ycmllcyw8YnI+CndlJiMzOTtsbCBmaWd1
cmUgaXQgb3V0Ljxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8YnI+Cjxicj4KPGJy
PgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Cjxicj4KTWVzc2FnZTogMjxicj4K
RGF0ZTogV2VkLCAxMiBNYXIgMjAxNCAxMDozNToxMyArMDAwMDxicj4KRnJvbTogSG9tYW0gRGFi
aXMgJmx0OzxhIGhyZWY9Im1haWx0bzpoZGFiaXNAZGlnaXNvZnQudHYiPmhkYWJpc0BkaWdpc29m
dC50djwvYT4mZ3Q7PGJyPgpUbzogPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zv
bm9Ab2Zvbm8ub3JnPC9hPjxicj4KU3ViamVjdDogUmU6IFByb2JsZW0gcmVjb25uZWN0aW5nIHdo
ZW4gM0cgZG9uZ2xlIGlzIHJlLWluc2VydGVkPGJyPgpNZXNzYWdlLUlEOjxicj4KoCCgIKAgoCAm
bHQ7PGEgaHJlZj0ibWFpbHRvOkNBSyUyQnNmb3VlX242UF96R01ZcmRwLTVtZ20tVVpZaXZrTSUy
QlhXNmZnNF9mc3pCakxuYUFAbWFpbC5nbWFpbC5jb20iPkNBSytzZm91ZV9uNlBfekdNWXJkcC01
bWdtLVVaWWl2a00rWFc2Zmc0X2ZzekJqTG5hQUBtYWlsLmdtYWlsLmNvbTwvYT4mZ3Q7PGJyPgpD
b250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9JnF1b3Q7aXNvLTg4NTktMSZxdW90Ozxi
cj4KPGJyPgpIaSw8YnI+Cjxicj4KSSBoYXZlIHNpbXBsaWZpZWQgdGhlIHByb2Nlc3MgYnkgZWxp
bWluYXRpbmcgY29ubm1hbiBhbmQgZm9jdXNpbmcgb24gb2Zvbm8uPGJyPgo8YnI+CkkgaW5zZXJ0
IHRoZSBkb25nbGUgYW5kIHJ1biB0aGUgZm9sbG93aW5nOjxicj4KPGJyPgpvb3RAc21wODY3MDp+
IyBkYnVzLXNlbmQgLS1zeXN0ZW0gLS1wcmludC1yZXBseSAtLWRlc3Q9b3JnLm9mb25vIC88YnI+
Cm9yZy5vZm9uby5NYW5hZ2VyLkdldE1vZGVtczxicj4KbWV0aG9kIHJldHVybiBzZW5kZXI9OjEu
ODYgLSZndDsgZGVzdD06MS45MyByZXBseV9zZXJpYWw9Mjxicj4KoCCgYXJyYXkgWzxicj4KoCCg
IKAgc3RydWN0IHs8YnI+CqAgoCCgIKAgoG9iamVjdCBwYXRoICZxdW90Oy9odWF3ZWlfMCZxdW90
Ozxicj4KoCCgIKAgoCCgYXJyYXkgWzxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAg
oCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtPbmxpbmUmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAg
oHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxzZTxicj4KoCCgIKAgoCCgIKAg
KTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAm
cXVvdDtQb3dlcmVkJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCg
IKAgoCCgIGJvb2xlYW4gZmFsc2U8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoCCgIGRp
Y3QgZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7TG9ja2Rvd24mcXVvdDs8
YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxz
ZTxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCg
IKAgoCCgIKAgoHN0cmluZyAmcXVvdDtFbWVyZ2VuY3kmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAg
oHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxzZTxicj4KoCCgIKAgoCCgIKAg
KTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAm
cXVvdDtJbnRlcmZhY2VzJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAg
oCCgIKAgoCCgIGFycmF5IFs8YnI+CqAgoCCgIKAgoCCgIKAgoCCgIF08YnI+CqAgoCCgIKAgoCCg
ICk8YnI+CqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcg
JnF1b3Q7RmVhdHVyZXMmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCg
IKAgoCCgIKAgYXJyYXkgWzxicj4KoCCgIKAgoCCgIKAgoCCgIKAgXTxicj4KoCCgIKAgoCCgIKAg
KTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAm
cXVvdDtUeXBlJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAg
oCCgIHN0cmluZyAmcXVvdDtoYXJkd2FyZSZxdW90Ozxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCg
IKAgoCCgXTxicj4KoCCgIKAgfTxicj4KoCCgXTxicj4KPGJyPgpyb290QHNtcDg2NzA6fiMgZGJ1
cy1zZW5kIC0tc3lzdGVtIC0tcHJpbnQtcmVwbHkgLS1kZXN0PW9yZy5vZm9ubyAvaHVhd2VpXzA8
YnI+Cm9yZy5vZm9uby5Nb2RlbS5TZXRQcm9wZXJ0eSBzdHJpbmc6JnF1b3Q7UG93ZXJlZCZxdW90
OyB2YXJpYW50OmJvb2xlYW46dHJ1ZTxicj4KbWV0aG9kIHJldHVybiBzZW5kZXI9OjEuODYgLSZn
dDsgZGVzdD06MS45NSByZXBseV9zZXJpYWw9Mjxicj4KPGJyPgpyb290QHNtcDg2NzA6fiMgZGJ1
cy1zZW5kIC0tc3lzdGVtIC0tcHJpbnQtcmVwbHkgLS1kZXN0PW9yZy5vZm9ubyAvaHVhd2VpXzA8
YnI+Cm9yZy5vZm9uby5Nb2RlbS5TZXRQcm9wZXJ0eSBzdHJpbmc6JnF1b3Q7T25saW5lJnF1b3Q7
IHZhcmlhbnQ6Ym9vbGVhbjp0cnVlPGJyPgptZXRob2QgcmV0dXJuIHNlbmRlcj06MS44NiAtJmd0
OyBkZXN0PToxLjk2IHJlcGx5X3NlcmlhbD0yPGJyPgo8YnI+CnJvb3RAc21wODY3MDp+IyBkYnVz
LXNlbmQgLS1zeXN0ZW0gLS1wcmludC1yZXBseSAtLWRlc3Q9b3JnLm9mb25vIC9odWF3ZWlfMDxi
cj4Kb3JnLm9mb25vLkNvbm5lY3Rpb25NYW5hZ2VyLkdldENvbnRleHRzPGJyPgptZXRob2QgcmV0
dXJuIHNlbmRlcj06MS44NiAtJmd0OyBkZXN0PToxLjk4IHJlcGx5X3NlcmlhbD0yPGJyPgqgIKBh
cnJheSBbPGJyPgqgIKAgoCBzdHJ1Y3Qgezxicj4KoCCgIKAgoCCgb2JqZWN0IHBhdGggJnF1b3Q7
L2h1YXdlaV8wL2NvbnRleHQxJnF1b3Q7PGJyPgqgIKAgoCCgIKBhcnJheSBbPGJyPgqgIKAgoCCg
IKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O05hbWUmcXVv
dDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZx
dW90O0ludGVybmV0JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0
IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O0FjdGl2ZSZxdW90Ozxicj4K
oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBib29sZWFuIGZhbHNlPGJy
PgqgIKAgoCCgIKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCg
IKAgoCCgc3RyaW5nICZxdW90O1R5cGUmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQg
oCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90O2ludGVybmV0JnF1b3Q7PGJyPgqgIKAgoCCg
IKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3Ry
aW5nICZxdW90O1Byb3RvY29sJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCg
IKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtpcCZxdW90Ozxicj4KoCCgIKAgoCCgIKAgKTxicj4K
oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtB
Y2Nlc3NQb2ludE5hbWUmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCg
IKAgoCCgIKAgc3RyaW5nICZxdW90OzNJcmVsYW5kJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCApPGJy
PgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90
O1VzZXJuYW1lJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAg
oCCgIHN0cmluZyAmcXVvdDsmcXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoCCg
IGRpY3QgZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7UGFzc3dvcmQmcXVv
dDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZx
dW90OyZxdW90Ozxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8
YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtTZXR0aW5ncyZxdW90Ozxicj4KoCCgIKAg
oCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBhcnJheSBbPGJyPgqgIKAgoCCgIKAg
oCCgIKAgoCBdPGJyPgqgIKAgoCCgIKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxi
cj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O0lQdjYuU2V0dGluZ3MmcXVvdDs8YnI+CqAg
oCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYXJyYXkgWzxicj4KoCCgIKAg
oCCgIKAgoCCgIKAgXTxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgXTxicj4KoCCgIKAg
fTxicj4KoCCgIKAgc3RydWN0IHs8YnI+CqAgoCCgIKAgoG9iamVjdCBwYXRoICZxdW90Oy9odWF3
ZWlfMC9jb250ZXh0MiZxdW90Ozxicj4KoCCgIKAgoCCgYXJyYXkgWzxicj4KoCCgIKAgoCCgIKAg
ZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtOYW1lJnF1b3Q7PGJy
PgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtJ
bnRlcm5ldCZxdW90Ozxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRy
eSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtBY3RpdmUmcXVvdDs8YnI+CqAgoCCg
IKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxzZTxicj4KoCCg
IKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAg
oHN0cmluZyAmcXVvdDtUeXBlJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCg
IKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtpbnRlcm5ldCZxdW90Ozxicj4KoCCgIKAgoCCgIKAg
KTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAm
cXVvdDtQcm90b2NvbCZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAg
oCCgIKAgoCBzdHJpbmcgJnF1b3Q7aXAmcXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCg
IKAgoCCgIGRpY3QgZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7QWNjZXNz
UG9pbnROYW1lJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAg
oCCgIHN0cmluZyAmcXVvdDszSXJlbGFuZCZxdW90Ozxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCg
IKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtVc2Vy
bmFtZSZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBz
dHJpbmcgJnF1b3Q7JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0
IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O1Bhc3N3b3JkJnF1b3Q7PGJy
PgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDsm
cXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPGJyPgqg
IKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7U2V0dGluZ3MmcXVvdDs8YnI+CqAgoCCgIKAgoCCg
IKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYXJyYXkgWzxicj4KoCCgIKAgoCCgIKAgoCCg
IKAgXTxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAg
oCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtJUHY2LlNldHRpbmdzJnF1b3Q7PGJyPgqgIKAgoCCg
IKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIGFycmF5IFs8YnI+CqAgoCCgIKAgoCCg
IKAgoCCgIF08YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoF08YnI+CqAgoCCgIH08YnI+
CqAgoCCgIHN0cnVjdCB7PGJyPgqgIKAgoCCgIKBvYmplY3QgcGF0aCAmcXVvdDsvaHVhd2VpXzAv
Y29udGV4dDMmcXVvdDs8YnI+CqAgoCCgIKAgoGFycmF5IFs8YnI+CqAgoCCgIKAgoCCgIGRpY3Qg
ZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7TmFtZSZxdW90Ozxicj4KoCCg
IKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7SW50ZXJu
ZXQmcXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPGJy
PgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7QWN0aXZlJnF1b3Q7PGJyPgqgIKAgoCCgIKAg
oCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIGJvb2xlYW4gZmFsc2U8YnI+CqAgoCCgIKAg
oCCgICk8YnI+CqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJp
bmcgJnF1b3Q7VHlwZSZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAg
oCCgIKAgoCBzdHJpbmcgJnF1b3Q7aW50ZXJuZXQmcXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+
CqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7
UHJvdG9jb2wmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCg
IKAgc3RyaW5nICZxdW90O2lwJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCApPGJyPgqgIKAgoCCgIKAg
oCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O0FjY2Vzc1BvaW50
TmFtZSZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBz
dHJpbmcgJnF1b3Q7JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0
IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O1VzZXJuYW1lJnF1b3Q7PGJy
PgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDsm
cXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPGJyPgqg
IKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7UGFzc3dvcmQmcXVvdDs8YnI+CqAgoCCgIKAgoCCg
IKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90OyZxdW90Ozxicj4KoCCg
IKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAg
oHN0cmluZyAmcXVvdDtTZXR0aW5ncyZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCg
IKAgoCCgIKAgoCCgIKAgoCBhcnJheSBbPGJyPgqgIKAgoCCgIKAgoCCgIKAgoCBdPGJyPgqgIKAg
oCCgIKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCg
c3RyaW5nICZxdW90O0lQdjYuU2V0dGluZ3MmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlh
bnQgoCCgIKAgoCCgIKAgoCCgIKAgYXJyYXkgWzxicj4KoCCgIKAgoCCgIKAgoCCgIKAgXTxicj4K
oCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgXTxicj4KoCCgIKAgfTxicj4KoCCgIKAgc3RydWN0
IHs8YnI+CqAgoCCgIKAgoG9iamVjdCBwYXRoICZxdW90Oy9odWF3ZWlfMC9jb250ZXh0NCZxdW90
Ozxicj4KoCCgIKAgoCCgYXJyYXkgWzxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAg
oCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtOYW1lJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2
YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtJbnRlcm5ldCZxdW90Ozxicj4K
oCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCg
IKAgoHN0cmluZyAmcXVvdDtBY3RpdmUmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQg
oCCgIKAgoCCgIKAgoCCgIKAgYm9vbGVhbiBmYWxzZTxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCg
IKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtUeXBl
JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmlu
ZyAmcXVvdDtpbnRlcm5ldCZxdW90Ozxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAg
ZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtQcm90b2NvbCZxdW90
Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1
b3Q7aXAmcXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoCCgIGRpY3QgZW50cnko
PGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7QWNjZXNzUG9pbnROYW1lJnF1b3Q7PGJy
PgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDsm
cXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPGJyPgqg
IKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7VXNlcm5hbWUmcXVvdDs8YnI+CqAgoCCgIKAgoCCg
IKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90OyZxdW90Ozxicj4KoCCg
IKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAg
oHN0cmluZyAmcXVvdDtQYXNzd29yZCZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCg
IKAgoCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCApPGJy
PgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90
O1NldHRpbmdzJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAg
oCCgIGFycmF5IFs8YnI+CqAgoCCgIKAgoCCgIKAgoCCgIF08YnI+CqAgoCCgIKAgoCCgICk8YnI+
CqAgoCCgIKAgoCCgIGRpY3QgZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7
SVB2Ni5TZXR0aW5ncyZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAg
oCCgIKAgoCBhcnJheSBbPGJyPgqgIKAgoCCgIKAgoCCgIKAgoCBdPGJyPgqgIKAgoCCgIKAgoCAp
PGJyPgqgIKAgoCCgIKBdPGJyPgqgIKAgoCB9PGJyPgqgIKAgoCBzdHJ1Y3Qgezxicj4KoCCgIKAg
oCCgb2JqZWN0IHBhdGggJnF1b3Q7L2h1YXdlaV8wL2NvbnRleHQ1JnF1b3Q7PGJyPgqgIKAgoCCg
IKBhcnJheSBbPGJyPgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCg
c3RyaW5nICZxdW90O05hbWUmcXVvdDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAg
oCCgIKAgoCCgIKAgc3RyaW5nICZxdW90O0ludGVybmV0JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCAp
PGJyPgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZx
dW90O0FjdGl2ZSZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCg
IKAgoCBib29sZWFuIGZhbHNlPGJyPgqgIKAgoCCgIKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0
IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O1R5cGUmcXVvdDs8YnI+CqAg
oCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90O2ludGVy
bmV0JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCApPGJyPgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxi
cj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O1Byb3RvY29sJnF1b3Q7PGJyPgqgIKAgoCCg
IKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDtpcCZxdW90Ozxi
cj4KoCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAg
oCCgIKAgoHN0cmluZyAmcXVvdDtBY2Nlc3NQb2ludE5hbWUmcXVvdDs8YnI+CqAgoCCgIKAgoCCg
IKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90OyZxdW90Ozxicj4KoCCg
IKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAg
oHN0cmluZyAmcXVvdDtVc2VybmFtZSZxdW90Ozxicj4KoCCgIKAgoCCgIKAgoCCgdmFyaWFudCCg
IKAgoCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCApPGJy
PgqgIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDxicj4KoCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90
O1Bhc3N3b3JkJnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAg
oCCgIHN0cmluZyAmcXVvdDsmcXVvdDs8YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAgoCCg
IGRpY3QgZW50cnkoPGJyPgqgIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7U2V0dGluZ3MmcXVv
dDs8YnI+CqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgYXJyYXkgWzxi
cj4KoCCgIKAgoCCgIKAgoCCgIKAgXTxicj4KoCCgIKAgoCCgIKAgKTxicj4KoCCgIKAgoCCgIKAg
ZGljdCBlbnRyeSg8YnI+CqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtJUHY2LlNldHRpbmdz
JnF1b3Q7PGJyPgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIGFycmF5
IFs8YnI+CqAgoCCgIKAgoCCgIKAgoCCgIF08YnI+CqAgoCCgIKAgoCCgICk8YnI+CqAgoCCgIKAg
oF08YnI+CqAgoCCgIH08YnI+CqAgoF08YnI+CnJvb3RAc21wODY3MDp+IyBkYnVzLXNlbmQgLS1z
eXN0ZW0gLS1wcmludC1yZXBseSAtLWRlc3Q9b3JnLm9mb25vPGJyPgovaHVhd2VpXzAvY29udGV4
dDEgb3JnLm9mb25vLkNvbm5lY3Rpb25Db250ZXh0LlNldFByb3BlcnR5IHN0cmluZzomcXVvdDtB
Y3RpdmUmcXVvdDs8YnI+CnZhcmlhbnQ6Ym9vbGVhbjp0cnVlPGJyPgpFcnJvciBvcmcub2Zvbm8u
RXJyb3IuRmFpbGVkOiBPcGVyYXRpb24gZmFpbGVkPGJyPgo8YnI+Cjxicj4KVGhlIG9mb25vIGRl
YnVnIGlzIGFzIGZvbGxvd3M6PGJyPgo8YnI+Cjxicj4Kb2Zvbm9kWzE1NjBdOiBvRm9ubyB2ZXJz
aW9uIDEuMTQ8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3BsdWdpbi5jOl9fb2Zv
bm9fcGx1Z2luX2luaXQoKTxicj4Kb2Zvbm9kWzE1NjBdOjxicj4KL29mb25vLTEuMTQvcGx1Z2lu
cy9wdXNoLW5vdGlmaWNhdGlvbi5jOnB1c2hfbm90aWZpY2F0aW9uX2luaXQoKTxicj4Kb2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOnNtYXJ0X21lc3Nh
Z2luZ19pbml0KCk8YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9jZG1hLXBy
b3Zpc2lvbi5jOm9mb25vX2NkbWFfcHJvdmlzaW9uX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2
ZXI6IDB4NTU2YzFiYjAgbmFtZTogQ0RNQSBwcm92aXNpb25pbmc8YnI+Cm9mb25vZFsxNTYwXTo8
YnI+Ci9vZm9uby0xLjE0L3NyYy9ncHJzLXByb3Zpc2lvbi5jOm9mb25vX2dwcnNfcHJvdmlzaW9u
X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzFiODAgbmFtZTogUHJvdmlzaW9u
aW5nPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvZHVuX2d3X2JsdWV6NS5j
OmR1bl9nd19pbml0KCk8YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9oYW5k
c2ZyZWUtYXVkaW8uYzpvZm9ub19oYW5kc2ZyZWVfY2FyZF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4K
ZHJpdmVyOiAweDU1NmMxYTUwPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzFhNjAs
IG5hbWU6IGhmcDxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2hlOTEwLmM6
aGU5MTBfaW5pdCgpPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9m
b25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzE5ZTAsIG5hbWU6
IGhlOTEwPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvY29ubm1hbi5jOmNv
bm5tYW5faW5pdCgpPGJyPgpvZm9ub2RbMTU2MF06PGJyPgovb2Zvbm8tMS4xNC9zcmMvcHJpdmF0
ZS1uZXR3b3JrLmM6b2Zvbm9fcHJpdmF0ZV9uZXR3b3JrX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpk
cml2ZXI6IDB4NTU2YzE5YjAsIG5hbWU6IENvbm5NYW4gUHJpdmF0ZSBOZXR3b3JrPGJyPgpvZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzE5NjAsIG5hbWU6IHNpbTkwMDxicj4Kb2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6PGJyPgoweDU1NmMxOTEwLCBuYW1lOiBzYW1zdW5nPGJyPgpvZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjo8YnI+CjB4NTU2YzE4YzAsIG5hbWU6IHNwZWVkdXBjZG1hPGJyPgpvZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjo8YnI+CjB4NTU2YzE4NzAsIG5hbWU6IHNwZWVkdXA8YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
Ojxicj4KMHg1NTZjMTgyMCwgbmFtZTogYWxjYXRlbDxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJy
PgoweDU1NmMxN2MwLCBuYW1lOiBpY2VyYTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9z
cmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1
NmMxNzcwLCBuYW1lOiBsaW5rdG9wPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzE3
MjAsIG5hbWU6IG5va2lhY2RtYTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMxNmQw
LCBuYW1lOiBub2tpYTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpv
Zm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMxNjgwLCBuYW1l
OiB0YzY1PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21v
ZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzE1ZjAsIG5hbWU6IHN0ZTxi
cj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMxNTkwLCBuYW1lOiBpZng8YnI+Cm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMTU0MCwgbmFtZTogcGFsbXByZTxicj4Kb2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KSBkcml2ZXI6PGJyPgoweDU1NmMxNGYwLCBuYW1lOiBub3ZhdGVsPGJyPgpvZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjo8YnI+CjB4NTU2YzE0YTAsIG5hbWU6IHNpZXJyYTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
PGJyPgoweDU1NmMxNDIwLCBuYW1lOiBodWF3ZWk8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEu
MTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4K
MHg1NTZjMTNkMCwgbmFtZTogenRlPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzEz
NzAsIG5hbWU6IGhzbzxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpv
Zm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMxMzIwLCBuYW1l
OiBtYm08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9k
ZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMTJkMCwgbmFtZTogY2FseXBz
bzxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMxMjgwLCBuYW1lOiB3YXZlY29tPGJy
PgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzEyMzAsIG5hbWU6IGcxPGJyPgpvZm9ub2Rb
MTU2MF06PGJyPgovb2Zvbm8tMS4xNC9zcmMvY2RtYS12b2ljZWNhbGwuYzpvZm9ub19jZG1hX3Zv
aWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxMWEwLCBuYW1lOiBj
ZG1hbW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9f
ZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMxMWMwLCBuYW1lOiBj
ZG1hbW9kZW08YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9jZG1hLWNvbm5t
YW4uYzpvZm9ub19jZG1hX2Nvbm5tYW5fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1
NTZjMTFmMCwgbmFtZTogY2RtYW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2
YzExMWMsIG5hbWU6IHBob25lc2ltPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9t
b2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzEx
NTQsIG5hbWU6IGxvY2FsaGZwPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2
YzExMDQsIG5hbWU6IHBob25lc2ltPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9j
dG0uYzpvZm9ub19jdG1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMTBmMCwg
bmFtZTogcGhvbmVzaW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9waG9u
ZXNpbS5jOnBhcnNlX2NvbmZpZygpIGZpbGVuYW1lPGJyPgovZXRjL29mb25vL3Bob25lc2ltLmNv
bmY8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2Ry
aXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzEwYjAsIG5hbWU6IHNwZWVkdXBtb2Rl
bTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9p
Y2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBmNTAsIG5hbWU6IGhm
cG1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2Rl
dmluZm9fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMTAxMCwgbmFtZTogaGZw
bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19u
ZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMGZhMCwgbmFtZTogaGZw
bW9kZW08YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9jYWxsLXZvbHVtZS5j
Om9mb25vX2NhbGxfdm9sdW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzBm
ZTAsIG5hbWU6IGhmcG1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9oYW5k
c2ZyZWUuYzpvZm9ub19oYW5kc2ZyZWVfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1
NTZjMTAzMCwgbmFtZTogaGZwbW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3Jj
L3NpcmkuYzpvZm9ub19zaXJpX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzEw
NjAsIG5hbWU6IGhmcG1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9uZXR3
b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBl
YzAsIG5hbWU6IGR1bm1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6b2Zvbm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwZWYwLCBu
YW1lOiBkdW5tb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxs
LmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBk
ZjAsIG5hbWU6IHN0ZW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2
YzBlNzAsIG5hbWU6IHN0ZW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06PGJyPgovb2Zvbm8tMS4xNC9z
cmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIo
KTxicj4KZHJpdmVyOiAweDU1NmMwZTQwLCBuYW1lOiBzdGVtb2RlbTxicj4Kb2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdp
c3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBjYjAsIG5hbWU6IGlmeG1vZGVtPGJyPgpvZm9ub2Rb
MTU2MF06PGJyPgovb2Zvbm8tMS4xNC9zcmMvYXVkaW8tc2V0dGluZ3MuYzpvZm9ub19hdWRpb19z
ZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwZDAwLCBuYW1lOiBp
Znhtb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOjxicj4KL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRp
bmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjog
MHg1NTZjMGQyMCwgbmFtZTogaWZ4bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
c3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZl
cjogMHg1NTZjMGQ1MCwgbmFtZTogaWZ4bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEu
MTQvc3JjL3N0ay5jOm9mb25vX3N0a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1
NmMwZDgwLCBuYW1lOiBpZnhtb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMv
Y3RtLmM6b2Zvbm9fY3RtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzBkYjAs
IG5hbWU6IGlmeG1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6
b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBj
NDAsIG5hbWU6IGhzb21vZGVtPGJyPgpvZm9ub2RbMTU2MF06PGJyPgovb2Zvbm8tMS4xNC9zcmMv
cmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxi
cj4KZHJpdmVyOiAweDU1NmMwYzYwLCBuYW1lOiBoc29tb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIo
KTxicj4KZHJpdmVyOiAweDU1NmMwYmIwLCBuYW1lOiBtYm1tb2RlbTxicj4Kb2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4NTU2YzBiZTAsIG5hbWU6IG1ibW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06PGJyPgov
b2Zvbm8tMS4xNC9zcmMvbG9jYXRpb24tcmVwb3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0
aW5nX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBjMDAsIG5hbWU6IG1ibW1v
ZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192
b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMGIyMCwgbmFtZTog
Y2FseXBzb21vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zdGsuYzpvZm9u
b19zdGtfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMGI3MCwgbmFtZTogY2Fs
eXBzb21vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy91c3NkLmM6b2Zvbm9f
dXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwYTAwLCBuYW1lOiBodWF3
ZWltb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zv
bm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzBhMjAsIG5h
bWU6IGh1YXdlaW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06PGJyPgovb2Zvbm8tMS4xNC9zcmMvYXVk
aW8tc2V0dGluZ3MuYzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxicj4K
ZHJpdmVyOiAweDU1NmMwYTcwLCBuYW1lOiBodWF3ZWltb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOjxi
cj4KL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3Nf
ZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMGFiMCwgbmFtZTogaHVhd2VpbW9k
ZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2Nv
bnRleHRfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMGE5MCwgbmFtZTogaHVh
d2VpbW9kZW08YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9jZG1hLW5ldHJl
Zy5jOm9mb25vX2NkbWFfbmV0cmVnX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2
YzBhZTAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Ny
Yy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6
IDB4NTU2YzA5NzAsIG5hbWU6IGljZXJhbW9kZW08YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9u
by0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9y
ZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzA5YTAsIG5hbWU6IGljZXJhbW9kZW08YnI+Cm9m
b25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3Jh
ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzA5MjAsIG5h
bWU6IHp0ZW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zv
bm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzA4ZTAs
IG5hbWU6IHN3bW9kZW08YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9yYWRp
by1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpk
cml2ZXI6IDB4NTU2YzA4OTAsIG5hbWU6IG53bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKTxi
cj4KZHJpdmVyOiAweDU1NmMwNmIwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9v
Zm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2RldmluZm9fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+
CmRyaXZlcjogMHg1NTZjMDc2MCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOjxicj4K
L29mb25vLTEuMTQvc3JjL2NhbGwtYmFycmluZy5jOm9mb25vX2NhbGxfYmFycmluZ19kcml2ZXJf
cmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwNzEwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9u
b2RbMTU2MF06PGJyPgovb2Zvbm8tMS4xNC9zcmMvY2FsbC1mb3J3YXJkaW5nLmM6b2Zvbm9fY2Fs
bF9mb3J3YXJkaW5nX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YzA0ODAsIG5h
bWU6IGF0bW9kZW08YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9jYWxsLW1l
dGVyLmM6b2Zvbm9fY2FsbF9tZXRlcl9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1
NmMwNGIwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMTU2MF06PGJyPgovb2Zvbm8tMS4xNC9z
cmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCk8
YnI+CmRyaXZlcjogMHg1NTZjMDM5MCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9zcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3Rl
cigpPGJyPgpkcml2ZXI6IDB4NTU2YzA3MzAsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFsxNTYw
XTogL29mb25vLTEuMTQvc3JjL3Vzc2QuYzpvZm9ub191c3NkX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjo8YnI+CjB4NTU2YzA2ODAsIG5hbWU6IGF0bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvc3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJy
PgoweDU1NmMwNDAwLCBuYW1lOiBhdG1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3NyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZj
MDU2MCwgbmFtZTogYXRtb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2lt
LmM6b2Zvbm9fc2ltX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzA1YTgsIG5h
bWU6IGF0bW9kZW0tbm9lZjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6
b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzA2NjAsIG5hbWU6
IGF0bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9u
b19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMDUwMCwgbmFtZTog
YXRtb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6b2Zvbm9fY2Jz
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzA0NjAsIG5hbWU6IGF0bW9kZW08
YnI+Cm9mb25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9jYWxsLXZvbHVtZS5jOm9mb25v
X2NhbGxfdm9sdW1lX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzA3OTAsIG5h
bWU6IGF0bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9u
b19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzA3ZDAsIG5hbWU6IGF0
bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJz
X2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZjMDgwMCwgbmFtZTog
YXRtb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLWF1dGguYzpvZm9u
b19zaW1fYXV0aF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwODIwLCBuYW1l
OiBhdG1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9nbnNzLmM6b2Zvbm9f
Z25zc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwODQwLCBuYW1lOiBhdG1v
ZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVt
X2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YzAxYjAsIG5hbWU6IGdvYmk8YnI+
Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2
ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmJmZjgwLCBuYW1lOiBxbWltb2RlbTxicj4K
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19kcml2
ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmJmZmYwLCBuYW1lOiBxbWltb2RlbTxicj4K
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxs
X2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YmZmYTAsIG5hbWU6IHFtaW1vZGVt
PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMDAyMCwgbmFtZTogcW1pbW9kZW0tbGVnYWN5
PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZjMDA3MCwgbmFtZTogcW1pbW9kZW08YnI+Cm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3Ntcy5jOm9mb25vX3Ntc19kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmMwMGMwLCBuYW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOjxicj4KMHg1NTZjMDBlMCwgbmFtZTogcW1pbW9kZW08YnI+Cm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CjB4NTU2YzAxMDAsIG5hbWU6IHFtaW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9u
by0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJy
Pgpkcml2ZXI6IDB4NTU2YzAxMjAsIG5hbWU6IHFtaW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06PGJy
Pgovb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19k
cml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmMwMTQwLCBuYW1lOiBxbWltb2RlbTxi
cj4Kb2Zvbm9kWzE1NjBdOjxicj4KL29mb25vLTEuMTQvc3JjL2xvY2F0aW9uLXJlcG9ydGluZy5j
Om9mb25vX2xvY2F0aW9uX3JlcG9ydGluZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAw
eDU1NmMwMTcwLCBuYW1lOiBxbWltb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9z
cmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1
NmJmZjJjLCBuYW1lOiB1ODUwMDxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpvZm9ub19kZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YmZm
MTAsIG5hbWU6IHU4NTAwPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YmZlYzAsIG5h
bWU6IG45MDA8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZiZmU3MCwgbmFtZTogaXNp
dXNiPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2Rldmlu
Zm9fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZlcjogMHg1NTZiZmI5MCwgbmFtZTogaXNpbW9k
ZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3Bob25lYm9vay5jOm9mb25vX3Bo
b25lYm9va19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmJmYjgwLCBuYW1lOiBp
c2ltb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25v
X25ldHJlZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmJmYmIwLCBuYW1lOiBp
c2ltb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvdm9pY2VjYWxsLmM6b2Zv
bm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YmZiZTAsIG5h
bWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpvZm9u
b19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZiZmMzMCwgbmFtZTogaXNp
bW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOm9mb25vX2Nic19k
cml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmJmYzUwLCBuYW1lOiBpc2ltb2RlbTxi
cj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjo8YnI+CjB4NTU2YmZjNzAsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0
ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmJmY2MwLCBuYW1lOiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzE1
NjBdOjxicj4KL29mb25vLTEuMTQvc3JjL2NhbGwtZm9yd2FyZGluZy5jOm9mb25vX2NhbGxfZm9y
d2FyZGluZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmJmY2UwLCBuYW1lOiBp
c2ltb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOjxicj4KL29mb25vLTEuMTQvc3JjL2NhbGwtc2V0dGlu
Z3MuYzpvZm9ub19jYWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4
NTU2YmZkMDAsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06PGJyPgovb2Zvbm8tMS4x
NC9zcmMvY2FsbC1iYXJyaW5nLmM6b2Zvbm9fY2FsbF9iYXJyaW5nX2RyaXZlcl9yZWdpc3Rlcigp
IGRyaXZlcjo8YnI+CjB4NTU2YmZkMzAsIG5hbWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06
PGJyPgovb2Zvbm8tMS4xNC9zcmMvY2FsbC1tZXRlci5jOm9mb25vX2NhbGxfbWV0ZXJfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KMHg1NTZiZmQ1MCwgbmFtZTogaXNpbW9kZW08YnI+Cm9m
b25vZFsxNTYwXTo8YnI+Ci9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3Jh
ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgpkcml2ZXI6IDB4NTU2YmZkODAsIG5h
bWU6IGlzaW1vZGVtPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zv
bm9fZ3Byc19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1NmJmZGIwLCBuYW1lOiBp
c2ltb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dw
cnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KZHJpdmVyOiAweDU1NmJmZGQwLCBuYW1l
OiBpc2ltb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOjxicj4KL29mb25vLTEuMTQvc3JjL2F1ZGlvLXNl
dHRpbmdzLmM6b2Zvbm9fYXVkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CmRyaXZl
cjogMHg1NTZiZmRmMCwgbmFtZTogaXNpbW9kZW08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEu
MTQvc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgoweDU1
NmJmZTAwLCBuYW1lOiB3Z21vZGVtMi41PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6dWRldl9zdGFydCgpPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6ZW51bWVyYXRlX2RldmljZXMoKTxicj4Kb2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBodWI8YnI+Clso
bnVsbCk6KG51bGwpXTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZu
Zy5jOmNoZWNrX3VzYl9kZXZpY2UoKSB1c2I8YnI+ClswYmRhOjgxNzZdPGJyPgpvZm9ub2RbMTU2
MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHJ0bDgx
OTJjdTxicj4KWyhudWxsKToobnVsbCldPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHJ0bDgxOTJjdTxicj4KWzBiZGE6ODE3
Nl08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191
c2JfZGV2aWNlKCkgaHViPGJyPgpbKG51bGwpOihudWxsKV08YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiPGJyPgpbMTJk
MToxZjAxXTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNo
ZWNrX3VzYl9kZXZpY2UoKSB1c2I8YnI+ClsobnVsbCk6KG51bGwpXTxicj4Kb2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnJlbW92ZV9kZXZpY2UoKTxicj4KL3N5cy9k
ZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjA8YnI+Cm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNlKCk8
YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxicj4K
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX21vZGVtX2xp
c3QoKTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNr
X3VzYl9kZXZpY2UoKSB1c2I8YnI+ClsxMmQxOjEwMDFdPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9u
by0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KWyhu
dWxsKToobnVsbCldPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5n
LmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KWyhudWxsKToobnVsbCldPGJyPgpvZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgp
IG9wdGlvbjxicj4KWyhudWxsKToobnVsbCldPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KWzEyZDE6MTAw
MV08YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2
aWNlKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzIt
MTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZp
Y2UoKTxicj4KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0x
LzItMToxLjAvdHR5VVNCMC90dHkvdHR5VVNCMDxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjA8YnI+CihodWF3ZWkp
IDI1NS8yNTUvMjU1IFswMF0gPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+Cm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgYWRk
PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQo
KSBzdWJzeXN0ZW0gdHR5IGZpbmlzaGVkPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KWzEyZDE6MTAwMV08
YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNl
KCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxi
cj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2Uo
KTxicj4KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzIt
MToxLjEvdHR5VVNCMS90dHkvdHR5VVNCMTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjE8YnI+CihodWF3ZWkpIDI1
NS8yNTUvMjU1IFswMV0gPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgYWRkPGJy
PgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBz
dWJzeXN0ZW0gdHR5IGZpbmlzaGVkPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdp
bnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KWzEyZDE6MTAwMV08YnI+
Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzphZGRfZGV2aWNlKCk8
YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxicj4K
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKTxi
cj4KL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMTox
LjIvdHR5VVNCMi90dHkvdHR5VVNCMjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVn
aW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjI8YnI+CihodWF3ZWkpIDI1NS8y
NTUvMjU1IFswMl0gPT0mZ3Q7IChudWxsKSAobnVsbCk8YnI+Cm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgYWRkPGJyPgpv
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJz
eXN0ZW0gdHR5IGZpbmlzaGVkPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMv
dWRldm5nLmM6Y2hlY2tfbW9kZW1fbGlzdCgpPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6Y3JlYXRlX21vZGVtKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXZuZy5jOmNyZWF0ZV9tb2RlbSgpIGRyaXZlcj1odWF3ZWk8YnI+Cm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRlKCkgbmFt
ZTogKG51bGwpLDxicj4KdHlwZTogaHVhd2VpPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3BsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCk8YnI+Ci9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIC9kZXYvdHR5VVNCMDxicj4KMjU1LzI1
NS8yNTUgMDAgKG51bGwpPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
dm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0IxPGJyPgoyNTUvMjU1LzI1NSAwMSAobnVs
bCk8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9o
dWF3ZWkoKSAvZGV2L3R0eVVTQjI8YnI+CjI1NS8yNTUvMjU1IDAyIChudWxsKTxicj4Kb2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIG1kbT0v
ZGV2L3R0eVVTQjA8YnI+CnBjdWk9L2Rldi90dHlVU0IyIGRpYWc9KG51bGwpIHFtaT0obnVsbCkg
bmV0PShudWxsKTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpzZXRf
bW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDU1NmQ0MmEwPGJyPgpwcm9wZXJ0eSBEZXZpY2U8YnI+
Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5
KCkgbW9kZW0gMHg1NTZkNDJhMDxicj4KcHJvcGVydHkgTW9kZW08YnI+Cm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZk
NDJhMDxicj4KcHJvcGVydHkgUGN1aTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMv
bW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDU1NmQ0MmEwPGJyPgpwcm9wZXJ0
eSBEaWFnPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNldF9tb2Rl
bV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZDQyYTA8YnI+CnByb3BlcnR5IE5ldHdvcmtJbnRlcmZh
Y2U8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1f
cmVnaXN0ZXIoKSAweDU1NmQ0MmEwPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdp
bnMvaHVhd2VpLmM6aHVhd2VpX3Byb2JlKCkgMHg1NTZkNDJhMDxicj4Kb2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzplbWl0X21vZGVtX2FkZGVkKCkgMHg1NTZkNDJhMDxicj4K
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpjYWxsX21vZGVtd2F0Y2hlcygp
IDB4NTU2ZDQyYTAgYWRkZWQ6MTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5z
L2hmcF9hZ19ibHVlejUuYzptb2RlbV93YXRjaCgpIG1vZGVtOjxicj4KMHg1NTZkNDJhMCwgYWRk
ZWQ6IDE8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9kdW5fZ3dfYmx1ZXo1
LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CjB4NTU2ZDQyYTAsIGFkZGVkOiAxPGJyPgpvZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6bW9kZW1fd2F0
Y2goKSBtb2RlbTo8YnI+CjB4NTU2ZDQyYTAsIGFkZGVkOiAxPGJyPgpvZm9ub2RbMTU2MF06IC9v
Zm9uby0xLjE0L3BsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzptb2RlbV93YXRjaCgpIG1vZGVt
Ojxicj4KMHg1NTZkNDJhMCwgYWRkZWQ6IDE8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
cGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfZW5hYmxlKCkgMHg1NTZkNDJhMDxicj4Kb2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAw
eDU1NmQ0MmEwPGJyPgpwcm9wZXJ0eSBNb2RlbTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL2h1YXdlaS5jOm9wZW5fZGV2aWNlKCkgTW9kZW0gL2Rldi90dHlVU0IwPGJyPgpv
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgp
IG1vZGVtIDB4NTU2ZDQyYTA8YnI+CnByb3BlcnR5IFBjdWk8YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpvcGVuX2RldmljZSgpIFBjdWkgL2Rldi90dHlVU0Iy
PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVRFMCArQ01FRT0xXHI8YnI+Cm9mb25vZFsx
NTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsg
QVRJXHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuTWFudWZhY3R1cmVyOiBodWF3
ZWlcclxuTW9kZWw6IEUzMDNcclxuUmV2aXNpb246PGJyPgoyMi4zMTguMDUuMDAuMDBcclxuSU1F
STogODYyNTY2MDIwMDA1Njk3XHJcbitHQ0FQOjxicj4KK0NHU00sK0RTLCtFU1xyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVReUkZTV0lUQ0g9P1xyPGJyPgpvZm9u
b2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbkVSUk9SXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmZ3Q7IEFUK0NGVU49MVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbk9LXHJc
bjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmNmdW5fZW5h
YmxlKCk8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5TWVNJTkZPXHI8YnI+Cm9mb25v
ZFsxNTYwXTogUENVSTogJmx0OyBcclxuXlNZU0lORk86MiwzLDAsNSwxLDAsNFxyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c3lzaW5m
b19lbmFibGVfY2IoKSAyNTUgLSZndDsgMTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFU
JmFtcDtDMFxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ1M9JnF1b3Q7R1NNJnF1b3Q7XHI8YnI+Cm9mb25v
ZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZn
dDsgQVReVTJESUFHP1xyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbl5VMkRJQUc6
IDExOVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVReR0VUUE9S
VE1PREVccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5eR0VUUE9SVE1PREU6IFRZ
UEU6IFdDRE1BOiBodWF3ZWksXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTog
Jmd0OyBBVF5VU1NETU9ERT0/XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuXlVT
U0RNT0RFOiAoMC0xKVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsg
QVReRElBTE1PREU9P1xyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbl5ESUFMTU9E
RTogKDAtMiksKDAtMjU1KVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZn
dDsgQVReQ1ZPSUNFPT9ccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5eQ1ZPSUNF
OiAoMClcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NGVU49
NVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDR1JFRzogMFxyXG48YnI+Cm9m
b25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDBcclxuPGJyPgpvZm9ub2RbMTU2MF06
IFBDVUk6ICZsdDsgXHJcbk9LXHJcblxyXG5eU1JWU1Q6IDBcclxuXHJcbl5NT0RFOiAwLDBcclxu
PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6Y2Z1bl9vZmZs
aW5lKCk8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hh
bmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAwLDxicj4KbmV3IHN0YXRlOiAxPGJyPgpvZm9ub2RbMTU2
MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3ByZV9zaW0oKSAweDU1NmQ0
MmEwPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVReVVNTRE1PREU/XHI8YnI+Cm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2go
KSAweDU1NmU5OWM4PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9u
b19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg1NTZlOTljODxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZTk5Yzg8
YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuXlVTU0RNT0RFOiAxXHJcblxyXG5PS1xy
XG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5ESUFMTU9ERT9ccjxicj4Kb2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5eRElBTE1PREU6MywyXHJcblxyXG5PS1xyXG48YnI+Cm9m
b25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5DVk9JQ0U/XHI8YnI+Cm9mb25vZFsxNTYwXTogUENV
STogJmx0OyBcclxuXkNWT0lDRTogMSwgODAwMCwgMTYsIDIwXHJcblxyXG5PS1xyXG48YnI+Cm9m
b25vZFsxNTYwXTogVm9pY2UgY2hhbm5lbDogODAwMCBIeiwgMTYgYml0cywgMjBtcyBwZXJpb2Q8
YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtHQ0FQXHI8YnI+Cm9mb25vZFsxNTYwXTog
UENVSTogJmx0OyBcclxuK0dDQVA6ICtDR1NNLCtEUywrRVNcclxuXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDEyMjU4LDAsMCwyNTVccjxicj4Kb2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUM4MjAy
NDEyMTgzMDIyRkUyQTUwMzgwMDE3MThBMDEwNThCMDMyRjA2MDM4MDAyMDAwQTg4MDExMCZxdW90
O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRt
b2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKTxicj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMw
PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVReRERTRVRFWD0/XHI8YnI+Cm9mb25vZFsx
NTYwXTogUENVSTogJmx0OyBcclxuXkREU0VURVg6ICgyKVxyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ0dNSVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZs
dDsgXHJcbmh1YXdlaVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsg
QVQrQ1JTTT0xNzYsMTIyNTgsMCwwLDEwXHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBc
clxuK0NSU006IDE0NCwwLCZxdW90Ozk4NTMwMzA1MDEwNzA4NTMwNUY2JnF1b3Q7XHJcblxyXG5P
S1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTA8YnI+Cm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2Io
KSBidWZvZmY6IDAsPGJyPgpkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPGJyPgpvZm9ub2RbMTU2MF06
IFBDVUk6ICZndDsgQVQrQ0dNTVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbkUz
MDNcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTky
LDI4NDIxLDAsMCwyNTVccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8
YnI+CjE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RjA1QTUwMzgwMDE3MThBMDEwNThCMDM2
RjA2MDQ4MDAyMDAwQTg4MDExMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKTxicj4K
Y3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQr
Q0dNUlxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbjIyLjMxOC4wNS4wMC4wMFxy
XG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg0
MjEsMCwwLDEwXHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCww
LCZxdW90OzY1NkVGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25v
ZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9j
YigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTA8YnI+Cm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJy
PgpkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQr
Q0dTTlxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbjg2MjU2NjAyMDAwNTY5N1xy
XG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMTIw
MzcsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4K
MTQ0LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjJGMDVBNTAzODAwMTcxOEEwMTA1OEIwMzJGMDYw
NDgwMDIwMDBBODgwMTI4JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgpjcnNt
X2luZm9fY2I6IDkwLCAwMCwgMzA8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNN
PTE3NiwxMjAzNywwLDAsMTBccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTogMTQ0LDAsJnF1b3Q7NjU2RUZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Jz
bV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAxMDxicj4Kb2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9m
ZjogMCw8YnI+CmRhdGFvZmY6IDAsIHRvY29weTogMTA8YnI+Cm9mb25vZFsxNTYwXTogUENVSTog
Jmd0OyBBVCtDUElOP1xyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUElOOiBS
RUFEWVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMv
YXRtb2RlbS9zaW0uYzphdF9jcGluX2NiKCkgY3JzbV9waW5fY2I6PGJyPgpSRUFEWTxicj4Kb2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfcGluX3JldHJp
ZXNfcXVlcnkoKTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUXkNQSU4/XHI8YnI+Cm9m
b25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuXkNQSU46IFJFQURZLCwxMCwzLDEwLDNcclxuXHJc
bk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4KY291bnRlciBpZD05LCB2YWw9MTA8YnI+Cm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGlu
X2NiKCkgcmV0cnk8YnI+CmNvdW50ZXIgaWQ9MSwgdmFsPTM8YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmh1YXdlaV9jcGluX2NiKCkgcmV0cnk8YnI+
CmNvdW50ZXIgaWQ9MTEsIHZhbD0xMDxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4KY291bnRlciBpZD00
LCB2YWw9Mzxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NTkwLDAs
MCwyNTVccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTA2LDEzMCwm
cXVvdDsmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTkyLDI4NTg5LDAsMCwyNTVccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxy
XG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RkFEQTUwMzgwMDE3MThB
MDEwNThCMDM2RjA2MDY4MDAyMDAwNDg4MDExOCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9f
Y2IoKTxicj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6
ICZndDsgQVQrQ1JTTT0xNzYsMjg1ODksMCwwLDRccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAm
bHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDImcXVvdDtcclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Jz
bV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCA0PGJyPgpvZm9ub2RbMTU2MF06
IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2Zm
OiAwLDxicj4KZGF0YW9mZjogMCwgdG9jb3B5OiA0PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZn
dDsgQVQrQ1JTTT0xOTIsMjg0MzgsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg0NzIsMCwwLDI1NVxyPGJyPgpvZm9u
b2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxQzgyMDI0
MTIxODMwMjZGMzhBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwMjgwMDIwMDBBODgwMTIwJnF1b3Q7
XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgpjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8
YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODQ3MiwwLDAsMTBccjxi
cj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7N0VFRTEx
MUMyN0Y2NTkwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21f
cmVhZF9jYjogOTAsIDAwLCAxMDxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2lt
ZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCw8YnI+CmRhdGFvZmY6IDAs
IHRvY29weTogMTA8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODUw
MiwwLDAsMjU1XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgox
NDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyNkY1NkE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA3
ODAwMjAwMDE4ODAxMjgmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zv
bm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CmNyc21f
aW5mb19jYjogOTAsIDAwLCAzMDxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTc2LDI4NTAyLDAsMCwxXHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006
IDE0NCwwLCZxdW90OzAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2lt
ZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCw8YnI+CmRhdGFvZmY6IDAs
IHRvY29weTogMTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NJTUlccjxicj4Kb2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4yNzIwNTAxMDA0MTM1ODBcclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY2lt
aV9jYigpIGNpbWlfY2I6PGJyPgoyNzIwNTAxMDA0MTM1ODA8YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAxLDxi
cj4KbmV3IHN0YXRlOiAyPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVh
d2VpLmM6aHVhd2VpX3Bvc3Rfc2ltKCkgMHg1NTZkNDJhMDxicj4Kb2Zvbm9kWzE1NjBdOjxicj4K
L29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2dwcnNfY29udGV4
dF9wcm9iZSgpPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmdldF9t
b2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4NTU2ZDQyYTA8YnI+CnByb3BlcnR5IEFsd2F5c09ubGlu
ZTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSQz0xXHI8YnI+Cm9mb25vZFsxNTYw
XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQr
Q0xJUD0xXHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9u
b2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ09MUD0xXHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTog
Jmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ0NXQT0xXHI8
YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06
PGJyPgovb2Zvbm8tMS4xNC9kcml2ZXJzL2h1YXdlaW1vZGVtL3ZvaWNlY2FsbC5jOmh1YXdlaV92
b2ljZWNhbGxfaW5pdGlhbGl6ZWQoKTxicj4KcmVnaXN0ZXJpbmcgdG8gbm90aWZpY2F0aW9uczxi
cj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0
ZV93YXRjaCgpIDB4NTU2ZTk5Yzg8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lu
cy9ibHVlejUuYzpidF9yZWdpc3Rlcl9wcm9maWxlKCkgQmx1ZXRvb3RoOjxicj4KUmVnaXN0ZXJp
bmcgMDAwMDExMWYtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIChoZnBfYWcpIHByb2ZpbGU8
YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5DVk9JQ0U9P1xyPGJyPgpvZm9ub2RbMTU2
MF06IFBDVUk6ICZsdDsgXHJcbl5DVk9JQ0U6ICgwKVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2Rb
MTU2MF06IFBDVUk6ICZndDsgQVQrQ1NDUz0/XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0
OyBcclxuK0NTQ1M6ICgmcXVvdDtJUkEmcXVvdDssJnF1b3Q7VUNTMiZxdW90OywmcXVvdDtHU00m
cXVvdDspXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5TWVND
Rkc9P1xyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbl5TWVNDRkc6PGJyPgooMiwx
MywxNCwxNiksKDAtMyksKCgyMDAwMDAwNDAwMzgwLCZxdW90O0dTTTkwMC9HU00xODAwL1dDRE1B
OTAwL1dDRE1BMjEwMCZxdW90OyksKDI4MDAwMCwmcXVvdDtHU004NTAvR1NNMTkwMCZxdW90Oyks
KDNmZmZmZmZmLCZxdW90O0FsbDxicj4KYmFuZHMmcXVvdDspKSwoMC0yKSwoMC00KVxyXG5cclxu
T0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1NNUz0/XHI8YnI+Cm9mb25v
ZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NTTVM6ICgwLDEpXHJcblxyXG5PS1xyXG48YnI+Cm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmF0X2NzbXNfcXVl
cnlfY2IoKSBDU01TPGJyPgpxdWVyeSBwYXJzZWQgc3VjY2Vzc2Z1bGx5PGJyPgpvZm9ub2RbMTU2
MF06IFBDVUk6ICZndDsgQVQrQ0dEQ09OVD0/XHI8YnI+Cm9mb25vZFsxNTYwXTogUmVnaXN0ZXJQ
cm9maWxlKCkgcmVwbGllZCBhbiBlcnJvcjo8YnI+Cm9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9y
LlNwYXduLkNoaWxkRXhpdGVkLCBMYXVuY2ggaGVscGVyIGV4aXRlZCB3aXRoPGJyPgp1bmtub3du
IHJldHVybiBjb2RlIDE8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NHRENPTlQ6
PGJyPgooMS0xMSksJnF1b3Q7SVAmcXVvdDssLCwoMC0yKSwoMC0zKSwoMCwxKSwoMCwxKVxyXG4r
Q0dEQ09OVDo8YnI+CigxLTExKSwmcXVvdDtQUFAmcXVvdDssLCwoMC0yKSwoMC0zKSwoMCwxKSwo
MCwxKVxyXG5cclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTkyLDI4NDgwLDAsMCwyNTVccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMjIwNjgzMDI2RjQwQTUwMzgwMDE3
MThBMDEwNThCMDM2RjA2MDU4MDAyMDBDQzg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZv
X2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAzMjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmZ3Q7IEFUK0NQQlM9P1xyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUEJT
OiAoJnF1b3Q7U00mcXVvdDssJnF1b3Q7RU4mcXVvdDssJnF1b3Q7T04mcXVvdDssJnF1b3Q7RkQm
cXVvdDspXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDU01T
PTFccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NNUzogMSwxLDFcclxuXHJc
bk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NHUkVHPT9ccjxicj4Kb2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ0dSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48YnI+
Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCwxLDQsMzRccjxicj4K
b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90OzRENzky
MDRFNzU2RDYyNjU3MkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYwNzkxNTM4MzEzOTc3ODQ4RkZGRkZG
RkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6
IDkwLCAwMCwgMzQ8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDU01TP1xyPGJyPgpv
Zm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDU01TOiAxLDEsMSwxXHJcblxyXG5PS1xyXG48
YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDR1JFRz0yXHI8YnI+Cm9mb25vZFsxNTYw
XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQr
Q0dBVVRPPTBccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9m
b25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDR0VSRVA9MiwxXHI8YnI+Cm9mb25vZFsxNTYwXTog
UENVSTogJmx0OyBcclxuRVJST1JcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Bs
dWdpbnMvYmx1ZXo1LmM6YnRfcmVnaXN0ZXJfcHJvZmlsZSgpIEJsdWV0b290aDo8YnI+ClJlZ2lz
dGVyaW5nIDAwMDAxMTAzLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiAoZHVuX2d3KSBwcm9m
aWxlPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsMiw0LDM0
XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVv
dDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ01HRj0/
XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NNR0Y6ICgwLDEpXHJcblxyXG5P
S1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCwzLDQs
MzRccjxicj4Kb2Zvbm9kWzE1NjBdOiBSZWdpc3RlclByb2ZpbGUoKSByZXBsaWVkIGFuIGVycm9y
Ojxicj4Kb3JnLmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuU3Bhd24uQ2hpbGRFeGl0ZWQsIExhdW5j
aCBoZWxwZXIgZXhpdGVkIHdpdGg8YnI+CnVua25vd24gcmV0dXJuIGNvZGUgMTxicj4Kb2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90O0ZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAw
MCwgMzQ8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUE1TPT9ccjxicj4Kb2Zvbm9k
WzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BNUzo8YnI+CigmcXVvdDtTTSZxdW90OywmcXVvdDtN
RSZxdW90OyksKCZxdW90O1NNJnF1b3Q7LCZxdW90O01FJnF1b3Q7KSwoJnF1b3Q7U00mcXVvdDss
JnF1b3Q7TUUmcXVvdDspXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0
OyBBVCtDUlNNPTE3OCwyODQ4MCw0LDQsMzRccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7
IFxyXG4rQ1JTTTo8YnI+CjE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xy
XG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+Cm9mb25vZFsx
NTYwXTogUENVSTogJmd0OyBBVCtDTUdGPTBccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7
IFxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4
MCw1LDQsMzRccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0
NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYw
XTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJy
PgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBB
VCtDUE1TPSZxdW90O01FJnF1b3Q7LCZxdW90O01FJnF1b3Q7LCZxdW90O01FJnF1b3Q7XHI8YnI+
Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NQTVM6IDAsMjAsMCwyMCwwLDIwXHJcblxy
XG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCw2
LDQsMzRccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CjE0NCww
LCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpj
cnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtD
Tk1JPT9ccjxicj4Kb2Zvbm9kWzE1NjBdOiBEdXBsaWNhdGUgRUZzZG4gZW50cmllcyBmb3IgYEVt
ZXJnZW5jeSBTZXJ2aWNlcyYjMzk7PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitD
Tk1JOiAoMC0yKSwoMC0zKSwoMCwyKSwoMC0yKSwoMCwxKVxyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zbXMuYzpidWlsZF9jbm1pX3N0
cmluZygpPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ05NST0xLDEsMiwxLDBccjxi
cj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTog
L29mb25vLTEuMTQvc3JjL3Ntcy5jOnNtc19yZXN0b3JlX3R4X3F1ZXVlKCk8YnI+Cm9mb25vZFsx
NTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOnNtc193YXRjaCgp
IHJlZ2lzdGVyZWQ8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1t
ZXNzYWdpbmcuYzpzbXNfd2F0Y2goKSByZWdpc3RlcmVkPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6
ICZndDsgQVQrQ01HTD00XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxu
PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zbXMuYzphdF9j
bWdsX2RvbmUoKTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NHU01TPTNccjxicj4K
b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg1NTZkNDJh
MDxicj4KcHJvcGVydHkgQWx3YXlzT25saW5lPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3NldF9vbmxpbmUoKSBtb2RlbTxicj4KMHg1NTZkNDJh
MCBvbmxpbmU8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDRlVOPTFccjxicj4Kb2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5eU0lNU1Q6MCwwXHJcbjxicj4Kb2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOnNpbXN0X25vdGlmeSgpIDEgLSZndDsgMDxi
cj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG5cclxuXlNJTVNUOjEsMFxyXG48
YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpzaW1zdF9ub3Rp
ZnkoKSAwIC0mZ3Q7IDE8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVF5TWVNJTkZPXHI8
YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDJcclxuXHJcbitDR1JFRzo8
YnI+CjJcclxuXHJcbl5TWVNJTkZPOjAsMywwLDAsMSwwLDBcclxuXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlm
eSgpIC9odWF3ZWlfMDxicj4Kc3RhdHVzIDI8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
cGx1Z2lucy9odWF3ZWkuYzpzeXNpbmZvX29ubGluZV9jYigpIDEgLSZndDsgMTxicj4Kb2Zvbm9k
WzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQg
c3RhdGU6IDIsPGJyPgpuZXcgc3RhdGU6IDM8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
cGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcG9zdF9vbmxpbmUoKSAweDU1NmQ0MmEwPGJyPgpvZm9u
b2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JFRz0/XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTog
Jmx0OyBcclxuK0NSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENV
STogJmd0OyBBVCtDU0NCPT9ccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1ND
QjooMCwxKVxyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1VT
RD0xXHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2Rb
MTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTgsMCwwLDI1NVxyPGJyPgpvZm9ub2Rb
MTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIx
MDAwNjA1ODMwMjZGQ0FBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgwMDIwMDFFODgwMCZxdW90
O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRt
b2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKTxicj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMy
PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JFRz0yXHI8YnI+Cm9mb25vZFsxNTYw
XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3Ny
Yy9zaW0uYzpvZm9ub19zaW1fYWRkX3Nwbl93YXRjaCgpIDB4NTU2ZTk5Yzg8YnI+Cm9mb25vZFsx
NTYwXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVz
X3dhdGNoKCk8YnI+CjB4NTU2ZWZiZTg8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3Jj
L25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCk8YnI+CjB4NTU2ZWZi
ZTg8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDU0NCPTBccjxicj4Kb2Zvbm9kWzE1
NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQv
c3JjL2Nicy5jOmNic19nb3RfaW1zaSgpIEdvdCBJTVNJOiAyNzIwNTAxMDA0MTM1ODA8YnI+Cm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRf
c3RhdHVzX3dhdGNoKCk8YnI+CjB4NTU2ZWZiZTg8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0
OyBBVCtDUlNNPTE3OCwyODYxOCwxLDQsNlxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsg
XHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Jz
bV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgpvZm9ub2RbMTU2MF06
IFBDVUk6ICZndDsgQVQrQ1JFRz9ccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JFRzogMiwyXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvc3Jj
L25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgpPGJyPgovaHVhd2VpXzAgc3Rh
dHVzIDIgdGVjaCAtMTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5j
OmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2soKTxicj4KMHg1NTZlZmJlOCwgKG5pbCk8YnI+Cm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkg
MiwgLTEsIC0xLCAtMSw8YnI+CihudWxsKShudWxsKTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8t
MS4xNC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDI8YnI+Cm9mb25vZFsxNTYw
XTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOCwyLDQsNlxyPGJyPgpvZm9ub2RbMTU2MF06
IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxu
XHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgpv
Zm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMyw0LDZccjxicj4Kb2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAw
JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAw
MCwgNjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE4LDQsNCw2
XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAw
MDAwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0x
LjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFk
X2NiOiA5MCwgMDAsIDY8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwy
ODYxOCw1LDQsNlxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQs
MCwmcXVvdDswMDAwMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+
CmNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQr
Q1JTTT0xOTIsMjg2MTcsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJc
bitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAwNTA1ODMwMjZGQzlBNTAzODAw
MTcxOEEwMTA1OEIwMzZGMDYwMjgwMDIwMDE5ODgwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpv
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2lu
Zm9fY2IoKTxicj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPGJyPgpvZm9ub2RbMTU2MF06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsMSw0LDVccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tc
clxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8YnI+Cm9mb25vZFsx
NTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNywyLDQsNVxyPGJyPgpvZm9ub2RbMTU2
MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJc
blxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNTxicj4K
b2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDMsNCw1XHI8YnI+Cm9m
b25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAwMDAwMDAm
cXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAw
LCA1PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsNCw0LDVc
cjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEw
MDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2Ni
OiA5MCwgMDAsIDU8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYx
Nyw1LDQsNVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwm
cXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgpjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgNTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTkyLDI4NDMzLDAsMCwyNTVccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTogMTA2LDEzMCwmcXVvdDsmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAv
b2Zvbm8tMS4xNC9zcmMvbWVzc2FnZS13YWl0aW5nLmM6bXdfY3Boc19td2lzX3JlYWRfY2IoKSBO
bzxicj4KQ1BIUyBNV0lTIG9uIFNJTTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTkyLDI4NjE5LDAsMCwyNTVccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG4r
Q1JTTTo8YnI+CjE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMTAwNTgzMDI2RkNCQTUwMzgwMDE3
MThBMDEwNThCMDM2RjA2MDU4MDAyMDA1MDg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zv
bm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZv
X2NiKCk8YnI+CmNyc21faW5mb19jYjogOTAsIDAwLCAzMjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDEsNCwxNlxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6
ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4x
NC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9j
YjogOTAsIDAwLCAxNjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4
NjE5LDIsNCwxNlxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4K
MTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJc
bk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjxicj4Kb2Zv
bm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDMsNCwxNlxyPGJyPgpvZm9u
b2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8
YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc4LDI4NjE5LDQsNCwxNlxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsg
XHJcbitDUlNNOjxicj4KMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAs
IDAwLCAxNjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDUs
NCwxNlxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KMTQ0LDAs
JnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJc
bjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9yZWFkX2NiKCk8YnI+CmNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjxicj4Kb2Zvbm9kWzE1
NjBdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9jaygpIGJ1Zm9m
ZjogMCw8YnI+CnNlZWtvZmY6IDM5LCB0b3JlYWQ6IDE3PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9u
by0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLDxicj4K
c2Vla29mZjogMzksIHRvcmVhZDogMTA8YnI+Cm9mb25vZFsxNTYwXTogL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL2Nicy5jOmF0X2Nic19zZXRfdG9waWNzKCk8YnI+Cm9mb25vZFsxNTYwXTog
UENVSTogJmd0OyBBVCtDU0NCPTBccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5P
S1xyXG48YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDU0NCPTAsJnF1b3Q7MCw1MCwy
MTQsNDM1Mi00MzU2JnF1b3Q7XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuT0tc
clxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg0MzcsMCwwLDI1
NVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90
OyZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JT
TT0xOTIsMjg2MTUsMCwwLDI1NVxyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitD
UlNNOjxicj4KMTQ0LDAsJnF1b3Q7NjIxRTgyMDU0MjIxMDAyMjA1ODMwMjZGQzdBNTAzODAwMTcx
OEEwMTA1OEIwMzZGMDYwMjgwMDIwMEFBODgwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9f
Y2IoKTxicj4KY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6
ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTUsMSw0LDM0XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTog
Jmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDs0RDYxNjk2Q0ZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGMDc5MTUzODMzMzMzMTMxN0ZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxu
T0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0u
YzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgpvZm9u
b2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTUsMiw0LDM0XHI8YnI+Cm9mb25v
ZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwg
MDAsIDM0PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTUsMyw0
LDM0XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwm
cXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3Jz
bV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1JT
TT0xNzgsMjg2MTUsNCw0LDM0XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NS
U006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgpv
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3Jl
YWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgpvZm9ub2RbMTU2MF06IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTUsNSw0LDM0XHI8YnI+Cm9mb25vZFsxNTYwXTogUENV
STogJmx0OyBcclxuK0NSU006PGJyPgoxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5c
clxuT0tcclxuPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgpv
Zm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbl5NT0RFOiA1LDRcclxuPGJyPgpvZm9ub2RbMTU2
MF06IFBDVUk6ICZsdDsgXHJcbl5SU1NJOiAxM1xyXG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVv
dDssNDEsMzUsNTNcclxuPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAx
LCZxdW90OzAwNDAmcXVvdDssJnF1b3Q7MDJDMTAxNzgmcXVvdDtcclxuPGJyPgpvZm9ub2RbMTU2
MF06IFBDVUk6ICZsdDsgXHJcbl5TUlZTVDogMlxyXG48YnI+Cm9mb25vZFsxNTYwXTogL29mb25v
LTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgpPGJyPgovaHVh
d2VpXzAgc3RhdHVzIDEgdGVjaCAyPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9j
YnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDEsIC0xLCAtMSwgMiw8YnI+CihudWxsKShudWxs
KTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNf
Y2hhbmdlZCgpIDE8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDT1BTPTMsMlxyPGJy
PgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiBQ
Q1VJOiAmZ3Q7IEFUK0NPUFM/XHI8YnI+Cm9mb25vZFsxNTYwXTogUENVSTogJmx0OyBcclxuK0NP
UFM6IDAsMiwmcXVvdDsyNzIwNSZxdW90OywyXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNTYw
XTo8YnI+Ci9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5j
OmNvcHNfbnVtZXJpY19jYigpIENvcHM8YnI+Cm51bWVyaWMgZ290IG1jYzogMjcyLCBtbmM6IDA1
PGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsgQVQrQ1NRXHI8YnI+Cm9mb25vZFsxNTYwXTog
UENVSTogJmx0OyBcclxuK0NTUTogMTMsOTlcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NjBd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjc3Ff
Y2IoKTxicj4KY3NxX2NiOiAxMzxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0
d29yay5jOm9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3RpZnkoKTxicj4Kc3RyZW5ndGggNDE8YnI+
Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDR0FUVD0xXHI8YnI+Cm9mb25vZFsxNTYwXTog
UENVSTogJmx0OyBcclxuT0tcclxuXHJcbitDR1JFRzogMSwmcXVvdDswMDQwJnF1b3Q7LCZxdW90
OzAyQzEwMTc4JnF1b3Q7XHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3By
cy5jOmdwcnNfYXR0YWNoX2NhbGxiYWNrKCkgL2h1YXdlaV8wIGVycm9yPGJyPgo9IDA8YnI+Cm9m
b25vZFsxNTYwXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3Rp
ZnkoKSAvaHVhd2VpXzA8YnI+CnN0YXR1cyAxPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZndDsg
QVQrQ09QUz0zLDBccjxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+
Cm9mb25vZFsxNTYwXTogUENVSTogJmd0OyBBVCtDT1BTP1xyPGJyPgpvZm9ub2RbMTU2MF06IFBD
VUk6ICZsdDsgXHJcbitDT1BTOiAwLDAsJnF1b3Q7MyBJUkwmcXVvdDssMlxyXG5cclxuT0tcclxu
PGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJl
Z2lzdHJhdGlvbi5jOmNvcHNfY2IoKTxicj4KY29wc19jYjogMyBJUkwsIDI3MiAwNSAyPGJyPgpv
Zm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9j
YWxsYmFjaygpPGJyPgoweDU1NmVmYmU4LCAobmlsKTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8t
MS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAxLCAtMSwgLTEsIDIsPGJyPgoy
NzIwNTxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9u
X2NoYW5nZWQoKSAxLCAwLCAwPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJOiAmZ3Q7
IEFUK0NHUkVHP1xyPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbitDR1JFRzogMiwx
LCZxdW90OzAwNDAmcXVvdDssJnF1b3Q7MDJDMTAxNzgmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOnJlZ2lzdHJhdGlvbl9zdGF0dXNf
Y2IoKSAvaHVhd2VpXzA8YnI+CmVycm9yIDAgc3RhdHVzIDE8YnI+Cm9mb25vZFsxNTYwXTogL29m
b25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvaHVhd2VpXzA8
YnI+CnN0YXR1cyAxPGJyPgpvZm9ub2RbMTU2MF06IFBDVUk6ICZsdDsgXHJcbl5SU1NJOiAxMVxy
XG5cclxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDssMzgsMzAsNDlcclxuPGJyPgpvZm9ub2RbMTU2
MF06IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0cmVuZ3RoX25vdGlm
eSgpPGJyPgpzdHJlbmd0aCAzNTxicj4Kb2Zvbm9kWzE1NjBdOjxicj4KL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2dwcnNfYWN0aXZhdGVfcHJpbWFyeSgpIGNp
ZCAxPGJyPgpvZm9ub2RbMTU2MF06IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6cHJpX2FjdGl2YXRl
X2NhbGxiYWNrKCkgMHg1NTZlYjc4ODxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMv
Z3Bycy5jOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIEFjdGl2YXRpbmc8YnI+CmNvbnRleHQgZmFp
bGVkIHdpdGggZXJyb3I6IFVua25vd24gZXJyb3IgdHlwZTxicj4Kb2Zvbm9kWzE1NjBdOiBQQ1VJ
OiAmbHQ7IFxyXG5eUlNTSTogMTNcclxuXHJcbl5IQ1NROiZxdW90O1dDRE1BJnF1b3Q7LDQyLDM1
LDUxXHJcbjxicj4Kb2Zvbm9kWzE1NjBdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25v
X25ldHJlZ19zdHJlbmd0aF9ub3RpZnkoKTxicj4Kc3RyZW5ndGggNDE8YnI+Cjxicj4KPGJyPgpJ
ZiBJIG5vdyByZXN0YXJ0IG9mb25vIHRoZW4gYWN0aXZhdGluZyB0aGUgc2FtZSBjb250ZXh0IHdp
bGwgd29yayBmaW5lLjxicj4KPGJyPgo8YnI+CkhvbWFtPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+
Ck9uIDEwIE1hcmNoIDIwMTQgMTg6MTYsICZsdDs8YSBocmVmPSJtYWlsdG86b2Zvbm8tcmVxdWVz
dEBvZm9uby5vcmciPm9mb25vLXJlcXVlc3RAb2Zvbm8ub3JnPC9hPiZndDsgd3JvdGU6PGJyPgo8
YnI+CiZndDsgU2VuZCBvZm9ubyBtYWlsaW5nIGxpc3Qgc3VibWlzc2lvbnMgdG88YnI+CiZndDsg
oCCgIKAgoCA8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8
L2E+PGJyPgomZ3Q7PGJyPgomZ3Q7IFRvIHN1YnNjcmliZSBvciB1bnN1YnNjcmliZSB2aWEgdGhl
IFdvcmxkIFdpZGUgV2ViLCB2aXNpdDxicj4KJmd0OyCgIKAgoCCgIDxhIGhyZWY9Imh0dHBzOi8v
bGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5o
dHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KJmd0
OyBvciwgdmlhIGVtYWlsLCBzZW5kIGEgbWVzc2FnZSB3aXRoIHN1YmplY3Qgb3IgYm9keSAmIzM5
O2hlbHAmIzM5OyB0bzxicj4KJmd0OyCgIKAgoCCgIDxhIGhyZWY9Im1haWx0bzpvZm9uby1yZXF1
ZXN0QG9mb25vLm9yZyI+b2Zvbm8tcmVxdWVzdEBvZm9uby5vcmc8L2E+PGJyPgomZ3Q7PGJyPgom
Z3Q7IFlvdSBjYW4gcmVhY2ggdGhlIHBlcnNvbiBtYW5hZ2luZyB0aGUgbGlzdCBhdDxicj4KJmd0
OyCgIKAgoCCgIDxhIGhyZWY9Im1haWx0bzpvZm9uby1vd25lckBvZm9uby5vcmciPm9mb25vLW93
bmVyQG9mb25vLm9yZzwvYT48YnI+CiZndDs8YnI+CiZndDsgV2hlbiByZXBseWluZywgcGxlYXNl
IGVkaXQgeW91ciBTdWJqZWN0IGxpbmUgc28gaXQgaXMgbW9yZSBzcGVjaWZpYzxicj4KJmd0OyB0
aGFuICZxdW90O1JlOiBDb250ZW50cyBvZiBvZm9ubyBkaWdlc3QuLi4mcXVvdDs8YnI+CiZndDs8
YnI+CiZndDs8YnI+CiZndDsgVG9kYXkmIzM5O3MgVG9waWNzOjxicj4KJmd0Ozxicj4KJmd0OyCg
IKAxLiBQcm9ibGVtIHJlY29ubmVjdGluZyB3aGVuIDNHIGRvbmdsZSBpcyByZS1pbnNlcnRlZCAo
SG9tYW0gRGFiaXMpPGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+
CiZndDs8YnI+CiZndDsgTWVzc2FnZTogMTxicj4KJmd0OyBEYXRlOiBNb24sIDEwIE1hciAyMDE0
IDE4OjE3OjA0ICswMDAwPGJyPgomZ3Q7IEZyb206IEhvbWFtIERhYmlzICZsdDs8YSBocmVmPSJt
YWlsdG86aGRhYmlzQGRpZ2lzb2Z0LnR2Ij5oZGFiaXNAZGlnaXNvZnQudHY8L2E+Jmd0Ozxicj4K
Jmd0OyBUbzogPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3Jn
PC9hPjxicj4KJmd0OyBTdWJqZWN0OiBQcm9ibGVtIHJlY29ubmVjdGluZyB3aGVuIDNHIGRvbmds
ZSBpcyByZS1pbnNlcnRlZDxicj4KJmd0OyBNZXNzYWdlLUlEOjxicj4KJmd0OyCgIKAgoCCgICZs
dDtDQUsrc2ZvdEJ0eXNLMXlDVHQ2NG0zZ3VGd2Z6V2JfPTxicj4KJmd0OyA8YSBocmVmPSJtYWls
dG86NHN6ajBVMmI1V3N3Z3QxbTFDZ0BtYWlsLmdtYWlsLmNvbSI+NHN6ajBVMmI1V3N3Z3QxbTFD
Z0BtYWlsLmdtYWlsLmNvbTwvYT4mZ3Q7PGJyPgomZ3Q7IENvbnRlbnQtVHlwZTogdGV4dC9wbGFp
bjsgY2hhcnNldD0mcXVvdDtpc28tODg1OS0xJnF1b3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IEhpLDxi
cj4KJmd0Ozxicj4KJmd0OyBJIGhhdmUgdGhlIGZvbGxvd2luZzogSHVhd2VpIEUzMDMgM0cgVVNC
IGRvbmdsZSwgY29ubm1hbiAxLjIwIGFuZCBvZm9ubzxicj4KJmd0OyAxLjE0Ljxicj4KJmd0Ozxi
cj4KJmd0OyBJIGNhbiBjb25uZWN0IHRvIGEgcGFydGljdWxhciBBUE4gdXNpbmcgY29ubm1hbiBh
bmQgb2Zvbm8uPGJyPgomZ3Q7PGJyPgomZ3Q7IEhvd2V2ZXIsIGlmIEkgcmVtb3ZlIGFuZCByZSBp
bnNlcnQgdGhlIGRvbmdsZSBJIGFtIHVuYWJsZSB0byByZWNvbm5lY3QgdG88YnI+CiZndDsgdGhl
IHNlcnZpY2UuIElmIEkgcmVzdGFydCBlaXRoZXIgY29ubm1hbiBvciBvZm9ubyB0aGVuIHJlY29u
bmVjdGlvbiB0bzxicj4KJmd0OyBzZXJ2aWNlIGlzIG9rLjxicj4KJmd0Ozxicj4KJmd0OyBDb25u
bWFuIGhhcyB0aGUgZm9sbG93aW5nIGNvbmZpZzo8YnI+CiZndDs8YnI+CiZndDsgW0dlbmVyYWxd
PGJyPgomZ3Q7IEJhY2tncm91bmRTY2FubmluZz1mYWxzZTxicj4KJmd0OyBEZWZhdWx0QXV0b0Nv
bm5lY3RUZWNobm9sb2dpZXM9Y2VsbHVsYXI8YnI+CiZndDsgUHJlZmVycmVkVGVjaG5vbG9naWVz
PWNlbGx1bGFyLHdpZmk8YnI+CiZndDsgU2luZ2xlQ29ubmVjdGVkVGVjaG5vbG9neT1mYWxzZTxi
cj4KJmd0OyBUZXRoZXJpbmdUZWNobm9sb2dpZXM9d2lmaTxicj4KJmd0OyBQZXJzaXN0ZW50VGV0
aGVyaW5nTW9kZT10cnVlPGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IEluIG9mb25vIHRoZSBs
b2cgZm9yIGNvbm5lY3QvcmVtb3ZlIGFuZCByZWNvbm5lY3QgaXM6PGJyPgomZ3Q7PGJyPgomZ3Q7
IHJvb3RAaTEwMDp+IyBPRk9OT19BVF9ERUJVRz0xIG9mb25vZCAtbiAtZCCgJmd0OyAvb2Zvbm8u
bG9nPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IG9Gb25vIHZlcnNpb24gMS4xNDxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvcGx1Z2luLmM6X19vZm9ub19wbHVnaW5faW5p
dCgpPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3BsdWdpbnMv
cHVzaC1ub3RpZmljYXRpb24uYzpwdXNoX25vdGlmaWNhdGlvbl9pbml0KCk8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzpzbWFydF9t
ZXNzYWdpbmdfaW5pdCgpPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJyPgomZ3Q7IC9vZm9uby0x
LjE0L3NyYy9jZG1hLXByb3Zpc2lvbi5jOm9mb25vX2NkbWFfcHJvdmlzaW9uX2RyaXZlcl9yZWdp
c3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMWJiMCBuYW1lOiBDRE1BIHByb3Zpc2lvbmlu
Zzxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy1w
cm92aXNpb24uYzpvZm9ub19ncHJzX3Byb3Zpc2lvbl9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0
OyBkcml2ZXI6IDB4NTU2YzFiODAgbmFtZTogUHJvdmlzaW9uaW5nPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvZHVuX2d3X2JsdWV6NS5jOmR1bl9nd19pbml0KCk8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL2hhbmRzZnJl
ZS1hdWRpby5jOm9mb25vX2hhbmRzZnJlZV9jYXJkX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7
IGRyaXZlcjogMHg1NTZjMWE1MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6
IDB4NTU2YzFhNjAsIG5hbWU6IGhmcDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL2hlOTEwLmM6aGU5MTBfaW5pdCgpPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgom
Z3Q7IGRyaXZlcjogMHg1NTZjMTllMCwgbmFtZTogaGU5MTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvcGx1Z2lucy9jb25ubWFuLmM6Y29ubm1hbl9pbml0KCk8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL3ByaXZhdGUtbmV0d29yay5j
Om9mb25vX3ByaXZhdGVfbmV0d29ya19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6
IDB4NTU2YzE5YjAsIG5hbWU6IENvbm5NYW4gUHJpdmF0ZSBOZXR3b3JrPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdp
c3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMTk2MCwgbmFtZTogc2ltOTAwPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMTkxMCwgbmFtZTogc2Ftc3VuZzxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2Rl
bV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YzE4YzAsIG5hbWU6IHNw
ZWVkdXBjZG1hPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMTg3
MCwgbmFtZTogc3BlZWR1cDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4
NTU2YzE4MjAsIG5hbWU6IGFsY2F0ZWw8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJp
dmVyOiAweDU1NmMxN2MwLCBuYW1lOiBpY2VyYTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0
OyBkcml2ZXI6IDB4NTU2YzE3NzAsIG5hbWU6IGxpbmt0b3A8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8
YnI+CiZndDsgZHJpdmVyOiAweDU1NmMxNzIwLCBuYW1lOiBub2tpYWNkbWE8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3Jl
Z2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMxNmQwLCBuYW1lOiBub2tpYTxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2
ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YzE2ODAsIG5hbWU6IHRjNjU8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1f
ZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMxNWYwLCBuYW1lOiBzdGU8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9k
ZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMxNTkwLCBuYW1lOiBp
Zng8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9f
bW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMxNTQwLCBuYW1l
OiBwYWxtcHJlPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5j
Om9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMTRm
MCwgbmFtZTogbm92YXRlbDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
bW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4
NTU2YzE0YTAsIG5hbWU6IHNpZXJyYTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2
ZXI6IDB4NTU2YzE0MjAsIG5hbWU6IGh1YXdlaTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0
OyBkcml2ZXI6IDB4NTU2YzEzZDAsIG5hbWU6IHp0ZTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4K
Jmd0OyBkcml2ZXI6IDB4NTU2YzEzNzAsIG5hbWU6IGhzbzxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxi
cj4KJmd0OyBkcml2ZXI6IDB4NTU2YzEzMjAsIG5hbWU6IG1ibTxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIo
KTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YzEyZDAsIG5hbWU6IGNhbHlwc288YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3Jl
Z2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMxMjgwLCBuYW1lOiB3YXZlY29tPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2Ry
aXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMTIzMCwgbmFtZTogZzE8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL2NkbWEtdm9pY2Vj
YWxsLmM6b2Zvbm9fY2RtYV92b2ljZWNhbGxfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJp
dmVyOiAweDU1NmMxMWEwLCBuYW1lOiBjZG1hbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKTxi
cj4KJmd0OyBkcml2ZXI6IDB4NTU2YzExYzAsIG5hbWU6IGNkbWFtb2RlbTxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvY2RtYS1jb25ubWFuLmM6b2Zvbm9f
Y2RtYV9jb25ubWFuX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CiZndDsgMHg1NTZjMTFm
MCwgbmFtZTogY2RtYW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjog
MHg1NTZjMTExYywgbmFtZTogcGhvbmVzaW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsg
ZHJpdmVyOiAweDU1NmMxMTU0LCBuYW1lOiBsb2NhbGhmcDxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0
ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YzExMDQsIG5hbWU6IHBob25lc2ltPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jdG0uYzpvZm9ub19jdG1fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMxMGYwLCBuYW1lOiBwaG9uZXNpbTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3Bob25lc2ltLmM6cGFyc2Vf
Y29uZmlnKCkgZmlsZW5hbWU8YnI+CiZndDsgL2V0Yy9vZm9uby9waG9uZXNpbS5jb25mPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2
ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7IDB4NTU2YzEwYjAsIG5hbWU6IHNwZWVkdXBt
b2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvdm9p
Y2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CiZn
dDsgMHg1NTZjMGY1MCwgbmFtZTogaGZwbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKTxicj4K
Jmd0OyBkcml2ZXI6IDB4NTU2YzEwMTAsIG5hbWU6IGhmcG1vZGVtPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdp
c3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMGZhMCwgbmFtZTogaGZwbW9kZW08YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL2NhbGwtdm9sdW1lLmM6
b2Zvbm9fY2FsbF92b2x1bWVfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1
NmMwZmUwLCBuYW1lOiBoZnBtb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAv
b2Zvbm8tMS4xNC9zcmMvaGFuZHNmcmVlLmM6b2Zvbm9faGFuZHNmcmVlX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjo8YnI+CiZndDsgMHg1NTZjMTAzMCwgbmFtZTogaGZwbW9kZW08YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpcmkuYzpvZm9ub19zaXJpX2RyaXZlcl9y
ZWdpc3RlcigpIGRyaXZlcjo8YnI+CiZndDsgMHg1NTZjMTA2MCwgbmFtZTogaGZwbW9kZW08YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRy
ZWdfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMwZWMwLCBuYW1lOiBk
dW5tb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9m
b25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwZWYwLCBu
YW1lOiBkdW5tb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4x
NC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZl
cjo8YnI+CiZndDsgMHg1NTZjMGRmMCwgbmFtZTogc3RlbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3Jl
Z2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMwZTcwLCBuYW1lOiBzdGVtb2RlbTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGlu
Z3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2
ZXI6IDB4NTU2YzBlNDAsIG5hbWU6IHN0ZW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJy
PgomZ3Q7IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwY2IwLCBuYW1lOiBpZnhtb2RlbTxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvYXVkaW8tc2V0
dGluZ3MuYzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBk
cml2ZXI6IDB4NTU2YzBkMDAsIG5hbWU6IGlmeG1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3Nl
dHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMGQyMCwgbmFt
ZTogaWZ4bW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMu
YzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAw
eDU1NmMwZDUwLCBuYW1lOiBpZnhtb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvc3RrLmM6b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CiZn
dDsgMHg1NTZjMGQ4MCwgbmFtZTogaWZ4bW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL2N0bS5jOm9mb25vX2N0bV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJy
PgomZ3Q7IDB4NTU2YzBkYjAsIG5hbWU6IGlmeG1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3Rl
cigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMGM0MCwgbmFtZTogaHNvbW9kZW08YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6
b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAw
eDU1NmMwYzYwLCBuYW1lOiBoc29tb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4K
Jmd0OyBkcml2ZXI6IDB4NTU2YzBiYjAsIG5hbWU6IG1ibW1vZGVtPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9zdGsuYzpvZm9ub19zdGtfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwYmUwLCBuYW1lOiBtYm1tb2RlbTxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOjxicj4KJmd0Ozxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvbG9jYXRpb24tcmVw
b3J0aW5nLmM6b2Zvbm9fbG9jYXRpb25fcmVwb3J0aW5nX2RyaXZlcl9yZWdpc3RlcigpPGJyPgom
Z3Q7IGRyaXZlcjogMHg1NTZjMGMwMCwgbmFtZTogbWJtbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2Fs
bF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7IDB4NTU2YzBiMjAsIG5hbWU6IGNh
bHlwc29tb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc3RrLmM6
b2Zvbm9fc3RrX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CiZndDsgMHg1NTZjMGI3MCwg
bmFtZTogY2FseXBzb21vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Ny
Yy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7IDB4
NTU2YzBhMDAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJyPgom
Z3Q7IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwYTIwLCBuYW1lOiBodWF3ZWltb2RlbTxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvYXVkaW8tc2V0
dGluZ3MuYzpvZm9ub19hdWRpb19zZXR0aW5nc19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBk
cml2ZXI6IDB4NTU2YzBhNzAsIG5hbWU6IGh1YXdlaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3NyYy9yYWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlv
X3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMGFiMCwg
bmFtZTogaHVhd2VpbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3Jj
L2dwcnMuYzpvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJp
dmVyOiAweDU1NmMwYTkwLCBuYW1lOiBodWF3ZWltb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
Ojxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvY2RtYS1uZXRyZWcuYzpvZm9ub19jZG1hX25ldHJl
Z19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7IDB4NTU2YzBhZTAsIG5hbWU6IGh1
YXdlaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6
b2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1
NTZjMDk3MCwgbmFtZTogaWNlcmFtb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0
OyAvb2Zvbm8tMS4xNC9zcmMvcmFkaW8tc2V0dGluZ3MuYzpvZm9ub19yYWRpb19zZXR0aW5nc19k
cml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YzA5YTAsIG5hbWU6IGljZXJh
bW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL3Jh
ZGlvLXNldHRpbmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+
CiZndDsgZHJpdmVyOiAweDU1NmMwOTIwLCBuYW1lOiB6dGVtb2RlbTxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJf
cmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YzA4ZTAsIG5hbWU6IHN3bW9kZW08YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRp
bmdzLmM6b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJp
dmVyOiAweDU1NmMwODkwLCBuYW1lOiBud21vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJy
PgomZ3Q7IC9vZm9uby0xLjE0L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwNmIwLCBuYW1lOiBhdG1vZGVtPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX2Rldmlu
Zm9fZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMwNzYwLCBuYW1lOiBh
dG1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3NyYy9j
YWxsLWJhcnJpbmcuYzpvZm9ub19jYWxsX2JhcnJpbmdfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
Ojxicj4KJmd0OyAweDU1NmMwNzEwLCBuYW1lOiBhdG1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3NyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9ub19jYWxs
X2ZvcndhcmRpbmdfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMwNDgw
LCBuYW1lOiBhdG1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJyPgomZ3Q7IC9vZm9uby0x
LjE0L3NyYy9jYWxsLW1ldGVyLmM6b2Zvbm9fY2FsbF9tZXRlcl9kcml2ZXJfcmVnaXN0ZXIoKSBk
cml2ZXI6PGJyPgomZ3Q7IDB4NTU2YzA0YjAsIG5hbWU6IGF0bW9kZW08YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL2NhbGwtc2V0dGluZ3MuYzpvZm9ub19j
YWxsX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMDM5
MCwgbmFtZTogYXRtb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8t
MS4xNC9zcmMvcGhvbmVib29rLmM6b2Zvbm9fcGhvbmVib29rX2RyaXZlcl9yZWdpc3RlcigpIGRy
aXZlcjo8YnI+CiZndDsgMHg1NTZjMDczMCwgbmFtZTogYXRtb2RlbTxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVy
KCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwNjgwLCBuYW1lOiBhdG1vZGVtPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwNDAwLCBuYW1lOiBhdG1vZGVtPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwNTYwLCBuYW1lOiBhdG1vZGVtPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fZHJpdmVy
X3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwNWE4LCBuYW1lOiBhdG1vZGVtLW5v
ZWY8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3N0ay5jOm9mb25vX3N0
a19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7IDB4NTU2YzA2NjAsIG5hbWU6IGF0
bW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpv
Zm9ub19uZXRyZWdfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmMwNTAw
LCBuYW1lOiBhdG1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9j
YnMuYzpvZm9ub19jYnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMw
NDYwLCBuYW1lOiBhdG1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJyPgomZ3Q7IC9vZm9u
by0xLjE0L3NyYy9jYWxsLXZvbHVtZS5jOm9mb25vX2NhbGxfdm9sdW1lX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjo8YnI+CiZndDsgMHg1NTZjMDc5MCwgbmFtZTogYXRtb2RlbTxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3Jl
Z2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwN2QwLCBuYW1lOiBhdG1vZGVtPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19jb250
ZXh0X2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZjMDgwMCwgbmFtZTog
YXRtb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLWF1dGgu
YzpvZm9ub19zaW1fYXV0aF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2
YzA4MjAsIG5hbWU6IGF0bW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL2duc3MuYzpvZm9ub19nbnNzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CiZndDsg
MHg1NTZjMDg0MCwgbmFtZTogYXRtb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBk
cml2ZXI6IDB4NTU2YzAxYjAsIG5hbWU6IGdvYmk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVnaXN0ZXIoKTxicj4K
Jmd0OyBkcml2ZXI6IDB4NTU2YmZmODAsIG5hbWU6IHFtaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdp
c3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZiZmZmMCwgbmFtZTogcW1pbW9kZW08YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9m
b25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7IDB4NTU2YmZm
YTAsIG5hbWU6IHFtaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Ny
Yy9zaW0uYzpvZm9ub19zaW1fZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1
NmMwMDIwLCBuYW1lOiBxbWltb2RlbS1sZWdhY3k8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJy
PgomZ3Q7IDB4NTU2YzAwNzAsIG5hbWU6IHFtaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9zbXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVy
Ojxicj4KJmd0OyAweDU1NmMwMGMwLCBuYW1lOiBxbWltb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvdXNzZC5jOm9mb25vX3Vzc2RfZHJpdmVyX3JlZ2lzdGVyKCkg
ZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwMGUwLCBuYW1lOiBxbWltb2RlbTxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lz
dGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmMwMTAwLCBuYW1lOiBxbWltb2RlbTxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4
dF9kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YzAxMjAsIG5hbWU6IHFt
aW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3NyYy9y
YWRpby1zZXR0aW5ncy5jOm9mb25vX3JhZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJy
PgomZ3Q7IGRyaXZlcjogMHg1NTZjMDE0MCwgbmFtZTogcW1pbW9kZW08YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTo8YnI+CiZndDs8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL2xvY2F0aW9uLXJlcG9y
dGluZy5jOm9mb25vX2xvY2F0aW9uX3JlcG9ydGluZ19kcml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0
OyBkcml2ZXI6IDB4NTU2YzAxNzAsIG5hbWU6IHFtaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigp
PGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZiZmYyYywgbmFtZTogdTg1MDA8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fZGV2aW5mb19kcml2ZXJfcmVn
aXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YmZmMTAsIG5hbWU6IHU4NTAwPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25vX21vZGVtX2RyaXZl
cl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZiZmVjMCwgbmFtZTogbjkwMDxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9k
cml2ZXJfcmVnaXN0ZXIoKTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YmZlNzAsIG5hbWU6IGlzaXVz
Yjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpvZm9ub19k
ZXZpbmZvX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZiZmI5MCwgbmFt
ZTogaXNpbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQv
c3JjL3Bob25lYm9vay5jOm9mb25vX3Bob25lYm9va19kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6
PGJyPgomZ3Q7IDB4NTU2YmZiODAsIG5hbWU6IGlzaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX2RyaXZlcl9yZWdpc3Rl
cigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1NTZiZmJiMCwgbmFtZTogaXNpbW9kZW08YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL3ZvaWNlY2FsbC5jOm9mb25v
X3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7IDB4NTU2YmZiZTAs
IG5hbWU6IGlzaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9z
bXMuYzpvZm9ub19zbXNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4KJmd0OyAweDU1NmJm
YzMwLCBuYW1lOiBpc2ltb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvY2JzLmM6b2Zvbm9fY2JzX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CiZndDsgMHg1
NTZiZmM1MCwgbmFtZTogaXNpbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7
IDB4NTU2YmZjNzAsIG5hbWU6IGlzaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy91c3NkLmM6b2Zvbm9fdXNzZF9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJy
PgomZ3Q7IDB4NTU2YmZjYzAsIG5hbWU6IGlzaW1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3NyYy9jYWxsLWZvcndhcmRpbmcuYzpvZm9ub19jYWxsX2Zv
cndhcmRpbmdfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmJmY2UwLCBu
YW1lOiBpc2ltb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4x
NC9zcmMvY2FsbC1zZXR0aW5ncy5jOm9mb25vX2NhbGxfc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVy
KCk8YnI+CiZndDsgZHJpdmVyOiAweDU1NmJmZDAwLCBuYW1lOiBpc2ltb2RlbTxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9zcmMvY2FsbC1iYXJyaW5nLmM6b2Zv
bm9fY2FsbF9iYXJyaW5nX2RyaXZlcl9yZWdpc3RlcigpIGRyaXZlcjo8YnI+CiZndDsgMHg1NTZi
ZmQzMCwgbmFtZTogaXNpbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29m
b25vLTEuMTQvc3JjL2NhbGwtbWV0ZXIuYzpvZm9ub19jYWxsX21ldGVyX2RyaXZlcl9yZWdpc3Rl
cigpIGRyaXZlcjo8YnI+CiZndDsgMHg1NTZiZmQ1MCwgbmFtZTogaXNpbW9kZW08YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6
b2Zvbm9fcmFkaW9fc2V0dGluZ3NfZHJpdmVyX3JlZ2lzdGVyKCk8YnI+CiZndDsgZHJpdmVyOiAw
eDU1NmJmZDgwLCBuYW1lOiBpc2ltb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfZHJpdmVyX3JlZ2lzdGVyKCkgZHJpdmVyOjxicj4K
Jmd0OyAweDU1NmJmZGIwLCBuYW1lOiBpc2ltb2RlbTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJfcmVnaXN0ZXIo
KTxicj4KJmd0OyBkcml2ZXI6IDB4NTU2YmZkZDAsIG5hbWU6IGlzaW1vZGVtPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3NyYy9hdWRpby1zZXR0aW5ncy5jOm9m
b25vX2F1ZGlvX3NldHRpbmdzX2RyaXZlcl9yZWdpc3RlcigpPGJyPgomZ3Q7IGRyaXZlcjogMHg1
NTZiZmRmMCwgbmFtZTogaXNpbW9kZW08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL3NpbS5jOm9mb25vX3NpbV9kcml2ZXJfcmVnaXN0ZXIoKSBkcml2ZXI6PGJyPgomZ3Q7
IDB4NTU2YmZlMDAsIG5hbWU6IHdnbW9kZW0yLjU8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzp1ZGV2X3N0YXJ0KCk8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzplbnVtZXJhdGVfZGV2aWNlcygpPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tf
dXNiX2RldmljZSgpIGh1Yjxicj4KJmd0OyBbKG51bGwpOihudWxsKV08YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkg
dXNiPGJyPgomZ3Q7IFswYmRhOjgxNzZdPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHJ0bDgxOTJjdTxicj4KJmd0
OyBbKG51bGwpOihudWxsKV08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgcnRsODE5MmN1PGJyPgomZ3Q7IFswYmRh
OjgxNzZdPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5n
LmM6Y2hlY2tfdXNiX2RldmljZSgpIHJ0bDgxOTJjdTxicj4KJmd0OyBbMGJkYTo4MTc2XTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3Vz
Yl9kZXZpY2UoKSBodWI8YnI+CiZndDsgWyhudWxsKToobnVsbCldPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVz
Yjxicj4KJmd0OyBbMTJkMToxMDAxXTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb248YnI+CiZndDsgWyhu
dWxsKToobnVsbCldPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMv
dWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KJmd0OyBbMTJkMToxMDAxXTxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9k
ZXZpY2UoKTxicj4KJmd0OyAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEv
dXNiMi8yLTE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2
bmcuYzphZGRfZGV2aWNlKCk8YnI+CiZndDs8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3BsYXRmb3Jt
L3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjAvdHR5VVNCMC90dHkvdHR5VVNCMDxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9k
ZXZpY2UoKSAvZGV2L3R0eVVTQjA8YnI+CiZndDsgKGh1YXdlaSkgMjU1LzI1NS8yNTUgWzAwXSA9
PSZndDsgKG51bGwpIChudWxsKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb248YnI+CiZndDsgWyhudWxs
KToobnVsbCldPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRl
dm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KJmd0OyBbMTJkMToxMDAxXTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZp
Y2UoKTxicj4KJmd0OyAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNi
Mi8yLTE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcu
YzphZGRfZGV2aWNlKCk8YnI+CiZndDs8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3Rh
bmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjEvdHR5VVNCMS90dHkvdHR5VVNCMTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZp
Y2UoKSAvZGV2L3R0eVVTQjE8YnI+CiZndDsgKGh1YXdlaSkgMjU1LzI1NS8yNTUgWzAxXSA9PSZn
dDsgKG51bGwpIChudWxsKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVn
aW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb248YnI+CiZndDsgWyhudWxsKToo
bnVsbCldPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5n
LmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KJmd0OyBbMTJkMToxMDAxXTxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2Uo
KTxicj4KJmd0OyAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8y
LTE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzph
ZGRfZGV2aWNlKCk8YnI+CiZndDs8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3Rhbmdv
eC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjIvdHR5VVNCMi90dHkvdHR5VVNCMjxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2Uo
KSAvZGV2L3R0eVVTQjI8YnI+CiZndDsgKGh1YXdlaSkgMjU1LzI1NS8yNTUgWzAyXSA9PSZndDsg
KG51bGwpIChudWxsKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5z
L3VkZXZuZy5jOmNyZWF0ZV9tb2RlbSgpPGJyPgomZ3Q7IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90
YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNyZWF0ZV9tb2RlbSgpIGRyaXZlcj1odWF3ZWk8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3Jl
YXRlKCkgbmFtZTogKG51bGwpLDxicj4KJmd0OyB0eXBlOiBodWF3ZWk8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKTxicj4K
Jmd0OyAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9o
dWF3ZWkoKSAvZGV2L3R0eVVTQjA8YnI+CiZndDsgMjU1LzI1NS8yNTUgMDAgKG51bGwpPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVh
d2VpKCkgL2Rldi90dHlVU0IxPGJyPgomZ3Q7IDI1NS8yNTUvMjU1IDAxIChudWxsKTxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdl
aSgpIC9kZXYvdHR5VVNCMjxicj4KJmd0OyAyNTUvMjU1LzI1NSAwMiAobnVsbCk8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWko
KSBtZG09L2Rldi90dHlVU0IwPGJyPgomZ3Q7IHBjdWk9L2Rldi90dHlVU0IyIGRpYWc9KG51bGwp
IHFtaT0obnVsbCkgbmV0PShudWxsKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmVi
MzgwIHByb3BlcnR5IERldmljZTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmViMzgw
IHByb3BlcnR5IE1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9t
b2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtPGJyPgomZ3Q7IDB4NTU2ZWIzODAgcHJv
cGVydHkgUGN1aTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0u
YzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmViMzgwIHByb3BlcnR5
IERpYWc8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0
X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08YnI+CiZndDsgMHg1NTZlYjM4MCBwcm9wZXJ0eSBOZXR3
b3JrSW50ZXJmYWNlPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX3JlZ2lzdGVyKCkgMHg1NTZlYjM4MDxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wcm9iZSgpIDB4NTU2ZWIz
ODA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6ZW1pdF9t
b2RlbV9hZGRlZCgpIDB4NTU2ZWIzODA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL21vZGVtLmM6Y2FsbF9tb2RlbXdhdGNoZXMoKSAweDU1NmViMzgwPGJyPgomZ3Q7IGFk
ZGVkOjE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9oZnBfYWdf
Ymx1ZXo1LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CiZndDsgMHg1NTZlYjM4MCwgYWRkZWQ6
IDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9kdW5fZ3dfYmx1
ZXo1LmM6bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CiZndDsgMHg1NTZlYjM4MCwgYWRkZWQ6IDE8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdp
bmcuYzptb2RlbV93YXRjaCgpIG1vZGVtOjxicj4KJmd0OyAweDU1NmViMzgwLCBhZGRlZDogMTxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3B1c2gtbm90aWZpY2F0
aW9uLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CiZndDsgMHg1NTZlYjM4MCwgYWRkZWQ6IDE8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3
ZWlfZW5hYmxlKCkgMHg1NTZlYjM4MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmVi
MzgwIHByb3BlcnR5IE1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Bs
dWdpbnMvaHVhd2VpLmM6b3Blbl9kZXZpY2UoKSBNb2RlbTxicj4KJmd0OyAvZGV2L3R0eVVTQjA8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVt
X3Byb3BlcnR5KCkgbW9kZW08YnI+CiZndDsgMHg1NTZlYjM4MCBwcm9wZXJ0eSBQY3VpPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6b3Blbl9kZXZp
Y2UoKSBQY3VpIC9kZXYvdHR5VVNCMjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBNb2RlbTogJmd0
OyBBVEUwICtDTUVFPTFccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFURTAg
K0NNRUU9MVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVRJXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuTWFudWZhY3R1cmVyOiBodWF3ZWlcclxuTW9kZWw6IEUzMDNcclxuUmV2aXNp
b246PGJyPgomZ3Q7IDIyLjMxOC4wNS4wMC4wMFxyXG5JTUVJOiA4NjI1NjYwMjAwMDU2OTdcclxu
K0dDQVA6PGJyPgomZ3Q7ICtDR1NNLCtEUywrRVNcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlJGU1dJVENIPT9ccjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG5FUlJPUlxyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVCtDRlVOPTFccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5eU0lNU1Q6MCwwXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5P
S1xyXG5cclxuXlNJTVNUOjEsMFxyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX2VuYWJsZSgpPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c2ltc3Rfbm90aWZ5KCkgMjU1IC0mZ3Q7IDE8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5TWVNJTkZPXHI8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDJcclxuXHJcbitDR1JFRzo8YnI+
CiZndDsgMlxyXG5cclxuXlNZU0lORk86MCwzLDAsMCwxLDAsMFxyXG5cclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c3lzaW5mb19l
bmFibGVfY2IoKSAxIC0mZ3Q7IDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogTW9kZW06ICZndDsg
QVQmYW1wO0MwXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCZhbXA7QzBc
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBNb2RlbTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiBNb2RlbTogJmd0OyBBVCtDU0NTPSZxdW90O0dTTSZxdW90O1xyPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NDUz0mcXVvdDtHU00mcXVvdDtccjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBNb2RlbTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUXlUyRElBRz9ccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5e
VTJESUFHOiAxMTlcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUXkdFVFBPUlRNT0RFXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuXkdFVFBPUlRNT0RFOiBUWVBFOiBXQ0RNQTogaHVhd2VpLFxyXG5cclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVReVVNTRE1PREU9P1xyPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5VU1NETU9ERTogKDAtMSlcclxuXHJcbk9LXHJc
bjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkRJQUxNT0RFPT9ccjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eRElBTE1PREU6ICgwLTIpLCgwLTI1
NSlcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkNW
T0lDRT0/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXkNWT0lDRTog
KDApXHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
RlVOPTVccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JFRzogMFxy
XG5cclxuK0NHUkVHOiAwXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5PS1xyXG5cclxuXk1PREU6IDAsMFxyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX29mZmxpbmUoKTxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3Rh
dGU6IDAsPGJyPgomZ3Q7IG5ldyBzdGF0ZTogMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wcmVfc2ltKCkgMHg1NTZlYjM4MDxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlVTU0RNT0RFP1xyPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dh
dGNoKCkgMHg1NTZkYzY2MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
c2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZGM2NjA8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0
Y2goKSAweDU1NmRjNjYwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5V
U1NETU9ERTogMVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVReRElBTE1PREU/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
XkRJQUxNT0RFOjMsMlxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVReQ1ZPSUNFP1xyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bl5DVk9JQ0U6IDEsIDgwMDAsIDE2LCAyMFxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFZvaWNlIGNoYW5uZWw6IDgwMDAgSHosIDE2IGJpdHMsIDIwbXMgcGVyaW9kPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrR0NBUFxyPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VTXHJcblxyXG5PS1xyXG48
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwxMjI1OCwwLDAs
MjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgom
Z3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDIyRkUyQTUwMzgwMDE3MThB
MDEwNThCMDMyRjA2MDM4MDAyMDAwQTg4MDExMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNt
X2luZm9fY2IoKTxicj4KJmd0OyBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5ERFNFVEVYPT9ccjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eRERTRVRFWDogKDIpXHJcblxyXG5PS1xyXG48YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR01JXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuaHVhd2VpXHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwxMjI1OCwwLDAsMTBccjxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDsgMTQ0LDAsJnF1b3Q7OTg1
MzAzMDUwMTA3MDg1MzA1RjYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8
YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDEwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2Zm
OiAwLDxicj4KJmd0OyBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZndDsgQVQrQ0dNTVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbkUzMDNcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTkyLDI4NDIxLDAsMCwyNTVccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDs8YnI+CiZndDsgMTQ0LDAsJnF1b3Q7NjIxQzgy
MDI0MTIxODMwMjZGMDVBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNDgwMDIwMDBBODgwMTEwJnF1
b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgomZ3Q7IGNyc21faW5mb19j
YjogOTAsIDAwLCAzMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NHTVJc
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4yMi4zMTguMDUuMDAuMDBc
clxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009
MTc2LDI4NDIxLDAsMCwxMFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bitDUlNNOjxicj4KJmd0OyAxNDQsMCwmcXVvdDs2NTZFRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xy
XG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMv
YXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkw
LCAwMCwgMTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6
c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJyPgomZ3Q7IGRhdGFvZmY6IDAs
IHRvY29weTogMTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR1NOXHI8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuODYyNTY2MDIwMDA1Njk3XHJc
blxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5
MiwxMjAzNywwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
K0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDIyRjA1
QTUwMzgwMDE3MThBMDEwNThCMDMyRjA2MDQ4MDAyMDAwQTg4MDEyOCZxdW90O1xyXG5cclxuT0tc
clxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX2luZm9fY2IoKTxicj4KJmd0OyBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwxMjAzNywwLDAs
MTBccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZn
dDsgMTQ0LDAsJnF1b3Q7NjU2RUZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDEwPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFk
X2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLDxicj4KJmd0OyBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1BJTj9ccjxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BJTjogUkVBRFlcclxuXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3Bpbl9jYigpIGNyc21fcGluX2NiOjxicj4KJmd0OyBSRUFEWTxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfcGluX3JldHJpZXNfcXVl
cnkoKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkNQSU4/XHI8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXkNQSU46IFJFQURZLCwxMCwzLDEwLDNc
clxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4KJmd0OyBjb3VudGVyIGlk
PTksIHZhbD0xMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4KJmd0OyBjb3VudGVyIGlkPTEs
IHZhbD0zPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2Rl
bS9zaW0uYzpodWF3ZWlfY3Bpbl9jYigpIHJldHJ5PGJyPgomZ3Q7IGNvdW50ZXIgaWQ9MTEsIHZh
bD0xMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4KJmd0OyBjb3VudGVyIGlkPTQsIHZhbD0z
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1OTAsMCww
LDI1NVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYs
MTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1ODksMCwwLDI1NVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDs2
MjFDODIwMjQxMjE4MzAyNkZBREE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA2ODAwMjAwMDQ4ODAx
MTgmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CiZndDsgY3JzbV9p
bmZvX2NiOiA5MCwgMDAsIDMwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q1JTTT0xNzYsMjg1ODksMCwwLDRccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7
IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDImcXVvdDtcclxuXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDQ8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxv
Y2tfY2IoKSBidWZvZmY6IDAsPGJyPgomZ3Q7IGRhdGFvZmY6IDAsIHRvY29weTogNDxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDM4LDAsMCwyNTVccjxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTA2LDEzMCwmcXVv
dDsmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTkyLDI4NDcyLDAsMCwyNTVccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDs8YnI+CiZndDsgMTQ0LDAsJnF1b3Q7NjIxQzgyMDI0
MTIxODMwMjZGMzhBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwMjgwMDIwMDBBODgwMTIwJnF1b3Q7
XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgomZ3Q7IGNyc21faW5mb19jYjog
OTAsIDAwLCAzMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc2
LDI4NDcyLDAsMCwxMFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
UlNNOjxicj4KJmd0OyAxNDQsMCwmcXVvdDs3RUVFMTExQzI3RjY1OTAwMDAwMCZxdW90O1xyXG5c
clxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRt
b2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAw
MCwgMTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2lt
X2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJyPgomZ3Q7IGRhdGFvZmY6IDAsIHRv
Y29weTogMTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5Miwy
ODUwMiwwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NS
U006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDI2RjU2QTUw
MzgwMDE3MThBMDEwNThCMDM2RjA2MDc4MDAyMDAwMTg4MDEyOCZxdW90O1xyXG5cclxuT0tcclxu
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0u
YzphdF9jcnNtX2luZm9fY2IoKTxicj4KJmd0OyBjcnNtX2luZm9fY2I6IDkwLCAwMCwgMzA8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwyODUwMiwwLDAsMVxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVv
dDswMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCw8YnI+CiZndDsg
ZGF0YW9mZjogMCwgdG9jb3B5OiAxPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ0lNSVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbjI3MjA1MDEw
MDQxMzU4MFxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jaW1pX2NiKCkgY2ltaV9jYjo8YnI+CiZndDsgMjcy
MDUwMTAwNDEzNTgwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2Rl
bS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMSw8YnI+CiZndDsgbmV3IHN0YXRl
OiAyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6
aHVhd2VpX3Bvc3Rfc2ltKCkgMHg1NTZlYjM4MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOjxicj4K
Jmd0OyAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRfZ3Byc19j
b250ZXh0X3Byb2JlKCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21v
ZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08YnI+CiZndDsgMHg1NTZlYjM4MCBwcm9w
ZXJ0eSBBbHdheXNPbmxpbmU8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
UkM9MVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmViMzgwIHByb3BlcnR5IEFsd2F5c09ubGluZTxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdl
aV9zZXRfb25saW5lKCkgbW9kZW08YnI+CiZndDsgMHg1NTZlYjM4MCBvbmxpbmU8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDTElQPTFccjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVCtDT0xQPTFccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5P
S1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDQ1dBPTFccjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvZHJpdmVycy9odWF3ZWltb2RlbS92b2ljZWNh
bGwuYzpodWF3ZWlfdm9pY2VjYWxsX2luaXRpYWxpemVkKCk8YnI+CiZndDsgcmVnaXN0ZXJpbmcg
dG8gbm90aWZpY2F0aW9uczxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
c2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZGM2NjA8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9ibHVlejUuYzpidF9yZWdpc3Rlcl9wcm9m
aWxlKCk8YnI+CiZndDsgQmx1ZXRvb3RoOiBSZWdpc3RlcmluZyAwMDAwMTExZi0wMDAwLTEwMDAt
ODAwMC0wMDgwNWY5YjM0ZmIgKGhmcF9hZyk8YnI+CiZndDsgcHJvZmlsZTxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkNWT0lDRT0/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuXkNWT0lDRTogKDApXHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU0NTPT9ccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1NDUzogKCZxdW90O0lSQSZxdW90OywmcXVvdDtVQ1MyJnF1b3Q7
LCZxdW90O0dTTSZxdW90OylcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmZ3Q7IEFUXlNZU0NGRz0/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuXlNZU0NGRzo8YnI+CiZndDs8YnI+CiZndDsgKDIsMTMsMTQsMTYpLCgwLTMpLCgoMjAw
MDAwMDQwMDM4MCwmcXVvdDtHU005MDAvR1NNMTgwMC9XQ0RNQTkwMC9XQ0RNQTIxMDAmcXVvdDsp
LCgyODAwMDAsJnF1b3Q7R1NNODUwL0dTTTE5MDAmcXVvdDspLCgzZmZmZmZmZiwmcXVvdDtBbGw8
YnI+CiZndDsgYmFuZHMmcXVvdDspKSwoMC0yKSwoMC00KVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NNUz0/XHI8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NTTVM6ICgwLDEpXHJcblxyXG5PS1xyXG48YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmF0X2NzbXNf
cXVlcnlfY2IoKSBDU01TPGJyPgomZ3Q7IHF1ZXJ5IHBhcnNlZCBzdWNjZXNzZnVsbHk8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR0RDT05UPT9ccjxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ0dEQ09OVDo8YnI+CiZndDsgKDEtMTEpLCZxdW90
O0lQJnF1b3Q7LCwsKDAtMiksKDAtMyksKDAsMSksKDAsMSlcclxuK0NHRENPTlQ6PGJyPgomZ3Q7
ICgxLTExKSwmcXVvdDtQUFAmcXVvdDssLCwoMC0yKSwoMC0zKSwoMCwxKSwoMCwxKVxyXG5cclxu
XHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NGVU49MVxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5TSU1TVDowLDBcclxuPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c2ltc3Rf
bm90aWZ5KCkgMSAtJmd0OyAwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFJlZ2lzdGVyUHJvZmls
ZSgpIHJlcGxpZWQgYW4gZXJyb3I6PGJyPgomZ3Q7IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9y
LlNwYXduLkNoaWxkRXhpdGVkLCBMYXVuY2ggaGVscGVyIGV4aXRlZCB3aXRoPGJyPgomZ3Q7IHVu
a25vd24gcmV0dXJuIGNvZGUgMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5PS1xyXG5cclxuXlNJTVNUOjEsMFxyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpzaW1zdF9ub3RpZnkoKSAwIC0mZ3Q7IDE8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQ4MCwwLDAsMjU1XHI8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDJcclxuXHJcbitDR1JF
RzogMlxyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJy
PgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMjIwNjgzMDI2RjQwQTUw
MzgwMDE3MThBMDEwNThCMDM2RjA2MDU4MDAyMDBDQzg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY3JzbV9pbmZvX2NiKCk8YnI+CiZndDsgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1BCUz0/XHI8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NQQlM6ICgmcXVvdDtTTSZxdW90OywmcXVvdDtFTiZx
dW90OywmcXVvdDtPTiZxdW90OywmcXVvdDtGRCZxdW90OylcclxuXHJcbk9LXHJcbjxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTTVM9MVxyPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDU01TOiAxLDEsMVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dSRUc9P1xyPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDR1JFRzogKDAtMilcclxuXHJcbk9LXHJcbjxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0lORk9ccjxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eU1lTSU5GTzowLDMsMCwwLDEsMCwwXHJcblxyXG5PS1xy
XG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpz
eXNpbmZvX29ubGluZV9jYigpIDEgLSZndDsgMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9zcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3RhdGU6IDIsPGJy
PgomZ3Q7IG5ldyBzdGF0ZTogMzxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wb3N0X29ubGluZSgpIDB4NTU2ZWIzODA8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCwxLDQsMzRccjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDs8YnI+CiZn
dDsgMTQ0LDAsJnF1b3Q7NEQ3OTIwNEU3NTZENjI2NTcyRkZGRkZGRkZGRkZGRkZGRkZGRkZGRjA3
OTE1MzgzMTM5Nzc4NDhGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NNUz9ccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1NNUzogMSwxLDEsMVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dSRUc9MlxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NHQVVUTz0wXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tc
clxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dFUkVQPTIsMVxyPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbkVSUk9SXHJcbjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2JsdWV6NS5jOmJ0X3JlZ2lzdGVyX3By
b2ZpbGUoKTxicj4KJmd0OyBCbHVldG9vdGg6IFJlZ2lzdGVyaW5nIDAwMDAxMTAzLTAwMDAtMTAw
MC04MDAwLTAwODA1ZjliMzRmYiAoZHVuX2d3KTxicj4KJmd0OyBwcm9maWxlPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JFRz0/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NSRUc6ICgwLTIpXHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU0NCPT9ccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1NDQjooMCwxKVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1VTRD0xXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ1JTTT0xNzgsMjg0ODAsMiw0LDM0XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVh
ZF9jYjogOTAsIDAwLCAzNDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NN
R0Y9P1xyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFJlZ2lzdGVyUHJvZmlsZSgpIHJlcGxpZWQg
YW4gZXJyb3I6PGJyPgomZ3Q7IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLlNwYXduLkNoaWxk
RXhpdGVkLCBMYXVuY2ggaGVscGVyIGV4aXRlZCB3aXRoPGJyPgomZ3Q7IHVua25vd24gcmV0dXJu
IGNvZGUgMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ01HRjogKDAs
MSlcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NS
RUc9MlxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9z
cG5fd2F0Y2goKSAweDU1NmRjNjYwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpPGJyPgomZ3Q7
IDB4NTU2ZGNmMTg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU0NCPTBc
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOmNic19nb3RfaW1zaSgpIEdvdCBJ
TVNJOjxicj4KJmd0OyAyNzIwNTAxMDA0MTM1ODA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL25ldHdvcmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCk8
YnI+CiZndDsgMHg1NTZkY2YxODxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NQTVM9P1xyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUE1TOjxi
cj4KJmd0OyAoJnF1b3Q7U00mcXVvdDssJnF1b3Q7TUUmcXVvdDspLCgmcXVvdDtTTSZxdW90Oywm
cXVvdDtNRSZxdW90OyksKCZxdW90O1NNJnF1b3Q7LCZxdW90O01FJnF1b3Q7KVxyXG5cclxuT0tc
clxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAs
Myw0LDM0XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJy
PgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xy
XG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Np
bS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSRUc/XHI8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDIsMlxyXG5cclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVn
X3N0YXR1c19ub3RpZnkoKTxicj4KJmd0OyAvaHVhd2VpXzAgc3RhdHVzIDIgdGVjaCAtMTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOmN1cnJlbnRfb3Bl
cmF0b3JfY2FsbGJhY2soKTxicj4KJmd0OyAweDU1NmRjZjE4LCAobmlsKTxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAy
LCAtMSwgLTEsIC0xLDxicj4KJmd0OyAobnVsbCkobnVsbCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAyPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ01HRj0wXHI8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBD
VUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsNCw0LDM0XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90O0ZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7
IGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NQTVM9JnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDssJnF1b3Q7TUUmcXVvdDtc
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eTU9ERTogNSw0XHJcbjxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BNUzogMCwyMCwwLDIwLDAs
MjBcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTc4LDI4NDgwLDUsNCwzNFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitDUlNNOjxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90
O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6
IDkwLCAwMCwgMzQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDTk1JPT9c
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ05NSTo8YnI+CiZndDsg
KDAtMiksKDAtMyksKDAsMiksKDAtMiksKDAsMSlcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc21zLmM6YnVpbGRfY25taV9z
dHJpbmcoKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4
NDgwLDYsNCwzNFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNN
Ojxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxu
T0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2Rl
bS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MzQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDTk1JPTEsMSwyLDEsMFxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IER1cGxpY2F0ZSBFRnNkbiBlbnRyaWVzIGZvciBgRW1l
cmdlbmN5IFNlcnZpY2VzJiMzOTs8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9uZXR3b3Jr
LmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpPGJyPgomZ3Q7IDB4NTU2ZGNmMTg8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Ntcy5jOnNtc19yZXN0b3Jl
X3R4X3F1ZXVlKCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9w
dXNoLW5vdGlmaWNhdGlvbi5jOnNtc193YXRjaCgpPGJyPgomZ3Q7IHJlZ2lzdGVyZWQ8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzpz
bXNfd2F0Y2goKSByZWdpc3RlcmVkPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsg
QVQrQ1JTTT0xOTIsMjg2MTgsMCwwLDI1NVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6
ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDs2MjFFODIwNTQy
MjEwMDA2MDU4MzAyNkZDQUE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA1ODAwMjAwMUU4ODAwJnF1
b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgomZ3Q7IGNyc21faW5mb19j
YjogOTAsIDAwLCAzMjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NNR0w9
NFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbl5SU1NJOiAxM1xyXG5c
clxuXkhDU1E6JnF1b3Q7V0NETUEmcXVvdDssNDIsMzQsNDlcclxuPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc21zLmM6YXRfY21nbF9kb25lKCk8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR1NNUz0zXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZn
dDsgQVQrQ1JTTT0xNzgsMjg2MTgsMSw0LDZccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5P
S1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA2
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMiw0
LDZccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
PGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMyw0LDZccjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7
XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjog
OTAsIDAwLCA2PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgs
Mjg2MTgsNCw0LDZccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
cmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsNSw0LDZccjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAw
MDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21f
cmVhZF9jYjogOTAsIDAwLCA2PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q1JTTT0xOTIsMjg2MTcsMCwwLDI1NVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOjxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDs2MjFFODIwNTQyMjEw
MDA1MDU4MzAyNkZDOUE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjAyODAwMjAwMTk4ODAwJnF1b3Q7
XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgomZ3Q7IGNyc21faW5mb19jYjog
OTAsIDAwLCAzMjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4
LDI4NjE3LDEsNCw1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NS
U006IDE0NCwwLCZxdW90OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNywyLDQsNVxyPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAw
JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVh
ZF9jYjogOTAsIDAwLCA1PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JT
TT0xNzgsMjg2MTcsMyw0LDVccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEwMDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgNTxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDQsNCw1XHI8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAw
MDAwMDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3Jz
bV9yZWFkX2NiOiA5MCwgMDAsIDU8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDUlNNPTE3OCwyODYxNyw1LDQsNVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA1PGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg0MzMsMCwwLDI1NVxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZx
dW90OyZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3NyYy9tZXNzYWdlLXdhaXRpbmcuYzptd19jcGhzX213aXNfcmVhZF9jYigpIE5vPGJyPgom
Z3Q7IENQSFMgTVdJUyBvbiBTSU08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDUlNNPTE5MiwyODYxOSwwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIy
MTAwMTAwNTgzMDI2RkNCQTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDU4MDAyMDA1MDg4MDAmcXVv
dDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CiZndDsgY3JzbV9pbmZvX2Ni
OiA5MCwgMDAsIDMyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0x
NzgsMjg2MTksMSw0LDE2XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
K0NSU006PGJyPgomZ3Q7IDE0NCwwLCZxdW90O0ZGMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21f
cmVhZF9jYjogOTAsIDAwLCAxNjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTc4LDI4NjE5LDIsNCwxNlxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOjxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0
OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVCtDUlNNPTE3OCwyODYxOSwzLDQsMTZccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDsgMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8
YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE2PGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksNCw0LDE2XHI8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7IDE0NCwwLCZxdW90O0ZGMDBGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVh
ZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDUsNCwxNlxyPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0OyAxNDQsMCwmcXVvdDtG
RjAwRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxv
Y2soKSBidWZvZmY6IDAsPGJyPgomZ3Q7IHNlZWtvZmY6IDM5LCB0b3JlYWQ6IDE3PGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Js
b2NrKCkgYnVmb2ZmOiAwLDxicj4KJmd0OyBzZWVrb2ZmOiAzOSwgdG9yZWFkOiAxMDxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vY2JzLmM6YXRfY2Jz
X3NldF90b3BpY3MoKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9
MFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9MCwmcXVvdDswLDUwLDIxNCw0MzUy
LTQzNTYmcXVvdDtccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xy
XG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQzNyww
LDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDEw
NiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxNSwwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuXlNSVlNUOiAyXHJcblxyXG4rQ0dSRUc6IDEsJnF1b3Q7MDA0
MCZxdW90OywmcXVvdDswMkMxMTU1QSZxdW90O1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvaHVhd2Vp
XzA8YnI+CiZndDsgc3RhdHVzIDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMjIw
NTgzMDI2RkM3QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDI4MDAyMDBBQTg4MDAmcXVvdDtcclxu
XHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CiZndDsgY3JzbV9pbmZvX2NiOiA5MCwg
MDAsIDMyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2
MTUsMSw0LDM0XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006
PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzRENjE2OTZDRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkYwNzkxNTM4MzMzMzMxMzE3RkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5P
S1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCAz
NDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDIs
NCwzNFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4K
Jmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxu
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0u
YzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwzLDQsMzRc
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDs8
YnI+CiZndDsgMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTUsNCw0LDM0XHI8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgom
Z3Q7IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
cmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250
ZXh0LmM6YXRfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5KCkgY2lkIDE8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogTW9kZW06ICZndDsgQVQrQ0dEQ09OVD0xLCZxdW90O0lQJnF1b3Q7LCZxdW90OzNJcmVs
YW5kJnF1b3Q7XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogTW9kZW06ICZsdDsgXHJcbk9LXHJc
bjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3By
cy1jb250ZXh0LmM6YXRfY2dkY29udF9jYigpPGJyPgomZ3Q7IG9rIDE8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogTW9kZW06ICZndDsgQVREKjk5KioqMSNccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDUsNCwzNFxyPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IE1vZGVtOiAmbHQ7IFxyXG5DT05ORUNUXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRfY2dkYXRhX2Ni
KCkgb2s8YnI+CiZndDsgMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6c2V0dXBfcHBwKCk8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90
O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgom
Z3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JFRzogMSwmcXVvdDswMDQwJnF1b3Q7LCZxdW90OzAyQzExNTVBJnF1b3Q7
XHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9m
b25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCk8YnI+CiZndDsgL2h1YXdlaV8wIHN0YXR1cyAxIHRl
Y2ggMjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX2xv
Y2F0aW9uX2NoYW5nZWQoKSAxLCAtMSwgLTEsIDIsPGJyPgomZ3Q7IChudWxsKShudWxsKTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNf
Y2hhbmdlZCgpIDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDT1BTPTMs
MlxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM/XHI8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuK0NPUFM6IDAsMiwmcXVvdDsyNzIwNSZxdW90OywyXHJcblxy
XG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvZHJp
dmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19udW1lcmljX2NiKCkgQ29w
czxicj4KJmd0OyBudW1lcmljIGdvdCBtY2M6IDI3MiwgbW5jOiAwNTxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTUVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6
ICZsdDsgXHJcbitDU1E6IDEzLDk5XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y3Nx
X2NiKCk8YnI+CiZndDsgY3NxX2NiOiAxMzxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3RpZnkoKTxicj4KJmd0
OyBzdHJlbmd0aCA0MTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM9
MywwXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ09QUz9ccjxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ09QUzogMCwwLCZxdW90OzMgSVJMJnF1b3Q7LDJcclxu
XHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjb3BzX2NiKCk8YnI+CiZndDsgY29wc19jYjog
MyBJUkwsIDI3MiAwNSAyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9u
ZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpPGJyPgomZ3Q7IDB4NTU2ZGNmMTgs
IChuaWwpPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYnMuYzpjYnNf
bG9jYXRpb25fY2hhbmdlZCgpIDEsIC0xLCAtMSwgMiw8YnI+CiZndDsgMjcyMDU8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2Vk
KCkgMSwgMCwgMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5j
Om5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuXlJTU0k6IDEwXHJcblxyXG5eSENTUTomcXVvdDtXQ0RNQSZxdW90OywzNywyOCw0
N1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpv
Zm9ub19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5KCk8YnI+CiZndDsgc3RyZW5ndGggMzI8YnI+CiZn
dDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgSG9tYW08YnI+CiZndDs8YnI+CiZndDs8YnI+
CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZn
dDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8
YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+
CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0
OyBcclxuXlJTU0k6IDEyXHJcblxyXG5eSENTUTomcXVvdDtXQ0RNQSZxdW90Oyw0MiwzMyw0N1xy
XG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9u
b19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5KCk8YnI+CiZndDsgc3RyZW5ndGggMzg8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXk1PREU6IDUsN1xyXG48YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOnBw
cF9jb25uZWN0KCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogSVA6IDEwLjIwNS4yMDYuMjQzPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IEROUzogMTcyLjMwLjIyNC42NSwgMTcyLjMwLjIyNC42NTxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOnByaV9hY3RpdmF0
ZV9jYWxsYmFjaygpIDB4NTU2ZTY1YTg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSBuZXQgYWRkPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBz
dWJzeXN0ZW0gbmV0PGJyPgomZ3Q7IGZpbmlzaGVkPGJyPgomZ3Q7PGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfbW9kZW1fbGlzdCgpPGJy
PgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgom
Z3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7
PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDs8YnI+CiZndDs8YnI+CiZndDsgXHJcbl5E
U0ZMT1dSUFQ6MDAwMDAwMDIsMDAwMDAxRUQsMDAwMDAyOUUsMDAwMDAwMDAwMDAwMDNBNiwwMDAw
MDAwMDAwMDAwNEQ0LDAwMDAwMDAwLDAwMDAwMDAwXHJcbjxicj4KJmd0Ozxicj4KJmd0Ozxicj4K
Jmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0
Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxi
cj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7PGJyPgomZ3Q7PGJyPgomZ3Q7IFxyXG5eRFNGTE9XUlBUOjAw
MDAwMDA0LDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwMDAwMDAzQTYsMDAwMDAwMDAwMDAwMDRE
NCwwMDAwMDAwMCwwMDAwMDAwMFxyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNlKCk8YnI+CiZndDs8YnI+CiZndDsgL3N5
cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjAvdHR5
VVNCMC90dHkvdHR5VVNCMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVn
aW5zL3VkZXZuZy5jOmRlc3Ryb3lfbW9kZW0oKTxicj4KJmd0OyAvc3lzL2RldmljZXMvcGxhdGZv
cm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fcmVtb3ZlKCkgMHg1NTZlYjM4MDxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzptb2RlbV91bnJlZ2lz
dGVyKCkgMHg1NTZlYjM4MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMv
bW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3RhdGU6IDMsPGJyPgomZ3Q7IG5ldyBz
dGF0ZTogMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpm
bHVzaF9hdG9tcygpPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tZXNz
YWdlLXdhaXRpbmcuYzptd19yZW1vdmUoKSBhdG9tOjxicj4KJmd0OyAweDU1NmU1OTUwPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYWxsLWJhcnJpbmcuYzpjYWxsX2Jh
cnJpbmdfcmVtb3ZlKCkgYXRvbTo8YnI+CiZndDsgMHg1NTZlNTZiODxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2FsbC1zZXR0aW5ncy5jOmNhbGxfc2V0dGluZ3NfcmVt
b3ZlKCkgYXRvbTo8YnI+CiZndDsgMHg1NTZlNTVkMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvY2FsbC1mb3J3YXJkaW5nLmM6Y2FsbF9mb3J3YXJkaW5nX3JlbW92ZSgp
PGJyPgomZ3Q7IGF0b206IDB4NTU2ZTU0Zjg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL3Vzc2QuYzp1c3NkX3JlbW92ZSgpIGF0b206IDB4NTU2ZTU0Mzg8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpfX29mb25v
X25ldHJlZ19yZW1vdmVfc3RhdHVzX3dhdGNoKCkgMHg1NTZkY2YxODxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvY2JzLmM6Y2JzX3JlbW92ZSgpIGF0b206IDB4NTU2ZTUy
Yzg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2dwcnNfZGV0YWNoX3NodXRkb3duKCkgY2lkIDE8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9yZW1v
dmVfc3BuX3dhdGNoKCk8YnI+CiZndDsgMHg1NTZkYzY2MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm5ldHJlZ19yZW1vdmUoKSBhdG9tOiAweDU1NmRk
Yjg4PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6Z3Byc19j
b250ZXh0X3VucmVnaXN0ZXIoKSAweDU1NmU0NmE4LDxicj4KJmd0OyAweDU1NmRkODQwPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6Z3Byc19jb250ZXh0X3Jl
bW92ZSgpIGF0b206PGJyPgomZ3Q7IDB4NTU2ZTQ2Yzg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTo8
YnI+CiZndDsgL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2dw
cnNfY29udGV4dF9yZW1vdmUoKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL2JsdWV6NS5jOmJ0X3VucmVnaXN0ZXJfcHJvZmlsZSgpPGJyPgomZ3Q7IEJsdWV0b290
aDogVW5yZWdpc3RlcmluZyBwcm9maWxlIC9ibHVldG9vdGgvcHJvZmlsZS9kdW5fZ3c8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpncHJzX3VucmVnaXN0ZXIo
KSAweDU1NmRkODQwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9ncHJz
LmM6Z3Byc19yZW1vdmUoKSBhdG9tOiAweDU1NmRkOGE4PGJyPgomZ3Q7IG9mb25vZFszMDk0M106
PGJyPgomZ3Q7IC9vZm9uby0xLjE0L3BsdWdpbnMvcHVzaC1ub3RpZmljYXRpb24uYzpwdXNoX25v
dGlmaWNhdGlvbl9jbGVhbnVwKCk8YnI+CiZndDsgMHg1NTZkZjE5MDxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9wbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOnNt
YXJ0X21lc3NhZ2luZ19jbGVhbnVwKCkgMHg1NTZkZjE2MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvc21zLmM6c21zX3JlbW92ZSgpIGF0b206IDB4NTU2ZGQ3ODA8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3JhZGlvLXNldHRpbmdzLmM6cmFk
aW9fc2V0dGluZ3NfcmVtb3ZlKCk8YnI+CiZndDsgYXRvbTogMHg1NTZkZGJmODxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvcGhvbmVib29rLmM6cGhvbmVib29rX3JlbW92
ZSgpIGF0b206PGJyPgomZ3Q7IDB4NTU2ZGRiMDg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL2F1ZGlvLXNldHRpbmdzLmM6YXVkaW9fc2V0dGluZ3NfcmVtb3ZlKCk8YnI+
CiZndDsgYXRvbTogMHg1NTZkZGEyODxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvdm9pY2VjYWxsLmM6dm9pY2VjYWxsX3JlbW92ZSgpIGF0b206PGJyPgomZ3Q7IDB4NTU2
ZDY4Yzg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9ibHVlejUu
YzpidF91bnJlZ2lzdGVyX3Byb2ZpbGUoKTxicj4KJmd0OyBCbHVldG9vdGg6IFVucmVnaXN0ZXJp
bmcgcHJvZmlsZSAvYmx1ZXRvb3RoL3Byb2ZpbGUvaGZwX2FnPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpzaW1fcmVtb3ZlKCkgYXRvbTogMHg1NTZkYzc4ODxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpkZXZpbmZvX3Jl
bW92ZSgpIGF0b206IDB4NTU2ZGQwNzA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfZGlzYWJsZSgpIDB4NTU2ZWIzODA8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfcmVtb3Zl
KCkgMHg1NTZlYjM4MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzp1bnJlZ2lzdGVyX3Byb3BlcnR5KCkgcHJvcGVydHk8YnI+CiZndDsgMHg1NTZlYjEyODxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzp1bnJlZ2lzdGVy
X3Byb3BlcnR5KCkgcHJvcGVydHk8YnI+CiZndDsgMHg1NTZlYjJiMDxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzp1bnJlZ2lzdGVyX3Byb3BlcnR5KCkgcHJv
cGVydHk8YnI+CiZndDsgMHg1NTZlYjEwODxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9zcmMvbW9kZW0uYzp1bnJlZ2lzdGVyX3Byb3BlcnR5KCkgcHJvcGVydHk8YnI+CiZndDsg
MHg1NTZlYjQ0MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0u
Yzp1bnJlZ2lzdGVyX3Byb3BlcnR5KCkgcHJvcGVydHk8YnI+CiZndDsgMHg1NTZlYjBkMDxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzplbWl0X21vZGVtX3Jl
bW92ZWQoKSAweDU1NmViMzgwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Ny
Yy9tb2RlbS5jOmNhbGxfbW9kZW13YXRjaGVzKCkgMHg1NTZlYjM4MDxicj4KJmd0OyBhZGRlZDow
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaGZwX2FnX2JsdWV6
NS5jOm1vZGVtX3dhdGNoKCkgbW9kZW06PGJyPgomZ3Q7IDB4NTU2ZWIzODAsIGFkZGVkOiAwPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvZHVuX2d3X2JsdWV6NS5j
Om1vZGVtX3dhdGNoKCkgbW9kZW06PGJyPgomZ3Q7IDB4NTU2ZWIzODAsIGFkZGVkOiAwPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvc21hcnQtbWVzc2FnaW5nLmM6
bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CiZndDsgMHg1NTZlYjM4MCwgYWRkZWQ6IDA8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5j
Om1vZGVtX3dhdGNoKCkgbW9kZW06PGJyPgomZ3Q7IDB4NTU2ZWIzODAsIGFkZGVkOiAwPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6ZGVzdHJveV9t
b2RlbSgpIC9kZXYvdHR5VVNCMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9w
bHVnaW5zL3VkZXZuZy5jOmRlc3Ryb3lfbW9kZW0oKSAvZGV2L3R0eVVTQjE8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpkZXN0cm95X21vZGVtKCkg
L2Rldi90dHlVU0IyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMv
dWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IHJlbW92ZTxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzpyZW1vdmVfbW9kZW0oKTxicj4KJmd0
OyAvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4wL3R0
eVVTQjAvdHR5L3R0eVVTQjA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHk8YnI+CiZndDsgZmluaXNoZWQ8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1v
dmVfZGV2aWNlKCk8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhj
ZC0xL3VzYjIvMi0xLzItMToxLjA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
cGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHkgcmVtb3ZlPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnJlbW92ZV9tb2RlbSgp
PGJyPgomZ3Q7IC9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzIt
MToxLjEvdHR5VVNCMS90dHkvdHR5VVNCMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eTxicj4KJmd0OyBm
aW5pc2hlZDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZu
Zy5jOnJlbW92ZV9kZXZpY2UoKTxicj4KJmd0Ozxicj4KJmd0OyAvc3lzL2RldmljZXMvcGxhdGZv
cm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEvMi0xOjEuMS90dHlVU0IxL3R0eS90dHlVU0Ix
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZf
ZXZlbnQoKSBzdWJzeXN0ZW0gdHR5IHJlbW92ZTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL3VkZXYuYzpyZW1vdmVfbW9kZW0oKTxicj4KJmd0OyAvZGV2aWNlcy9w
bGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMS8yLTE6MS4yL3R0eVVTQjIvdHR5L3R0
eVVTQjI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6
dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHk8YnI+CiZndDsgZmluaXNoZWQ8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogVW5yZWdpc3RlclByb2ZpbGUoKSByZXBsaWVkIGFuIGVycm9yOjxicj4KJmd0
OyBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5TcGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhl
bHBlciBleGl0ZWQgd2l0aDxicj4KJmd0OyB1bmtub3duIHJldHVybiBjb2RlIDE8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNl
KCk8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIv
Mi0xLzItMToxLjE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91
ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSBuZXQgcmVtb3ZlPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnJlbW92ZV9tb2RlbSgpPGJyPgomZ3Q7
IC9kZXZpY2VzL3ZpcnR1YWwvbmV0L3BwcDA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSBuZXQ8YnI+CiZndDsg
ZmluaXNoZWQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2
bmcuYzpyZW1vdmVfZGV2aWNlKCk8YnI+CiZndDs8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3BsYXRm
b3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjIvdHR5VVNCMi90dHkvdHR5VVNC
Mjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnJl
bW92ZV9kZXZpY2UoKTxicj4KJmd0OyAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2kt
aGNkLTEvdXNiMi8yLTEvMi0xOjEuMjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9wbHVnaW5zL3VkZXZuZy5jOnJlbW92ZV9kZXZpY2UoKTxicj4KJmd0OyAvc3lzL2RldmljZXMv
cGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNlKCk8YnI+CiZndDsg
L3N5cy9kZXZpY2VzL3ZpcnR1YWwvbmV0L3BwcDA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogVW5y
ZWdpc3RlclByb2ZpbGUoKSByZXBsaWVkIGFuIGVycm9yOjxicj4KJmd0OyBvcmcuZnJlZWRlc2t0
b3AuREJ1cy5FcnJvci5TcGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhlbHBlciBleGl0ZWQgd2l0
aDxicj4KJmd0OyB1bmtub3duIHJldHVybiBjb2RlIDE8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZn
dDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8
YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+
CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgdXNiPGJyPgom
Z3Q7IFsxMmQxOjFmMDFdPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdp
bnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIHVzYjxicj4KJmd0OyBbKG51bGwpOihudWxs
KV08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpy
ZW1vdmVfZGV2aWNlKCk8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3RhbmdveC1laGNp
LWhjZC0xL3VzYjIvMi0xLzItMToxLjA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy91ZGV2bmcuYzpyZW1vdmVfZGV2aWNlKCk8YnI+CiZndDsgL3N5cy9kZXZpY2Vz
L3BsYXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfbW9kZW1fbGlzdCgpPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNi
X2RldmljZSgpIHVzYjxicj4KJmd0OyBbMTJkMToxMDAxXTxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX3VzYl9kZXZpY2UoKSBvcHRpb248
YnI+CiZndDsgWyhudWxsKToobnVsbCldPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3BsdWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KJmd0OyBb
KG51bGwpOihudWxsKV08YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uPGJyPgomZ3Q7IFsobnVsbCk6KG51
bGwpXTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYuYzp1
ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBhZGQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgpIHN1YnN5c3RlbSB0dHk8YnI+CiZn
dDsgZmluaXNoZWQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91
ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uPGJyPgomZ3Q7IFsxMmQxOjEwMDFdPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2Rl
dmljZSgpPGJyPgomZ3Q7IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhjaS1oY2QtMS91
c2IyLzItMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZu
Zy5jOmFkZF9kZXZpY2UoKTxicj4KJmd0Ozxicj4KJmd0OyAvc3lzL2RldmljZXMvcGxhdGZvcm0v
dGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEvMi0xOjEuMS90dHlVU0IxL3R0eS90dHlVU0IxPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6YWRkX2Rl
dmljZSgpIC9kZXYvdHR5VVNCMTxicj4KJmd0OyAoaHVhd2VpKSAyNTUvMjU1LzI1NSBbMDFdID09
Jmd0OyAobnVsbCkgKG51bGwpPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6Y2hlY2tfdXNiX2RldmljZSgpIG9wdGlvbjxicj4KJmd0OyBbMTJkMTox
MDAxXTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5j
OmFkZF9kZXZpY2UoKTxicj4KJmd0OyAvc3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2kt
aGNkLTEvdXNiMi8yLTE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lu
cy91ZGV2bmcuYzphZGRfZGV2aWNlKCk8YnI+CiZndDs8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3Bs
YXRmb3JtL3RhbmdveC1laGNpLWhjZC0xL3VzYjIvMi0xLzItMToxLjAvdHR5VVNCMC90dHkvdHR5
VVNCMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5j
OmFkZF9kZXZpY2UoKSAvZGV2L3R0eVVTQjA8YnI+CiZndDsgKGh1YXdlaSkgMjU1LzI1NS8yNTUg
WzAwXSA9PSZndDsgKG51bGwpIChudWxsKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9wbHVnaW5zL3VkZXYuYzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eSBhZGQ8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2LmM6dWRldl9ldmVudCgp
IHN1YnN5c3RlbSB0dHk8YnI+CiZndDsgZmluaXNoZWQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpjaGVja191c2JfZGV2aWNlKCkgb3B0aW9uPGJy
PgomZ3Q7IFsxMmQxOjEwMDFdPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpPGJyPgomZ3Q7IC9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS90YW5nb3gtZWhjaS1oY2QtMS91c2IyLzItMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmFkZF9kZXZpY2UoKTxicj4KJmd0Ozxicj4KJmd0OyAv
c3lzL2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTEvMi0xOjEuMi90
dHlVU0IyL3R0eS90dHlVU0IyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Bs
dWdpbnMvdWRldm5nLmM6YWRkX2RldmljZSgpIC9kZXYvdHR5VVNCMjxicj4KJmd0OyAoaHVhd2Vp
KSAyNTUvMjU1LzI1NSBbMDJdID09Jmd0OyAobnVsbCkgKG51bGwpPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldi5jOnVkZXZfZXZlbnQoKSBzdWJzeXN0ZW0g
dHR5IGFkZDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXYu
Yzp1ZGV2X2V2ZW50KCkgc3Vic3lzdGVtIHR0eTxicj4KJmd0OyBmaW5pc2hlZDxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOmNoZWNrX21vZGVtX2xp
c3QoKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5j
OmNyZWF0ZV9tb2RlbSgpPGJyPgomZ3Q7IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS90YW5nb3gtZWhj
aS1oY2QtMS91c2IyLzItMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVn
aW5zL3VkZXZuZy5jOmNyZWF0ZV9tb2RlbSgpIGRyaXZlcj1odWF3ZWk8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRlKCkgbmFt
ZTogKG51bGwpLDxicj4KJmd0OyB0eXBlOiBodWF3ZWk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKTxicj4KJmd0OyAvc3lz
L2RldmljZXMvcGxhdGZvcm0vdGFuZ294LWVoY2ktaGNkLTEvdXNiMi8yLTE8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSAv
ZGV2L3R0eVVTQjA8YnI+CiZndDsgMjU1LzI1NS8yNTUgMDAgKG51bGwpPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHVhd2VpKCkgL2Rl
di90dHlVU0IxPGJyPgomZ3Q7IDI1NS8yNTUvMjU1IDAxIChudWxsKTxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3VkZXZuZy5jOnNldHVwX2h1YXdlaSgpIC9kZXYv
dHR5VVNCMjxicj4KJmd0OyAyNTUvMjU1LzI1NSAwMiAobnVsbCk8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9odWF3ZWkoKSBtZG09L2Rl
di90dHlVU0IwPGJyPgomZ3Q7IHBjdWk9L2Rldi90dHlVU0IyIGRpYWc9KG51bGwpIHFtaT0obnVs
bCkgbmV0PShudWxsKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmRkMjgwIHByb3Bl
cnR5IERldmljZTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0u
YzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmRkMjgwIHByb3BlcnR5
IE1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOnNl
dF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtPGJyPgomZ3Q7IDB4NTU2ZGQyODAgcHJvcGVydHkgUGN1
aTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzpzZXRfbW9k
ZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmRkMjgwIHByb3BlcnR5IERpYWc8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6c2V0X21vZGVtX3By
b3BlcnR5KCkgbW9kZW08YnI+CiZndDsgMHg1NTZkZDI4MCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJm
YWNlPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOm9mb25v
X21vZGVtX3JlZ2lzdGVyKCkgMHg1NTZkZDI4MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wcm9iZSgpIDB4NTU2ZGQyODA8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6ZW1pdF9tb2RlbV9hZGRl
ZCgpIDB4NTU2ZGQyODA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21v
ZGVtLmM6Y2FsbF9tb2RlbXdhdGNoZXMoKSAweDU1NmRkMjgwPGJyPgomZ3Q7IGFkZGVkOjE8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9oZnBfYWdfYmx1ZXo1LmM6
bW9kZW1fd2F0Y2goKSBtb2RlbTo8YnI+CiZndDsgMHg1NTZkZDI4MCwgYWRkZWQ6IDE8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9kdW5fZ3dfYmx1ZXo1LmM6bW9k
ZW1fd2F0Y2goKSBtb2RlbTo8YnI+CiZndDsgMHg1NTZkZDI4MCwgYWRkZWQ6IDE8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzptb2Rl
bV93YXRjaCgpIG1vZGVtOjxicj4KJmd0OyAweDU1NmRkMjgwLCBhZGRlZDogMTxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6bW9k
ZW1fd2F0Y2goKSBtb2RlbTo8YnI+CiZndDsgMHg1NTZkZDI4MCwgYWRkZWQ6IDE8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpodWF3ZWlfZW5hYmxl
KCkgMHg1NTZkZDI4MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9k
ZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbTxicj4KJmd0OyAweDU1NmRkMjgwIHByb3Bl
cnR5IE1vZGVtPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVh
d2VpLmM6b3Blbl9kZXZpY2UoKSBNb2RlbTxicj4KJmd0OyAvZGV2L3R0eVVTQjA8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5
KCkgbW9kZW08YnI+CiZndDsgMHg1NTZkZDI4MCBwcm9wZXJ0eSBQY3VpPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6b3Blbl9kZXZpY2UoKSBQY3Vp
IC9kZXYvdHR5VVNCMjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFURTAgK0NN
RUU9MVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUSVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbk1hbnVmYWN0dXJlcjogaHVhd2VpXHJcbk1vZGVsOiBFMzAzXHJc
blJldmlzaW9uOjxicj4KJmd0OyAyMi4zMTguMDUuMDAuMDBcclxuSU1FSTogODYyNTY2MDIwMDA1
Njk3XHJcbitHQ0FQOjxicj4KJmd0OyArQ0dTTSwrRFMsK0VTXHJcblxyXG5PS1xyXG48YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5SRlNXSVRDSD0/XHI8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuRVJST1JcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZndDsgQVQrQ0ZVTj0xXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdp
bnMvaHVhd2VpLmM6Y2Z1bl9lbmFibGUoKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUXlNZU0lORk9ccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5e
U1lTSU5GTzoyLDMsMCw1LDEsMCw0XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpzeXNpbmZvX2VuYWJsZV9jYigpIDI1NSAt
Jmd0OyAxPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQmYW1wO0MwXHI8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NDUz0mcXVvdDtHU00mcXVvdDtccjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVF5VMkRJQUc/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuXlUyRElBRzogMTE5XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVF5HRVRQT1JUTU9ERVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbl5HRVRQT1JUTU9ERTogVFlQRTogV0NETUE6IGh1YXdlaSxcclxuXHJcbk9L
XHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlVTU0RNT0RFPT9ccjxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eVVNTRE1PREU6ICgwLTEpXHJc
blxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5ESUFMTU9E
RT0/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXkRJQUxNT0RFOiAo
MC0yKSwoMC0yNTUpXHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVF5DVk9JQ0U9P1xyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJc
bl5DVk9JQ0U6ICgwKVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVQrQ0ZVTj01XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
T0tcclxuXHJcbl5TUlZTVDogMFxyXG5cclxuXk1PREU6IDAsMFxyXG48YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWkuYzpjZnVuX29mZmxpbmUoKTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vf
c3RhdGUoKSBvbGQgc3RhdGU6IDAsPGJyPgomZ3Q7IG5ldyBzdGF0ZTogMTxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2h1YXdlaS5jOmh1YXdlaV9wcmVfc2ltKCkg
MHg1NTZkZDI4MDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlVTU0RNT0RF
P1xyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW0uYzpvZm9ub19z
aW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg1NTZlNzYyODxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZTc2
Mjg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3Np
bV9hZGRfc3RhdGVfd2F0Y2goKSAweDU1NmU3NjI4PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbl5VU1NETU9ERTogMVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFBDVUk6ICZndDsgQVReRElBTE1PREU/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuXkRJQUxNT0RFOjMsMlxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVReQ1ZPSUNFP1xyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbl5DVk9JQ0U6IDEsIDgwMDAsIDE2LCAyMFxyXG5cclxuT0tcclxuPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFZvaWNlIGNoYW5uZWw6IDgwMDAgSHosIDE2IGJpdHMsIDIw
bXMgcGVyaW9kPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrR0NBUFxyPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitHQ0FQOiArQ0dTTSwrRFMsK0VT
XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNN
PTE5MiwxMjI1OCwwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBc
clxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUM4MjAyNDEyMTgzMDIy
RkUyQTUwMzgwMDE3MThBMDEwNThCMDMyRjA2MDM4MDAyMDAwQTg4MDExMCZxdW90O1xyXG5cclxu
T0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2Rl
bS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKTxicj4KJmd0OyBjcnNtX2luZm9fY2I6IDkwLCAwMCwg
MzA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5ERFNFVEVYPT9ccjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5eRERTRVRFWDogKDIpXHJcblxyXG5P
S1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR01JXHI8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuaHVhd2VpXHJcblxyXG5PS1xyXG48YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3NiwxMjI1OCwwLDAsMTBc
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDsg
MTQ0LDAsJnF1b3Q7OTg1MzAzMDUwMTA3MDg1MzA1RjYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
Y3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDEwPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Js
b2NrX2NiKCkgYnVmb2ZmOiAwLDxicj4KJmd0OyBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEwPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dNTVxyPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbkUzMDNcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDIxLDAsMCwyNTVccjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDs8YnI+CiZndDsgMTQ0
LDAsJnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGMDVBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNDgw
MDIwMDBBODgwMTEwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgom
Z3Q7IGNyc21faW5mb19jYjogOTAsIDAwLCAzMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmZ3Q7IEFUK0NHTVJccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4y
Mi4zMTguMDUuMDAuMDBcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmZ3Q7IEFUK0NSU009MTc2LDI4NDIxLDAsMCwxMFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0OyAxNDQsMCwmcXVvdDs2NTZFRkZGRkZGRkZG
RkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBj
cnNtX3JlYWRfY2I6IDkwLCAwMCwgMTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJyPgom
Z3Q7IGRhdGFvZmY6IDAsIHRvY29weTogMTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVCtDR1NOXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuODYy
NTY2MDIwMDA1Njk3XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmd0OyBBVCtDUlNNPTE5MiwxMjAzNywwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUM4
MjAyNDEyMTgzMDIyRjA1QTUwMzgwMDE3MThBMDEwNThCMDMyRjA2MDQ4MDAyMDAwQTg4MDEyOCZx
dW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2Ry
aXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKTxicj4KJmd0OyBjcnNtX2luZm9f
Y2I6IDkwLCAwMCwgMzA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNN
PTE3NiwxMjAzNywwLDAsMTBccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG4rQ1JTTTo8YnI+CiZndDsgMTQ0LDAsJnF1b3Q7NjU2RUZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5
MCwgMDAsIDEwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9zaW1mcy5j
OnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLDxicj4KJmd0OyBkYXRhb2ZmOiAw
LCB0b2NvcHk6IDEwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1BJTj9c
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BJTjogUkVBRFlcclxu
XHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3Bpbl9jYigpIGNyc21fcGluX2NiOjxicj4KJmd0OyBSRUFEWTxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRf
cGluX3JldHJpZXNfcXVlcnkoKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
XkNQSU4/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXkNQSU46IFJF
QURZLCwxMCwzLDEwLDNcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zv
bm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4K
Jmd0OyBjb3VudGVyIGlkPTksIHZhbD0xMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4KJmd0
OyBjb3VudGVyIGlkPTEsIHZhbD0zPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzpodWF3ZWlfY3Bpbl9jYigpIHJldHJ5PGJyPgomZ3Q7IGNv
dW50ZXIgaWQ9MTEsIHZhbD0xMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9k
cml2ZXJzL2F0bW9kZW0vc2ltLmM6aHVhd2VpX2NwaW5fY2IoKSByZXRyeTxicj4KJmd0OyBjb3Vu
dGVyIGlkPTQsIHZhbD0zPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JT
TT0xOTIsMjg1OTAsMCwwLDI1NVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg1ODksMCwwLDI1NVxyPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0Ozxicj4KJmd0
OyAxNDQsMCwmcXVvdDs2MjFDODIwMjQxMjE4MzAyNkZBREE1MDM4MDAxNzE4QTAxMDU4QjAzNkYw
NjA2ODAwMjAwMDQ4ODAxMTgmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8
YnI+CiZndDsgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzYsMjg1ODksMCwwLDRccjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDImcXVvdDtcclxu
XHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0
bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwg
MDAsIDQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbWZzLmM6c2lt
X2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJyPgomZ3Q7IGRhdGFvZmY6IDAsIHRv
Y29weTogNDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4
NDM4LDAsMCwyNTVccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTogMTA2LDEzMCwmcXVvdDsmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTkyLDI4NDcyLDAsMCwyNTVccjxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDs8YnI+CiZndDsgMTQ0LDAs
JnF1b3Q7NjIxQzgyMDI0MTIxODMwMjZGMzhBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwMjgwMDIw
MDBBODgwMTIwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgomZ3Q7
IGNyc21faW5mb19jYjogOTAsIDAwLCAzMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTc2LDI4NDcyLDAsMCwxMFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0OyAxNDQsMCwmcXVvdDs3RUVFMTExQzI3RjY1OTAw
MDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsPGJyPgomZ3Q7
IGRhdGFvZmY6IDAsIHRvY29weTogMTA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0
OyBBVCtDUlNNPTE5MiwyODUwMiwwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENV
STogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUM4MjAy
NDEyMTgzMDI2RjU2QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDc4MDAyMDAwMTg4MDEyOCZxdW90
O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKTxicj4KJmd0OyBjcnNtX2luZm9fY2I6
IDkwLCAwMCwgMzA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3
NiwyODUwMiwwLDAsMVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitD
UlNNOiAxNDQsMCwmcXVvdDswMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2Io
KTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiAvb2Zvbm8tMS4xNC9zcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9m
ZjogMCw8YnI+CiZndDsgZGF0YW9mZjogMCwgdG9jb3B5OiAxPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZndDsgQVQrQ0lNSVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbjI3MjA1MDEwMDQxMzU4MFxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jaW1pX2NiKCkgY2ltaV9j
Yjo8YnI+CiZndDsgMjcyMDUwMTAwNDEzNTgwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L3NyYy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMSw8YnI+
CiZndDsgbmV3IHN0YXRlOiAyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3Bs
dWdpbnMvaHVhd2VpLmM6aHVhd2VpX3Bvc3Rfc2ltKCkgMHg1NTZkZDI4MDxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOjxicj4KJmd0OyAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250
ZXh0LmM6YXRfZ3Byc19jb250ZXh0X3Byb2JlKCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW08YnI+CiZndDsg
MHg1NTZkZDI4MCBwcm9wZXJ0eSBBbHdheXNPbmxpbmU8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
UENVSTogJmd0OyBBVCtDUkM9MVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NMSVA9MVxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NPTFA9MVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IC9vZm9uby0xLjE0L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtPGJy
PgomZ3Q7IDB4NTU2ZGQyODAgcHJvcGVydHkgQWx3YXlzT25saW5lPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6aHVhd2VpX3NldF9vbmxpbmUoKSBt
b2RlbTxicj4KJmd0OyAweDU1NmRkMjgwIG9ubGluZTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDQ1dBPTFccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTo8YnI+CiZndDsgL29mb25vLTEuMTQvZHJpdmVycy9odWF3
ZWltb2RlbS92b2ljZWNhbGwuYzpodWF3ZWlfdm9pY2VjYWxsX2luaXRpYWxpemVkKCk8YnI+CiZn
dDsgcmVnaXN0ZXJpbmcgdG8gbm90aWZpY2F0aW9uczxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4NTU2ZTc2
Mjg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9ibHVlejUuYzpi
dF9yZWdpc3Rlcl9wcm9maWxlKCk8YnI+CiZndDsgQmx1ZXRvb3RoOiBSZWdpc3RlcmluZyAwMDAw
MTExZi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIgKGhmcF9hZyk8YnI+CiZndDsgcHJvZmls
ZTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXkNWT0lDRT0/XHI8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXkNWT0lDRTogKDApXHJcblxyXG5PS1xy
XG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU0NTPT9ccjxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NDUzogKCZxdW90O0lSQSZxdW90Oywm
cXVvdDtVQ1MyJnF1b3Q7LCZxdW90O0dTTSZxdW90OylcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUXlNZU0NGRz0/XHI8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuXlNZU0NGRzo8YnI+CiZndDs8YnI+CiZndDsgKDIsMTMsMTQs
MTYpLCgwLTMpLCgoMjAwMDAwMDQwMDM4MCwmcXVvdDtHU005MDAvR1NNMTgwMC9XQ0RNQTkwMC9X
Q0RNQTIxMDAmcXVvdDspLCgyODAwMDAsJnF1b3Q7R1NNODUwL0dTTTE5MDAmcXVvdDspLCgzZmZm
ZmZmZiwmcXVvdDtBbGw8YnI+CiZndDsgYmFuZHMmcXVvdDspKSwoMC0yKSwoMC00KVxyXG5cclxu
T0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NNUz0/XHI8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NTTVM6ICgwLDEpXHJcblxyXG5P
S1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVt
L3Ntcy5jOmF0X2NzbXNfcXVlcnlfY2IoKSBDU01TPGJyPgomZ3Q7IHF1ZXJ5IHBhcnNlZCBzdWNj
ZXNzZnVsbHk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDR0RDT05UPT9c
cjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ0dEQ09OVDo8YnI+CiZn
dDsgKDEtMTEpLCZxdW90O0lQJnF1b3Q7LCwsKDAtMiksKDAtMyksKDAsMSksKDAsMSlcclxuK0NH
RENPTlQ6PGJyPgomZ3Q7ICgxLTExKSwmcXVvdDtQUFAmcXVvdDssLCwoMC0yKSwoMC0zKSwoMCwx
KSwoMCwxKVxyXG5cclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTkyLDI4NDgwLDAsMCwyNTVccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQ
Q1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDs8YnI+CiZndDsgMTQ0LDAsJnF1b3Q7NjIxRTgy
MDU0MjIxMDAyMjA2ODMwMjZGNDBBNTAzODAwMTcxOEEwMTA1OEIwMzZGMDYwNTgwMDIwMENDODgw
MCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX2luZm9fY2IoKTxicj4KJmd0OyBjcnNtX2lu
Zm9fY2I6IDkwLCAwMCwgMzI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
RlVOPTFccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBSZWdpc3RlclByb2ZpbGUoKSByZXBsaWVk
IGFuIGVycm9yOjxicj4KJmd0OyBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5TcGF3bi5DaGls
ZEV4aXRlZCwgTGF1bmNoIGhlbHBlciBleGl0ZWQgd2l0aDxicj4KJmd0OyB1bmtub3duIHJldHVy
biBjb2RlIDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXlNJTVNUOjAs
MFxyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9odWF3ZWku
YzpzaW1zdF9ub3RpZnkoKSAxIC0mZ3Q7IDA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuT0tcclxuXHJcbl5TSU1TVDoxLDBcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c2ltc3Rfbm90aWZ5KCkgMCAtJmd0OyAxPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1BCUz0/XHI8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NQQlM6ICgmcXVvdDtTTSZxdW90OywmcXVvdDtF
TiZxdW90OywmcXVvdDtPTiZxdW90OywmcXVvdDtGRCZxdW90OylcclxuXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTTVM9MVxyPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDU01TOiAxLDEsMVxyXG5cclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dSRUc9P1xyPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDR1JFRzogKDAtMilcclxuXHJcbk9LXHJcbjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgwLDEsNCwzNFxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0Ozxi
cj4KJmd0OyAxNDQsMCwmcXVvdDs0RDc5MjA0RTc1NkQ2MjY1NzJGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGMDc5MTUzODMxMzk3Nzg0OEZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9j
cnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVF5TWVNJTkZPXHI8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogUENVSTogJmx0OyBcclxuXlNZU0lORk86MCwzLDAsMCwxLDAsMFxyXG5cclxuT0tcclxu
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3BsdWdpbnMvaHVhd2VpLmM6c3lz
aW5mb19vbmxpbmVfY2IoKSAxIC0mZ3Q7IDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAyLDxicj4K
Jmd0OyBuZXcgc3RhdGU6IDM8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1
Z2lucy9odWF3ZWkuYzpodWF3ZWlfcG9zdF9vbmxpbmUoKSAweDU1NmRkMjgwPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NNUz9ccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNd
OiBQQ1VJOiAmbHQ7IFxyXG4rQ1NNUzogMSwxLDEsMVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dSRUc9MlxyPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NHQVVUTz0wXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
T0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ0dFUkVQPTIsMVxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbkVSUk9SXHJcbjxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9wbHVnaW5zL2JsdWV6NS5jOmJ0X3JlZ2lzdGVy
X3Byb2ZpbGUoKTxicj4KJmd0OyBCbHVldG9vdGg6IFJlZ2lzdGVyaW5nIDAwMDAxMTAzLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYiAoZHVuX2d3KTxicj4KJmd0OyBwcm9maWxlPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsMiw0LDM0XHI8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgom
Z3Q7IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
cmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSRUc9P1xyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAoMC0yKVxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NDQj0/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuK0NTQ0I6KDAsMSlcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2Rb
MzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NVU0Q9MVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBSZWdpc3RlclByb2Zp
bGUoKSByZXBsaWVkIGFuIGVycm9yOjxicj4KJmd0OyBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJv
ci5TcGF3bi5DaGlsZEV4aXRlZCwgTGF1bmNoIGhlbHBlciBleGl0ZWQgd2l0aDxicj4KJmd0OyB1
bmtub3duIHJldHVybiBjb2RlIDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDTUdGPT9ccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ01HRjog
KDAsMSlcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFU
K0NSU009MTc4LDI4NDgwLDMsNCwzNFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZs
dDsgXHJcbitDUlNNOjxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZx
dW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2Ry
aXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRf
Y2I6IDkwLCAwMCwgMzQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUkVH
PTJccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3NpbS5jOm9mb25vX3NpbV9hZGRfc3Bu
X3dhdGNoKCkgMHg1NTZlNzYyODxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9z
cmMvbmV0d29yay5jOl9fb2Zvbm9fbmV0cmVnX2FkZF9zdGF0dXNfd2F0Y2goKTxicj4KJmd0OyAw
eDU1NmU3MGQ4PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1NDQj0wXHI8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuXk1PREU6IDUsNFxyXG48YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYnMuYzpjYnNfZ290X2ltc2koKSBHb3QgSU1TSTo8
YnI+CiZndDsgMjcyMDUwMTAwNDEzNTgwPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3NyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpPGJyPgom
Z3Q7IDB4NTU2ZTcwZDg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUE1T
PT9ccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1BNUzo8YnI+CiZn
dDsgKCZxdW90O1NNJnF1b3Q7LCZxdW90O01FJnF1b3Q7KSwoJnF1b3Q7U00mcXVvdDssJnF1b3Q7
TUUmcXVvdDspLCgmcXVvdDtTTSZxdW90OywmcXVvdDtNRSZxdW90OylcclxuXHJcbk9LXHJcbjxi
cj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgwLDQsNCwz
NFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0
Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUkVHP1xyPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDUkVHOiAyLDJcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdGF0
dXNfbm90aWZ5KCk8YnI+CiZndDsgL2h1YXdlaV8xIHN0YXR1cyAyIHRlY2ggLTE8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpjdXJyZW50X29wZXJhdG9y
X2NhbGxiYWNrKCk8YnI+CiZndDsgMHg1NTZlNzBkOCwgKG5pbCk8YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvc3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMiwgLTEs
IC0xLCAtMSw8YnI+CiZndDsgKG51bGwpKG51bGwpPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9v
Zm9uby0xLjE0L3NyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NNR0Y9MFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NSU009MTc4LDI4NDgwLDUsNCwzNFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBD
VUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNt
X3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDUE1TPSZxdW90O01FJnF1b3Q7LCZxdW90O01FJnF1b3Q7LCZxdW90O01FJnF1b3Q7XHI8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NQTVM6IDAsMjAsMCwyMCwwLDIw
XHJcblxyXG5PS1xyXG5cclxuXlJTU0k6PGJyPgomZ3Q7IDEzXHJcblxyXG5eSENTUTomcXVvdDtX
Q0RNQSZxdW90Oyw0MCwzNCw1M1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0
OyBBVCtDUlNNPTE3OCwyODQ4MCw2LDQsMzRccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJ
OiAmbHQ7IFxyXG4rQ1JTTTo8YnI+CiZndDs8YnI+CiZndDsgMTQ0LDAsJnF1b3Q7RkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkYmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDM0PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q05NST0/XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NOTUk6PGJy
PgomZ3Q7ICgwLTIpLCgwLTMpLCgwLDIpLCgwLTIpLCgwLDEpXHJcblxyXG5PS1xyXG48YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmJ1aWxk
X2NubWlfc3RyaW5nKCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDTk1J
PTEsMSwyLDEsMFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IER1cGxpY2F0ZSBFRnNkbiBlbnRy
aWVzIGZvciBgRW1lcmdlbmN5IFNlcnZpY2VzJiMzOTs8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
UENVSTogJmx0OyBcclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0
L3NyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpPGJyPgomZ3Q7
IDB4NTU2ZTcwZDg8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL3Ntcy5j
OnNtc19yZXN0b3JlX3R4X3F1ZXVlKCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlvbi5jOnNtc193YXRjaCgpPGJyPgomZ3Q7IHJlZ2lz
dGVyZWQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvcGx1Z2lucy9zbWFydC1t
ZXNzYWdpbmcuYzpzbXNfd2F0Y2goKSByZWdpc3RlcmVkPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTgsMCwwLDI1NVxyPGJyPgomZ3Q7IG9mb25vZFsz
MDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVv
dDs2MjFFODIwNTQyMjEwMDA2MDU4MzAyNkZDQUE1MDM4MDAxNzE4QTAxMDU4QjAzNkYwNjA1ODAw
MjAwMUU4ODAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29m
b25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpPGJyPgomZ3Q7
IGNyc21faW5mb19jYjogOTAsIDAwLCAzMjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NNR0w9NFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbk9L
XHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0v
c21zLmM6YXRfY21nbF9kb25lKCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDR1NNUz0zXHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuT0tcclxu
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMSw0
LDZccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAs
JnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMw
OTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
PGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsMiw0LDZccjxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7
XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVy
cy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjog
OTAsIDAwLCA2PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgs
Mjg2MTgsMyw0LDZccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JT
TTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
cmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTgsNCw0LDZccjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAw
MDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21f
cmVhZF9jYjogOTAsIDAwLCA2PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQr
Q1JTTT0xNzgsMjg2MTgsNSw0LDZccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7
IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDAwMDAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA2PGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTcsMCwwLDI1NVxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0Ozxi
cj4KJmd0OyAxNDQsMCwmcXVvdDs2MjFFODIwNTQyMjEwMDA1MDU4MzAyNkZDOUE1MDM4MDAxNzE4
QTAxMDU4QjAzNkYwNjAyODAwMjAwMTk4ODAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
aW5mb19jYigpPGJyPgomZ3Q7IGNyc21faW5mb19jYjogOTAsIDAwLCAzMjxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE3LDEsNCw1XHI8YnI+CiZndDsg
b2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAwMDAw
MDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9y
ZWFkX2NiOiA5MCwgMDAsIDU8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtD
UlNNPTE3OCwyODYxNywyLDQsNVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitDUlNNOiAxNDQsMCwmcXVvdDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA1PGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTcsMyw0LDVccjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7MDEw
MDAwMDAwMCZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBj
cnNtX3JlYWRfY2I6IDkwLCAwMCwgNTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7
IEFUK0NSU009MTc4LDI4NjE3LDQsNCw1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NSU006IDE0NCwwLCZxdW90OzAxMDAwMDAwMDAmcXVvdDtcclxuXHJcbk9LXHJc
bjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDU8YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNyw1LDQsNVxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxNDQsMCwmcXVv
dDswMTAwMDAwMDAwJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgom
Z3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCA1PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVQrQ1JTTT0xOTIsMjg0MzMsMCwwLDI1NVxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106
IFBDVUk6ICZsdDsgXHJcbitDUlNNOiAxMDYsMTMwLCZxdW90OyZxdW90O1xyXG5cclxuT0tcclxu
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9tZXNzYWdlLXdhaXRpbmcu
Yzptd19jcGhzX213aXNfcmVhZF9jYigpIE5vPGJyPgomZ3Q7IENQSFMgTVdJUyBvbiBTSU08YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODYxOSwwLDAsMjU1
XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7
PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIyMTAwMTAwNTgzMDI2RkNCQTUwMzgwMDE3
MThBMDEwNThCMDM2RjA2MDU4MDAyMDA1MDg4MDAmcXVvdDtcclxuXHJcbk9LXHJcbjxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Jz
bV9pbmZvX2NiKCk8YnI+CiZndDsgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDMyPGJyPgomZ3Q7IG9m
b25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTksMSw0LDE2XHI8YnI+CiZn
dDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7IDE0NCwwLCZx
dW90O0ZGMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNjxicj4K
Jmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE5LDIsNCwxNlxy
PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0OyAx
NDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxu
T0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2Rl
bS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MTY8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxOSwz
LDQsMTZccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+
CiZndDsgMTQ0LDAsJnF1b3Q7RkYwMEZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtc
clxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJz
L2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5
MCwgMDAsIDE2PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgs
Mjg2MTksNCw0LDE2XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NS
U006PGJyPgomZ3Q7IDE0NCwwLCZxdW90O0ZGMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVh
ZF9jYjogOTAsIDAwLCAxNjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NS
U009MTc4LDI4NjE5LDUsNCwxNlxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbitDUlNNOjxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRjAwRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9u
by0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBj
cnNtX3JlYWRfY2I6IDkwLCAwMCwgMTY8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEu
MTQvc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2soKSBidWZvZmY6IDAsPGJyPgomZ3Q7
IHNlZWtvZmY6IDM5LCB0b3JlYWQ6IDE3PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0x
LjE0L3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLDxicj4KJmd0
OyBzZWVrb2ZmOiAzOSwgdG9yZWFkOiAxMDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8t
MS4xNC9kcml2ZXJzL2F0bW9kZW0vY2JzLmM6YXRfY2JzX3NldF90b3BpY3MoKTxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NTQ0I9MFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0
M106IFBDVUk6ICZsdDsgXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAm
Z3Q7IEFUK0NTQ0I9MCwmcXVvdDswLDUwLDIxNCw0MzUyLTQzNTYmcXVvdDtccjxicj4KJmd0OyBv
Zm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQz
XTogUENVSTogJmd0OyBBVCtDUlNNPTE5MiwyODQzNywwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogUENVSTogJmx0OyBcclxuXlNSVlNUOiAyXHJcblxyXG4rQ0dSRUc6PGJyPgomZ3Q7
IDEsJnF1b3Q7MDA0MCZxdW90OywmcXVvdDswMkMxMDE3OCZxdW90O1xyXG5cclxuK0NSU006IDEw
NiwxMzAsJnF1b3Q7JnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTog
L29mb25vLTEuMTQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvaHVhd2Vp
XzE8YnI+CiZndDsgc3RhdHVzIDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBB
VCtDUlNNPTE5MiwyODYxNSwwLDAsMjU1XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTog
Jmx0OyBcclxuK0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzYyMUU4MjA1NDIy
MTAwMjIwNTgzMDI2RkM3QTUwMzgwMDE3MThBMDEwNThCMDM2RjA2MDI4MDAyMDBBQTg4MDAmcXVv
dDtcclxuXHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCk8YnI+CiZndDsgY3JzbV9pbmZvX2Ni
OiA5MCwgMDAsIDMyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0x
NzgsMjg2MTUsMSw0LDM0XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxu
K0NSU006PGJyPgomZ3Q7PGJyPgomZ3Q7IDE0NCwwLCZxdW90OzRENjE2OTZDRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkYwNzkxNTM4MzMzMzMxMzE3RkZGRkZGRkZGRkZGJnF1b3Q7XHJc
blxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAs
IDAwLCAzNDxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4
NjE1LDIsNCwzNFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNN
Ojxicj4KJmd0Ozxicj4KJmd0OyAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxu
T0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2Rl
bS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwg
MzQ8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDUlNNPTE3OCwyODYxNSwz
LDQsMzRccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1JTTTo8YnI+
CiZndDs8YnI+CiZndDsgMTQ0LDAsJnF1b3Q7RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkYmcXVvdDtcclxuXHJcbk9LXHJc
bjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4xNC9kcml2ZXJzL2F0bW9kZW0vc2lt
LmM6YXRfY3JzbV9yZWFkX2NiKCk8YnI+CiZndDsgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZndDsgQVQrQ1JTTT0xNzgsMjg2MTUsNCw0LDM0
XHI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSU006PGJyPgomZ3Q7
PGJyPgomZ3Q7IDE0NCwwLCZxdW90O0ZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+
CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21fcmVhZF9jYigpPGJyPgomZ3Q7IGNyc21fcmVhZF9jYjogOTAsIDAwLCAzNDxicj4KJmd0
OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NSU009MTc4LDI4NjE1LDUsNCwzNFxyPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDUlNNOjxicj4KJmd0Ozxicj4K
Jmd0OyAxNDQsMCwmcXVvdDtGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRiZxdW90O1xyXG5cclxuT0tcclxuPGJyPgomZ3Q7
IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNt
X3JlYWRfY2IoKTxicj4KJmd0OyBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMzQ8YnI+CiZndDsgb2Zv
bm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NSRUc6IDEsJnF1b3Q7MDA0MCZxdW90OywmcXVv
dDswMkMxMDE3OCZxdW90O1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgpPGJyPgomZ3Q7IC9odWF3
ZWlfMSBzdGF0dXMgMSB0ZWNoIDI8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQv
c3JjL2Nicy5jOmNic19sb2NhdGlvbl9jaGFuZ2VkKCkgMSwgLTEsIC0xLCAyLDxicj4KJmd0OyAo
bnVsbCkobnVsbCk8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMu
YzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAxPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6
ICZndDsgQVQrQ09QUz0zLDJccjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxy
XG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDT1BTP1xyPGJy
PgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsgXHJcbitDT1BTOiAwLDIsJnF1b3Q7Mjcy
MDUmcXVvdDssMlxyXG5cclxuT0tcclxuPGJyPgomZ3Q7IG9mb25vZFszMDk0M106PGJyPgomZ3Q7
IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOmNvcHNf
bnVtZXJpY19jYigpIENvcHM8YnI+CiZndDsgbnVtZXJpYyBnb3QgbWNjOiAyNzIsIG1uYzogMDU8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmd0OyBBVCtDU1Fccjxicj4KJmd0OyBvZm9u
b2RbMzA5NDNdOiBQQ1VJOiAmbHQ7IFxyXG4rQ1NROiAxMyw5OVxyXG5cclxuT0tcclxuPGJyPgom
Z3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJl
Z2lzdHJhdGlvbi5jOmNzcV9jYigpPGJyPgomZ3Q7IGNzcV9jYjogMTM8YnI+CiZndDsgb2Zvbm9k
WzMwOTQzXTogL29mb25vLTEuMTQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RyZW5ndGhf
bm90aWZ5KCk8YnI+CiZndDsgc3RyZW5ndGggNDE8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENV
STogJmd0OyBBVCtDT1BTPTMsMFxyPGJyPgomZ3Q7IG9mb25vZFszMDk0M106IFBDVUk6ICZsdDsg
XHJcbk9LXHJcbjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiBQQ1VJOiAmZ3Q7IEFUK0NPUFM/XHI8
YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogUENVSTogJmx0OyBcclxuK0NPUFM6IDAsMCwmcXVvdDsz
IElSTCZxdW90OywyXHJcblxyXG5PS1xyXG48YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19jYigpPGJy
PgomZ3Q7IGNvcHNfY2I6IDMgSVJMLCAyNzIgMDUgMjxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAv
b2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2soKTxicj4K
Jmd0OyAweDU1NmU3MGQ4LCAobmlsKTxicj4KJmd0OyBvZm9ub2RbMzA5NDNdOiAvb2Zvbm8tMS4x
NC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAxLCAtMSwgLTEsIDIsPGJyPgomZ3Q7
IDI3MjA1PGJyPgomZ3Q7IG9mb25vZFszMDk0M106IC9vZm9uby0xLjE0L3NyYy9jYnMuYzpjYnNf
bG9jYXRpb25fY2hhbmdlZCgpIDEsIDAsIDA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25v
LTEuMTQvc3JjL2dwcnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAxPGJyPgomZ3Q7IG9mb25v
ZFszMDk0M106PGJyPgomZ3Q7IC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRl
eHQuYzphdF9ncHJzX2FjdGl2YXRlX3ByaW1hcnkoKSBjaWQgMTxicj4KJmd0OyBvZm9ub2RbMzA5
NDNdOiAvb2Zvbm8tMS4xNC9zcmMvZ3Bycy5jOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIDB4NTU2
ZWIwNzA8YnI+CiZndDsgb2Zvbm9kWzMwOTQzXTogL29mb25vLTEuMTQvc3JjL2dwcnMuYzpwcmlf
YWN0aXZhdGVfY2FsbGJhY2soKSBBY3RpdmF0aW5nPGJyPgomZ3Q7IGNvbnRleHQgZmFpbGVkIHdp
dGggZXJyb3I6IFVua25vd24gZXJyb3IgdHlwZTxicj4KJmd0OyAtLS0tLS0tLS0tLS0tLSBuZXh0
IHBhcnQgLS0tLS0tLS0tLS0tLS08YnI+CiZndDsgQW4gSFRNTCBhdHRhY2htZW50IHdhcyBzY3J1
YmJlZC4uLjxicj4KJmd0OyBVUkw6ICZsdDs8YnI+CiZndDsgPGEgaHJlZj0iaHR0cDovL2xpc3Rz
Lm9mb25vLm9yZy9waXBlcm1haWwvb2Zvbm8vYXR0YWNobWVudHMvMjAxNDAzMTAvMjE5NWE4YjAv
YXR0YWNobWVudC5odG1sIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9w
aXBlcm1haWwvb2Zvbm8vYXR0YWNobWVudHMvMjAxNDAzMTAvMjE5NWE4YjAvYXR0YWNobWVudC5o
dG1sPC9hPjxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLTxicj4KJmd0Ozxicj4KJmd0OyBTdWJqZWN0OiBEaWdlc3QgRm9vdGVyPGJy
PgomZ3Q7PGJyPgomZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fPGJyPgomZ3Q7IG9mb25vIG1haWxpbmcgbGlzdDxicj4KJmd0OyA8YSBocmVmPSJtYWls
dG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgomZ3Q7IDxhIGhyZWY9
Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9h
Pjxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS08YnI+CiZndDs8YnI+CiZndDsgRW5kIG9mIG9mb25vIERpZ2VzdCwgVm9sIDU5LCBJc3N1ZSA3
PGJyPgomZ3Q7ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKjxicj4KJmd0Ozxi
cj4KPGJyPgo8YnI+Cjxicj4KLS08YnI+CkhvbWFtIERhYmlzIHwgU29mdHdhcmUgQ29uc3VsdGFu
dDxicj4KbTogKzM1MyA4NiA4ODEgNDAxODxicj4Kc2t5cGU6IGhkYWJpczE8YnI+Ci0tLS0tLS0t
LS0tLS0tIG5leHQgcGFydCAtLS0tLS0tLS0tLS0tLTxicj4KQW4gSFRNTCBhdHRhY2htZW50IHdh
cyBzY3J1YmJlZC4uLjxicj4KVVJMOiAmbHQ7PGEgaHJlZj0iaHR0cDovL2xpc3RzLm9mb25vLm9y
Zy9waXBlcm1haWwvb2Zvbm8vYXR0YWNobWVudHMvMjAxNDAzMTIvMDMzNzYzNTkvYXR0YWNobWVu
dC5odG1sIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9waXBlcm1haWwv
b2Zvbm8vYXR0YWNobWVudHMvMjAxNDAzMTIvMDMzNzYzNTkvYXR0YWNobWVudC5odG1sPC9hPiZn
dDs8YnI+Ci0tLS0tLS0tLS0tLS0tIG5leHQgcGFydCAtLS0tLS0tLS0tLS0tLTxicj4KQSBub24t
dGV4dCBhdHRhY2htZW50IHdhcyBzY3J1YmJlZC4uLjxicj4KTmFtZTogQkFDN0U3NkMtOEI2Qy00
NjNCLThCOEUtODcwM0JBNjc4N0FDWzZdLnBuZzxicj4KVHlwZTogaW1hZ2UvcG5nPGJyPgpTaXpl
OiA4NDA2IGJ5dGVzPGJyPgpEZXNjOiBub3QgYXZhaWxhYmxlPGJyPgpVUkw6ICZsdDs8YSBocmVm
PSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL3BpcGVybWFpbC9vZm9uby9hdHRhY2htZW50cy8yMDE0
MDMxMi8wMzM3NjM1OS9hdHRhY2htZW50LnBuZyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0
cy5vZm9uby5vcmcvcGlwZXJtYWlsL29mb25vL2F0dGFjaG1lbnRzLzIwMTQwMzEyLzAzMzc2MzU5
L2F0dGFjaG1lbnQucG5nPC9hPiZndDs8YnI+Cjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPGJyPgo8YnI+ClN1YmplY3Q6IERpZ2VzdCBGb290ZXI8YnI+Cjxicj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcg
bGlzdDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3Jn
PC9hPjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5m
by9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4v
bGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8YnI+Cjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPGJyPgo8YnI+CkVuZCBvZiBvZm9ubyBEaWdlc3QsIFZvbCA1OSwgSXNzdWUgMTI8YnI+
CioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKio8YnI+CjwvYmxvY2txdW90ZT48
L2Rpdj48YnI+PGRpdj48YnI+PC9kaXY+PGRpdiBkaXI9Imx0ciI+PHNwYW4+PC9zcGFuPjxzcGFu
Pjwvc3Bhbj48YnI+PGRpdj48YnI+PC9kaXY+PC9kaXY+CjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============9101639083990510875==--

