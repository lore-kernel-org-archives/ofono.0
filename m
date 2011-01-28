Content-Type: multipart/mixed; boundary="===============3184949374427503627=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC 1/5] gprs: Update documentation for IPv6
Date: Fri, 28 Jan 2011 13:49:16 +0100
Message-ID: <AANLkTi=wAzXyb7uqCCY-7sqhgoi_bSQeQAR1Kt6WoyVt@mail.gmail.com>
In-Reply-To: <1296058970-11815-2-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3184949374427503627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dict IPv6Settings [rea=
donly, optional]
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Holds all the IPv6 network settings.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 string Interface [readonly, optional]
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Holds the name of the IPv6 network inter=
face
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 used by this context (e.g. "ppp0" "usb0"=
).
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 For combined IPv4v6 context (3GPP rel 8)=
 the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 same network interface may be used for b=
oth
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPv4 and IPv6. IPv4 and IPv6 may also be
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offered via separate network interfaces.
> +

I think it would be nice if we could keep only one interface here.
It's a bit messy that the difference between R7 and R8
networks will be visible to the users like this.

So when in a R7 network the uplink traffic should be filtered into the
right ipv4 and ipv6 pdp-connection automagically.
I know STE will support this in the modem firmware.

If firmware doesn't support this perhaps this could also be handled
in the kernel drivers. This should be doable for phonet (and Caif),
maybe a little more tricky with ppp/pppd?

Regards,
Sjur

--===============3184949374427503627==--

