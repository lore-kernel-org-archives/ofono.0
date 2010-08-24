Content-Type: multipart/mixed; boundary="===============5440590351154277308=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: About ppp_receive()
Date: Tue, 24 Aug 2010 18:17:20 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352A45BB94@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C720A59.5000504@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5440590351154277308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Steven wrote:
> Hi,
> =

> In function ppp_receive, we first check the protocol type of this
> frame =

> like:
> =

>   guint16 protocol =3D ppp_proto(buf);
> =

> and here we assumed the length of the protocol field is 16 bits, but
> in =

> RFC 1661, the protocol field should be one or two octets.
> =

> "The Protocol field is one or two octets, and its value identifies
> the datagram encapsulated in the Information field of the packet."
> =

> why we given the assumption that protocol field is 16 bit length?

First I am not ppp expert. :-).

If you take look at pppd source code, main.c, get_input() also always fetch=
 two bytes 'protocol' for struct protent as well.

Can you give a case we failed in our ppp stack?

Thanks.
Zhenhua

> In CDMA 2000 environment, just as the Sprint Network, PPP should
>   support a compressed protocol field. Is there anything difference
> between GSM =

> and CDMA?
> =

> B.R
> =

> Steven
> =

> -------------------------------------------------------------------------=
--------------------------
> Confidentiality Notice: The information contained in this e-mail and
> any accompanying attachment(s) is intended only for the use of the
> intended recipient and may be confidential and/or privileged of
> Neusoft Corporation, its subsidiaries and/or its affiliates. If any
> reader of this communication is not the intended recipient,
> unauthorized use, forwarding, printing,  storing, disclosure or
> copying is strictly prohibited, and may be unlawful.If you have
> received this communication in error,please immediately notify the
> sender by return e-mail, and delete the original message and all
> copies from your system. Thank you.
> -------------------------------------------------------------------------=
--------------------------
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua

--===============5440590351154277308==--

