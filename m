Content-Type: multipart/mixed; boundary="===============2923726861306369726=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Wed, 09 Jun 2010 18:11:14 -0700
Message-ID: <1276132274.2182.74.camel@localhost.localdomain>
In-Reply-To: <1276126192.2509.28.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2923726861306369726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> > > > > > I don't like this being an argument to SendMessage(). I think it
> > > > > > needs to be exposed, but as a property instead. Is there a use =
case
> > > > > > for setting this per message? I think majority of current phones
> > > > > > either provide a global setting for this, or set it on by defau=
lt.
> > > > >
> > > > > our idea is actually that every new SMS has its own object path f=
or its
> > > > > lifetime. So we can have then properties easily on them.
> > > >
> > > > Sure, but there should still be a property in SmsManager to control
> > > > whether srr is to be set on outgoing messages.
> > > >
> > > > Another property in the actual SmsMessage (residing on its own obje=
ct
> > > > path) could then indicate whether srr *was* set for that particular
> > > > message when it was sent.
> > > =

> > > I tend to disagree with that; by making it an SmsManager property, you
> > > are creating an API that is not reentrant. If more than one applicati=
on
> > > is sending SMS's at the same time and they have different requirements
> > > wrt to status-reports, they would be trumping each other:
> > =

> > While you're 100% correct about a possible race condition, the reality =
is that =

> > nobody actually uses it this way.  It is just a setting buried somewher=
e in =

> > the Settings UI that the user maybe changes once in his lifetime.
> =

> If you are confident this will never be a problem then *shrug*; I am
> just not comfortable with generic unconstrained APIs that operate like
> that.

please keep in mind that we are on purpose not going to expose anything
just for the sake of having an API for it. The API must make sense from
an UI use case point of view. oFono is suppose to do all the heavy
lifting and this also means that we are not exposing every single detail
or possibility of GSM/UMTS.

I would even go one step further in this case and always request status
reports and if the user doesn't want them, then it can throw this kind
of information away.

So there might be cases where we are wrong in the first place, but that
is fine as well. This is a learning experience that we have to go
through to create proper APIs. This API design by committee is not
working out anyway. It just creates clutter and extra shim layers since
everything gets way too complicated. The idea is to have a really simple
API first and then only if needed introduce complexity.

Regards

Marcel



--===============2923726861306369726==--

