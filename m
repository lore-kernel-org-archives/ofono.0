Content-Type: multipart/mixed; boundary="===============3280924393761387348=="
MIME-Version: 1.0
From: Jussi Kukkonen <jku@linux.intel.com>
Subject: Re: RFC: API for Neighbouring Cell Info
Date: Sun, 31 Jan 2010 13:11:01 +0200
Message-ID: <4B656545.1020509@linux.intel.com>
In-Reply-To: <1264782563.19283.825.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3280924393761387348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

First, as a general comment: if this sort of info was available, I'd =

definitely use it (see http://github.com/jku/geoclue/commits/new-stuff =

for a first version using currently available API). Neighbor cell info =

would make non-complete cell location databases so much more useful...

Aki Niemi wrote:
> pe, 2010-01-29 kello 16:56 +0100, ext Denis Kenzior kirjoitti:
>> Honestly I don't like either approach, the Agent pattern would be a
>> much better fit here.  This would allow us to specify =

>> the polling/update interval and stop neighbor cell updates when no one
>> is interested in them.
> =

> In my experience, the positioning guys don't need periodic updates at
> all. The data needs to be fetched on demand. Like whenever the user
> starts up a location-aware application.

I'm willing to bet this is a chicken-egg problem: Why design software =

that uses periodic location updates if they aren't available?

Only exposing plain polling is fine if it makes sense in a powersaving =

(and api simplicity) sense: a version of periodic updating can always be =

implemented at the position service (geoclue) level if it seems useful.

  - Jussi


--===============3280924393761387348==--

