Content-Type: multipart/mixed; boundary="===============2204200995972815282=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 2/2] ifxmodem: add enable/disable ctm support
Date: Wed, 12 Jan 2011 08:55:48 -0800
Message-ID: <1294851348.3873.105.camel@aeonflux>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802D59E62@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2204200995972815282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> > Now this is something I don't like at all. It is copied code from the
> > modem plugin. =

> =

> Its the same audio configuration code except that there is a new
> parameter added
> at the end of the parameter list for TTY case.

I really hate duplicating magic numbers in two places. Can we do this
without +XDRV for now and put a /* TODO mark */ in the code. I do need
to think about this audio settings handling a bit more.

So you might have to keep the +XDRV local in your code for testing, but
I'd rather get the other TTY logic in place and worry about the audio
stuff in a second round of patches.

> > Also if this is required, we might need to figure out a
> > complete different way of handling this. We can't have this
> > in two places since that means a full disconnect. Maybe
> > putting this into the audio settings atom might be better.
> > However before we can do anything, I have to understand the
> > semantics behind XDRV, normal voice calls and TTY calls.
> > =

> =

> Correct me if I'm wrong. If we move this to the audio settings atom,
> then I'm
> afraid that it will end up in used by only ifx modem. =


I am not following. This whole stuff is IFX specific. So yes, it will
only be used by IFX. All other vendors have to do their own stuff.

Regards

Marcel



--===============2204200995972815282==--

