Content-Type: multipart/mixed; boundary="===============2246096885949714162=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Mon, 03 Jan 2011 17:00:17 +0200
Message-ID: <201101031700.17266.remi.denis-courmont@nokia.com>
In-Reply-To: <1293072292.9439.8.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2246096885949714162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 23 December 2010 04:44:52 ext Marcel Holtmann, you wrote:
> So the idea of having an oFono D-Bus API to export time information is
> just wrong from my point of view. The plugin inside oFono should tell
> the time daemon about this.

That would be race-prone by design. For all we know, the time daemon might =
be =

started after oFono (or restarted). It's pretty basic design to have a gett=
er =

and a change signal for any kind of value.

Besides, I find hard-coding The One time daemon in the oFono plugin rather =

silly. It's really nothing but an arbitrary design limitation that would be =

overcome with a clean D-Bus API like we proposed several times.

> And not the time daemon go out and bother
> with additional sources etc.

Last time I checked, NTP clients "go out and bother" to ask the configured =
NTP =

server, not the other way around. I fail to see reason why oFono should wor=
k =

the other way around. I do see several reasons why it should not.

> And if you take the normalized time based on a monotonic clock, such a
> plugin that just send a D-Bus message to a time daemon is actually a lot
> simpler than exposing a full blown D-Bus interface.

It's very marginally simpler: one signal against one signal plus one getter =

that will share much marshalling code with the signal. But that's irrelevan=
t. =

It actually works. The sole signal design is broken.

> So the plugin just has to store the normalized time in memory. And if a
> time daemon is present, then send out an update if needed, otherwise
> don't bother.

Oh? That would actualy be far more complicated, as the plugin would then ne=
ed =

to track down the presence of the time daemon. I see some contradiction her=
e.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============2246096885949714162==--

