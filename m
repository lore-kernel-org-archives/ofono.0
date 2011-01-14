Content-Type: multipart/mixed; boundary="===============6554369575255232338=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Fri, 14 Jan 2011 15:58:50 +0200
Message-ID: <1295013530.2109.10.camel@jsaunama-desktop>
In-Reply-To: <1295012686.3873.141.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6554369575255232338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, 2011-01-14 at 14:44 +0100, ext Marcel Holtmann wrote:
> Hi Jukka,
> =

> > > > I was not sure if all MVNOs have their own MNC, but in any case some
> > > > operators use different trade names. Off the top of my hat I know o=
ur
> > > > local Finnish operators Elisa and Sonera use trade names like Kolum=
bus
> > > > and TeleFinland, and their name shown in UI needs to be correct.
> > > =

> > > what does the name showing in the UI has to do with the provision data
> > > for the GPRS contexts? I am missing your point here.
> > =

> > Isn't the 'name' property of a context shown in some UI (when user
> > selects connection to open)?
> =

> so you wanna use the SPN to set the nice friendly name of the Context.
> So far we just defaulted to "Internet" and "MMS" and did not bother any
> further.

Yes, that is how our previous UIs have done it, and I guess our UX
designers like it in the future too.

> For example ConnMan actually takes that information from the network
> registration and not from the context.
>
> > And there might be cases where other context settings like APN is
> > different with different trade names.
> =

> Is that really the case? Can this be used reliably?

Quick look at our operator database does indeed confirm that, there are
cases where different SPN maps to different APN.

--Jukka



--===============6554369575255232338==--

