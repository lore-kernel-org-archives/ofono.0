Content-Type: multipart/mixed; boundary="===============1664154362028885121=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Option GTM 382
Date: Tue, 27 Apr 2010 09:16:24 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731CD28565@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <p2w35f991da1004260633q80d32ae4r5831ddd64e1b98bc@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1664154362028885121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Teemu,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Teemu Piiroinen
>Sent: Monday, April 26, 2010 9:33 PM
>To: ofono(a)ofono.org
>Subject: Re: Option GTM 382
>
>No luck yet..
>
>Did I setup the sw correcty?
>- I run configure, make and make install
>- Added ofono.rules to /etc/udev/rules.d and /lib/udev/rules.d/
>- Started ofono by running ofonod from shell
>
>Is there something else I need to do?

If you just copied ofono.rules to /etc/udev/rules.d, the rule might not tak=
e effect directly. Here are the steps:
1. Copy ofono.rules to /etc/udev/rules.d (I'm using Ubuntu 10.04, and it se=
ems rule can still work in this directory)
2. Run " udevadm control --reload-rules" to make rule work (Or you may rest=
art your computer to make it work)
3. In ofono directory, run "./bootstrap-configure" and "make" (There is no =
need to install)
4. Copy plugins/modem.conf to /etc/ofono (Sometimes oFono may rely on this =
file. But for this Option modem, it's recognized using udev, so this file h=
as no use)
5. Run oFono by using "src/ofonod -nd '*'", and use "test/list-modems" to s=
ee if the modem is recognized.
6. Hope you get luck this time


>
>I also removed network manager from Ubuntu, but that didn't help either.

There is no need to remove this :)

>
>Br,
>Teemu


Regards,
-Yang

--===============1664154362028885121==--

