Content-Type: multipart/mixed; boundary="===============3847623766650289442=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Wed, 08 Dec 2010 09:44:12 +0100
Message-ID: <1291797852.4795.137.camel@aeonflux>
In-Reply-To: <1291552819.4795.121.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3847623766650289442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > > where is this timed running? I prefer the plugin just send a D-Bus
> > > message to the timed directly instead of a Get/Changed API kind of
> > > thing.
> > =

> > AFAIK, timed is in system bus. However, I fail to see how you can make
> > this any simpler. In the end, one of the two entities has to implement
> > a service that the other one uses. There also needs to be some
> > synchronization for when the entities start up. A getter/signal API is
> > also what timed uses in Harmattan, but of course if you have a better
> > idea, I'm all ears.
> =

> is timed actually open source and I can have a look at it?

so what about this? Where is the timed respository? I really wanna have
a look at it and see what it is doing.

Regards

Marcel



--===============3847623766650289442==--

