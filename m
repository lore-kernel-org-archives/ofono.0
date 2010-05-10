Content-Type: multipart/mixed; boundary="===============1519060797489285720=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] ppp: transition phase to DEAD when lcp finishes
Date: Mon, 10 May 2010 10:08:40 -0700
Message-ID: <20100510100840.4f495736@kcaccard-MOBL3>
In-Reply-To: <201005100921.38197.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1519060797489285720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 10 May 2010 09:21:37 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Kristen,
> =

> > change the state to DEAD when lcp finishes.  This prevents us from
> > calling our disconnect function again if we are already dead.  =

> =

> I'm curious under what circumstances tlf gets called on LCP when we're al=
ready =

> down?

A timeout after sending a terminate ack causes a tlf and switches us
to the STOPPED state.  disconnect function is called at tlf, and =

disconnect reason correctly set.  Then, our read watcher is destroyed and
we signal down (transitions us to state STARTING) and close (calls tlf
and transitions us to INITIAL).  Disconnect function is called with
disconnect reason set to link dead.

--===============1519060797489285720==--

