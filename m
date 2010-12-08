Content-Type: multipart/mixed; boundary="===============6161442487326491549=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Wed, 08 Dec 2010 10:13:45 +0200
Message-ID: <1291796025.25976.62.camel@tucson>
In-Reply-To: <201012071812.27110.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6161442487326491549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On Tue, 2010-12-07 at 18:12 +0200, ext R=C3=A9mi Denis-Courmont wrote:
> More than one second delay over D-Bus is not unheard of, especially on mo=
bile =

> devices. I don't see the point of sending _both_ the reception timestamp =
and =

> the original NITZ value, but I do see the point in sending a value who =

> transmission is not time-sensitive.

Over a second round trip delay? We're running the D-Bus daemon behind a
GPRS link these days are we? ;)

> And even if drift were not a problem, it's best to have an API that does =

> fundamentally not suffer from the problem. Otherwise, you will need to ju=
stify =

> every second month why drift is a negligible issue.

It's still a constant imprecision caused by D-Bus latency (round-trip in
the case timed used the getter), so I wouldn't call it "drift".

That said, I get your point, and providing a value estimating the device
boot-time, rooted in the system monotonic clock is indeed a good
approach.

+1

Cheers,
Aki





--===============6161442487326491549==--

