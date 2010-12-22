Content-Type: multipart/mixed; boundary="===============6928995645328345121=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Wed, 22 Dec 2010 05:37:09 -0800
Message-ID: <1293025029.2658.70.camel@aeonflux>
In-Reply-To: <871v5aajzi.fsf@ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6928995645328345121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

> >>> Then I didn't look far back enough (or I'm simply blind).  But I still
> >>> prefer this to be inside the driver or HACKING.calypso for easier acc=
ess.
> >> =

> >> I am with you that this needs to be documented better than GIT commit
> >> logs.
> >> =

> >> However I do prefer doc/calypso-modem.txt and doc/ifx-modem.txt though
> >> since I don't wanna clutter the root directory.
> >> =

> >
> > Sounds good to me.
> =

> Cool.  Once I've worked out the simplest udev rule for calypso, I'll
> submit a patch to create doc/calypso-modem.txt to document that.
> =

> (I don't yet understand why it makes sense for calypso to be handled
> differently from other cases in plugins/ofono.rules, but I'm happy to
> trust that there is a good reason for this.)

the other cases come from an unique vendor and product ID. The Calypso
and also IFX modems are based on device nodes. These are not unique.
They are platform specific. Not all platform will have a Calypso modem
behind /dev/ttySAC0 for example.

Regards

Marcel



--===============6928995645328345121==--

