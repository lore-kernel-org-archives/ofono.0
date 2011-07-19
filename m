Content-Type: multipart/mixed; boundary="===============7834690054590684619=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Mobile broadband provider info plugin
Date: Tue, 19 Jul 2011 08:36:46 -0500
Message-ID: <4E25886E.8000700@gmail.com>
In-Reply-To: <4E25847B.1070401@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7834690054590684619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 07/19/2011 08:19 AM, Oleg Zhurakivskyy wrote:
> =

> Hello Denis,
> =

> On 07/18/2011 03:46 PM, Denis Kenzior wrote:
>> Are you sure? Briefly looking through serviceproviders.xml I only
>> noticed different plans within the same provider.  You might be right of
>> course, but even if you are, we have no way of distinguishing between a
>> different plan and a different APN type.
> =

> Hmm, now I am not sure. In a plugin the settings is the access point
> settings? If so, yes, there are multiple access points within the same
> provider in serviceproviders.xml. Or what kind of setting is meant?
> =


So oFono supports 3 context types:

- internet
- mms
- wap

Some (most?) providers use different APNs for these.  However, the
providers also have different service plans (e.g. pre-paid, gprs-only,
wap-only, etc)

So your database ends up needing to have settings for each provider,
each service plan for that provider and different context type settings
for each service plan.

To my understanding, with mobile-broadband-provider-info the best we can
do is provision the internet context only.

>> Option 2 sounds like the most likely candidate right now.  Option 3 is
>> the direction where we need mobile-broadband-provider-info to go in.  In
>> particular adding the internet/mms/wap tags and SPN entries to its
>> database.
> =

> OK, let's do option 2 for now and extend the
> mobile-broadband-provider-info. Could you please explain regarding the
> SPN entries, I am not sure if I understand this correct.
> =


This is there to handle MVNOs.  Basically you might have a provider (A)
that owns the network and a provider (B) that buys access to A's
network.  Both can administer different service plans (and have
different settings for APNs, etc).  In theory the MNC of provider B
should be different from that of A, however some countries / networks
are weird and have re-used provider's A MCC/MNC for subscribers of
provider B.

This is where the SPN comes in, since the MVNO is interested in
displaying their name to the customer, the SPN is nearly always provided
on the SIM.  In the case of the same MCC/MNC, the SPN can thus be used
to distinguish between provider A's settings and provider B's settings.

Regards,
-Denis

--===============7834690054590684619==--

