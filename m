Content-Type: multipart/mixed; boundary="===============6159654947672008520=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: [RFC PATCH 5/6] Support for concatenated SMS status report.
Date: Mon, 07 Jun 2010 16:02:25 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A52@jklmail01.ixonos.local>
In-Reply-To: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A51@jklmail01.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6159654947672008520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
> > Hi Pasi,
> >
> > > ---
> > >  include/history.h |    2 +
> > >  src/sms.c         |   67 ++++++++++++++++++++----
> > >  src/smsutil.c     |  152
> > >  +++++++++++++++++++++++++++++++++++++++++++++++++++++ src/smsutil.h
> > |
> > >   32 +++++++++++
> |
> > I suggest thinking about the data structure use some more.  In particul=
ar,
> > using a list of struct mr_numbers is very inefficient.  Using a pair of=
 bitmaps
> > for mr numbers (which can only be 0..255) would be way more efficient a=
nd
> > probably would make the code much easier to write.
> =

> I am not sure if I am quite getting what do you mean. Do you mean somethi=
ng
> like:
|
> Br,
> Pasi

OK, now I noticed that there's some bitmapping done in sms_assembly and
now I am beginning to get at least some kind of sense.

Br,
Pasi



--===============6159654947672008520==--

