Content-Type: multipart/mixed; boundary="===============2344818999898601197=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Wed, 31 Mar 2010 01:55:41 +0300
Message-ID: <80fd4e751003301555y26bb4719sa6c69d24345cf6e3@mail.gmail.com>
In-Reply-To: <1269972166.11714.350.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2344818999898601197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/30 Marcel Holtmann <marcel@holtmann.org>:
>> >> > So I'm still having trouble understanding the issue. =C2=A0When oFo=
no calls
>> >> > disable, the driver is expected to take all necessary steps to disa=
ble the
>> >> > modem. =C2=A0If that means waiting N seconds after the command has =
been sent, so be
>> >> > it. =C2=A0During shutdown of the daemon, oFonod waits for a grace p=
eriod and waits
>> >> > on any devices that are being shut down. =C2=A0In effect it "hangs =
around" after
>> >> > power off.
>> >>
>> >> >> Another solution is to use sscd-like daemon also with ofono (the o=
Fono
>> >> >> Powered property would then just follow the power state of the mod=
em).
>> >> >
>> >> > Automatic powerup is actually possible from the driver. =C2=A0See H=
FP driver for
>> >> > details.
>> >> >
>> >> >> > We reply with the busy error, you're correct. =C2=A0However, I d=
on't really
>> >> >> > see anything better we can do here, do you have any suggestions?
>> >> >>
>> >> >> Keep the target state around somewhere, or call enable/disable
>> >> >> regardless of the current state of the Powered property?
>> >> >>
>> >> >
>> >> > Note that oFono does not record the powered preferences, ConnMan is
>> >> > responsible for that.
>> >> >
>> >> > Sending a disable when we are already disabled would be wrong and w=
ould break
>> >> > some plugins.
>> >> >
>> >> > And I'm still having trouble understanding why you want this. =C2=
=A0Please give
>> >> > concrete use-cases.
>> >>
>> >> Sure.
>> >>
>> >> I want Powered-1 that controls the atoms. Atoms should be loaded when
>> >> modem is in responsive state and removed when, e.g., modem reboots.
>> >> This we can do now, iow, if you connect a Nokia phone via USB, oFono
>> >> can follow its state via the MTC indications it sends on top of the
>> >> phonet link running over USB.
>> >>
>> >> I want Powered-2 that controls the modem power. When ofonod starts in
>> >> N900, it should power up the internal modem. When ofonod terminates
>> >> itself, it should shut down modem nicely before calling exit().
>> >>
>> >> Now, enable/disable/ofono_modem_set_powered() controls both aspects; I
>> >> want to separate them. It is also possible to implement Powered-2 in
>> >> the probe/remove methods; however, they are quite time-consuming
>> >> operations and best done from the mainloop.
>> >
>> > I am with Denis here. I am missing the point in what you are trying to
>> > achieve. The complexity you propose should not be exposed to the
>> > applications at all. This can be all handled internally. Or I am missi=
ng
>> > something essential, but right now, I don't see it.
>>
>> I'm trying to
>> 1) load atoms only after when isimodem is up and running and reset the
>> state of the isimodem atoms in case the isimodem reboots (or user
>> turns off a Nokia handset connected via USB)
>> 2) have asyncronous probe and remove
>> 3) separate rf state and availablity of the atoms, especially the SIM at=
oms.
>>
>> With the current enable/disable/ofono_modem_set_powered, I can do 1)
>> or 2), but not both. I can not do 3 at all.
>
> non of these should be solved via the D-Bus at all. Really this is
> internal modem specific details. You are approaching this wrongly.

1) and 2) are already done through D-Bus, only thing is missing is
oFono core properly supporting transitions between Powered false and
true.

> 1) If the modem reboots, then handle this inside the isimodem plugin of
> oFono.

It is already handled fine in core. isidriver calls
ofono_modem_set_powered(false) when it detects that isimodem reboots.
When modem is back in business, it calls
ofono_modem_set_powered(true).

Is there a particular reason why I should reinvent the wheel?

>No reason to involve userspace here. If the handset gets turned
> off, then the modem object just goes away.

What is the difference between modem object not being there at all and
modem object being there, but with Powered=3Dfalse?

With the current ofono core, removing the object path will also remove
the config information.

> 2) What do you mean by this. They are asynchronous.

Not in the master branch. enable() and disable() are async, probe()
and remove() are sync.

How the driver knows if the disable() is called because someone just
tried to set Powered=3Dfalse or if ofonod is terminating? In first case,
I just want modem to go standby (and flush the atoms) and keep the SIM
warmed up and ready, in the second case, driver should ask modem to do
proper power off and then does all the required jazz with the gpio
lines. It would be help much if disable() would indicate if "soft"
poweroff  or "hard" poweroff is required; likewise
ofono_modem_set_powered() could take enum with transitional states
(powering_on, powered_on, powering_off, powered_off + perhaps
something like powered_standby). If you don't feel like doing it, I'm
happy to contribute.

> 3) I don't understand this. We have pre-sim and post-sim functionality.
> If you RFKILL a radio it would be same as removing its object path. Or
> do you wanna access the SIM card while RFKILLed. What is that good for?

Nobody wants to re-enter the pin code if they exit flight mode. It
should be possible to spool SMSs while the device is in flight mode.

Is there any good reason to keep SIM offlimits?

> This is no reason to not integrate Phonet with RFKILL. RFKILL can kill
> the radio interface or the whole device. So if it chooses to take the
> device off the Phonet "bus", then that is fine as well.

How do you plan to rfkill USB modem with ttyACM*? If you don't, do you
plan to allow ofono application to effectively say AT+CFUN=3D0 via the
API? Whatever you plan, we can use same mechanism with isimodem.

-- =

Pekka.Pessi mail at nokia.com

--===============2344818999898601197==--

