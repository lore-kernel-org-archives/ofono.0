Content-Type: multipart/mixed; boundary="===============1994870779738899871=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Using ofono in C
Date: Mon, 02 May 2011 08:02:00 -0700
Message-ID: <1304348520.15916.100.camel@aeonflux>
In-Reply-To: <4DBEA538.4070202@makhutov.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1994870779738899871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Artem,

> I am looking for some examples how to use ofono in C.
> =

> I need something lightweight without using thinks like Qt so ofono might
> be run on low end devices like wifi routers.

you can use oFono directly via the libdbus C binding. It is pretty
lightweight. An example would be tools/auto-enable.c to get you started
with things.

Regards

Marcel



--===============1994870779738899871==--

