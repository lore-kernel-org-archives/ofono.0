Content-Type: multipart/mixed; boundary="===============1885522831062912604=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH_v9 1/4] huaweicdma: create a dedicated netreg atom.
Date: Thu, 11 Aug 2011 17:04:57 +0200
Message-ID: <4E43EF99.3090708@linux.intel.com>
In-Reply-To: <4E417D0E.9030406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1885522831062912604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I did a test with a Huawei EC152 cdma dongle in India with this patch. =

Please find below the oFono logs.
It appears that the service domain is reported in the ^SYSINFO answer as =

'CDMA not supported' whereas the cdma data connection could be =

established successfully.

ofonod[11013]: Modem: > AT^SYSINFO\r
ofonod[11013]: Modem: < \r\n^SYSINFO:0,255,0,0,0\r\n\r\nOK\r\n
ofonod[11013]: =

drivers/huaweicdmamodem/network-registration.c:sysinfo_cb() 0, 255, 0

The issue is that the switch case in the function 'parse_sysinfo' is =

overiding the status returned by the field srv_status by the status =

returned by the field srv_domain. Therefore, the status returned by the =

function 'parse_sysinfo' is always =

"CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED'.

In practice, I don't think we need to handle the srv_domain field.
Perhaps, do you have some background here you can share?

I need also to raise another issue which is more likely a timing issue.
Until now, the cdma connection could be initiated as soon as the =

cdma.ConnectionManager interface was registered in ofono.org.
For cdma, as only few AT commands are exchanged, this can happen quite =

immediately and is likely to fail since we are not registered to the =

network.
Now that the cdma netreg atom is available, could we think indeed to =

register ConMann to the cdma netreg status change but also to trigger =

the cdma cellular network creation once the status becomes 'registered'?
That said, I don't know if this status is sufficiently representative =

like the 'Attached' state for gprs.

For gprs precisely, can we think to adopt the same mechanism ? I mean, =

add the cellular networks (corresponding to the gprs contexts) only once =

gprs is attached ? This could be helpful in case of automatic =

reconnection after plug-in the 3G dongle (it avoids to perform the =

automatic connection too early).

Regards,

Philippe.


ofonod[11596]: src/modem.c:ofono_modem_create() name: (null), type: =

huaweicdma
ofonod[11596]: src/modem.c:set_modem_property() modem 0x9a88078 property =

Path
ofonod[11596]: src/modem.c:set_modem_property() modem 0x9a88078 property =

Registered
ofonod[11596]: plugins/udev.c:add_modem() =

/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3:1.1/ttyUSB1/tty/ttyUS=
B1 =

(huaweicdma)
ofonod[11596]: plugins/udev.c:add_huawei() modem 0x9a88078
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

ModemRegistered
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

PcuiRegistered
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

Path
ofonod[11596]: plugins/udev.c:add_modem() =

/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3:1.2/ttyUSB2/tty/ttyUS=
B2 =

(huaweicdma)
ofonod[11596]: plugins/udev.c:add_huawei() modem 0x9a88078
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

ModemRegistered
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

PcuiRegistered
ofonod[11596]: src/modem.c:set_modem_property() modem 0x9a88078 property =

Pcui
ofonod[11596]: src/modem.c:set_modem_property() modem 0x9a88078 property =

PcuiRegistered
ofonod[11596]: plugins/udev.c:add_huawei() /dev/ttyUSB2 PCui
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

Path
ofonod[11596]: plugins/udev.c:add_modem() =

/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3:1.0/ttyUSB0/tty/ttyUS=
B0 =

(huaweicdma)
ofonod[11596]: plugins/udev.c:add_huawei() modem 0x9a88078
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

ModemRegistered
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

PcuiRegistered
ofonod[11596]: src/modem.c:set_modem_property() modem 0x9a88078 property =

Modem
ofonod[11596]: src/modem.c:set_modem_property() modem 0x9a88078 property =

ModemRegistered
ofonod[11596]: plugins/udev.c:add_huawei() /dev/ttyUSB0 Modem
ofonod[11596]: plugins/huaweicdma.c:huaweicdma_probe() 0x9a88078
ofonod[11596]: plugins/hfp_ag.c:modem_watch() modem: 0x9a88078, added: 1
ofonod[11596]: plugins/dun_gw.c:modem_watch() modem: 0x9a88078, added: 1
ofonod[11596]: examples/emulator.c:modem_watch() modem: 0x9a88078, added: 1
ofonod[11596]: plugins/smart-messaging.c:modem_watch() modem: 0x9a88078, =

