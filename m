Content-Type: multipart/mixed; boundary="===============4522255667088502501=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH] new gemalto plugin
Date: Wed, 31 Oct 2018 07:55:26 +0100
Message-ID: <CAKSBH7FiSURgggfqPnBK-LEOPzZc8D6Et-RKHvt7Orimn5Tvqw@mail.gmail.com>
In-Reply-To: <28c428ea-837b-46dd-7e4c-ede65b15356a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4522255667088502501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Oct 30, 2018 at 4:23 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >> So just a cursory look through this, but overall my impression is that
> >> this code would be utterly unmaintainable.  You need to split this up
> >> into something without a bazillion if conditions and #ifdefs in it.
> >> Notice how none of our existing driver code uses #ifdefs.
> >
> > In your existing code, there are a few models from each vendor,
> > partially supported, with hardcoded choices for several options.
> >
>
> We can only do so much without docs.  Remember, much of these drivers
> were community contributed based on reverse engineering efforts or if
> lucky, leaked docs which were frequently incomplete.  So let me flip
> this around and ask where were you all this time? ;)

The point here is that it is the first time a large scale operation is
attempted.
I find it normal to have all kind of options for all the models.
It won't be easy to maintain, I agree.

Below I see that your main concerns are about mixed-mode drivers,
which make only a part of the if's, all the branching is at the moment
limited to the initialization.

>
> >>
> >> That means MBIM/QMI/AT logic needs to be separated into separate
> >> drivers.  If you have a weird QMI/AT or MBIM/AT or QMI over MBIM
> >> combination stuff going on, then these all need to be separate drivers.
> >>
> >
> > Several modems are either qmi+at or mbim+at, while others are simply
> > at (for example with ppp, ecm, ncm networking).
>
> So you might need to expand on this some more.  What is QMI+AT or
> MBIM+AT actually doing?  Is there a single AT port? Multiple? What is
> the AT port being used for, just vendor specific APIs or something more?

MBIM and QMI are actually used only for the gprs-context atom.
The modems can work with the mbim or gobi plugin if they support the
respective protocols (I have tested them with changes in udevng), but
then we only get the bare minimum: no configuration options, hardware
monitor, low-power mode, gnss and its options, and the rest.
So, given that we need the AT interface anyway, everything is done
through it. It is also easier to debug than the big binary blog
(admittedly, wireshark helps a lot for mbim, but not sure for qmi).

>
> >
> > The qmi and mbim part is limited to initialization and gprs-context,
> > the rest is common.
> > Shall I duplicate everything for this?
>
> I don't really have a recommendation yet as I don't have enough info.
> But, in general, we prefer duplication over convoluted code.  This is
> because you can turn features off via configure / plugin blacklisting.
> If you have one giant unified driver, then your hands are tied.

The plugin works this way: if mbim is detected, it is initialized, and
then up to 2 AT interfaces are probed.
The same for qmi: if qmi is detected, it is initialized, and then up
to 2 AT interfaces are probed.
If ELL is not used, mbim is skipped and the modem will use PPP from
atmodem/gprs-context.
The same would be true for qmi, but there is no ifdef, so there is no
need for fallback options.
Apart from its length, the code is quite simple. When the mbim or qmi
initialization is finished, successfully or not, the plugin moves to
the AT interfaces.

QMI support is quite straightforward: only a quick initialization,
basically to make sure it is there. It doesn't need all the gobi
plugin init sequence.
MBIM is more elaborate, it needs to exchange a few frames for a proper
initialization, but then again, it finishes here. This initialization
follows the mbim plugin up to a point, but does not need the entire
mbim plugin enable sequence.
MBIM support works a bit differently depending on the chipset
manufacturer. The drivers/mbim/gprs-context works out of the box for
some models, while for others it is necessary to create the PDP
context with AT+CGDCONT. But this is dealt with a dedicated atom, only
the atom selection is visible in the plugin.

enough for the detour. Back to the plug-in initialization: the
different models have zillion of differences. Whenever possible, I
prefer to ask the modem, otherwise it is if/switch depending on the
model.
Example of the first case: all Gemalto modems support the AT^SAIC
command if there is voice support (I checked down to the MC55 that
were like rel.98 or earlier).
All switches are independent from each other, working on a simple
principle, like for voice: ascertain if the feature is present and
with which options, then select the right atom and atom options.
There are quite a few, but maintainable thanks to that. Unfortunately
not all features can be probed at startup because some require to be
online, so the checks are split in 3 parts: pre-defined with PID,
tested during the enable phase (could be shifted to pre-sim to have a
faster enable), and in post-online.
And this is the part to maintain. If I split the plugins in 3
independent ones, I need to duplicate and maintain this.



