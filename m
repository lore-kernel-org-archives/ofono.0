Content-Type: multipart/mixed; boundary="===============8181589322040165757=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 2/4] Core support for packet switched bearer reporting
Date: Mon, 10 Jan 2011 13:33:31 +0200
Message-ID: <201101101333.31577.remi.denis-courmont@nokia.com>
In-Reply-To: <4D273E7C.7080605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8181589322040165757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 07 January 2011 18:25:32 ext Denis Kenzior, you wrote:
> Hi R=C3=A9mi,
> =

> On 01/07/2011 10:02 AM, R=C3=A9mi Denis-Courmont wrote:
> > ---
> > =

> >  include/gprs.h |    2 ++
> >  src/gprs.c     |   32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 0 deletions(-)
> =

> please see the 'Submitting patches' section in HACKING

The rules are self-contradictory. Either the patch spreads multiple =

directories, or it breaks compilation.

For the sake of git-bisect'ing, I'd rather not break compilation.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============8181589322040165757==--

