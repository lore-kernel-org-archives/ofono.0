Content-Type: multipart/mixed; boundary="===============8303130446827310548=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 11:02:46 -0700
Message-ID: <1269972166.11714.350.camel@localhost.localdomain>
In-Reply-To: <80fd4e751003300940m1a6d9005se0de6e0de03f6e49@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8303130446827310548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> >> > So I'm still having trouble understanding the issue.  When oFono cal=
ls
> >> > disable, the driver is expected to take all necessary steps to disab=
le the
> >> > modem.  If that means waiting N seconds after the command has been s=
ent, so be
> >> > it.  During shutdown of the daemon, oFonod waits for a grace period =
and waits
> >> > on any devices that are being shut down.  In effect it "hangs around=
" after
> >> > power off.
> >>
> >> >> Another solution is to use sscd-like daemon also with ofono (the oF=
ono
> >> >> Powered property would then just follow the power state of the mode=
m).
> >> >
> >> > Automatic powerup is actually possible from the driver.  See HFP dri=
ver for
> >> > details.
> >> >
> >> >> > We reply with the busy error, you're correct.  However, I don't r=
eally
> >> >> > see anything better we can do here, do you have any suggestions?
> >> >>
> >> >> Keep the target state around somewhere, or call enable/disable
> >> >> regardless of the current state of the Powered property?
> >> >>
> >> >
> >> > Note that oFono does not record the powered preferences, ConnMan is
> >> > responsible for that.
> >> >
> >> > Sending a disable when we are already disabled would be wrong and wo=
uld break
> >> > some plugins.
> >> >
> >> > And I'm still having trouble understanding why you want this.  Pleas=
e give
> >> > concrete use-cases.
> >>
> >> Sure.
> >>
> >> I want Powered-1 that controls the atoms. Atoms should be loaded when
> >> modem is in responsive state and removed when, e.g., modem reboots.
> >> This we can do now, iow, if you connect a Nokia phone via USB, oFono
> >> can follow its state via the MTC indications it sends on top of the
> >> phonet link running over USB.
> >>
> >> I want Powered-2 that controls the modem power. When ofonod starts in
> >> N900, it should power up the internal modem. When ofonod terminates
> >> itself, it should shut down modem nicely before calling exit().
> >>
> >> Now, enable/disable/ofono_modem_set_powered() controls both aspects; I
> >> want to separate them. It is also possible to implement Powered-2 in
> >> the probe/remove methods; however, they are quite time-consuming
> >> operations and best done from the mainloop.
> >
> > I am with Denis here. I am missing the point in what you are trying to
> > achieve. The complexity you propose should not be exposed to the
> > applications at all. This can be all handled internally. Or I am missing
> > something essential, but right now, I don't see it.
> =

> I'm trying to
> 1) load atoms only after when isimodem is up and running and reset the
> state of the isimodem atoms in case the isimodem reboots (or user
> turns off a Nokia handset connected via USB)
> 2) have asyncronous probe and remove
> 3) separate rf state and availablity of the atoms, especially the SIM ato=
ms.
> =

> With the current enable/disable/ofono_modem_set_powered, I can do 1)
> or 2), but not both. I can not do 3 at all.

non of these should be solved via the D-Bus at all. Really this is
internal modem specific details. You are approaching this wrongly.

1) If the modem reboots, then handle this inside the isimodem plugin of
oFono. No reason to involve userspace here. If the handset gets turned
off, then the modem object just goes away.

2) What do you mean by this. They are asynchronous.

3) I don't understand this. We have pre-sim and post-sim functionality.
If you RFKILL a radio it would be same as removing its object path. Or
do you wanna access the SIM card while RFKILLed. What is that good for?

> >> It seems to me that Marcel thinks "Powered" should control the RF
> >> state, too. So, a separate property for enabling he RF would be nice,
> >> too.
> >
> > That is what I call RFKILL and we have a proper subsystem for that.
> =

> Huh? How do you plan to rfkill a modem behind serial line (over
> bluetooth? over USB? over SSI?)? Should we add a kernel driver for all
> the modems? How do you plan to solve the interaction between ofonod at
> commands and the rfkill driver?
> =

> Phonet is just a glorified serial line with binary protocol. Kernel
> drivers do not care what is at the other end of that serial line.
> There are gpio lines to wake up the thing at the end of serial line;
> gpio lines have their own kernel driver. That is all we need from
> kernel.

This is no reason to not integrate Phonet with RFKILL. RFKILL can kill
the radio interface or the whole device. So if it chooses to take the
device off the Phonet "bus", then that is fine as well.

Regards

Marcel



--===============8303130446827310548==--

