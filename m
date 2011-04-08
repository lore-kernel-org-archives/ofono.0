Content-Type: multipart/mixed; boundary="===============2827224394732076764=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: [RFC PATCH v3] gprs: add function to handle activated context
Date: Fri, 08 Apr 2011 16:03:28 +0300
Message-ID: <4D9F07A0.9050900@nokia.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948B3B116BE6@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2827224394732076764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane,

>
>> So the spec says, ME PDN ACT can come even for an implicit context
>> activation request associated with CGATT, which is the case with EPS.
>>
>> For 3G, if this happens (ME PDN ACT) for UE initiated activation of
>> context, then the cid is already set with CGDCONT.
>>
>> For EPS this can happen for default context, where cid is not set with
>> CGDCONT, but is in the range as returned by CGDCONT.
>>
>> Here the cid issue, because cid is managed by ofono and is never
>> communicated to modem.  Probably to avoid sending too many CGDCONT's
>> during startup. or is it something else?
>>
>> I thought the default context activation will come to TE as NW ACT, with
>> a cid not in range of CGDCONT.
>>
> Exactly so the idea to avoid any issue was to call ofono_gprs_set_cid_ran=
ge from the driver with a range which doesn't include the CID used for init=
ial EPS context.
> Normaly we know from the modem vendor which CID will be used for the init=
ial EPS context.
>
> For instance if +CGDSCONT=3D? Is returning 1-25 as range then we call  of=
ono_gprs_set_cid_range with 2-25 as range assuming that CID 1 will be used =
for the initial EPS context.
Ok so you are assuming that cid 1 will be always used for default =

context, and so this is work around for the issue.

Instead we could also expect it to have a unique id.

I still feel that the default context should be a NW initiated context =

and will have a unique cid.

Also why can't the context id management be done in modem instead of ofono?

Regards
Arun



--===============2827224394732076764==--

