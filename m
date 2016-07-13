Content-Type: multipart/mixed; boundary="===============8824462119300519326=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: designated way for modems disappearing from bus during +CFUN=1
Date: Wed, 13 Jul 2016 14:47:33 -0500
Message-ID: <57869AD5.9000505@gmail.com>
In-Reply-To: <20160713182742.GC5596@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8824462119300519326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Harald,

On 07/13/2016 01:27 PM, Harald Welte wrote:
> Hi Denis,
>
> some context - not that it matters much for this discussion -:
> In order to test the various Osmocom components implementing GSM/3G
> network elements, we are putting together a physical setup with 128
> modems and 16 different base stations, all connected over wired coaxial
> cables, with digital step attenuators, etc.

Neat!

>
> The purpose of ofono in this setup is to control lots of modems attached
> to a PC, which then runs python software (osmo-gsm-tester) executing a
> test suite using the dbus interface towards ofono, as well as various
> other interfaces to our Osmocom GSM components.
>
> On the one hand, we want to use plenty of identical modems at the same
> time for parallel testing  / load testing with reproducible result.  On
> the other hand, we will be using plenty of different modem models (and
> are actually developing carrier boards for 12 mPCIe modems each right
> now), in order to test interoperability with as many different baseband
> processors, protocol stack vendors, protocol stack versions, etc.
>
> For this to work, we need to make sure that the d-bus interactions on
> the modem side actually perform the respective actions on the radio
> interface.

Sure, makes sense.

>
> This is of course a use case for which ofono was not primarily written,
> but it is a *very* good candidate, given it's comprehensive dbus
> interfaces for virtually every possible feature of a device (not just
> the common simple voice call or sms cases, but also including
> supplementary services, SIM toolkit, ...
>
> The expectation is that low-level operations like changing the modem
> onlie state trigger the corresponding transaction on the network (IMSI
> ATTACH / IMSI DETACH).  From our experience with ofono and some Sierra
> and Gemalto modems, the way how the drivers use the modems does not
> reliably guarantee that.

oFono expects modem drivers to guarantee 3 broad states:

disabled (Powered=3D0, Online=3D0) - Sim Card off, TX/RX circuits off
enabled (Powered=3D1, Online=3D0) - Sim card reader on, TX/RX circuits off
online (Powered=3D1, Online=3D1) - full functionality

How the modem handles things like IMSI attach / detach is specific to =

the firmware.  (Some companies might even consider specifics a secret).

>
> Also, the drivers seem to have tremendous problems with dealing properly
> with modem boot-up.  Most modems have some unsolicited indications
> telling you when the AT interpreter is ready, when the SIM card is
> available, when the phonebook has been read, when the SMS have been
> read, etc.

That could be just the modems you're picking.  Some of the modems out =

there have better firmware implementations that others.  I think in =

general Sierra has a lower quality driver in oFono than say Ericsson or =

uBlox.  But that can be fixed with a bit of work.

>
> At least with those modems tested, ofono did not reliably behave due to
> deficiencies particularly in the early start up of a modem, and when
> repeatedly going through cycles of enable/online/offline/disable.
>
> So for every modem model we use, we need to clean this up.  However,
> given that we are not ofono experts, and given that there is no actual
> documentation on how the start-up of an ofono driver should deal with
> the momdem (which interface should be bound when, in which order, ...)
> it has been rather hard.
>

Understandable, but there are no real rules.  It all depends on what the =

hardware can do.  oFono core just sends requests to the driver.  It is =

up to the driver to figure out how AT channel multiplexing is setup, =

etc.  Generally the rule of thumb is 1 AT channel for commands + 1 =

high-speed interface.  Or 1 AT channel for commands + 1 for PPP.  If =

your hardware supports multiple active contexts, then you'd need =

multiple high-speed interfaces.  Combinations of high-speed + PPP are =

also possible.  Then some AT modems have dedicated GPS interfaces, etc.

> A 100% reliable behavior is important.  ofono crashing and re-starting
> due to modem driver interoperability issues would mean that a test case
> fails, which in turn means that jenkins will report a test failure on
> the respective commit to Osmocom that triggered execution of the test in
> the first place.

Yep, but sometimes this is something we can't even control.  Modem =

firmware is notoriously buggy itself.

>
> The first-genreation hardware (not built by us) had 16 SL8082 attached
> over UART, using quad-usb-serial chips. Using the USB path one could set
> up persistent device names and then bind ofono on top.
>
> The second hardware works with banks of 16 SL8082 modems each, so the
> minimal configuration is one ofono process talking to 16 SL8082 over
> USB.  And here is where the devices disappear from the bus when going
> through CFUN=3D1.
>
> On Wed, Jul 13, 2016 at 12:09:31PM -0500, Denis Kenzior wrote:
>>
>> The best way to deal with this is not to have the modem reset :)  Does
>> Sierra Wireless have any extensions to turn off this behavior?
>
> But a lot of modems keep internal state unless you fully reset them.  So
> we actually have a storng incentive to make sure that no state is kept
> between two executions of test cases, so doing a real reset actually is
> what you want.

