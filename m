Content-Type: multipart/mixed; boundary="===============8104197373822788995=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/5] Call Counters (2nd)
Date: Wed, 08 Dec 2010 13:28:16 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC02FA7E@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1291812092.4795.165.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8104197373822788995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > Because if your battery runs out in the middle of a 4 hour =

> conference
> > call, your timers are not updated and become worthless. Obviously,
> > this is a compromise between how reliable the counters are and how
> > many wakeups and IO we can bear.
> =

> I think this is not a good idea to have oFono handles this. Why can't
> the system daemon just shutdown all calls when the battery reaches
> critical limit.
> =

> You will never fully run down the battery anyway. One of the system
> health components in the system will prevent it and then can cleanly
> shutdown oFono and thus all calls. The only case where the =

> system could
> potentially misfunction in this area would be an emergency call. But
> that is a total different use case anyway.

There are other ways in which the device might reset without warning:
- hardware glitch triggering an involuntary reset
- software glitch triggering an involuntary reset
- device drops and battery connection is momentarily broken when it hits th=
e ground
- user rips out the battery in mid-use

While periodically syncing call and data counters to permanent memory is by=
 no means appealing, we have certain accuracy requirements for the stored c=
ounters. The only way those requirements can be met is by syncing the count=
ers to storage at reasonable intervals. Whether this should be part of oFon=
o is a matter for discussion, I guess, but at minimum we need to have the e=
nablers to do this.

	MikaL

--===============8104197373822788995==--

