Content-Type: multipart/mixed; boundary="===============9048031595541168465=="
MIME-Version: 1.0
From: Ayoub Zaki <ayoub.zaki@embexus.com>
Subject: Re: ublox toby L210 support in ofono
Date: Thu, 14 Mar 2019 19:46:37 +0100
Message-ID: <22639f72-68a6-cd7a-3162-25d1e04f5d99@embexus.com>
In-Reply-To: <4b0540a9-a897-da35-a628-c93853381b9d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9048031595541168465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 14.03.19 19:27, Denis Kenzior wrote:
> Hi Ayoub,
>
>> [ /ublox_0 ]
>> =C2=A0=C2=A0 =C2=A0 [ /ublox_0/context1 ]
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 Type =3D internet
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 Protocol =3D ip
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name =3D Internet
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 IPv6.Settings =3D { }
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 AuthenticationMethod =3D chap
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 Username =3D
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 AccessPointName =3D mtm.tag.com.mnc001=
.mcc232.gprs
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 Active =3D 1
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 Settings =3D { Address=3D10.3.26.101 N=
etmask=3D255.255.255.0 =

>> DomainNameServers=3D194.48.139.254,194.48.128.199, Gateway=3D10.3.26.154 =

>> Method=3Dstatic }
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 Password =3D
>
> So, looks like you're connected, but the driver has not provided the =

> network interface string.=C2=A0 Most likely something is missing in =

> plugins/udevng.c and it isn't properly setting the net devnode.
>
> ofonod[228]: ../ofono-1.22/plugins/udevng.c:create_modem() =

> /sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1/usb1/1-1
> ofonod[228]: ../ofono-1.22/plugins/udevng.c:create_modem() driver=3Dublox
> ofonod[228]: ../ofono-1.22/src/modem.c:ofono_modem_create() name: =

> (null), type: ublox
> ofonod[228]: ../ofono-1.22/plugins/udevng.c:setup_ublox() =

> /sys/devices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1/usb1/1-1
> ofonod[228]: ../ofono-1.22/plugins/udevng.c:setup_ublox() /dev/ttyACM0 =

> 2/2/1 02 (null)
> ofonod[228]: ../ofono-1.22/plugins/udevng.c:setup_ublox() =

> aux=3D/dev/ttyACM0 modem=3D(null) net=3D(null)
>
> As you can see, net is NULL here...
>
> <snip>
>
>>
>> It looks like the modem is online but there is no ppp interface =

>> associated with it
> According to plugins/udevng.c & plugins/ublox.c, this modem could be =

> be using a high-speed interface, depending on the profile.


I checked with lsusb:

root(a)beaglebone-yocto:~# lsusb
Bus 001 Device 002: ID 1546:1146 U-Blox AG

In plugins/udevng.c I can see that it support both rndis_host and cdc_acm

 =C2=A0=C2=A0=C2=A0 { "ublox",=C2=A0=C2=A0 =C2=A0"rndis_host",=C2=A0=C2=A0 =
=C2=A0"1546", "1146"=C2=A0=C2=A0 =C2=A0},
 =C2=A0=C2=A0 =C2=A0{ "ublox",=C2=A0=C2=A0 =C2=A0"cdc_acm",=C2=A0=C2=A0 =C2=
=A0"1546", "1146"=C2=A0=C2=A0 =C2=A0},


What should I do to make it work ?


So basically that modem is not supported ?!


Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards

-- =

Ayoub Zaki
Embedded Systems Consultant

Vaihinger Stra=C3=9Fe 2/1
D-71634 Ludwigsburg

Mobile   : +4917662901545
Email    : ayoub.zaki(a)embexus.com
Homepage : https://embexus.com
VAT No.  : DE313902634


--===============9048031595541168465==--

