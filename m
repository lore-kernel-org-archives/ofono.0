Content-Type: multipart/mixed; boundary="===============8090068498229522141=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Can't send second message in v0.3
Date: Wed, 19 Aug 2009 22:10:10 -0500
Message-ID: <200908192210.11656.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C130206BE7C94@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8090068498229522141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> ofonod[15312]: Got 1 recipients
> ofonod[15312]: ref: 1, offset: 0
> ofonod[15312]: pdu_len: 22, tpdu_len: 21
> ofonod[15312]: tx_next: 0x8b8a248
> ofonod[15312]: > AT+CMGS=3D21\r
> ofonod[15312]: < AT+CMGS=3D21\r
> ofonod[15312]: < \r\n>
> ofonod[15312]: > 0011000B813118567873F20000A707EDF27C1E3E9701<CtrlZ>
> ofonod[15312]: < 0011000B813118567873F20000A707EDF27C1E3E9701<CtrlZ>
> ofonod[15312]: < \r\n+CMGS: 124
> ofonod[15312]: < \r\nOK\r\n
> ofonod[15312]: Got 1 recipients
> ofonod[15312]: ref: 2, offset: 0
> ofonod[15312]: pdu_len: 22, tpdu_len: 21
>

Are you sure this worked before on this modem?

> ofonod[15312]: < \r\n+CMGS: 124
> ofonod[15312]: < \r\nOK\r\n

This line tells me the modem is not a compliant 27.007 modem as there's no =

terminating \r\n on the CMGS.  The default parser is extremely strict and =

ignores this input.  A slightly tweaked parser is required for this device.

Regards,
-Denis

--===============8090068498229522141==--

