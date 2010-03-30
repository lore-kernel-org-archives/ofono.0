Content-Type: multipart/mixed; boundary="===============4731209709658525829=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 08:45:02 -0700
Message-ID: <1269963903.11714.254.camel@localhost.localdomain>
In-Reply-To: <80fd4e751003300834t57552977r2355e01810ff8964@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4731209709658525829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> >> That is also a problem. The other problem is that the party
> >> controlling the modem power state is supposed to keep GPIO lines in
> >> known position for a while after the modem has indicated it has been
> >> powered down. In an N900 running maemo, a daemon called sscd does
> >> that. sscd exits only after modem has been safely powered down during
> >> reboot and shutdown. If ofonod does the controlling, it should hang
> >> around after power off for a while, too.
> >
> > So I'm still having trouble understanding the issue.  When oFono calls
> > disable, the driver is expected to take all necessary steps to disable =
the
> > modem.  If that means waiting N seconds after the command has been sent=
, so be
> > it.  During shutdown of the daemon, oFonod waits for a grace period and=
 waits
> > on any devices that are being shut down.  In effect it "hangs around" a=
fter
> > power off.
> =

> >> Another solution is to use sscd-like daemon also with ofono (the oFono
> >> Powered property would then just follow the power state of the modem).
> >
> > Automatic powerup is actually possible from the driver.  See HFP driver=
 for
> > details.
> >
> >> > We reply with the busy error, you're correct.  However, I don't real=
ly
> >> > see anything better we can do here, do you have any suggestions?
> >>
> >> Keep the target state around somewhere, or call enable/disable
> >> regardless of the current state of the Powered property?
> >>
> >
> > Note that oFono does not record the powered preferences, ConnMan is
> > responsible for that.
> >
> > Sending a disable when we are already disabled would be wrong and would=
 break
> > some plugins.
> >
> > And I'm still having trouble understanding why you want this.  Please g=
ive
> > concrete use-cases.
> =

> Sure.
> =

> I want Powered-1 that controls the atoms. Atoms should be loaded when
> modem is in responsive state and removed when, e.g., modem reboots.
> This we can do now, iow, if you connect a Nokia phone via USB, oFono
> can follow its state via the MTC indications it sends on top of the
> phonet link running over USB.
> =

> I want Powered-2 that controls the modem power. When ofonod starts in
> N900, it should power up the internal modem. When ofonod terminates
> itself, it should shut down modem nicely before calling exit().
> =

> Now, enable/disable/ofono_modem_set_powered() controls both aspects; I
> want to separate them. It is also possible to implement Powered-2 in
> the probe/remove methods; however, they are quite time-consuming
> operations and best done from the mainloop.

I am with Denis here. I am missing the point in what you are trying to
achieve. The complexity you propose should not be exposed to the
applications at all. This can be all handled internally. Or I am missing
something essential, but right now, I don't see it.

> It seems to me that Marcel thinks "Powered" should control the RF
> state, too. So, a separate property for enabling he RF would be nice,
> too.

That is what I call RFKILL and we have a proper subsystem for that. And
it is different from your Power-1 and Power-2 thing? Sorry, but you
really lost me now.

Regards

Marcel



--===============4731209709658525829==--

