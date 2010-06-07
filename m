Content-Type: multipart/mixed; boundary="===============0509263859208365900=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: VS: [RFC PATCH 5/6] Support for concatenated SMS status report.
Date: Mon, 07 Jun 2010 12:45:40 -0500
Message-ID: <201006071245.41219.denkenz@gmail.com>
In-Reply-To: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A51@jklmail01.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0509263859208365900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> > I suggest thinking about the data structure use some more.  In
> > particular, using a list of struct mr_numbers is very inefficient.  Usi=
ng
> > a pair of bitmaps for mr numbers (which can only be 0..255) would be way
> > more efficient and probably would make the code much easier to write.
> =

> I am not sure if I am quite getting what do you mean. Do you mean somethi=
ng
> like:
> struct mr_numbers {
>         unsigned int mr1 : 8,
>         unsigned int mr2 : 8,
>         unsigned int mr3 : 8,
>         unsigned int mr4 : 8
> };

No, I mean something like:
	unsigned int needed_mrs[8];
	unsigned int obtained_mrs[8];

where each set bit represents a number at that particular offset.  See how =
cbs =

/ sms assemblies do this.

Regards,
-Denis

--===============0509263859208365900==--

