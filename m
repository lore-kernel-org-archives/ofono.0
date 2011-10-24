Content-Type: multipart/mixed; boundary="===============4533431340508386224=="
MIME-Version: 1.0
From: Jean Parpaillon <jean.parpaillon@free.fr>
Subject: Re: Ofono use
Date: Mon, 24 Oct 2011 17:48:39 +0200
Message-ID: <1319471319.32429.150.camel@talinn.home>
In-Reply-To: <4EA47705.4050404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4533431340508386224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
Thak you all for your answer.

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


Noted :)

> > The point is setting Online property usually end with a timeout. It is
> > the right workflow ? Must I look for other property ? =

> =

> What modem are you using?  In general Online should never result in a
> timeout...
> =


I am using a Huawei 1752 USB dongle.
After some time, modem is online, but I sometimes got a timeout. Really
precise, isn't it ? ;)

The really point now is I wanted to make voice calls but it appears that
this modem come with voice call feature disabled by default. Arggg.

> Regards,
> -Denis

Thanks again,
Jean


--===============4533431340508386224==--

