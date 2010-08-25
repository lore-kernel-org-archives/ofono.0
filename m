Content-Type: multipart/mixed; boundary="===============2463586298548843953=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: About ppp_receive()
Date: Wed, 25 Aug 2010 07:07:27 +0200
Message-ID: <1282712847.6841.44.camel@localhost.localdomain>
In-Reply-To: <4C749A91.5050203@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2463586298548843953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

> >>>> NO, just as the above have said ,we only negotiate two options, it's=
 ok
> >>>> for our PPP stack and it runs correctly.
> >>> Then I'm confused.  What is your concern here? :)
> >> currently, we worked on a Qualcomm CDMA chip, and it worked on a Relay =

> >> mode, just relay the air PPP packet to host, and in Ofono we should =

> >> support PFC to satisfy the spec (Sprint Spec.), But Ofono does not =

> >> support PFC, so comes this question.
> >>
> >>  From my personal point, Ofono should support PFC.
> > =

> > as you might have clearly figured from Denis and my responses, our PPP
> > code was designed to talk to a modem, not a network.
> > =

> > We don't want to implement a full blown PPP stack with all nasty
> > features. If this is needed for CDMA, because they push the PPP frames
> > over the air, then actually getting the kernel PPP frame processing
> > hooked up to our LCP and IPIP userspace code is the right thing to do
> > here.
> > =

> > At the moment we are not really putting additional energy into PPP since
> > it is a dying protocol in the GSM world. The networks never required it
> =

> I got it.
> =

> > and the modem hardware/firmware moves over to highspeed direct IP
> > interfaces.
> =

> I like to know this tech, is there any spec on this topic?

check oFono's Ericsson MBM or Option HSO support. Or Google for it.

Regards

Marcel



--===============2463586298548843953==--

