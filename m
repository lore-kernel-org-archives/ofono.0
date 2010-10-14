Content-Type: multipart/mixed; boundary="===============3391557198391397041=="
MIME-Version: 1.0
From: Alexander A Khryukin <alexander@mezon.ru>
Subject: Re: huawei e1550
Date: Thu, 14 Oct 2010 13:03:32 +0400
Message-ID: <1287047012.32351.12.camel@mezon.ru>
In-Reply-To: <87tykqcl1w.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3391557198391397041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixed logs


OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n -d


# /usr/lib/ofono/test/enable-modem =

Connecting modem /huawei0..


http://pastie.org/1220238



# /usr/lib/ofono/test/online-modem
Setting modem /huawei0 online...

http://pastie.org/1220240



after "Online-modem"


ofonod[7270]: src/gprs.c:gprs_context_remove() atom: 0x96680b8
ofonod[7270]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =

ofonod[7270]: src/modem.c:get_modem_property() modem 0x9668d90 property
Modem
ofonod[7270]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[7270]:
plugins/udev.c:remove_modem() /devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3=
:1.0/ttyUSB0/tty/ttyUSB0
ofonod[7270]: src/modem.c:get_modem_property() modem 0x9668d90 property
Path
ofonod[7270]: src/modem.c:ofono_modem_remove() 0x9668d90
ofonod[7270]: src/message-waiting.c:mw_remove() atom: 0x9668780
ofonod[7270]: src/ssn.c:ssn_remove() atom: 0x9668628
ofonod[7270]: src/call-barring.c:call_barring_remove() atom: 0x9668590
ofonod[7270]: src/call-settings.c:call_settings_remove() atom: 0x96684a0
ofonod[7270]: src/call-forwarding.c:call_forwarding_remove() atom:
0x9668248
ofonod[7270]: src/network.c:__ofono_netreg_remove_status_watch()
0x9667a98
ofonod[7270]: src/gprs.c:gprs_remove() atom: 0x9667fc0
ofonod[7270]: src/ussd.c:ussd_remove() atom: 0x9667550
ofonod[7270]: src/network.c:__ofono_netreg_remove_status_watch()
0x9667a98
ofonod[7270]: src/cbs.c:cbs_remove() atom: 0x9669228
ofonod[7270]: src/sms.c:sms_remove() atom: 0x9669260
ofonod[7270]: src/network.c:netreg_remove() atom: 0x9667118
ofonod[7270]: src/phonebook.c:phonebook_remove() atom: 0x9667a50
ofonod[7270]: src/audio-settings.c:audio_settings_remove() atom:
0x9667978
ofonod[7270]: src/voicecall.c:voicecall_remove() atom: 0x9666f78
ofonod[7270]: src/sim.c:sim_remove() atom: 0x9666cd0
ofonod[7270]: src/modem.c:devinfo_remove() atom: 0x9664d50
ofonod[7270]: plugins/huawei.c:huawei_disable() 0x9668d90
ofonod[7270]: plugins/huawei.c:huawei_remove() 0x9668d90
ofonod[7270]: src/modem.c:unregister_property() property 0x9666b60
ofonod[7270]: src/modem.c:unregister_property() property 0x9668e18
ofonod[7270]: src/modem.c:unregister_property() property 0x9666e68
ofonod[7270]: src/modem.c:unregister_property() property 0x9668e48
ofonod[7270]: src/modem.c:unregister_property() property 0x96672a0
ofonod[7270]: src/modem.c:unregister_property() property 0x9665228
ofonod[7270]: plugins/smart-messaging.c:modem_watch() modem: 0x9668d90,
added: 0
ofonod[7270]:
plugins/udev.c:remove_modem() /devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3=
:1.1/ttyUSB1/tty/ttyUSB1
ofonod[7270]:
plugins/udev.c:remove_modem() /devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3=
:1.2/ttyUSB2/tty/ttyUSB2






--===============3391557198391397041==--

