Content-Type: multipart/mixed; boundary="===============3342374376676642779=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ublox toby L210 support in ofono
Date: Thu, 14 Mar 2019 13:27:05 -0500
Message-ID: <4b0540a9-a897-da35-a628-c93853381b9d@gmail.com>
In-Reply-To: <b6d7c00d-d4dd-d6a7-0a96-7bbea2a3a216@embexus.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3342374376676642779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ayoub,

> [ /ublox_0 ]
>  =C2=A0 =C2=A0 [ /ublox_0/context1 ]
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Type =3D internet
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Protocol =3D ip
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Name =3D Internet
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPv6.Settings =3D { }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 AuthenticationMethod =3D chap
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Username =3D
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 AccessPointName =3D mtm.tag.com.mnc001.mcc23=
2.gprs
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Active =3D 1
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Settings =3D { Address=3D10.3.26.101 Netmask=
=3D255.255.255.0 =

> DomainNameServers=3D194.48.139.254,194.48.128.199, Gateway=3D10.3.26.154 =

> Method=3Dstatic }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Password =3D

So, looks like you're connected, but the driver has not provided the =

network interface string.  Most likely something is missing in =

plugins/udevng.c and it isn't properly setting the net devnode.

ofonod[228]: ../ofono-1.22/plugins/udevng.c:create_modem() =

/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1/usb1/1-1
ofonod[228]: ../ofono-1.22/plugins/udevng.c:create_modem() driver=3Dublox
ofonod[228]: ../ofono-1.22/src/modem.c:ofono_modem_create() name: =

(null), type: ublox
ofonod[228]: ../ofono-1.22/plugins/udevng.c:setup_ublox() =

/sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1/usb1/1-1
ofonod[228]: ../ofono-1.22/plugins/udevng.c:setup_ublox() /dev/ttyACM0 =

2/2/1 02 (null)
ofonod[228]: ../ofono-1.22/plugins/udevng.c:setup_ublox() =

aux=3D/dev/ttyACM0 modem=3D(null) net=3D(null)

As you can see, net is NULL here...

<snip>

> =

> It looks like the modem is online but there is no ppp interface =

> associated with it
According to plugins/udevng.c & plugins/ublox.c, this modem could be be =

using a high-speed interface, depending on the profile.

Regards,
-Denis

--===============3342374376676642779==--

