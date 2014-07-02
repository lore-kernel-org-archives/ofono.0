Content-Type: multipart/mixed; boundary="===============9179607454271448565=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: Re: [PATCH v2 0/6] Add a driver for u-blox modems
Date: Wed, 02 Jul 2014 12:53:23 +0200
Message-ID: <20140702105323.GX33006@rincewind.trouble.is>
In-Reply-To: <53B1B61F.7070304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9179607454271448565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2014-06-30 14:10:23 (-0500), Denis Kenzior <denkenz@gmail.com> wrote:
> On 06/26/2014 01:28 PM, Philip Paeps wrote:
> > Changes since v1:
> > =

> >  o Fix coding style nits and useless casts
> >  o Use prefixes
> >  o Make enable go to CFUN=3D4 (powered but radio off)
> > =

> > =

> > Philip Paeps (6):
> >   atmodem: add vendor u-blox
> >   udevng: add detection logic for u-blox modems
> >   plugins: new driver for u-blox SARA-U270 modems
> >   sim: query u-blox PIN retries with AT+UPINCNT
> >   gprs: add support for u-blox +UREG URCs
> >   atmodem: set the auth method for u-blox modems
> > =

> >  Makefile.am                    |    3 +
> >  drivers/atmodem/gprs-context.c |   31 ++++-
> >  drivers/atmodem/gprs.c         |   44 ++++++
> >  drivers/atmodem/sim.c          |   45 +++++++
> >  drivers/atmodem/vendor.h       |    3 +-
> >  plugins/ublox.c                |  291 ++++++++++++++++++++++++++++++++=
++++++++
> >  plugins/udevng.c               |   42 ++++++
> >  7 files changed, 455 insertions(+), 4 deletions(-)
> >  create mode 100644 plugins/ublox.c
> > =

> =

> Can you rebase the rest of the patches in this series, they no longer
> apply cleanly and 3-way merge gets confused as well.

Sure, I'll take care of this today.

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============9179607454271448565==--

