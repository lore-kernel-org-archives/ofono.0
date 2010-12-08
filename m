Content-Type: multipart/mixed; boundary="===============7147333282425741654=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH 0/5] Call Counters (2nd)
Date: Wed, 08 Dec 2010 22:02:31 +0100
Message-ID: <725063E4C37388418CDDC5A2C287906A20D08A19F8@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1291824722.4795.188.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7147333282425741654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 08 Dec 2010, Marcel Holtmann wrote:
> So I am actually thinking that doing that inside PulseAudio is a lot
> more efficient solution.
> =

> The idea is that PA already runs in the user session and has to monitor
> the uplink/downlink state (and additionally could monitor call states
> as well if needed). So it knows when a call is active and it is active
> anyway doing the audio processing. So it could just then go ahead and
> write your call accounting into Tracker.

Pulseaudio (or the meego PA modules for voice) isn't really an option =

for at least the following reasons:
 - lots of modems still handle all audio and PA will know nothing
   about calls at all with these modems
 - PA does not really care about individual calls, but whether =

   the audio traffic channel is connected or not
	- multi-call cases, cases were traffic channel is reconnected =

        mid-call, etc, etc, PA simply does not know enough (and should
        not)

I guess this could be done in higher layers on top of oFono (telepathy-ring,
dialer app, policy framework, etc), but I don't really know enough about
the call timer stuff to comment on the pro/cons of this.

br,
-- =

Kai Vehmanen


--===============7147333282425741654==--

