Content-Type: multipart/mixed; boundary="===============6889897048659118297=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: transition phase to DEAD when lcp finishes
Date: Mon, 10 May 2010 12:19:48 -0500
Message-ID: <201005101219.48429.denkenz@gmail.com>
In-Reply-To: <20100510100840.4f495736@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6889897048659118297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> On Mon, 10 May 2010 09:21:37 -0500
> =

> Denis Kenzior <denkenz@gmail.com> wrote:
> > Hi Kristen,
> >
> > > change the state to DEAD when lcp finishes.  This prevents us from
> > > calling our disconnect function again if we are already dead.
> >
> > I'm curious under what circumstances tlf gets called on LCP when we're
> > already down?
> =

> A timeout after sending a terminate ack causes a tlf and switches us
> to the STOPPED state.  disconnect function is called at tlf, and
> disconnect reason correctly set.  Then, our read watcher is destroyed and
> we signal down (transitions us to state STARTING) and close (calls tlf
> and transitions us to INITIAL).  Disconnect function is called with
> disconnect reason set to link dead.
> =


Ah yes, the silly Huawei hardware.  Sounds like we should ignore GAtIO =

disconnects when we're already in PPP_DEAD phase.

Regards,
-Denis

--===============6889897048659118297==--

