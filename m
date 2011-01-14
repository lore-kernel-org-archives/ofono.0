Content-Type: multipart/mixed; boundary="===============4870005373696967066=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Fri, 14 Jan 2011 14:44:46 +0100
Message-ID: <1295012686.3873.141.camel@aeonflux>
In-Reply-To: <1295002007.2109.3.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4870005373696967066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> > > I was not sure if all MVNOs have their own MNC, but in any case some
> > > operators use different trade names. Off the top of my hat I know our
> > > local Finnish operators Elisa and Sonera use trade names like Kolumbus
> > > and TeleFinland, and their name shown in UI needs to be correct.
> > =

> > what does the name showing in the UI has to do with the provision data
> > for the GPRS contexts? I am missing your point here.
> =

> Isn't the 'name' property of a context shown in some UI (when user
> selects connection to open)?

so you wanna use the SPN to set the nice friendly name of the Context.
So far we just defaulted to "Internet" and "MMS" and did not bother any
further.

For example ConnMan actually takes that information from the network
registration and not from the context.

> And there might be cases where other context settings like APN is
> different with different trade names.

Is that really the case? Can this be used reliably?

Regards

Marcel



--===============4870005373696967066==--

