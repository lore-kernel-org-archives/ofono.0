Content-Type: multipart/mixed; boundary="===============0009367353922916342=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Wed, 08 Dec 2010 18:49:44 +0200
Message-ID: <201012081849.45125.remi.denis-courmont@nokia.com>
In-Reply-To: <1291796025.25976.62.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0009367353922916342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 December 2010 10:13:45 ext Aki Niemi, you wrote:
> Hi R=C3=A9mi,
> =

> On Tue, 2010-12-07 at 18:12 +0200, ext R=C3=A9mi Denis-Courmont wrote:
> > More than one second delay over D-Bus is not unheard of, especially on
> > mobile devices. I don't see the point of sending _both_ the reception
> > timestamp and the original NITZ value, but I do see the point in sending
> > a value who transmission is not time-sensitive.
> =

> Over a second round trip delay? We're running the D-Bus daemon behind a
> GPRS link these days are we? ;)

No, we're running D-Bus on a busy device and a kernel with a suboptimal I/O =

scheduler (for our use cases). Not getting scheduled for several seconds is =

entirely possible.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0009367353922916342==--

