Content-Type: multipart/mixed; boundary="===============4625486649977036778=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Mon, 31 Jan 2011 13:52:28 +0100
Message-ID: <1296478348.1520.209.camel@aeonflux>
In-Reply-To: <5B2C0C388E5FAD42A7089E751CDCA9911F488F5EFB@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4625486649977036778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Miia,

> > why does the user have different needs here? Where are these needs
> > coming from?
> =

> You want real life user cases? :)
> =

> OK, I give you some. Personally nr 1 is my favourite one as that is such a
> common thing to happen.
> =

> 1) Have you ever been drunk and written stupid messages you really don't
> want to reach their destination the next day anymore if they have not
> already (maybe you wish they never would have reached the destination
> but all the mistakes can't be prevented..)
> =

> 2) You have a situation that you want to buy something important and
> there are two options of which you prefer other one. You can not reach
> the guy with preferred option via call so you send a message, but you
> want to be sure that you know the situation before the other offer
> closes. Of course the preferred option's seller expects you to make the
> commitment right away for purchase so text message can not be sent in
> vain. =

> =

> 3) Example from the wonderful world of Internet: =

> http://www.developershome.com/sms/sms_tutorial.asp?page=3DbasicConcepts

and what does this all buy you? There are so many funny ideas in GSM
that having nothing to do with reality anymore since the world has moved
on since 1995.

> > How does a normal user actually know what this means for him and the
> > network he is using? =

> The normal user knows this by reading the manual if he does not
> understand it directly when seeing the setting in the device. And if
> there is a chance that network does not support all features that device
> can offer, a disclaimer about that can be added to manual or help files.

This is the worst explanation ever. You might wanna talk to some user
interaction experts. They will tell you that they do exactly not want
this in a mobile device. It needs to self explanatory and your are not
suppose to read 600 pages of manual first.

I feel like being back in 1995 with my good old Nokia phone where I had
no clue what half of the options where doing for me ;)

> > Is the network actually honoring these values at
> > all these days
> Whether the network is honoring this case or not is not the issue here.
> If such would be the reason for dropping features then many things would
> never get completed when people would just discuss who should do what
> first. I have not met a situation at least in Finland where network does =
not
> support it, but I have not made comprehensive study about this. If the =

> network does not follow the request then that is a network issue and shou=
ld =

> be handled through other channels. The truth is that if oFono does not al=
low =

> this setting through the API, then devices using oFono have no means to =

> offer this choice to its users even if the network would support it.

And what would be the impact here with defaulting to the networks value?
It would just work fine and normally it all depends on the network
anyway. You can tell it to have 24 hours, but if it only wants to hold
it for 6 hours, then there is nothing you can do about. SMS is not a
reliable form of communication. I am pretty sure that all the terms of
service regarding SMS are phrased properly by the network operators.

Regards

Marcel



--===============4625486649977036778==--

