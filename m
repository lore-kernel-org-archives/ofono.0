Content-Type: multipart/mixed; boundary="===============6089638829969952977=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] Fix: Username and Password must be set after context
 is created.
Date: Mon, 01 Feb 2010 13:41:04 -0800
Message-ID: <1265060464.31341.59.camel@localhost.localdomain>
In-Reply-To: <201002011320.04073.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6089638829969952977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > > And we might wanna check if MBM cards behave similar and ensure that
> > > > STE and MBM cards use a similar code flow.
> > >
> > > When testing this EIAAUW fails if there are no prior PDP context on t=
he
> > > modem. Most likely this is the case with the MBM module as well, but I
> > > have not tested this.
> > =

> > Then we have to do that in the callback in an extra step. I don't really
> > like it, but seems the way to go. Please send a patch that also changes
> > this for MBM devices. We really wanna keep these in sync.
> =

> Actually the easiest way to do this is simply queue the EIAAUW after the =

> CGDCONT in activate_context.  If CGDCONT fails then EIAAUW won't have any =

> effect anyway (but will get executed nevertheless).  This is better than =

> worrying about strduping username/password and freeing it in all possible=
 code =

> paths.

sounds good enough to me. Just wanna have STE and MBM in sync here. And
of course an extra comment that explain why we do it.

Sjur, care to send a patch?

Regards

Marcel



--===============6089638829969952977==--