added: 1
ofonod[11596]: plugins/push-notification.c:modem_watch() modem: =

0x9a88078, added: 1
ofonod[11596]: plugins/huaweicdma.c:huaweicdma_enable()
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

Modem
ofonod[11596]: plugins/huaweicdma.c:open_device() Modem /dev/ttyUSB0
ofonod[11596]: src/modem.c:get_modem_property() modem 0x9a88078 property =

Pcui
ofonod[11596]: plugins/huaweicdma.c:open_device() Pcui /dev/ttyUSB2
ofonod[11596]: Modem: > ATE0 &C0 +CMEE=3D1\r
ofonod[11596]: PCUI: > ATE0 &C0 +CMEE=3D1\r
ofonod[11596]: Modem: < \r\nOK\r\n
ofonod[11596]: PCUI: < ATE0 &C0 +CMEE=3D1\r\r\nOK\r\n
ofonod[11596]: PCUI: > AT+CFUN=3D1\r
ofonod[11596]: PCUI: < \r\nOK\r\n
ofonod[11596]: plugins/huaweicdma.c:cfun_enable()
ofonod[11596]: examples/emulator.c:powered_watch() Adding modem =

0x9a88078 to the list
ofonod[11596]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[11596]: plugins/huaweicdma.c:huaweicdma_pre_sim() 0x9a88078
ofonod[11596]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[11596]: plugins/huaweicdma.c:huaweicdma_post_sim() 0x9a88078
ofonod[11596]: Example History Probe for modem: 0x9a88078
ofonod[11596]: Example Network Time Probe for modem: 0x9a88078
ofonod[11596]: src/modem.c:set_online() modem->online change 1
ofonod[11596]: src/modem.c:set_online() ofono_dbus_signal_property_changed
ofonod[11596]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[11596]: plugins/huaweicdma.c:huaweicdma_post_online() 0x9a88078
ofonod[11596]: src/cdma-netreg.c:ofono_cdma_netreg_create()
ofonod[11596]: =

drivers/huaweicdmamodem/network-registration.c:huaweicdma_netreg_probe()
ofonod[11596]: src/cdma-connman.c:ofono_cdma_connman_create()
ofonod[11596]: drivers/cdmamodem/connman.c:cdma_connman_probe()
ofonod[11596]: PCUI: > AT+GCAP\r
ofonod[11596]: Modem: > AT^SYSINFO\r
ofonod[11596]: Modem: < \r\n^SYSINFO:0,255,0,0,0\r\n\r\nOK\r\n
ofonod[11596]: =

drivers/huaweicdmamodem/network-registration.c:sysinfo_cb() 0, 255, 0
ofonod[11596]: src/cdma-netreg.c:ofono_cdma_netreg_status_notify()
ofonod[11596]: PCUI: < \r\n+GCAP: +CIS707-A,CIS-856-A,+MS, +ES, +DS, =

+FCLASS\r\n\r\nOK\r\n
ofonod[11596]: Modem: > AT&C0\r
ofonod[11596]: PCUI: > AT+GMI\r
ofonod[11596]: Modem: < \r\nOK\r\n
ofonod[11596]: drivers/cdmamodem/connman.c:at_c0_cb() ok 1
ofonod[11596]: src/cdma-connman.c:ofono_cdma_connman_register()
ofonod[11596]: PCUI: < \r\n+GMI: HUAWEI TECHNOLOGIES CO., LTD\r\n\r\nOK\r\n
ofonod[11596]: PCUI: > AT+GMM\r
ofonod[11596]: PCUI: < \r\nERROR\r\n
ofonod[11596]: PCUI: > AT+GMR\r
ofonod[11596]: PCUI: < \r\nTCPU_HWEC152DT01\r\n\r\nOK\r\n
ofonod[11596]: PCUI: > AT+GSN\r
ofonod[11596]: PCUI: < \r\n+GSN:80e75f34\r\n\r\nOK\r\n
ofonod[11596]: Modem: < \r\n^SIMST:240\r\n
ofonod[11596]: PCUI: < \r\n^SIMST:240\r\n
ofonod[11596]: Modem: < \r\n^RSSILVL:80\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:80\r\n
ofonod[11596]: Modem: < \r\n^MODE: =

