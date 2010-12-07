Content-Type: multipart/mixed; boundary="===============8215730523299777341=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Tue, 07 Dec 2010 18:12:27 +0200
Message-ID: <201012071812.27110.remi.denis-courmont@nokia.com>
In-Reply-To: <AANLkTimqcKbRrhthsa_PpgU2Gmhd+HRSS0qubTdAPB40@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8215730523299777341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 December 2010 09:51:57 ext Aki Niemi, you wrote:
> > Passing the time over D-Bus may cause extra drift/imprecision than we
> > already have. I wonder if it would make sense to provide not just the
> > current time but both:
> > - the current time for trivial programs, and
> > - the system boot time (i.e. nw_time - received) for smarter programs;
> >  this value cannot drift.
> =

> I remember we had similar argument in the past with the timed folks,
> which actually resulted in a much more convoluted API... I'm still not
> convinced time drift is a problem, since NITZ itself is accurate to
> the second.

> However, thinking about this, I actually don't see any value in
> providing a human readable time over D-Bus. No application should
> directly ask oFono for time, this is why timed is there to begin with.
> =

> So sending a plain time_t over D-Bus is actually sufficient. This
> leaves us with having to send timestamps over D-Bus, which is ugly.
> Can you explain how you see clock drift a problem here exactly?

More than one second delay over D-Bus is not unheard of, especially on mobi=
le =

devices. I don't see the point of sending _both_ the reception timestamp an=
d =

the original NITZ value, but I do see the point in sending a value who =

transmission is not time-sensitive.

And even if drift were not a problem, it's best to have an API that does =

fundamentally not suffer from the problem. Otherwise, you will need to just=
ify =

every second month why drift is a negligible issue.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============8215730523299777341==--