Understood.  But triggering a reset on CFUN=3D1 is not the way to do it. =

In the context of oFono, online_modem is supposed to simply activate =

RX/TX circuits + whatever logic in the modem to connect to a network. =

enable_modem is supposed to turn the SIM card on.

>
> Having built devices with GSM/UMTS modems that constantly roam around
> the planet abort marine vessels, visiting dozens to hundreds of cellular
> networks every month and modems getting locked up in weird states, doing
> full modem resets is a very desirable feature in all applications
> requiring reproducible/reliable behavior.

Can you do it when powering the device down?

>
>>> Examples for this are e.g. the Sierra Wireless SL808x series of modems,
>>> where this behavior is documented and expected.  But I'm sure there are
>>> others, at least I recall having seen this several times in the past.
>>
>> Generally this isn't done by the modems.  Some will physically power off
>> when you send them a CFUN=3D0.  Then you'd need to replug the USB cable.
>
> Well, if we talk about a consumer-grade USB stick: yes.  But as soon as
> you talk about industrial/M2M modems, you usually just have to pull the
> PWRON pin or something thta is conneted to the pin which usually
> connects the PMIC of the baseband processor to the physical on-switch of
> the device.  All connectorized or solder-type GMS/UMTS modems I've seen
> of any vendor offer that option.

Yep.  Properly integrated devices are easier.  But then there's no USB =

bus in the way.  You generally just 'know' that a modem is there.  No =

hotplug, etc.  The modem detection is also more or less static =

configuration.

>
>>> It is somewhat logical, as a +CFUN+1 is supposed to reset _all_ of the
>>> status in the modem, not just the protocol stack. So the fact that most
>>> modems don't disappear from the bus afterwards actually means that they
>>> are cheating.
>>
>> No, it means they are sane.
>
> I beg to differ, but Sierra and I seem to have the minority opinion
> there.
>
>> Many modem manufacturers use a second parameter to CFUN, which tells
>> the modem whether to reset or not.  E.g. CFUN=3D1,1 to cause a full
>> reset.
>
> Sierra has that, too - but the modem is still often performing a full
> reset. Probably because they simply want to be safe.  Rather reset too
> much state, than too little.
>

Possible, but Sierra might want to read 27.007.  CFUN=3D1 should not reset =

by default.

  <rst>: integer type
0	do not reset the MT before setting it to <fun> power level
NOTE 2:	This shall be always default when <rst> is not given.

It may be that CFUN=3D1 is simply the wrong command to send for Sierra =

devices.

>> I know of no USB based device that provides a complete power down settin=
g.
>
> A complete power-off is actually offered by a lot of modems that I've
> seen.  My experience is primarily with generations of Sierra Wireless
> devices, Gemalto/Cinterion as well as Quectel.  And an AT+POWEROFF or
> similar proprietary command for a full power-off is often provided.
> However, that's not a reset/reboot (with USB enumeration) but a full
> physical power off.
>
>> Since most of these devices need to be pulled out in order to change the=
 SIM
>> card, it is generally not a problem.
>
> that again may be true for consumer-grade devices, but there re plenty
> of modems where a physical card presence pin is actually provided on the
> slot, and where you can switch SIM cards.
>

Absolutely.  And oFono supports SIM hotswap.  But I've not seen any USB =

dongles do this.

