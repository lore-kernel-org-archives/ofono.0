Content-Type: multipart/mixed; boundary="===============2085048506483188421=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Tue, 21 Dec 2010 07:18:43 -0800
Message-ID: <1292944723.2658.51.camel@aeonflux>
In-Reply-To: <AANLkTikMvR2pYbyg_d=S0+Ba8usaJyEyveU--MXViv_C@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2085048506483188421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >> +
> >> +/* ResetState requests resending of StateChange. */
> >> +#define MID_RESEND_STATE     "ResendState"
> >
> > This is a bad D-Bus API btw. Using a D-Bus method to trigger signal
> > sending. You will wake up any listener for that signal. What is wrong
> > with just having a GetState?
> =

> My problem is that I need to get the path, or modem serial-number if
> you like, to the
> modem(s). As I don't know the start order I have to query the state at st=
artup.
> So this will happens only once. The simples way for me to get the path is
> to send "ResendState" to path "/". This will then send the state info
> for all modem
> paths.
> =

> I don't think I have the path them available at connect...
> If you have any other ideas of how to query the modem instances I'm all e=
ars?

I think you need to resend the D-Bus API of your init daemon. I need to
have a second look.

Regards

Marcel



--===============2085048506483188421==--

