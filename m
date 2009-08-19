Content-Type: multipart/mixed; boundary="===============5313540544512349274=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Can't send second message in v0.3
Date: Wed, 19 Aug 2009 09:47:54 -0500
Message-ID: <200908190947.54960.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C130206BE7BBC@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5313540544512349274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi,
> Can't send second message in v0.3 version and latest version, but it's ok
> in v0.2. In phonesim can't reproduce this issue.
>
> Ofonod log: V0.3
> ofonod[9884]: csca_query_cb: 8613800210500, 145
> ofonod[9884]: Got 1 recipients
> ofonod[9884]: ref: 1, offset: 0
> ofonod[9884]: pdu_len: 20, tpdu_len: 19
> ofonod[9884]: tx_next: 0x9bee070
> ofonod[9884]: Got 1 recipients
> ofonod[9884]: ref: 2, offset: 0
> ofonod[9884]: pdu_len: 20, tpdu_len: 19

This is strange.  Can you set the OFONO_AT_DEBUG environment variable and r=
e-
run ofonod?

E.g. export OFONO_AT_DEBUG=3D1; ofonod -nd

Report the AT trace so I can understand what is happening.  Sounds like the =

modem is not sending the first fragment.

Regards,
-Denis


--===============5313540544512349274==--