> The latter functionality is by the way also used in case you work with
> simulated SIM cards or "remote SIM card forwarding devices", where there
> is no physical SIM card present at the device, but just a
> microcontroller emulating the SIM card protocol from the ISO7816-4 slave
> side.  In such cases, when simulating a SIM card swap, you usually just
> signal that the SIM slot has opened, and then re-insert a different
> virtual SIM.

Assuming your firmware supports this.  Many just crash if your do a =

hotswap.  The more reliable approach might be SIM REFRESH, but even that =

is kind of nasty and device specific.

Having said that, oFono core has no problems supporting this.  How to =

make the hardware work reliably is the issue.

>
> But the real reason not to only go to CFUN=3D4 is becaus again you are
> leaking state.  The modem is not in the same state as one that has been
> reset. The timing and behavior will be different toward the network.
>
>> This is just a limitation of USB devices.
>
> I beg to differ.  USB devices coming and going on the bus accross device
> reset is a well-known phenomenon, and some software can deal with it
> very well, while other software less so.  There are buggy USB host
> controllers, buggy hubs, buggy modems, buggy cables, signal integrity
> issues, ....  There's EMI that might cause a bus reset, lots of reasons
> while devices go and re-enumerate at some point during the life-time of
> systems running for more than a day or so.
>

Sure, but you're talking about very device specific device detection. =

There's nothing stopping you implementing the behavior you want.

Our USB detection is done inside plugins/udevng.c  The current logic is =

pretty simple.  It assumes that if a device drops off the bus, its been =

pulled by the user.  This works fairly well for our typical use case. =

Anything more complex gets really complex.  Many device manufacturers =

don't even program the usb descriptors properly, so you have no idea =

whether the same device was plugged in, a different one, etc.

You can implement any sort of custom detection logic via another plugin.

>> If you want proper control of a modem power state, you might want to
>> research devices with full-featured modems on board.
>
> Among other things, we are building such devices.  But then, whether
> custom-built or existing devices: You will still interconnect the modem
> via USB, as a classic UART simply doesn't do for 3.5G or 4G speeds.
>
> But even if you power-cycle the modem physically:
>
> 1) how can you make sure the same device always gets the same ofono
>     device name?  It is the same modem, attached to the same port of the
>     same hub in the same bus hierarchy.  This is an issue even beyond our
>     use case.  I've seen USB-attached modems resetting/rebooting
>     themselves due to software bugs.  However, the user application
>     driving the modem should probably not have to deal with changing
>     device names in such instances, should it?  If there's only one
>     modem, that might be clumsy but still work.  If you have lots of
>     modems, you never know which one you talk to until you read out the
>     IMEI?
>

Good question.  For 'proper' devices which are connected using a =

high-speed serial bus or whatever this isn't an issue.  It tells us that =

it has reset and we can take appropriate actions.

For USB, it just simply has never been a concern.  If your USB =

descriptors are setup properly, you can use the serial number (or other =

unique identifier) to name your device object.  Maybe some other =

strategies might work.  If you get into issuing AT commands to determine =

IMEI, etc, it gets complicated.

> 2) I'm not talking about a full power-cycle in my original question, but
>     by something the driver issues :)
>
> So if I understand your response correctly, there is no
> support/design/concept in ofono that deals with a USB-attached modem
> disconnecting and re-connecting to the bus?

The core has no concept of a bus.  The driver tells it when a modem is =

created / removed.  The driver has to abstract all these details.

>
> Another question: Which (LGA, connectorized) 2G/3G (and possibly 4G)
> modems would you recommend in terms of highest quality of ofono driver
> integration?

Right now I would say Telit or uBlox.  The AT commands are generally =

available and the firmware is of pretty decent quality.  I think some of =

the newer Telit/uBlox modems are really an Intel modem, with a slightly =

modified Intel firmware, to the point that even most of the AT commands =

are the same.

>
> btw: Once we have the above-mentioned test setup running, it can be used
> the orther way around, too: To test a large number of different modems
> with ofono against a Osmocom based GSM network, and use that to test for
> regressions in new commits of ofono.  So there might be something in for
> you, too :)
>

Definitely!  The more testing the better.  I'm happy to support your =

efforts as best as I can.

> Regards,
> 	Harald
>

Regards,
-Denis

--===============8824462119300519326==--

