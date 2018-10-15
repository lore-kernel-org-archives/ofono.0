Content-Type: multipart/mixed; boundary="===============4496505836474964955=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v4 4/4] atmodem/lte: proto and authentication handling
Date: Mon, 15 Oct 2018 20:43:23 +0200
Message-ID: <CAKSBH7HZdtqskRCZ9YFELyD0XNx-Q5uSuk-b=Pe4+VcpRiCx-Q@mail.gmail.com>
In-Reply-To: <CAKSBH7Fzwh6htg2mf4tcwXfs7CScXqzoLPUOxWP7qTQOztEkJg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4496505836474964955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

would you please comment also on the mail series with subject:
  [RFC PATCH v6 x/1] lte: protocol and authentication for default ctx
which is the core atom for the lte series discussed here, so that I
don't resubmit the series just for spam.

Also, I would really appreciate a comment on the series:
  [RFC PATCH x/1] atmodem/lte: Gemalto vendor specific extension

and possibly the introduction of germaltomodem/voicecall. Series:
  [PATCH v3 x/2] Gemalto: support for voicecall

thank you,
Giacinto


On Mon, Oct 15, 2018 at 7:30 PM Giacinto Cifelli <gciofono@gmail.com> wro=
te:
>
> Hi Denis & Jonas,
>
> On Mon, Oct 15, 2018 at 7:27 PM Denis Kenzior <denkenz@gmail.com> wrote:
> >
> > Hi Jonas,
> >
> > >> +
> > >
> > > The above isn't wrong, but I question the need for the atomic
> > > constructs.  ofono isn't a thread-safe library.
> > >
> > > I see that there other uses of atomic accessors in the codebase, but I
> > > believe these are remnants of a past approach with other ambitions...
> > > Denis will set me right if I'm wrong about this because this mostly
> > > predates my involvement with ofono. :)
> >
> > oFono was never thread safe, and as you point out, atomic operations are
> > not really necessary.  But glib uses atomics for reference counting, so
> > we stuck to that.  Also Marcel at some point evangelized that g_atomic
> > is the one true way (TM) of implementing reference counting.
> >
> > With ell we don't use atomics at all.
> >
> > So given the above, I find both approaches acceptable.
> >
> > Regards,
> > -Denis
>
> Thank you both. I think I will keep this as it is then, and change the re=
st.
> I will re-submit the series later.
>
> Regards,
> Giacinto

--===============4496505836474964955==--

