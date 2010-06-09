Content-Type: multipart/mixed; boundary="===============4668309311954820347=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Wed, 09 Jun 2010 16:29:52 -0700
Message-ID: <1276126192.2509.28.camel@localhost.localdomain>
In-Reply-To: <201006091747.13739.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4668309311954820347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-06-09 at 17:47 -0500, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > On Thu, 2010-05-27 at 14:56 +0300, Aki Niemi wrote:
> > > On Thu, 2010-05-27 at 13:39 +0200, ext Marcel Holtmann wrote:
> > > > > I don't like this being an argument to SendMessage(). I think it
> > > > > needs to be exposed, but as a property instead. Is there a use ca=
se
> > > > > for setting this per message? I think majority of current phones
> > > > > either provide a global setting for this, or set it on by default.
> > > >
> > > > our idea is actually that every new SMS has its own object path for=
 its
> > > > lifetime. So we can have then properties easily on them.
> > >
> > > Sure, but there should still be a property in SmsManager to control
> > > whether srr is to be set on outgoing messages.
> > >
> > > Another property in the actual SmsMessage (residing on its own object
> > > path) could then indicate whether srr *was* set for that particular
> > > message when it was sent.
> > =

> > I tend to disagree with that; by making it an SmsManager property, you
> > are creating an API that is not reentrant. If more than one application
> > is sending SMS's at the same time and they have different requirements
> > wrt to status-reports, they would be trumping each other:
> =

> While you're 100% correct about a possible race condition, the reality is=
 that =

> nobody actually uses it this way.  It is just a setting buried somewhere =
in =

> the Settings UI that the user maybe changes once in his lifetime.

If you are confident this will never be a problem then *shrug*; I am
just not comfortable with generic unconstrained APIs that operate like
that.



--===============4668309311954820347==--

