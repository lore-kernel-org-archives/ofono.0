Content-Type: multipart/mixed; boundary="===============3853863862476416364=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] Use GET RESPONSE sim command to retrieve EF length.
Date: Sun, 21 Jun 2009 01:37:12 +0200
Message-ID: <fb249edb0906201637g4f0b3f52g62fdf221732321d9@mail.gmail.com>
In-Reply-To: <200906180210.39532.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3853863862476416364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/6/18 Denis Kenzior <denkenz@gmail.com>:
[...]
> Patch has been applied. =C2=A0Note that GET RESPONSE or the CSIM equivale=
nt is the
> only sane way to do this as we also need to support cyclical and record b=
ased
> files. =C2=A0Is there any other way to find out the total file size and t=
he record
> size on the Neo besides GET RESPONSE?
>
> For Record-Based files you can use CRSM=3D178,<file>,0,0,0 to find the re=
cord size,
> but not the total length of the file (e.g. how many records there are)
>
> If we can obtain this information, then we simply have to maintain a diff=
erent
> implementation when ti_calypso is used.

I've not found any way to get the total size or number of records
other than retrieving all records with
CRSM=3D178,<file>,<n>,4,<record-size> increasing <n> until we get an
error.  With what Stefan pointed out we can use +CSIM though, I'll
need to try it.

Regards

--===============3853863862476416364==--

