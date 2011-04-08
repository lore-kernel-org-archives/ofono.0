Content-Type: multipart/mixed; boundary="===============2232141899725664304=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [RFC PATCH v3] gprs: add function to handle activated context
Date: Fri, 08 Apr 2011 14:34:47 +0100
Message-ID: <8281606748F03E4390BB98A3F47F2E948B3B116E8A@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4D9F07A0.9050900@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2232141899725664304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

>>> So the spec says, ME PDN ACT can come even for an implicit context
>>> activation request associated with CGATT, which is the case with EPS.
>>>
>>> For 3G, if this happens (ME PDN ACT) for UE initiated activation of
>>> context, then the cid is already set with CGDCONT.
>>>
>>> For EPS this can happen for default context, where cid is not set with
>>> CGDCONT, but is in the range as returned by CGDCONT.
>>>
>>> Here the cid issue, because cid is managed by ofono and is never
>>> communicated to modem.  Probably to avoid sending too many CGDCONT's
>>> during startup. or is it something else?
>>>
>>> I thought the default context activation will come to TE as NW ACT,
>with
>>> a cid not in range of CGDCONT.
>>>
>> Exactly so the idea to avoid any issue was to call
>ofono_gprs_set_cid_range from the driver with a range which doesn't
>include the CID used for initial EPS context.
>> Normaly we know from the modem vendor which CID will be used for the
>initial EPS context.
>>
>> For instance if +CGDSCONT=3D? Is returning 1-25 as range then we call
>ofono_gprs_set_cid_range with 2-25 as range assuming that CID 1 will be
>used for the initial EPS context.
>Ok so you are assuming that cid 1 will be always used for default
>context, and so this is work around for the issue.

The modem vendor should know which CID will be used for the initial default=
 context.
So the idea was to add a requirement in the implementation of the gprs driv=
ers that ofono_gprs_set_cid should be called with a range that's doesn't in=
clude the CID used for the initial default bearer.

From what I know there is nothing in the spec saying which CID to use for =
initial default context.
And there is no standard AT commands to specify settings to use for the ini=
tial default context (CID, APN, user , password , IPV4/IPV6/ IPV4V6 ...)

>Instead we could also expect it to have a unique id.
>
>I still feel that the default context should be a NW initiated context
>and will have a unique cid.

As Pessi said before the PDN connectivity request is UE initiated.

-- The problem is, the initial EPS context is initiated by mobile, not by t=
he network. The mobile sends a piggybacked PDN CONNECTIVITY REQUEST with th=
e initial attach request in order to initiate the initial EPS context. --

>Also why can't the context id management be done in modem instead of
>ofono?

What do you mean by context id management be done in the modem ?

Regards,
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


--===============2232141899725664304==--

