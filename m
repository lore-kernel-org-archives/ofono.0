Content-Type: multipart/mixed; boundary="===============6055600336683982749=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 1/2] Expose voice call direction synchronously
Date: Wed, 12 Jan 2011 10:24:14 +0200
Message-ID: <201101121024.15408.remi.denis-courmont@nokia.com>
In-Reply-To: <4D2D38AC.9010901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6055600336683982749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 12 January 2011 07:14:20 ext Denis Kenzior, you wrote:
> Hi Kai,
> =

> On 01/11/2011 06:47 AM, Kai.Vehmanen(a)nokia.com wrote:
> > Hi,
> > =

> > On 10 Jan 2010, R=C3=A9mi Denis-Courmont wrote:
> >> Currently, the call direction can only be inferred from the signals.
> >> This adds a property to keep it visible also from GetCalls().
> > =

> > just adding one more do { ++votes; } while(0) for this.
> > telepathy-ring needs this as well when it is (re)started and there
> > are existing calls:
> > https://bugs.freedesktop.org/show_bug.cgi?id=3D32990
> =

> I'm still waiting for someone to give me a proper usecase for how the
> Dialer UI is going to use this information.

The dialer UI is not going to use GetCalls anyway. It is going to watch the =

signals, or place the call itself. So this question makes no sense.

I am not interested in playing politics on whether Telepathy should be used=
 or =

something, whether oFono should be the AT commands emulator or not, or whet=
her =

some operator or UI requirements make sense. I am interested in getting my =

work done.

We know this is required for TP-Ring and required for matd. Besides, it's t=
wo =

line, it's consistent and it's clear.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6055600336683982749==--

