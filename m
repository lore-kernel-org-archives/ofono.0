Content-Type: multipart/mixed; boundary="===============8827740556599092120=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/5] doc: Add documentation for 'forced-mode'
Date: Tue, 18 Jan 2011 21:31:07 +0100
Message-ID: <1295382667.3873.227.camel@aeonflux>
In-Reply-To: <AANLkTi=iRmh+ihG+9OHyx8p95v19tAAwE3sWOsnkTNBZ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8827740556599092120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> +                             "auto"         Network registration is p=
erformed
> >> +                                            automatically.
> >> +                             "forced-auto"  Network registration is p=
erformed
> >> +                                            automatically while manual
> >> +                                            selection is disabled.
> >
> > we need to discuss this a little bit. I am not sure using a mode of
> > forced auto is the best choice here.
> >
> > Maybe an extra property like "ManualAllowed" would be better. Thoughts?
> =

> The reason I ended up extending the Mode property was that once
> forced_auto is true, no other Mode than auto is anyway possible. So in
> a sense it is another type of Mode, which isn't to say a separate
> property wouldn't work equally well.
> =

> I'm really open to either option. The way the code is written makes it
> very easy to just expose this as a separate property.

the extra "forced-auto" mode feels kinda forced into this property. So
that is my main concern here.

However on the other hand the Mode property is actually read-only. If it
would be a user changeable property then it would be pretty clear that
we do not wanna intermix this here.

With this in mind, it might be just fine here from a UI interaction flow
point of view.

Denis, what is your take on this?

And while thinking about this, now I have another question. If this flag
is set on the SIM card, are you allowed to deregister from the network?

Regards

Marcel



--===============8827740556599092120==--

