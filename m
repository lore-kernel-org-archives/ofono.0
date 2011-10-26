Content-Type: multipart/mixed; boundary="===============7697666177558207777=="
MIME-Version: 1.0
From: Jean Parpaillon <jean.parpaillon@free.fr>
Subject: Re: Ofono use
Date: Wed, 26 Oct 2011 13:17:17 +0200
Message-ID: <1319627837.3807.20.camel@talinn.home>
In-Reply-To: <4EA47705.4050404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7697666177558207777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 23 octobre 2011 =C3=A0 15:20 -0500, Denis Kenzior a =C3=A9crit :
> Hi Jean,
> =

> On 10/24/2011 04:44 AM, Jean Parpaillon wrote:
> > Hi all,
> > I am currently trying to use ofono and I can not get how to register the
> > modem in a reliable way.
> > When I detect a modem, I set org.ofono.Modem.Powered to True.
> > When SimManager interface is ready, I enter the pin.
> > Then, I set the modem org.ofono.Modem.Online to True.
> =

> So far so good...
> =

> > By the way, I wait for NetworkRegistration interface to be available.
> > When it is available, I wait for NetworkRegistration.Name to be non
> > empty to call NetworkRegistration.Register.
> > =

> =

> oFono will automatically register unless the Mode property is set to
> 'manual'.  So calling NetworkRegistration.Register is wholly pointless
> if you obtain a NetworkRegistration.Name.  That means you're already
> registered ;)
> =

> > The point is setting Online property usually end with a timeout. It is
> > the right workflow ? Must I look for other property ? =

> =

> What modem are you using?  In general Online should never result in a
> timeout...
> =


At the end, setting Online to True always end in error if I follow the
workflow described above. Error is:
- First time:
Error setting online: org.freedesktop.DBus.Error.NoReply: Did not
receive a reply. Possible causes include: the remote application did not
send a reply, the message bus security policy blocked the reply, the
reply timeout expired, or the network connection was broken.
- Then, if I retry before 30sec:
Error setting online: org.ofono.Error.InProgress: Operation already in
progress

If I stop my program and come back after a while, modem is registered.
Modem is Huawei 1752USB

> Regards,
> -Denis

Best regards,
Jean


--===============7697666177558207777==--

