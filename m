Content-Type: multipart/mixed; boundary="===============7456290226690292161=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HE910-G - Can't activate context
Date: Sun, 24 Jun 2018 15:14:22 -0500
Message-ID: <fd742276-a2d3-28fc-1dd2-13a03b1bb278@gmail.com>
In-Reply-To: <CAGyX7WZZGpb7VJgUPDKDwgxpsZH0qSgCzf8=gbq4-HwSXXNo8Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7456290226690292161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jason,

> enable/power the modem through ofono and even register the SIM on the =

> network. From what I can tell, this bug seems to be present in all ofono =

> versions that don't use the he910.c plugin.

Maybe just the newer firmware behaves differently.  I think the people =

who merged the various telit drivers were using LE/UE 910 which is a bit =

newer than the HE910.

> The current problem we are having is that we cannot activate the context =

> with ofono or connman. Any attempt fails with:
> =

> Error activating /telit_1/context1: org.ofono.Error.NotImplemented: =

> Implementation not provided.

You might want to enable debugging (-d command line option) and see what =

it says.  HE910 uses the 'atmodem' gprs-context driver, which in turn =

depends on tun/tap being loaded.  Most likely your kernel is missing =

this functionality or you forgot to load the required module.

Regards,
-Denis

--===============7456290226690292161==--

