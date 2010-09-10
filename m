Content-Type: multipart/mixed; boundary="===============4457779378844077127=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: RFC: Supporting STK without PDUs
Date: Fri, 10 Sep 2010 15:33:38 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C901145BEDBE@orsmsx508.amr.corp.intel.com>
In-Reply-To: <4C8AA55A.1090800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4457779378844077127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> We have already had a discussion on this one when designing the current
> stk modem API.  The bottom line is that oFono tries to keep its core <->
> modem interfaces minimal and exposing the entirety of stkutil.h as
> official API is definitely too much.
> =

> So right now you will need to re-encode into PDU form to support such
> modems (or ask the vendor to give the raw pdus)  While this is a bit of
> a performance hit, it isn't too bad as the PDUs are always smaller than
> 256 bytes.

In that case we would still want to use functionality from stkutil.c to do =
the actual re-encoding. So in my mind it is a trade-off between forking stk=
util.c for one or more modem-plugins or exporting stkutil.h Given that the =
type definitions in stkutil.h are a relative straightforward mapping of TS =
102.223 and friends, it may not qualify as a "minimal" API but it will be a=
 rather stable API. So I would like to ask to reconsider exposing the type =
definitions as part of the official oFono modem API.

Cheers,
Waldo

--===============4457779378844077127==--

