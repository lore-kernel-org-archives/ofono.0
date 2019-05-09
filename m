Content-Type: multipart/mixed; boundary="===============3483603244876252829=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Thu, 09 May 2019 09:29:04 -0500
Message-ID: <9324ddff-1a79-0fdf-4420-1f3ca6a3a494@gmail.com>
In-Reply-To: <CAHB-Pjmd+c-80fDJL6OFS71NUn3j8nFebZ_EK3ybk_n2SM2yeg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3483603244876252829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

<snip>

>>> Just wondering if we should combine the CREG and UREG status >>> in som=
e way, the problem is that UREG is not indicating roaming or =

not...>>>> So that sounds like a bug in the firmware.  Does ublox =

support +CEREG?> > Yes they support CEREG according to the AT spec. I =

have not looked> into the difference, do you have an executive, summary? ;)
For whatever reason 3GPP decided to separate each technology status into =

a separate command.  So sort of similar to +CGREG for GPRS, they added =

CEREG for E-EUTRAN, and there's a 5G version, etc.  I think the intent =

of the spec was to keep CREG backwards compatible and applicable to all =

techs, but somehow the modem firmware guys got this wrong.

> =

> It might be a firmware issue. I have seen multiple cases where it
> reports unknown but UREG =3D 7... AND the LTE context still works.
> =


Ah wonderful.  I'd complain to the vendor.

Regards,
-Denis


--===============3483603244876252829==--

