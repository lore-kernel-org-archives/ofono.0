Content-Type: multipart/mixed; boundary="===============5917828544121499703=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] Bearer documentation
Date: Mon, 10 Jan 2011 16:26:23 -0800
Message-ID: <1294705583.3873.3.camel@aeonflux>
In-Reply-To: <201101101834.55049.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5917828544121499703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > On Friday 07 January 2011 18:23:25 ext Denis Kenzior, you wrote:
> > >> The other question I have is whether we should report this at the
> > >> context level or at the ConnectionManager level.  Can different cont=
exts
> > >> truly have different bearers?
> > > =

> > > At least for 3G with HS*PA, I believe we can. In my understanding, HS=
PA
> > > channels are allocated per contexts. Correct me if I'm wrong.
> > =

> > I don't know, to me it would not make sense to allocate different
> > bearers per context, but I'm not an RF engineer.  Do note that at least
> > several vendors provide extension commands that report the global active
> > bearer, not per context.  For instance, see the Ericsson *CPSB command.=
..
> =

> The UI wants to show a single icon for the number of "G's". I would assum=
e =

> that's meant to address this use case. Then you don't need to iterate ove=
r all =

> contexts, especially those not allocated through that this particular AT =

> serial port.

I am confused by your answer.

So from what I understand so far it is that with AT modems the bearer
information is a per context information. So the real question is if
this is just an AT command thing of how they defined it or if it can be
really independent.

As Denis said, the vendor commands indicate that it is a global bearer
information. If one context is on HSPA, then others will be as well. So
how does ISI provide this information? Is it globally or per context?

Regards

Marcel



--===============5917828544121499703==--

