Content-Type: multipart/mixed; boundary="===============7520410211003626007=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: [PATCH] rilmodem: Fix GPRS feature inavailable issue
Date: Thu, 14 Jan 2016 13:52:31 -0500
Message-ID: <5697EE6F.9030908@canonical.com>
In-Reply-To: <DA62CA5DDF4CA640AA25B1684E5D141102069F97@shsmsx102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7520410211003626007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/14/2016 01:14 AM, Zhang, Caiwen wrote:
> Hi tony,
>
> Thanks for your reply.
>
> In fact I have ever considered the way you mentioned. But l found in most=
 plugins, atoms (gprs, gprs_context, sms,
> call_forwarding ...) are created at post_sim phrase. It seems post_online=
 phrase is more reasonable. There should
> be some reason that the atom creation is brought forward. Does anyone kno=
w the reason?

Two other potential solutions...

1) Fix the modem/fw and/or rild implementation to allow querying of =

max_cids even when the radio is off.

2) It's doubtful that the number of cids available actually changes over =

time, so it might be acceptable to add a vendor quirk and just hard-code =

the value for this modem as is done with MTK modems.  A slightly more =

conservative approach would be to do this in the query_cids callback if =

the operation fails.

Regards,
/tony





--===============7520410211003626007==--

