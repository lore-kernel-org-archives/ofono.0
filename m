Content-Type: multipart/mixed; boundary="===============2522725076160512733=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v0 1/5] doc: Add bearer property
Date: Fri, 02 Dec 2011 06:10:17 -0600
Message-ID: <4ED8C029.80808@gmail.com>
In-Reply-To: <4EDC9F8D.30107@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2522725076160512733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>> The 1X and EVDO registration status is already handled by the
>> NetworkRegistration interface (namely Strength for 1X and DataStrength
>> for EV-DO).
> =

> As we propose this "bearer" property for GSM into connman-api.txt, why
> don't we for CDMA?
> It would be easier to have same property in GSM and CDMA to recover the
> info at network panel level for instance to display technology used.

Because Bearer property for ConnectionManager for GSM is different.  It
is a dynamic property that changes based on network resource allocation.
 The NetworkRegistration Technology property is simply an indication of
what technology the network cell supports.  Hence the rather different
set of values between the two.

> =

> We have the same kind of information into network.c namely "technology",
> should we add this property also into cdma-netreg.c?
> I saw it in a TODO into network-api.txt:
> [...]
> string Technology [readonly, optional]
> =

>             Contains the technology of the current network.
> =

>             The possible values are: "gsm", "edge", "umts", "hspa",
>                             "lte"
> =

>             TODO: Values for CDMA and EVDO based networks.
> [...]
> We have to add the values into common.h, right?

Nope, that TODO is just stale and has been removed.

> =

>> Whether we need an SVDO indicator is another question entirely, but it
>> definitely does not belong in ConnectionManager.  All SVDO indicates is
>> whether data + voice are possible simultaneously.
>>
> =

> Can't we specify at least the technology?

Perhaps, but right now this seems like a convenience feature and very
low on the priority list.  I'd rather we implement the current API
proposal first in its entirety before rushing off to define new APIs.

Regards,
-Denis

--===============2522725076160512733==--

