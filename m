Content-Type: multipart/mixed; boundary="===============6385063330872289336=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [RFC PATCH v3] gprs: add function to handle activated context
Date: Thu, 07 Apr 2011 16:47:55 +0100
Message-ID: <8281606748F03E4390BB98A3F47F2E948B3B116BE6@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4D9DB0CF.80800@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6385063330872289336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>
>So the spec says, ME PDN ACT can come even for an implicit context
>activation request associated with CGATT, which is the case with EPS.
>
>For 3G, if this happens (ME PDN ACT) for UE initiated activation of
>context, then the cid is already set with CGDCONT.
>
>For EPS this can happen for default context, where cid is not set with
>CGDCONT, but is in the range as returned by CGDCONT.
>
>Here the cid issue, because cid is managed by ofono and is never
>communicated to modem.  Probably to avoid sending too many CGDCONT's
>during startup. or is it something else?
>
>I thought the default context activation will come to TE as NW ACT, with
>a cid not in range of CGDCONT.
>

Exactly so the idea to avoid any issue was to call ofono_gprs_set_cid_range=
 from the driver with a range which doesn't include the CID used for initia=
l EPS context.
Normaly we know from the modem vendor which CID will be used for the initia=
l EPS context.

For instance if +CGDSCONT=3D? Is returning 1-25 as range then we call  ofon=
o_gprs_set_cid_range with 2-25 as range assuming that CID 1 will be used fo=
r the initial EPS context.

Redouane.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============6385063330872289336==--

