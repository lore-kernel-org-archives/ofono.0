Content-Type: multipart/mixed; boundary="===============4957487325794366371=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v4 4/4] atmodem/lte: proto and authentication handling
Date: Mon, 15 Oct 2018 19:30:58 +0200
Message-ID: <CAKSBH7Fzwh6htg2mf4tcwXfs7CScXqzoLPUOxWP7qTQOztEkJg@mail.gmail.com>
In-Reply-To: <5785f114-4a21-1613-b98c-96be19d2f891@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4957487325794366371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis & Jonas,

On Mon, Oct 15, 2018 at 7:27 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Jonas,
>
> >> +
> >
> > The above isn't wrong, but I question the need for the atomic
> > constructs.  ofono isn't a thread-safe library.
> >
> > I see that there other uses of atomic accessors in the codebase, but I
> > believe these are remnants of a past approach with other ambitions...
> > Denis will set me right if I'm wrong about this because this mostly
> > predates my involvement with ofono. :)
>
> oFono was never thread safe, and as you point out, atomic operations are
> not really necessary.  But glib uses atomics for reference counting, so
> we stuck to that.  Also Marcel at some point evangelized that g_atomic
> is the one true way (TM) of implementing reference counting.
>
> With ell we don't use atomics at all.
>
> So given the above, I find both approaches acceptable.
>
> Regards,
> -Denis

Thank you both. I think I will keep this as it is then, and change the rest.
I will re-submit the series later.

Regards,
Giacinto

--===============4957487325794366371==--

