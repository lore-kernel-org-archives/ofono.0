Content-Type: multipart/mixed; boundary="===============8020352594187700596=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RFC] AGPS Support
Date: Wed, 03 Nov 2010 19:40:41 +0200
Message-ID: <AANLkTimt4=Gkh9K1Xh4qckTKKO+WqacdmtJJuf_Jaubd@mail.gmail.com>
In-Reply-To: <AANLkTi=Oj=Ok9_QQsu+xhK+jF0fbSbpcxX4Qdu6f7xNK@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8020352594187700596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/11/3 Sjur Br=C3=A6ndeland <sjurbren@gmail.com>:
> I was previously under the false impression that you wanted oFono API
> to export AGPS functionality using dbus types only. Piping the AGPS
> XML (or ASN.1 coded data)
> through oFono certainly makes the oFono implementation much simpler.
> I'm all for that :-)

I think it has been the working assumption to just forward raw data
over D-Bus; PDU as an array of bytes. I believe the ISI modem
interface exposes raw ASN.1 PDUs directly.

Obviously we need to pick one format for the D-Bus interface, but I'm
a little wary of transcoding between the two formats, be it in the
core or in the drivers.

Cheers,
Aki

--===============8020352594187700596==--

