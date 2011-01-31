Content-Type: multipart/mixed; boundary="===============3094159869164482159=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Mon, 31 Jan 2011 16:44:38 +0100
Message-ID: <1296488678.1520.226.camel@aeonflux>
In-Reply-To: <1296485665.2158.85.camel@miia-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3094159869164482159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Miia,

> > and what does this all buy you? There are so many funny ideas in GSM
> > that having nothing to do with reality anymore since the world has moved
> > on since 1995.
> First of all, I don't think people stopped drinking and sending stupid
> messages after 1995. Or that no one does any personal commerce with
> questionable means any more. Are simple needs of a normal individual
> funny? I guess many of them are but still it always feels nice when you
> are able to get your needs met even if for someone else your need might
> not make sense. Not everyone wants same things.
>  =

> Of course if the aim here is to do an API that already decides in the
> lower level the options for the device manufacturers so they don't need
> to bother themselves with business decisions, then this is the way to
> go. Good luck with serving people-of-today who value options and freedom
> of choice. In the end, oFono is not providing the UI, if the device
> manufacturer does not want its users to have the option to change the
> validity period then they can omit the feature. But if this kind of
> features are not supported even in the oFono level, then what purpose
> does that serve? =


there is no point in supporting some dreamed up use case that you are
making up right now. You have no control over your SMS once it leaves
your mobile phone and got accepted by the network for submission. No
weird option is going to make this any better.

There is no control if the receiver has their mobile phone on or off.
And there is certainly no control over when the network will deliver the
SMS.

Same as you can not recall an email once it got delivered to the
receivers inbox. This is all just a wet dream ;)

> > This is the worst explanation ever. You might wanna talk to some user
> > interaction experts. They will tell you that they do exactly not want
> > this in a mobile device. It needs to self explanatory and your are not
> > suppose to read 600 pages of manual first.
> A user interaction expert would be clever enough hide the menu for the
> setting when it is not supported by the network. There are so many
> decisions that UI guys can do to make the feature self explainable. So I
> don't think it is required to drop the features only for the reason that
> maybe some networks don't support it. =


oFono's API is clearly about what makes sense to be exposed to the
actual user. It was never and will never be about adding any kind of
feature that you can dream of in the GSM world.

Until you really make a good case why the user should be exposed to such
an option, I don't see it.

So I am clearly in favor of sensible defaults here. But that is a
different story.

> > I feel like being back in 1995 with my good old Nokia phone where I had
> > no clue what half of the options where doing for me ;)
> Come on! :D Here we can go back to the fact that not everything must be =

> used that is available if you feel content as you are.

Actually exposing things that can not be used or the end user can not
make sense of is a pretty bad idea.

> > And what would be the impact here with defaulting to the networks value?
> > It would just work fine and normally it all depends on the network
> > anyway. You can tell it to have 24 hours, but if it only wants to hold
> > it for 6 hours, then there is nothing you can do about. SMS is not a
> > reliable form of communication. I am pretty sure that all the terms of
> > service regarding SMS are phrased properly by the network operators.
> What comes to SMS not being reliable, can you honestly say that you are =

> working to make a better phone but the features you support are not to
> trust? Anyway, even if the user can not do anything to the value when
> network does not support the setting, then is that enough reason to deny
> the option from everyone? =


I am not following here. What is an option good for if it does not give
anything to the user. In fact it could potentially be actually lying to
the user since we have no control whatsoever.

But hey, let me ask you this part. When did you ever changed that option
on your smartphone the last time. Maybe my last phone that had such an
option was the Nokia 6210 with the Bluetooth battery pack and even back
then it did not make sense to me.

Regards

Marcel



--===============3094159869164482159==--

