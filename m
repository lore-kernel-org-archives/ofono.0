Content-Type: multipart/mixed; boundary="===============0227590297103194319=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: RFC: Supporting STK without PDUs
Date: Sat, 11 Sep 2010 01:08:43 +0200
Message-ID: <1284160123.20451.16.camel@aeonflux.t-mobile.de>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C901145BEDBE@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0227590297103194319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > We have already had a discussion on this one when designing the current
> > stk modem API.  The bottom line is that oFono tries to keep its core <->
> > modem interfaces minimal and exposing the entirety of stkutil.h as
> > official API is definitely too much.
> > =

> > So right now you will need to re-encode into PDU form to support such
> > modems (or ask the vendor to give the raw pdus)  While this is a bit of
> > a performance hit, it isn't too bad as the PDUs are always smaller than
> > 256 bytes.
> =

> In that case we would still want to use functionality from stkutil.c to d=
o the actual re-encoding. So in my mind it is a trade-off between forking s=
tkutil.c for one or more modem-plugins or exporting stkutil.h Given that th=
e type definitions in stkutil.h are a relative straightforward mapping of T=
S 102.223 and friends, it may not qualify as a "minimal" API but it will be=
 a rather stable API. So I would like to ask to reconsider exposing the typ=
e definitions as part of the official oFono modem API.

what is the big deal with just using the PDU interface of the IFX
firmware? Why go through all this trouble if your target modem actually
does support PDU mode?

Regards

Marcel



--===============0227590297103194319==--

