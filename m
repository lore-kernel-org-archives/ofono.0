Content-Type: multipart/mixed; boundary="===============3298667007966101261=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH 1/3] Mobile broadband provider info plugin
Date: Tue, 19 Jul 2011 16:19:55 +0300
Message-ID: <4E25847B.1070401@intel.com>
In-Reply-To: <4E242B30.201@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3298667007966101261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Denis,

On 07/18/2011 03:46 PM, Denis Kenzior wrote:
> Are you sure? Briefly looking through serviceproviders.xml I only
> noticed different plans within the same provider.  You might be right of
> course, but even if you are, we have no way of distinguishing between a
> different plan and a different APN type.

Hmm, now I am not sure. In a plugin the settings is the access point settin=
gs? =

If so, yes, there are multiple access points within the same provider in =

serviceproviders.xml. Or what kind of setting is meant?

> Option 2 sounds like the most likely candidate right now.  Option 3 is
> the direction where we need mobile-broadband-provider-info to go in.  In
> particular adding the internet/mms/wap tags and SPN entries to its databa=
se.

OK, let's do option 2 for now and extend the mobile-broadband-provider-info=
. =

Could you please explain regarding the SPN entries, I am not sure if I =

understand this correct.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============3298667007966101261==--

