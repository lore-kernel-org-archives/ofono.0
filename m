Content-Type: multipart/mixed; boundary="===============5702846293307427462=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 0/5] Call Counters (2nd)
Date: Wed, 08 Dec 2010 23:35:31 +0100
Message-ID: <1291847731.4795.204.camel@aeonflux>
In-Reply-To: <725063E4C37388418CDDC5A2C287906A20D08A19F8@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5702846293307427462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

> > So I am actually thinking that doing that inside PulseAudio is a lot
> > more efficient solution.
> > =

> > The idea is that PA already runs in the user session and has to monitor
> > the uplink/downlink state (and additionally could monitor call states
> > as well if needed). So it knows when a call is active and it is active
> > anyway doing the audio processing. So it could just then go ahead and
> > write your call accounting into Tracker.
> =

> Pulseaudio (or the meego PA modules for voice) isn't really an option =

> for at least the following reasons:
>  - lots of modems still handle all audio and PA will know nothing
>    about calls at all with these modems

actually Denis raised the same question, but then again this is for a
product specific requirement. And for that product we know that PA will
do the audio processing.

>  - PA does not really care about individual calls, but whether =

>    the audio traffic channel is connected or not
> 	- multi-call cases, cases were traffic channel is reconnected =

>         mid-call, etc, etc, PA simply does not know enough (and should
>         not)

And that is my point (see other email). This should be tracking talk
time and not individual call time. And thus it would be fitting nicely
into PA in that case.

> I guess this could be done in higher layers on top of oFono (telepathy-ri=
ng,
> dialer app, policy framework, etc), but I don't really know enough about
> the call timer stuff to comment on the pro/cons of this.

Important for me is to weight the extra costs of IO and CPU consumption
when doing this inside oFono. And since ofonod itself would actually not
wake up during a phone call, I think this is not a good fit.

It could be that PA is not a good candidate either, but to me it looks
like a pretty smart place to handle this.

Regards

Marcel



--===============5702846293307427462==--

