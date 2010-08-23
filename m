Content-Type: multipart/mixed; boundary="===============9028859003264090822=="
MIME-Version: 1.0
From: Steven <liu-dj@neusoft.com>
Subject: About ppp_receive()
Date: Mon, 23 Aug 2010 13:42:49 +0800
Message-ID: <4C720A59.5000504@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9028859003264090822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

In function ppp_receive, we first check the protocol type of this frame =

like:

  guint16 protocol =3D ppp_proto(buf);

and here we assumed the length of the protocol field is 16 bits, but in =

RFC 1661, the protocol field should be one or two octets.

"The Protocol field is one or two octets, and its value identifies
the datagram encapsulated in the Information field of the packet."

why we given the assumption that protocol field is 16 bit length?

In CDMA 2000 environment, just as the Sprint Network, PPP should support =

  a compressed protocol field. Is there anything difference between GSM =

and CDMA?

B.R

Steven

---------------------------------------------------------------------------=
------------------------
Confidentiality Notice: The information contained in this e-mail and any ac=
companying attachment(s) =

is intended only for the use of the intended recipient and may be confident=
ial and/or privileged of =

Neusoft Corporation, its subsidiaries and/or its affiliates. If any reader =
of this communication is =

not the intended recipient, unauthorized use, forwarding, printing,  storin=
g, disclosure or copying =

is strictly prohibited, and may be unlawful.If you have received this commu=
nication in error,please =

immediately notify the sender by return e-mail, and delete the original mes=
sage and all copies from =

your system. Thank you. =

---------------------------------------------------------------------------=
------------------------


--===============9028859003264090822==--