>
> >
> > The #ifdefs are a choice of the project for the ELL, otherwise it
> > would be simply, well-integrated ifs (like for qmi).
> > I understand that the use of ELL will be extended in the future, why
> > not go all the way, remove the #ifdefs, and declare a full dependency?
>
> We can do that.  But that won't really help you in the grand scheme of
> things.  My point still stands though, we cannot have a bazillion if
> conditions in the driver with dozens/hundreds of different forks.  That
> just does not lead to maintainable code.  Lets work smarter, not harder
> here.
>

as explained, the bazillion conditions will remain. maybe only
mbim/qmi/plainAt will disappear. And all the vendor-specific atoms
will have to be duplicated too.

> >
> > Reading stored commands and executing them.
> > It is intended to configure the modem for a specific application.
> > There are hooks for each state of the modem state machine.
> >
> > There isn't much interest in passing these commands through an
> > interface, because each application has its own configuration and
> > sends a different set of commands.
> > And it is modem-specific, so  it is stored by USB VID-PID.
> >
>
> Since it sounds like this is a very esoteric use case, you might want to
> schedule this last.  Right now it just distracts from the core discussion.

ok for having it last, but it is not so esoteric.
Take for example the audio settings (which most likely exist for all
other vendors): you can select the type of interface
(analog/digital/usb), the port to use in case there is more than one,
suboptions like I2C or PCM, master/slave, and quite some other.
They could be set in a quite large vendor-specific interface (I saw
some tried it in an atom), but the configuration is fixed for the end
application, and - as you explained - will raise more problems than it
solves exposing these settings through dbus.
So the best is to run a couple of commands to set the interface
properly for the product and that's it.

>
> >>
> >> So first question is, why would you want to do this?  These days most
> >> systems use the time on the Application processor.  Who cares what the
> >> modem thinks the time is.
> >
> > Some systems care: this comes in fact from an application (and will be
> > committed mentioning a co-author).
> > And it helps for timestamps in case of stack logs.
> >
>
> So who do you think is going to be responsible for setting the time
> appropriately in the modem?  Remember, oFono is a user-centric API.  We
> don't expose stuff that is not somehow visible to the user.
>
> Have you considered just having your modem driver auto-magically setting
> the time into the modem and forgetting all this API business?
>

I'll look into this with the customer who proposed it, most likely
reading this conversation already.

> >>
> >> No AT command pass through in oFono upstream ;)  We've had this
> >> conversation many times, if there are useful AT commands that can be
> >> sent via this interface, then they should be abstracted behind a proper
> >> API instead.
> >
> > I may have misunderstood your comments the one time we had the conversa=
tion.
> > I don't understand your blind refusal: cluttering the interface with
> > every single command that an application may need for some special
> > events doesn't seem that brilliant.
>
> As I said, we're a user-centric and use-case centric API.  If a typical
> user doesn't see this or doesn't know what to do with something, then
> don't expose it.  If you can't explain a use case for something, don't
> expose it.  No typical user is going to send arbitrary AT commands and
> 'application may need special events' is also not a valid use case.
>
> Also, there are security and interference aspects to consider.  One can
> send some AT command that interferes with the functioning of an atom
> driver for example and then your entire system breaks.  Trust me, it is
> just not a good idea.  If you want to shoot yourself in the foot, be my
> guest.  But it isn't going upstream ;)

it's ok, GPLv2 just requires me to publish the changes I have done to
the code, not to fight to get them upstream.
I have posted this special case, it is public, so I won't discuss it
further here.
If Gemalto users want it, we will give it to them.

Nor I will go into all the use cases of ofono today. There is some
truth in what you say as the initial vision for the project, but
apparently it is growing out of that.

>
> >> So the modem is doing the property validation?  Yeah, not happening ;)
> >
> > The name and number of properties vary by the models.
> > There isn't much to validate in a general way. Null perhaps, or an
> > arbitrary maximum length.
> > This interface is supposed to use GetProperties and then can change
> > some of them.
> > That the set property is in the list returned by GetProperties can be v=
erified.
> >
>
> Yeah, again.  Not a valid usecase.  We're not here to half-ass expose
> every Gemalto feature via D-Bus.  This is not what this project is about.
>

