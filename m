Content-Type: multipart/mixed; boundary="===============6707435244905369258=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ublox TOBY-R200
Date: Wed, 19 Sep 2018 16:55:26 -0500
Message-ID: <85bde1b1-3ee4-7f62-88e3-809bf31ca335@gmail.com>
In-Reply-To: <CAFJydPWS6sVv0+0pYTRjy6Ne5r1+Z8A8r2QUOqWFGNZrGGE+og@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6707435244905369258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Please stop top-posting on this mailing list.  We follow the accepted =

best practice of open source mailing lists and require replies to be =

in-line.

> Sep 19 20:17:41 gateway daemon.warn ofonod[152]: Context activated for
> driver that doesn't support automatic context activation.

So this is a big clue that something is wrong.  The uBlox driver can =

create 'atmodem' or 'ubloxmodem' gprs contexts.  The atmodem =

gprs_context driver does not support .read_settings.  That is because we =

so far have not needed to support LTE contexts via PPP.  You would =

likely end up spiking the CPU to 100% and melt your device if you tried =

that ;)

The 'ubloxmodem' gprs_context driver does support read_settings, but I =

don't know enough about this hardware to guide you any further.

> I'm new to oFono and connman so I'm going to try to get cellular =

> connectivity working on a BeagleBone Black with u-blox TOBY-L201 (oFono =

> supported modem) plugged into USB first.=C2=A0 I can activate a context =

> successfully but cellular still says Connected =3D False in connmanctl on =

> the BeagleBone Black.=C2=A0 Any pointers or links on how to do get connma=
n =

> working with oFono are appreciated.
> =


This might be better asked on the ConnMan mailing list.

Regards,
-Denis

--===============6707435244905369258==--

