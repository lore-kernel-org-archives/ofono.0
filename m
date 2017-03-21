Content-Type: multipart/mixed; boundary="===============2186992230940471018=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: Telit LE920A4 - aux/modem channels and events
Date: Tue, 21 Mar 2017 16:07:27 +0000
Message-ID: <df05ade2-27b7-78dc-26b3-506a162537de@gmail.com>
In-Reply-To: <CANmGHYvpwsYS-4a1VeFu8Z-mYPj5hOOsA9QLGZH8-fsE4OFhCQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2186992230940471018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daryl,

I am currently working on LE910-SVG modem. Reading Telit docs, if your
modem is a 0x1201 variant, you should probably be using QMI for it.
Having said that, ppp through the Telit firmware should work too.

I can see you are missing qmi_wwan driver in your kernel. I am not sure
if qmicli should work without it. I can use qmicli to query modem's status
without issues, over cdc-wdm0.

If you are interested, I could send you my patch (work in progress) to ofon=
o,
enumerating the 0x1201 telit modems to use qmimodem driver. But I suppose it
would be best to get qmicli working first.

When you are getting +CREG - what state is it indicating?

btw my modem is LTE only, and it always shows +CREG as 2,0 - "not registere=
d",
so ofono logic is never setting up the ppp context. Hence I switched to usi=
ng
qmimodem.

Lukasz


On 21/03/17 14:49, Daryl Nebrich wrote:
> Hi,
> =

> I'm using the latest of ofono and connman.  I'm having an issue with a
> PPP connection and async events.  With the latest ofono code, I added
> LE920A4 to plugins/telit.c.  So it's using atmodem driver for gprs and
> gprs-context.  The modem is running in mode 0x1201, so below is the
> mapping of aux and modem.
> =

> /dev/ttyUSB0 (telit) 255/255/255 [00] =3D=3D> (null) (null)
> /dev/cdc-wdm0 (gobi) 255/255/255 [02] =3D=3D> (null) (null)
> /dev/ttyUSB1 (telit) 255/0/0 [03] =3D=3D> (null) (null)
> /dev/ttyUSB2 (telit) 255/0/0 [04] =3D=3D> (null) (null) -- for mode
> 0x1201, used for creating PPP connection
> /dev/ttyUSB3 (telit) 255/0/0 [05] =3D=3D> (null) (null) -- for mode
> 0x1201, used as chat for AT commands
> /dev/ttyUSB4 (telit) 255/0/0 [06] =3D=3D> (null) (null)
> =

> Initially after the PPP session is established, everything is fine.  I
> can ping using the ppp0 interface.  But as soon as I get an async
> event (+CREG, +CIEV, etc), ping stops working.  If I leave ping
> running, I'll eventually get a ppp_disconnect with Reason 5 and state
> 3.  The events are logged on the aux channel, but I'm not sure if
> they're coming on modem channel also.
> =

> This can happen without any associated NWDETACH (sometimes I'll just
> see a +CREG after PPP is connected).  In this case ppp_disconnect
> calls ofono_gprs_context_deactivated followed by g_at_chat_resume.  It
> looks like at_chat_resume ends up calling io_disconnect because of the
> below code.
> =

>     if (g_at_io_get_channel(chat->io) =3D=3D NULL) {
>         io_disconnect(chat);
>         return;
>     }
> =

> Is it expected that chat->io goes away because of the ppp_disconnect?
> When this happens the connman ofono plugin still thinks there's a
> network so it will repeatedly try to attach.  But the attach fails as
> it can't send AT commands anymore.
> =

> I've tried changing how events are handling while a PPP session is
> active by changing settings similar to below -
> =

>     g_at_chat_send(gcd->chat, "AT+CMER=3D1,0,0,0", none_prefix, NULL, NUL=
L, NULL);
>     g_at_chat_send(gcd->chat, "AT+CGEREP=3D2,1", none_prefix, NULL, NULL,=
 NULL);
>     g_at_chat_send(gcd->chat, "AT+CAOC=3D1", none_prefix, NULL, NULL, NUL=
L);
> =

> The above changes are in gprs-context.c/at_cgdcont_cb right before
> sending AT+CGDATA so I would expect them to suppress events on the
> modem channel.  But I still sometimes get a +CREG update which appears
> to disrupt the PPP session.  Any ideas?
> =

> BTW, I've trying using QMI on /dev/cdc-wdm0 using qmicli and
> qmi-network without any luck.  It just times out.
> =

> Thanks,
> Daryl
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>=20

--===============2186992230940471018==--

