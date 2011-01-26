Content-Type: multipart/mixed; boundary="===============1983558316857419137=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] netreg: Add CPHS CSP PLMN mode implementation
Date: Wed, 26 Jan 2011 12:48:25 +0100
Message-ID: <1296042505.1520.130.camel@aeonflux>
In-Reply-To: <AANLkTinrU2Mxym1=HrEqGmrSP6Lqn98Cs8aQ=taeRfQi@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1983558316857419137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > Just on a different thought here. The NETWORK_REGISTRATION_MODE_* is
> > local to src/network.c. We could just add the AUTO_ONLY mode there.
> >
> > The only downside I is see the already nasty init_registration_status
> > check, but that might be acceptable compared to crippling the string
> > conversion function.
> >
> > However at least the check would be clearly to just checking mode and
> > not mode + forced_mode.
> =

> I thought about this, but then we'd need more logic to when the user
> calls NetworkRegistration.Register() for automatic mode. That
> obviously can't change the mode. But perhaps this is now more
> manageable, since we got rid of Deregister(), which means there is
> just this one case to worry about.

can you have a stab at this and check how a patch would look like if we
just add another mode. If I am not mistaken we only have the extra code
in the init_registration_status. I could be wrong here since I have not
looked through that code in a long time.

Denis, any comments?

Regards

Marcel



--===============1983558316857419137==--

