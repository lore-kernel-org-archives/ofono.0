Content-Type: multipart/mixed; boundary="===============7724157390199376829=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Tue, 04 Jan 2011 00:30:52 -0800
Message-ID: <1294129852.5852.76.camel@aeonflux>
In-Reply-To: <87k4ilnkkq.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7724157390199376829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> > thinking about this a bit more and with the background that there is
> > already an existing public database, we might should just enable a
> > provision driver inside the oFono core.
> >
> > Meaning that we can have multiple implementations of different databases
> > with just different priorities. Each nicely separated in their own
> > plugin and we don't bother the oFono core with where to get the data
> > from. So my idea would be that the oFono core just asks to provision a
> > new context. If a plugin feels responsible, then it does so. If not then
> > it stays empty.
> =

> I like the idea. Simple to implement and we get maximum extensibility.
> =

> Are you willing to take a plugin into ofono git which would use
> mobile-broadband-provider-info database? Or should people maintain the pl=
ugins
> out of tree?

in general I would accept any of such plugins into the tree. However we
need to be a bit careful with the priority. And of course they need to
have some sort of usage.

What I expect to see in long term is that we have two or three different
formats. And they just differ because of the different vertical targets.

> For me the best would be to have all plugins in ofono tree and
> enable/disable them with configure switches.

I wanna use priorities and smart detection to use them. Nothing for the
user to configure. Just installing some extra packages should active its
usage. And yes, I want to make it possible to build all plugins at all
time.

Regards

Marcel



--===============7724157390199376829==--

