Content-Type: multipart/mixed; boundary="===============6125045040447930858=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Wed, 09 Jun 2010 15:21:29 -0700
Message-ID: <1276122089.2509.25.camel@localhost.localdomain>
In-Reply-To: <1274961405.3755.505.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6125045040447930858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-05-27 at 14:56 +0300, Aki Niemi wrote: =

> On Thu, 2010-05-27 at 13:39 +0200, ext Marcel Holtmann wrote: =

> > > I don't like this being an argument to SendMessage(). I think it needs
> > > to be exposed, but as a property instead. Is there a use case for
> > > setting this per message? I think majority of current phones either
> > > provide a global setting for this, or set it on by default.
> > =

> > our idea is actually that every new SMS has its own object path for its
> > lifetime. So we can have then properties easily on them.
> =

> Sure, but there should still be a property in SmsManager to control
> whether srr is to be set on outgoing messages.
> =

> Another property in the actual SmsMessage (residing on its own object
> path) could then indicate whether srr *was* set for that particular
> message when it was sent.

I tend to disagree with that; by making it an SmsManager property, you
are creating an API that is not reentrant. If more than one application
is sending SMS's at the same time and they have different requirements
wrt to status-reports, they would be trumping each other:

app A                                   app-B

smsmanager.status-reports =3D TRUE
                                      smsmanager.status-reports =3D FALSE
smsmanager.SendMessage(msg)  <--- OOPS
                                      smsmanager.SendMessage(msg)



--===============6125045040447930858==--

