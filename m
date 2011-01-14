Content-Type: multipart/mixed; boundary="===============2312512896353406795=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Fri, 14 Jan 2011 15:10:27 +0100
Message-ID: <1295014227.3873.144.camel@aeonflux>
In-Reply-To: <1295013530.2109.10.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2312512896353406795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> > > > > I was not sure if all MVNOs have their own MNC, but in any case s=
ome
> > > > > operators use different trade names. Off the top of my hat I know=
 our
> > > > > local Finnish operators Elisa and Sonera use trade names like Kol=
umbus
> > > > > and TeleFinland, and their name shown in UI needs to be correct.
> > > > =

> > > > what does the name showing in the UI has to do with the provision d=
ata
> > > > for the GPRS contexts? I am missing your point here.
> > > =

> > > Isn't the 'name' property of a context shown in some UI (when user
> > > selects connection to open)?
> > =

> > so you wanna use the SPN to set the nice friendly name of the Context.
> > So far we just defaulted to "Internet" and "MMS" and did not bother any
> > further.
> =

> Yes, that is how our previous UIs have done it, and I guess our UX
> designers like it in the future too.

I would advise the UI against using the name from the context
information and better using the one from the network registration
instead.

The context gets only provisioned once. So any update of the network
name can not be reflected later on by provisioning. It would have to be
a manual step. And operators are known to changing their names. When
using network registration this would just work fine.

Regards

Marcel



--===============2312512896353406795==--

