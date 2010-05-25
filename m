Content-Type: multipart/mixed; boundary="===============5324092864185487921=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/9] Remove hack around hfp agent interface
Date: Tue, 25 May 2010 09:53:39 +0200
Message-ID: <1274774019.27220.119.camel@localhost.localdomain>
In-Reply-To: <20100525074952.GA2710@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5324092864185487921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> > In the past we did this dirty hack to quickly fix HFP for the release, =
now
> > fixing it in a proper way.
> > ---
> >  drivers/hfpmodem/hfpmodem.h |    1 -
> >  plugins/hfp.c               |   12 +++---------
> >  2 files changed, 3 insertions(+), 10 deletions(-)
> > =

> =

> =

> The first two were refused. The following patches still apply cleanly from
> here.

send the debug option change separately (and also for ConnMan of course)
and then the rest as its own series. Intermixing multiple patches of
different types is a bad idea since everybody gets lost at some point.

Regards

Marcel



--===============5324092864185487921==--

