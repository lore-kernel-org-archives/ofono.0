Content-Type: multipart/mixed; boundary="===============8679518705272718255=="
MIME-Version: 1.0
From: Kai Scharwies <kai@scharwies.de>
Subject: Re: Qualcomm Gobi 2000 Modem Issues
Date: Fri, 08 Apr 2011 10:31:38 +0200
Message-ID: <BANLkTi=46H305-EY_yWj_iVsFYupn-JtBQ@mail.gmail.com>
In-Reply-To: <1302191536.2572.180.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8679518705272718255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/4/7 Marcel Holtmann <marcel@holtmann.org>:
> Hi Kai,
>
>> I ran into two issues trying to setup a data connection with a Gobi 2000=
 card.
>> The first one seems to be an error regarding simcard onlocking. After
>> enabling the modem test/list-modems shows the following, despite the
>> simcard is inserted correctly:
>>
>> [ /gobi0 ]
>> =C2=A0 =C2=A0 Features =3D sim
>> =C2=A0 =C2=A0 Emergency =3D 0
>> =C2=A0 =C2=A0 Powered =3D 1
>> =C2=A0 =C2=A0 Lockdown =3D 0
>> =C2=A0 =C2=A0 Interfaces =3D org.ofono.SimManager
>> =C2=A0 =C2=A0 Online =3D 0
>> =C2=A0 =C2=A0 Model =3D Qualcomm Gobi 2000
>> =C2=A0 =C2=A0 Revision =3D D1025-STUTABGD-3600 =C2=A01 =C2=A0[Jan 14 201=
0 14:00:00]
>> =C2=A0 =C2=A0 Serial =3D 353093033460401
>> =C2=A0 =C2=A0 Manufacturer =3D Qualcomm Incorporated
>> =C2=A0 =C2=A0 [ org.ofono.SimManager ]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Present =3D 0
>>
>> Our current workaround is quitting ofono and using minicom to unlock
>> the sim directly, then restarting ofono.
>> > at+cpin?
>> +CPIN: SIM PIN
>> OK
>>
>> > at+cpin=3D"1234"
>> OK
>> $QCSIMSTAT: 1 SIM INIT COMPLETED
>
> this is weird since the PIN unlocking should just work fine. Have you
> tried to use the test/enter-pin script?

Yes, I tried the enter-pin script. Using it without the optional PATH
this is the error:
dbus.exceptions.DBusException: org.ofono.Error.InvalidFormat: Argument
format is not recognized

Entering 'test/enter-pin /generic pin 1234' resultis in:
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "EnterPin" with
signature "ss" on interface "org.ofono.SimManager" doesn't exist

The problem is ofono not detecting the sim card properly since
'list-modems' shows:
    [ org.ofono.SimManager ]
        Present =3D 0

What it should look like is this (Output after unlocking via AT
commands, described above):
    [ org.ofono.SimManager ]
        Retries =3D
        MobileCountryCode =3D 262
        FixedDialing =3D 0
        SubscriberNumbers =3D
        PreferredLanguages =3D de en
        BarredDialing =3D 0
        CardIdentifier =3D 89490200000622126220
        LockedPins =3D
        MobileNetworkCode =3D 01
        SubscriberIdentity =3D 262019038101028
        Present =3D 1
        PinRequired =3D none

PinRequired should of course read "pin" before unlocking.
Anymore logs I could deliver to solve this issue?

