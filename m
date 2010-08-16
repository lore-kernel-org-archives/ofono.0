Content-Type: multipart/mixed; boundary="===============5517042251015657043=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 4/7] stemodem: Add Radio Settings to STE Modem
Date: Mon, 16 Aug 2010 18:36:39 +0200
Message-ID: <1281976600.23399.41.camel@localhost.localdomain>
In-Reply-To: <AANLkTi=rS3-6DFMDzOQiL1pfpQUTuHNnWpJxv5-=gBbC@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5517042251015657043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >> Changes since last patch set:
> >> o Moved updates to plugins/ste to separate patch.
> >> o Updated error handling.
> >> o Style issues.
> >>
> >>
> >>  Makefile.am                       |    4 +-
> >>  drivers/stemodem/radio-settings.c |  223 ++++++++++++++++++++++++++++=
+++++++++
> >>  drivers/stemodem/stemodem.c       |    2 +
> >>  drivers/stemodem/stemodem.h       |    2 +
> >>  4 files changed, 230 insertions(+), 1 deletions(-)
> >>  create mode 100644 drivers/stemodem/radio-settings.c
> >
> > is this identical to how MBM does it? If yes, then I prefer we add this
> > to drivers/mbmmodem/ and you just reference it. If not then I like to
> > see the MBM version of this and where it actually differs. Maybe a MBM
> > version with a STE quirk is better.
> =

> Actually this is not yet implemented by MBM, so I guess STE is master
> this time ;-)

I thought that part would be similar in both cards. Then I am fine with
this.

> > I prefer doing this in MBM since that modem driver was just the first.
> > There is no other preference here ;)
> =

> This actually raises one question. How should we handle version variation=
s from
> the same Modem vendor.
> The differences will be larger as we start adding support for LTE, and
> support different
> bearers (PC cards with USB and Modems with CAIF).
> Should we create more entries in the vendor enum, or do you have something
> else in mind?

We cross that bridge when we get to it.

Regards

Marcel



--===============5517042251015657043==--

