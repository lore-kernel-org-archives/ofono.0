Content-Type: multipart/mixed; boundary="===============8918418112724941912=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] new gemalto plugin
Date: Tue, 30 Oct 2018 10:23:00 -0500
Message-ID: <28c428ea-837b-46dd-7e4c-ede65b15356a@gmail.com>
In-Reply-To: <CAKSBH7Eec39PwwKuyyW3MSc-n2XF79SMhS-_cN2EPTK97EvMsA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8918418112724941912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> So just a cursory look through this, but overall my impression is that
>> this code would be utterly unmaintainable.  You need to split this up
>> into something without a bazillion if conditions and #ifdefs in it.
>> Notice how none of our existing driver code uses #ifdefs.
> =

> In your existing code, there are a few models from each vendor,
> partially supported, with hardcoded choices for several options.
> =


We can only do so much without docs.  Remember, much of these drivers =

were community contributed based on reverse engineering efforts or if =

lucky, leaked docs which were frequently incomplete.  So let me flip =

this around and ask where were you all this time? ;)

>>
>> That means MBIM/QMI/AT logic needs to be separated into separate
>> drivers.  If you have a weird QMI/AT or MBIM/AT or QMI over MBIM
>> combination stuff going on, then these all need to be separate drivers.
>>
> =

> Several modems are either qmi+at or mbim+at, while others are simply
> at (for example with ppp, ecm, ncm networking).

So you might need to expand on this some more.  What is QMI+AT or =

MBIM+AT actually doing?  Is there a single AT port? Multiple? What is =

the AT port being used for, just vendor specific APIs or something more?

> =

> The qmi and mbim part is limited to initialization and gprs-context,
> the rest is common.
> Shall I duplicate everything for this?

I don't really have a recommendation yet as I don't have enough info. =

But, in general, we prefer duplication over convoluted code.  This is =

because you can turn features off via configure / plugin blacklisting. =

If you have one giant unified driver, then your hands are tied.

> =

> The #ifdefs are a choice of the project for the ELL, otherwise it
> would be simply, well-integrated ifs (like for qmi).
> I understand that the use of ELL will be extended in the future, why
> not go all the way, remove the #ifdefs, and declare a full dependency?

We can do that.  But that won't really help you in the grand scheme of =

things.  My point still stands though, we cannot have a bazillion if =

conditions in the driver with dozens/hundreds of different forks.  That =

just does not lead to maintainable code.  Lets work smarter, not harder =

here.

> =

> Reading stored commands and executing them.
> It is intended to configure the modem for a specific application.
> There are hooks for each state of the modem state machine.
> =

> There isn't much interest in passing these commands through an
> interface, because each application has its own configuration and
> sends a different set of commands.
> And it is modem-specific, so  it is stored by USB VID-PID.
> =


Since it sounds like this is a very esoteric use case, you might want to =

schedule this last.  Right now it just distracts from the core discussion.

>>
>> So first question is, why would you want to do this?  These days most
>> systems use the time on the Application processor.  Who cares what the
>> modem thinks the time is.
> =

> Some systems care: this comes in fact from an application (and will be
> committed mentioning a co-author).
> And it helps for timestamps in case of stack logs.
> =


So who do you think is going to be responsible for setting the time =

appropriately in the modem?  Remember, oFono is a user-centric API.  We =

don't expose stuff that is not somehow visible to the user.

Have you considered just having your modem driver auto-magically setting =

the time into the modem and forgetting all this API business?

>>
>> No AT command pass through in oFono upstream ;)  We've had this
>> conversation many times, if there are useful AT commands that can be
>> sent via this interface, then they should be abstracted behind a proper
>> API instead.
> =

> I may have misunderstood your comments the one time we had the conversati=
on.
> I don't understand your blind refusal: cluttering the interface with
> every single command that an application may need for some special
> events doesn't seem that brilliant.

As I said, we're a user-centric and use-case centric API.  If a typical =

user doesn't see this or doesn't know what to do with something, then =

don't expose it.  If you can't explain a use case for something, don't =

expose it.  No typical user is going to send arbitrary AT commands and =

'application may need special events' is also not a valid use case.

Also, there are security and interference aspects to consider.  One can =

send some AT command that interferes with the functioning of an atom =

driver for example and then your entire system breaks.  Trust me, it is =

just not a good idea.  If you want to shoot yourself in the foot, be my =

guest.  But it isn't going upstream ;)

>> So the modem is doing the property validation?  Yeah, not happening ;)
> =

> The name and number of properties vary by the models.
> There isn't much to validate in a general way. Null perhaps, or an
> arbitrary maximum length.
> This interface is supposed to use GetProperties and then can change
> some of them.
> That the set property is in the list returned by GetProperties can be ver=
ified.
> =


Yeah, again.  Not a valid usecase.  We're not here to half-ass expose =

every Gemalto feature via D-Bus.  This is not what this project is about.

>> Why don't you just configure the device into NMEA mode and use
>> location_reporting atom ?
> =

> that atom is not compatible with gpsd and takes arbitrary choices on

So fix gpsd.  We're not taking upstream a vendor specific NMEA API when =

location-reporting already exists.

> how to handle the receiver, it is incomplete and adds constrains on

So fix the driver and set appropriately sane defaults?

> the dbus version.
What now?  The file-descriptor passing has been in DBus for like 8 years =

now.  I do not buy this at all.

> For example, for the gemalto atom, it starts the engine in
> assisted-gps mode, without loading the corresponding data files.
> =


So again, fix the driver?

>> How is 'powersave' useful?
> =

> If you go on holiday for 1 week, you may like that your car still
> starts when you come back.
> The modem in this kind of applications is always on, for anti-theft of
> simply so that you can blink the lights when coming out of a
> supermarket.
> But when parked, the modem remains listening for network events, and
> only ping the application (and ofono) in case of sms, for example (up
> to the specific application how to come back from sleep).
> Above, a common setting: no reg events (if we lose coverage we don't
> react instead of re-powering) and stop the gnss engine.
> =


Okay, lets deal with this later though.

>>
>> No, we're not doing MBIM/QMI/AT all in one driver.  These should
>> basically be 3 different drivers or merged into plugins/mbim
>> plugins/gobi or whatever.
> =

> again, the modems are all mixed-mode with AT.
> To support them properly, I need both views.
> But there is no mbim+qmi combination.

Yes, but others do support MBIM + QMI.

> =

> Is there a way to support mbim+at today?
> What do you suggest?

So I think we have two options we can pursue:

1. Instead of jumbling all the MBIM/QMI logic into the gemalto plugin, =

let the mbim/gobi driver take care of it.  It should be 100% the same =

anyway.  Have udevng set some attributes specific for Gemalto modems. =

Then add another plugin that registers a modem watch and gets notified =

of any modems added to the system.  If the modem has a set of magic =

attributes (e.g. ofono_modem_get_string, etc) then you know it is a =

Gemalto modem and you can bolt on additional capabilities to it.  So for =

example if all you're doing is running vendor AT command extensions over =

the AT port, you can simply have the plugin open the AT port and add any =

additional atoms / vendor APIs to the modem.  Look at =

plugins/smart-messaging.c or hfp_ag_bluez5.c for some ideas.

2. Split the single monolithic gemalto driver into 3+ drivers.  One for =

MBIM+AT, one for QMI+AT, one for Serial/USB AT.  Or alternatively extend =

plugins/gobi or plugins/mbim with Gemalto specific model quirks.

Regards,
-Denis

--===============8918418112724941912==--

