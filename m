Content-Type: multipart/mixed; boundary="===============1301173367771031116=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Wed, 09 Jun 2010 17:47:13 -0500
Message-ID: <201006091747.13739.denkenz@gmail.com>
In-Reply-To: <1276122089.2509.25.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1301173367771031116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> On Thu, 2010-05-27 at 14:56 +0300, Aki Niemi wrote:
> > On Thu, 2010-05-27 at 13:39 +0200, ext Marcel Holtmann wrote:
> > > > I don't like this being an argument to SendMessage(). I think it
> > > > needs to be exposed, but as a property instead. Is there a use case
> > > > for setting this per message? I think majority of current phones
> > > > either provide a global setting for this, or set it on by default.
> > >
> > > our idea is actually that every new SMS has its own object path for i=
ts
> > > lifetime. So we can have then properties easily on them.
> >
> > Sure, but there should still be a property in SmsManager to control
> > whether srr is to be set on outgoing messages.
> >
> > Another property in the actual SmsMessage (residing on its own object
> > path) could then indicate whether srr *was* set for that particular
> > message when it was sent.
> =

> I tend to disagree with that; by making it an SmsManager property, you
> are creating an API that is not reentrant. If more than one application
> is sending SMS's at the same time and they have different requirements
> wrt to status-reports, they would be trumping each other:

While you're 100% correct about a possible race condition, the reality is t=
hat =

nobody actually uses it this way.  It is just a setting buried somewhere in =

the Settings UI that the user maybe changes once in his lifetime.

There's no reason to burden everyone with sending a value (and storing / =

looking up its setting needlessly externally) that nobody really cares abou=
t.

Regards,
-Denis

--===============1301173367771031116==--

