Content-Type: multipart/mixed; boundary="===============3465085614078259469=="
MIME-Version: 1.0
From: Kai Scharwies <kai@scharwies.de>
Subject: Re: Qualcomm Gobi 2000 Modem Issues
Date: Thu, 28 Apr 2011 17:42:46 +0200
Message-ID: <BANLkTi=g3Xad-NzPyTT4a26Rb6oq1yr3fA@mail.gmail.com>
In-Reply-To: <1302270463.2572.185.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3465085614078259469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/4/8 Marcel Holtmann <marcel@holtmann.org>:
> Hi Kai,
>
>> >> I ran into two issues trying to setup a data connection with a Gobi 2=
000 card.
>> >> The first one seems to be an error regarding simcard onlocking. After
>> >> enabling the modem test/list-modems shows the following, despite the
>> >> simcard is inserted correctly:
>> >>
>> >> [ /gobi0 ]
>> >> =C2=A0 =C2=A0 Features =3D sim
>> >> =C2=A0 =C2=A0 Emergency =3D 0
>> >> =C2=A0 =C2=A0 Powered =3D 1
>> >> =C2=A0 =C2=A0 Lockdown =3D 0
>> >> =C2=A0 =C2=A0 Interfaces =3D org.ofono.SimManager
>> >> =C2=A0 =C2=A0 Online =3D 0
>> >> =C2=A0 =C2=A0 Model =3D Qualcomm Gobi 2000
>> >> =C2=A0 =C2=A0 Revision =3D D1025-STUTABGD-3600 =C2=A01 =C2=A0[Jan 14 =
2010 14:00:00]
>> >> =C2=A0 =C2=A0 Serial =3D 353093033460401
>> >> =C2=A0 =C2=A0 Manufacturer =3D Qualcomm Incorporated
>> >> =C2=A0 =C2=A0 [ org.ofono.SimManager ]
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Present =3D 0
>> >>
>> >> Our current workaround is quitting ofono and using minicom to unlock
>> >> the sim directly, then restarting ofono.
>> >> > at+cpin?
>> >> +CPIN: SIM PIN
>> >> OK
>> >>
>> >> > at+cpin=3D"1234"
>> >> OK
>> >> $QCSIMSTAT: 1 SIM INIT COMPLETED
>> >
>> > this is weird since the PIN unlocking should just work fine. Have you
>> > tried to use the test/enter-pin script?
>>
>> Yes, I tried the enter-pin script. Using it without the optional PATH
>> this is the error:
>> dbus.exceptions.DBusException: org.ofono.Error.InvalidFormat: Argument
>> format is not recognized
>>
>> Entering 'test/enter-pin /generic pin 1234' resultis in:
>> dbus.exceptions.DBusException:
>> org.freedesktop.DBus.Error.UnknownMethod: Method "EnterPin" with
>> signature "ss" on interface "org.ofono.SimManager" doesn't exist
>>
>> The problem is ofono not detecting the sim card properly since
>> 'list-modems' shows:
>> =C2=A0 =C2=A0 [ org.ofono.SimManager ]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Present =3D 0
>
> this is clearly a bug in the Gobi plugin then. It does not detect the
> SIM card properly. So you need to dig a bit into plugins/gobi.c and
> figure out how to fix it.
>

I would like to do that, but having trouble with the code, especially
because I couldn't find any documentation on AT$QCSIMSTAT and
code-documentation in gobi.c is virtually not present.
Maybe someone can help here.

Again, the problem is, that the modem responds "$QCSIMSTAT: 1,UNKNOWN"
instead of "$QCSIMSTAT: 1 SIM INIT COMPLETED" when "AT$QCSIMSTAT?" is
sent.

>> >> The second issue is not being able to activate an internet context:
>> >> (Network registration and attachment is alright)
>> >>
>> >> test/enable-modem
>> >> Connecting modem /gobi0...
>> >> test/online-modem
>> >> Setting modem /gobi0 online...
>> >> test/list-contexts
>> >> [ /gobi0 ]
>> >> =C2=A0 =C2=A0 [ /gobi0/context1 ]
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Username =3D
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Protocol =3D ip
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Name =3D Internet
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Settings =3D { }
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPv6.Settings =3D { }
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Active =3D 0
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AccessPointName =3D internet.t-mobile
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Password =3D
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Type =3D internet
>> >>
>> >> test/activate-context
>> >> Error activating /gobi0/context1: org.ofono.Error.NotImplemented:
>> >> Implementation not provided
>> >>
>> >> If you could give me a little assisting on where to look, maybe I
>> >> would be able to contribute patches, too.
>> >
>> > Of course this does not work. Check doc/hardware-support.txt for
>> > supported modem and supported capabilities.
>> >
>> > Until Qualcomm gives us the chance to implement QMI properly, we are a
>> > bit out of luck with just one AT command channel. You need at least two
>> > AT command channel to run oFono properly.
>> >
>>
>> I missed reading that document.
>> However I don't understand why you would need QMI for setting up a PPP
>> connection, since there are infact three AT command channels, not one,
>> if I understand the log correctly:
>>
>> ofonod[2844]: src/modem.c:ofono_modem_create() name: (null), type: gobi
>> ofonod[2844]: src/modem.c:set_modem_property() modem 0x8dcb268 property =
Path
>> ofonod[2844]: src/modem.c:set_modem_property() modem 0x8dcb268
>> property Registered
>> ofonod[2844]: plugins/udev.c:add_modem()
>> /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4:1.1/ttyUSB3/tty/ttyUSB3
>> (gobi)
>> ofonod[2844]: plugins/udev.c:add_gobi() modem 0x8dcb268
>> ofonod[2844]: src/modem.c:get_modem_property() modem 0x8dcb268 property =
Path
>> ofonod[2844]: plugins/udev.c:add_modem()
>> /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4:1.2/ttyUSB4/tty/ttyUSB4
>> (gobi)
>> ofonod[2844]: plugins/udev.c:add_gobi() modem 0x8dcb268
>> ofonod[2844]: src/modem.c:set_modem_property() modem 0x8dcb268 property =
Device
>> ofonod[2844]: plugins/gobi.c:gobi_probe() 0x8dcb268
>> ofonod[2844]: plugins/hfp_ag.c:modem_watch() modem: 0x8dcb268, added: 1
>> ofonod[2844]: plugins/dun_gw.c:modem_watch() modem: 0x8dcb268, added: 1
>> ofonod[2844]: plugins/smart-messaging.c:modem_watch() modem: 0x8dcb268, =
added: 1
>> ofonod[2844]: plugins/push-notification.c:modem_watch() modem:
>> 0x8dcb268, added: 1
>> ofonod[2844]: src/modem.c:get_modem_property() modem 0x8dcb268 property =
Path
>> ofonod[2844]: plugins/udev.c:add_modem()
>> /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4:1.3/ttyUSB5/tty/ttyUSB5
>> (gobi)
>
> This means that there are 3 TTYs exposed by the Gobi card. This does not
> mean that these are all AT modem capable ports. In fact they are not.
> Check /proc/bus/usb/devices and see what driver got loaded for what USB
> interface. All the qcaux bound interfaces are not really helpful.
>
> But if you by accident have a Gobi firmware that exposes 2 real AT
> command ports, I like to hear about it.

Can you please explain to me why a second command port is needed? I
tried setting up a data connection with said modem using modem-manager
and it just uses the one existing port for setting up a
ppp-connection.

>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============3465085614078259469==--

