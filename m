Content-Type: multipart/mixed; boundary="===============9023291020260896037=="
MIME-Version: 1.0
From: Kjetil ASDAL <kjetil.asdal@stericsson.com>
Subject: RE: Selecting multiple radio access technologies in oFono
Date: Wed, 02 Feb 2011 13:00:21 +0100
Message-ID: <24601CEAED63B94588D46990641D59241B7B4D8DB8@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <1296643483.1520.319.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9023291020260896037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


Marcel wrote: =

> Couldn't this be achieved by actual band selection if you really really
> wanted this? Do we actually have different LTE band at all. I am still
> not all that familiar with the low-level radio technology behind LTE.

When you say "band selection", I assume you are talking about frequency ban=
ds. =

AFAIK, the frequency band is a setting within the radio access technology, =
and =

I don't think it is possible to "disable" LTE by deselecting certain freque=
ncy =

bands. Furthermore, AFAIK, there are no AT commands for doing frequency ban=
d =

selection.

Anyway, if you do not want to use LTE, then you should specifically tell th=
e UE =

to disable/deactivate the part of the radio stack that handles EUTRAN.

Regards,
Kjetil

--===============9023291020260896037==--

