Content-Type: multipart/mixed; boundary="===============2420438313213492581=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: About ppp_receive()
Date: Mon, 23 Aug 2010 11:12:45 +0200
Message-ID: <1282554765.23399.225.camel@localhost.localdomain>
In-Reply-To: <4C720A59.5000504@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2420438313213492581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

> In function ppp_receive, we first check the protocol type of this frame =

> like:
> =

>   guint16 protocol =3D ppp_proto(buf);
> =

> and here we assumed the length of the protocol field is 16 bits, but in =

> RFC 1661, the protocol field should be one or two octets.
> =

> "The Protocol field is one or two octets, and its value identifies
> the datagram encapsulated in the Information field of the packet."
> =

> why we given the assumption that protocol field is 16 bit length?
> =

> In CDMA 2000 environment, just as the Sprint Network, PPP should support =

>   a compressed protocol field. Is there anything difference between GSM =

> and CDMA?

in GSM we are not using PPP over the air interface. The PPP session is
only between oFono and the modem hardware. If CDMA also talks PPP over
the air interface then that would be really sad :(

Regards

Marcel



--===============2420438313213492581==--