ditto for this atom: I have fulfilled the GPLv2 requirements.

Most of the options would make sense in a generic atom (like: which
satellites constellations to use for the fix (GPS, GLONASS, GALILEO,
Beidou, QZSS, ...), which to output, how to output them, NMEA version
to use, start/stop the receiver, start/stop the output, etc.
But some others would still require a vendor-specific plug-in, like on
which port to output the NMEA sentences, whether to exclude satellites
below a given angle, etc.


> >> Why don't you just configure the device into NMEA mode and use
> >> location_reporting atom ?
> >
> > that atom is not compatible with gpsd and takes arbitrary choices on
>
> So fix gpsd.  We're not taking upstream a vendor specific NMEA API when
> location-reporting already exists.

Changing it would make the dbus interface incompatible.
gpsd takes a device, not an fd, but the atom initialize the receiver
and opens the port.
This kind of linked mechanisms make policies, and are quite impossible
to break once done.
In my opinion, it is a bad design for linux, because the policies
should be a step higher, but it wasn't detected in time and now it has
to be like that.
You may have noticed that I didn't remove this atom from the plugin,
because there are now users for it.
And by the way: passing the fd most likely means that each client is
implementing its own  NMEA parser, with risks of bugs, duplication of
effort and lack of standardization. The atom encourages bad practices.

>
> > how to handle the receiver, it is incomplete and adds constrains on
>
> So fix the driver and set appropriately sane defaults?
>
> > the dbus version.
> What now?  The file-descriptor passing has been in DBus for like 8 years
> now.  I do not buy this at all.
>
> > For example, for the gemalto atom, it starts the engine in
> > assisted-gps mode, without loading the corresponding data files.
> >
>
> So again, fix the driver?
>
> >> How is 'powersave' useful?
> >
> > If you go on holiday for 1 week, you may like that your car still
> > starts when you come back.
> > The modem in this kind of applications is always on, for anti-theft of
> > simply so that you can blink the lights when coming out of a
> > supermarket.
> > But when parked, the modem remains listening for network events, and
> > only ping the application (and ofono) in case of sms, for example (up
> > to the specific application how to come back from sleep).
> > Above, a common setting: no reg events (if we lose coverage we don't
> > react instead of re-powering) and stop the gnss engine.
> >
>
> Okay, lets deal with this later though.

ok

>
> >>
> >> No, we're not doing MBIM/QMI/AT all in one driver.  These should
> >> basically be 3 different drivers or merged into plugins/mbim
> >> plugins/gobi or whatever.
> >
> > again, the modems are all mixed-mode with AT.
> > To support them properly, I need both views.
> > But there is no mbim+qmi combination.
>
> Yes, but others do support MBIM + QMI.

this might be a different use case, like all communication is qmi and
only carried over mbim frames. This would require a different plugin,
but I am not in this case.

>
> >
> > Is there a way to support mbim+at today?
> > What do you suggest?
>
> So I think we have two options we can pursue:
>
> 1. Instead of jumbling all the MBIM/QMI logic into the gemalto plugin,
> let the mbim/gobi driver take care of it.  It should be 100% the same
> anyway.  Have udevng set some attributes specific for Gemalto modems.
> Then add another plugin that registers a modem watch and gets notified
> of any modems added to the system.  If the modem has a set of magic
> attributes (e.g. ofono_modem_get_string, etc) then you know it is a
> Gemalto modem and you can bolt on additional capabilities to it.  So for
> example if all you're doing is running vendor AT command extensions over
> the AT port, you can simply have the plugin open the AT port and add any
> additional atoms / vendor APIs to the modem.  Look at
> plugins/smart-messaging.c or hfp_ag_bluez5.c for some ideas.
>
> 2. Split the single monolithic gemalto driver into 3+ drivers.  One for
> MBIM+AT, one for QMI+AT, one for Serial/USB AT.  Or alternatively extend
> plugins/gobi or plugins/mbim with Gemalto specific model quirks.

the second option is more interesting, but would make the behavior
switches in the plugin duplicated.
What about extracting the qmi and mbim initialization in a separate
file, so not to distract the reader?
All modems are, after all, AT modems, with special initialization for
dedicated interfaces. It initializes mbim just like it does for gnss,
only this code takes more space.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============4522255667088502501==--

