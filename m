Content-Type: multipart/mixed; boundary="===============4460206729751958567=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Thu, 01 Apr 2010 12:14:50 +0300
Message-ID: <k2m80fd4e751004010214r8f0ca85dx3675b4a02eacf505@mail.gmail.com>
In-Reply-To: <201003301824.09951.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4460206729751958567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/3/31 Denis Kenzior <denkenz@gmail.com>:
>>
>> 1) and 2) are already done through D-Bus, only thing is missing is
>> oFono core properly supporting transitions between Powered false and
>> true.
>
> So I just checked again, and we remove all atoms when turning off (even i=
f off
> subsequently fails). =C2=A0So I really don't see a need to expose the tra=
nsition
> (e.g. going up, going down) as a property. =C2=A0How do you want to use t=
his
> information?

I want to prevent core from exiting while a modem is in transitional
state. Before ofonod terminates, it calls disable and waits until
Powered gets false. I'd rather change Powered to false immediately
(when modem shutdown starts) but still keep waiting until modem is
properly powered down.

>> > 1) If the modem reboots, then handle this inside the isimodem plugin of
>> > oFono.
>>
>> It is already handled fine in core. isidriver calls
>> ofono_modem_set_powered(false) when it detects that isimodem reboots.
>> When modem is back in business, it calls
>> ofono_modem_set_powered(true).
>>
>> Is there a particular reason why I should reinvent the wheel?

> From your earlier posts it wasn't clear that you're happy with how this w=
orks.
> I perceived that there was some issue...

It seems to me that Marcel and Aki want to control TX power with the
Powered property. (BTW, there already is a post-sim mechanism to
control the RX/TX, namely Register/Deregister.)

>> >No reason to involve userspace here. If the handset gets turned
>> > off, then the modem object just goes away.
>>
>> What is the difference between modem object not being there at all and
>> modem object being there, but with Powered=3Dfalse?
>
> Think of it conceptually as a USB device being in an off state but still =
on the
> bus. =C2=A0You still know the device is attached, even if it is of limite=
d use.
> Remember that we use this to populate remote bluetooth devices, modems
> configured via modemconf and udev/netlink. =C2=A0This conveys presence an=
d potential
> usability.

That sounds sensible.

>> With the current ofono core, removing the object path will also remove
>> the config information.
>
> What are you using the config information for? =C2=A0It is possible that =
we should
> implement ofono_modem_unregister that would keep around the non-driver bi=
ts of
> the modem object. =C2=A0So far I have not done so because I saw no need...

Currently I'm using config to determine if the isimodem should or
should not control the modem and which phonet device it should or
should not use. It is used to determine if ofonod is run with maemo5
cellular daemons or without them.

>> > 2) What do you mean by this. They are asynchronous.
>>
>> Not in the master branch. enable() and disable() are async, probe()
>> and remove() are sync.
>
> probe and remove are sync for a reason, the core is going to become extre=
mely
> complicated otherwise. =C2=A0Been there and done that, so you better have=
 a very
> good reason for wanting this.

>> How the driver knows if the disable() is called because someone just
>> tried to set Powered=3Dfalse or if ofonod is terminating? In first case,
>> I just want modem to go standby (and flush the atoms) and keep the SIM
>> warmed up and ready, in the second case, driver should ask modem to do
>> proper power off and then does all the required jazz with the gpio
>> lines. It would be help much if disable() would indicate if "soft"
>> poweroff =C2=A0or "hard" poweroff is required; likewise
>
> This can be added, but the question is are you sure you need it? =C2=A0No=
ne of the
> other hardware we have would benefit from this functionality at all. =C2=
=A0This
> immediately raises the question of usefulness. =C2=A0Are you sure this is=
n't better
> accomplished by a specific plugin for your system as discussed elsewhere =
in
> this thread?

You don't seem to handle modem resets at all. Once atdriver gets so
far, other hardware will benefit, too.

>> ofono_modem_set_powered() could take enum with transitional states
>> (powering_on, powered_on, powering_off, powered_off + perhaps
>> something like powered_standby). If you don't feel like doing it, I'm
>> happy to contribute.
>
> Again, usecase please. =C2=A0How are you going to use this information?

* clean handling of modem reboots
* keep modem powered while ofonod is running, power it down before ofonod e=
xits
* allow applications to put modem on standby by with Powered property
(however, with N900 modem, the standby is not different from the
pre-sim state)

>> > 3) I don't understand this. We have pre-sim and post-sim functionality.
>> > If you RFKILL a radio it would be same as removing its object path. Or
>> > do you wanna access the SIM card while RFKILLed. What is that good for?
>>
>> Nobody wants to re-enter the pin code if they exit flight mode. It
>> should be possible to spool SMSs while the device is in flight mode.
>>
>> Is there any good reason to keep SIM offlimits?
>
> Please note that if your enable/disable behavior only shuts the rx/tx cir=
cuits
> then repeating PIN entry won't be a problem. =C2=A0And I already commente=
d on this
> elsewhere in the thread.
>
> All I ask is that before we start adding tons of properties we first make=
 sure
> the user can actually use them intelligently, =C2=A0that there is an actu=
al (not
> just perceived) use case.

In principle, the current D-Bus API is ok. It could be useful to
indicate the reason why modem cannot be Powered (fatal sw or hw
failure, selftest failure) but that might be better communicated
out-of-ofono.

What we miss from the core is a way to do asynchronous cleanup
(separate from Powered). A shutdown() method in modem driver and
corresponding callback, like ofono_modem_shutdown_ready(). This way we
can do what ever N900 requires us to do and there is no need to touch
other drivers.

-- =

Pekka.Pessi mail at nokia.com

--===============4460206729751958567==--