2\r\r\n\r\r\n^RSSILVL:80\r\r\n\r\r\n^HRSSILVL:0\r\n
ofonod[11596]: PCUI: < \r\n^MODE: =

2\r\r\n\r\r\n^RSSILVL:80\r\r\n\r\r\n^HRSSILVL:0\r\n
ofonod[11596]: Modem: > AT^SYSINFO\r
ofonod[11596]: Modem: < \r\n^SYSINFO:2,255,0,2,240\r\n\r\nOK\r\n
ofonod[11596]: =

drivers/huaweicdmamodem/network-registration.c:sysinfo_cb() 2, 255, 0
ofonod[11596]: src/cdma-netreg.c:ofono_cdma_netreg_status_notify()
ofonod[11596]: Modem: < \r\n^RSSILVL:20\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:20\r\n
ofonod[11596]: Modem: < =

\r\n^RSSILVL:80\r\n\r\n^HRSSILVL:20\r\n\r\n^MODE: =

8\r\r\n\r\r\n^RSSILVL:80\r\r\n\r\r\n^HRSSILVL:40\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:80\r\n\r\n^HRSSILVL:20\r\n
ofonod[11596]: Modem: > AT^SYSINFO\r
ofonod[11596]: Modem: < \r\n^HRSSILVL:40\r\n
ofonod[11596]: PCUI: < \r\n^MODE: =

8\r\r\n\r\r\n^RSSILVL:80\r\r\n\r\r\n^HRSSILVL:40\r\n
ofonod[11596]: Modem: < \r\n^SYSINFO:2,255,0,8,240\r\n\r\nOK\r\n
ofonod[11596]: =

drivers/huaweicdmamodem/network-registration.c:sysinfo_cb() 2, 255, 0
ofonod[11596]: src/cdma-netreg.c:ofono_cdma_netreg_status_notify()
ofonod[11596]: PCUI: < \r\n^HRSSILVL:40\r\n
ofonod[11596]: Modem: < \r\n^HRSSILVL:60\r\n
ofonod[11596]: PCUI: < \r\n^HRSSILVL:60\r\n
ofonod[11596]: Modem: < \r\n^RSSILVL:20\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:20\r\n
ofonod[11596]: Modem: < \r\n^RSSILVL:80\r\n\r\n^HRSSILVL:80\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:80\r\n\r\n^HRSSILVL:80\r\n
ofonod[11596]: Modem: < \r\n^MODE: =

4\r\r\n\r\r\n^RSSILVL:0\r\r\n\r\r\n^HRSSILVL:80\r\n
ofonod[11596]: PCUI: < \r\n^MODE: =

4\r\r\n\r\r\n^RSSILVL:0\r\r\n\r\r\n^HRSSILVL:80\r\n
ofonod[11596]: Modem: > AT^SYSINFO\r
ofonod[11596]: Modem: < \r\n^SYSINFO:2,255,0,4,240\r\n\r\nOK\r\n
ofonod[11596]: =

drivers/huaweicdmamodem/network-registration.c:sysinfo_cb() 2, 255, 0
fonod[11596]: src/cdma-netreg.c:ofono_cdma_netreg_status_notify()
ofonod[11596]: Modem: < \r\n^MODE: =

4\r\r\n\r\r\n^RSSILVL:0\r\r\n\r\r\n^HRSSILVL:80\r\n
ofonod[11596]: PCUI: < \r\n^MODE: =

4\r\r\n\r\r\n^RSSILVL:0\r\r\n\r\r\n^HRSSILVL:80\r\n
ofonod[11596]: Modem: > AT^SYSINFO\r
ofonod[11596]: Modem: < \r\n^SYSINFO:2,255,0,4,240\r\n\r\nOK\r\n
ofonod[11596]: =

drivers/huaweicdmamodem/network-registration.c:sysinfo_cb() 2, 255, 0
ofonod[11596]: src/cdma-netreg.c:ofono_cdma_netreg_status_notify()
ofonod[11596]: Modem: < \r\n^RSSILVL:80\r\n\r\n^MODE: =

8\r\r\n\r\r\n^RSSILVL:80\r\r\n\r\r\n^HRSSILVL:80\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:80\r\n\r\n^MODE: =