>
>> The second issue is not being able to activate an internet context:
>> (Network registration and attachment is alright)
>>
>> test/enable-modem
>> Connecting modem /gobi0...
>> test/online-modem
>> Setting modem /gobi0 online...
>> test/list-contexts
>> [ /gobi0 ]
>> =C2=A0 =C2=A0 [ /gobi0/context1 ]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Username =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Protocol =3D ip
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Name =3D Internet
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Settings =3D { }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPv6.Settings =3D { }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Active =3D 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AccessPointName =3D internet.t-mobile
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Password =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Type =3D internet
>>
>> test/activate-context
>> Error activating /gobi0/context1: org.ofono.Error.NotImplemented:
>> Implementation not provided
>>
>> If you could give me a little assisting on where to look, maybe I
>> would be able to contribute patches, too.
>
> Of course this does not work. Check doc/hardware-support.txt for
> supported modem and supported capabilities.
>
> Until Qualcomm gives us the chance to implement QMI properly, we are a
> bit out of luck with just one AT command channel. You need at least two
> AT command channel to run oFono properly.
>

I missed reading that document.
However I don't understand why you would need QMI for setting up a PPP
connection, since there are infact three AT command channels, not one,
if I understand the log correctly:

ofonod[2844]: src/modem.c:ofono_modem_create() name: (null), type: gobi
ofonod[2844]: src/modem.c:set_modem_property() modem 0x8dcb268 property Path
ofonod[2844]: src/modem.c:set_modem_property() modem 0x8dcb268
property Registered
ofonod[2844]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4:1.1/ttyUSB3/tty/ttyUSB3
(gobi)
ofonod[2844]: plugins/udev.c:add_gobi() modem 0x8dcb268
ofonod[2844]: src/modem.c:get_modem_property() modem 0x8dcb268 property Path
ofonod[2844]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4:1.2/ttyUSB4/tty/ttyUSB4
(gobi)
ofonod[2844]: plugins/udev.c:add_gobi() modem 0x8dcb268
ofonod[2844]: src/modem.c:set_modem_property() modem 0x8dcb268 property Dev=
ice
ofonod[2844]: plugins/gobi.c:gobi_probe() 0x8dcb268
ofonod[2844]: plugins/hfp_ag.c:modem_watch() modem: 0x8dcb268, added: 1
ofonod[2844]: plugins/dun_gw.c:modem_watch() modem: 0x8dcb268, added: 1
ofonod[2844]: plugins/smart-messaging.c:modem_watch() modem: 0x8dcb268, add=
ed: 1
ofonod[2844]: plugins/push-notification.c:modem_watch() modem:
0x8dcb268, added: 1
ofonod[2844]: src/modem.c:get_modem_property() modem 0x8dcb268 property Path
ofonod[2844]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4:1.3/ttyUSB5/tty/ttyUSB5
(gobi)
ofonod[2844]: plugins/udev.c:add_gobi() modem 0x8dcb268
ofonod[2844]: plugins/gobi.c:gobi_enable() 0x8dcb268
ofonod[2844]: src/modem.c:get_modem_property() modem 0x8dcb268 property Dev=
ice
ofonod[2844]: plugins/gobi.c:open_device() Device /dev/ttyUSB4
ofonod[2844]: plugins/gobi.c:cfun_enable()
ofonod[2844]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[2844]: plugins/gobi.c:gobi_pre_sim() 0x8dcb268
ofonod[2844]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[2844]: plugins/gobi.c:gobi_post_sim() 0x8dcb268
ofonod[2844]: src/sim.c:ofono_sim_add_state_watch() 0x8dc8900
ofonod[2844]: src/sim.c:ofono_sim_add_state_watch() 0x8dc8900
ofonod[2844]: Phonebook not supported by this modem.  If this is in
error please submit patches to support this hardware
ofonod[2844]: src/phonebook.c:phonebook_remove() atom: 0x8dc5498
ofonod[2844]: SMS not supported by this modem.  If this is in error
please submit patches to support this hardware
ofonod[2844]: src/sms.c:sms_remove() atom: 0x8dca430
ofonod[2844]: plugins/gobi.c:simstat_notify() state UNKNOWN

The other hint looking for missing TUN/TAP support is not an issue.
Using e.g. OpenVPN I definetly have the support enabled and the logs
didn't mention the error.

Best regards,
Kai

--===============8679518705272718255==--

