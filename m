Content-Type: multipart/mixed; boundary="===============3152232588309422998=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 18:24:09 -0500
Message-ID: <201003301824.09951.denkenz@gmail.com>
In-Reply-To: <80fd4e751003301555y26bb4719sa6c69d24345cf6e3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3152232588309422998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> >> I'm trying to
> >> 1) load atoms only after when isimodem is up and running and reset the
> >> state of the isimodem atoms in case the isimodem reboots (or user
> >> turns off a Nokia handset connected via USB)
> >> 2) have asyncronous probe and remove
> >> 3) separate rf state and availablity of the atoms, especially the SIM
> >> atoms.
> >>
> >> With the current enable/disable/ofono_modem_set_powered, I can do 1)
> >> or 2), but not both. I can not do 3 at all.
> >
> > non of these should be solved via the D-Bus at all. Really this is
> > internal modem specific details. You are approaching this wrongly.
> =

> 1) and 2) are already done through D-Bus, only thing is missing is
> oFono core properly supporting transitions between Powered false and
> true.

So I just checked again, and we remove all atoms when turning off (even if =
off =

subsequently fails).  So I really don't see a need to expose the transition =

(e.g. going up, going down) as a property.  How do you want to use this =

information?

> =

> > 1) If the modem reboots, then handle this inside the isimodem plugin of
> > oFono.
> =

> It is already handled fine in core. isidriver calls
> ofono_modem_set_powered(false) when it detects that isimodem reboots.
> When modem is back in business, it calls
> ofono_modem_set_powered(true).
> =

> Is there a particular reason why I should reinvent the wheel?
> =


From your earlier posts it wasn't clear that you're happy with how this wor=
ks.  =

I perceived that there was some issue... =


> >No reason to involve userspace here. If the handset gets turned
> > off, then the modem object just goes away.
> =

> What is the difference between modem object not being there at all and
> modem object being there, but with Powered=3Dfalse?

Think of it conceptually as a USB device being in an off state but still on=
 the =

bus.  You still know the device is attached, even if it is of limited use.  =

Remember that we use this to populate remote bluetooth devices, modems =

configured via modemconf and udev/netlink.  This conveys presence and poten=
tial =

usability.

> =

> With the current ofono core, removing the object path will also remove
> the config information.

What are you using the config information for?  It is possible that we shou=
ld =

implement ofono_modem_unregister that would keep around the non-driver bits=
 of =

the modem object.  So far I have not done so because I saw no need...

> =

> > 2) What do you mean by this. They are asynchronous.
> =

> Not in the master branch. enable() and disable() are async, probe()
> and remove() are sync.

probe and remove are sync for a reason, the core is going to become extreme=
ly =

complicated otherwise.  Been there and done that, so you better have a very =

good reason for wanting this.

> =

> How the driver knows if the disable() is called because someone just
> tried to set Powered=3Dfalse or if ofonod is terminating? In first case,
> I just want modem to go standby (and flush the atoms) and keep the SIM
> warmed up and ready, in the second case, driver should ask modem to do
> proper power off and then does all the required jazz with the gpio
> lines. It would be help much if disable() would indicate if "soft"
> poweroff  or "hard" poweroff is required; likewise

This can be added, but the question is are you sure you need it?  None of t=
he =

other hardware we have would benefit from this functionality at all.  This =

immediately raises the question of usefulness.  Are you sure this isn't bet=
ter =

accomplished by a specific plugin for your system as discussed elsewhere in =

this thread?

> ofono_modem_set_powered() could take enum with transitional states
> (powering_on, powered_on, powering_off, powered_off + perhaps
> something like powered_standby). If you don't feel like doing it, I'm
> happy to contribute.

Again, usecase please.  How are you going to use this information?

> =

> > 3) I don't understand this. We have pre-sim and post-sim functionality.
> > If you RFKILL a radio it would be same as removing its object path. Or
> > do you wanna access the SIM card while RFKILLed. What is that good for?
> =

> Nobody wants to re-enter the pin code if they exit flight mode. It
> should be possible to spool SMSs while the device is in flight mode.
> =

> Is there any good reason to keep SIM offlimits?

Please note that if your enable/disable behavior only shuts the rx/tx circu=
its =

then repeating PIN entry won't be a problem.  And I already commented on th=
is =

elsewhere in the thread.

All I ask is that before we start adding tons of properties we first make s=
ure =

the user can actually use them intelligently,  that there is an actual (not =

just perceived) use case.

Regards,
-Denis

--===============3152232588309422998==--