8\r\r\n\r\r\n^RSSILVL:80\r\r\n\r\r\n^HRSSILVL:80\r\n
ofonod[11596]: Modem: > AT^SYSINFO\r
ofonod[11596]: Modem: < \r\n^SYSINFO:2,255,0,8,240\r\n\r\nOK\r\n
ofonod[11596]: =

drivers/huaweicdmamodem/network-registration.c:sysinfo_cb() 2, 255, 0
ofonod[11596]: src/cdma-netreg.c:ofono_cdma_netreg_status_notify()
ofonod[11596]: Modem: < \r\n^RSSILVL:60\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:60\r\n
ofonod[11596]: src/cdma-connman.c:cdma_connman_set_property()
ofonod[11596]: src/cdma-connman.c:cdma_connman_set_property()
ofonod[11596]: src/cdma-connman.c:cdma_connman_set_property()
ofonod[11596]: src/cdma-connman.c:cdma_connman_set_property()
ofonod[11596]: src/cdma-connman.c:cdma_connman_set_property()
ofonod[11596]: drivers/cdmamodem/connman.c:cdma_connman_activate()
ofonod[11596]: Modem: > ATD#777\r
ofonod[11596]: Modem: < \r\nCONNECT\r\n
ofonod[11596]: drivers/cdmamodem/connman.c:atd_cb() ok 1
ofonod[11596]: drivers/cdmamodem/connman.c:setup_ppp()
ofonod[11596]: PCUI: < \r\nCONNECT\r\n
ofonod[11596]: drivers/cdmamodem/connman.c:ppp_connect()
ofonod[11596]: IP: 14.96.204.15
ofonod[11596]: DNS: 4.2.2.2, 4.2.2.3
ofonod[11596]: src/cdma-connman.c:activate_callback() 0x9a88880 ppp0
ofonod[11596]: src/cdma-connman.c:cdma_connman_settings_update()
ofonod[11596]: src/cdma-connman.c:cdma_connman_ifupdown()
ofonod[11596]: src/cdma-connman.c:cdma_connman_settings_signal()
ofonod[11596]: src/cdma-connman.c:cdma_connman_settings_append_variant()
ofonod[11596]: src/cdma-connman.c:cdma_connman_set_property()
ofonod[11596]: drivers/cdmamodem/connman.c:cdma_connman_deactivate()
ofonod[11596]: plugins/udev.c:remove_modem() /devices/virtual/net/ppp0
ofonod[11596]: PCUI: < \r\nNO CARRIER\r\n
ofonod[11596]: drivers/cdmamodem/connman.c:ppp_disconnect()
ofonod[11596]: src/cdma-connman.c:deactivate_callback()
ofonod[11596]: src/cdma-connman.c:cdma_connman_settings_reset()
ofonod[11596]: src/cdma-connman.c:cdma_connman_settings_free()
ofonod[11596]: src/cdma-connman.c:cdma_connman_settings_signal()
ofonod[11596]: src/cdma-connman.c:cdma_connman_settings_append_variant()
ofonod[11596]: src/cdma-connman.c:cdma_connman_ifupdown()
ofonod[11596]: Modem: < \r\n^RSSILVL:80\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:80\r\n
ofonod[11596]: Modem: < \r\n^RSSILVL:60\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:60\r\n
ofonod[11596]: Modem: < \r\n^RSSILVL:80\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:80\r\n
ofonod[11596]: Modem: < \r\n^RSSILVL:60\r\n
ofonod[11596]: PCUI: < \r\n^RSSILVL:60\r\n



On 08/09/2011 08:31 PM, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 08/08/2011 07:13 AM, Guillaume Zajac wrote:
>> From: Bertrand Aygon<bertrand.aygon@intel.com>
>>
>> ---
>>   Makefile.am                                    |    3 +-
>>   drivers/huaweicdmamodem/huaweicdmamodem.c      |    3 +
>>   drivers/huaweicdmamodem/huaweicdmamodem.h      |    3 +
>>   drivers/huaweicdmamodem/network-registration.c |  171 ++++++++++++++++=
++++++++
>>   4 files changed, 179 insertions(+), 1 deletions(-)
>>   create mode 100644 drivers/huaweicdmamodem/network-registration.c
>>
>
> I applied this patch but refactored it slightly afterwards.  Please
> review and make sure I didn't break anything.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============1885522831062912604==--

