Content-Type: multipart/mixed; boundary="===============8034143536076560021=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH] new gemalto plugin
Date: Wed, 31 Oct 2018 20:56:18 +0100
Message-ID: <CAKSBH7G+xdqk=v9RZ-AVC=Tr3CvtxbC3Gt2ZHX4z=VLsk0mKdA@mail.gmail.com>
In-Reply-To: <ffd39808-f201-a06f-3bd3-fed05b16110b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8034143536076560021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Oct 31, 2018 at 7:42 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >> So you might need to expand on this some more.  What is QMI+AT or
> >> MBIM+AT actually doing?  Is there a single AT port? Multiple? What is
> >> the AT port being used for, just vendor specific APIs or something mor=
e?
> >
> > MBIM and QMI are actually used only for the gprs-context atom.
> > The modems can work with the mbim or gobi plugin if they support the
> > respective protocols (I have tested them with changes in udevng), but
> > then we only get the bare minimum: no configuration options, hardware
> > monitor, low-power mode, gnss and its options, and the rest.
> > So, given that we need the AT interface anyway, everything is done
> > through it. It is also easier to debug than the big binary blog
> > (admittedly, wireshark helps a lot for mbim, but not sure for qmi).
> >
>
> You really need to decide what you want to do here.  If your modem is
> MBIM, then MBIM driver needs to be used.  I really don't want to get
> into situations where we build some Frankenstein driver with
> gprs-context being driven via MBIM and netreg being driven via AT command=
s.
>
> I can understand if you have MBIM + a GPS/GNSS port and want to expose
> location-reporting on that.  Ok, fine, I get that.  I can also
> understand if you want to use the AT command port for some vendor
> specific extensions not available via MBIM.  But I would need serious
> convincing of anything beyond this.
>
> > MBIM support works a bit differently depending on the chipset
> > manufacturer. The drivers/mbim/gprs-context works out of the box for
> > some models, while for others it is necessary to create the PDP
> > context with AT+CGDCONT. But this is dealt with a dedicated atom, only
> > the atom selection is visible in the plugin.
>
> So explain that one to me?  You send all context details in
> MBIM_CID_CONNECT.  So why would a CGDCONT be needed?
>
> >
> > enough for the detour. Back to the plug-in initialization: the
> > different models have zillion of differences. Whenever possible, I
> > prefer to ask the modem, otherwise it is if/switch depending on the
> > model.
> > Example of the first case: all Gemalto modems support the AT^SAIC
> > command if there is voice support (I checked down to the MC55 that
> > were like rel.98 or earlier).
>
> You do realize that all this probing can be done in the individual atom
> driver, right?  Even as far as the driver being able to call
> ofono_foo_remove if support is lacking.
>
> > All switches are independent from each other, working on a simple
> > principle, like for voice: ascertain if the feature is present and
> > with which options, then select the right atom and atom options.
> > There are quite a few, but maintainable thanks to that. Unfortunately
> > not all features can be probed at startup because some require to be
> > online, so the checks are split in 3 parts: pre-defined with PID,
> > tested during the enable phase (could be shifted to pre-sim to have a
> > faster enable), and in post-online.
>
> We've been through this, no AT commands should be executed in pre_sim,
> post_sim, post_online hooks...
>
> > And this is the part to maintain. If I split the plugins in 3
> > independent ones, I need to duplicate and maintain this.
>
> No, you really don't.  It might take a while for you to be convinced thou=
gh.
>
> > mbim/qmi/plainAt will disappear. And all the vendor-specific atoms
> > will have to be duplicated too.
>
> Again, they really don't need to be duplicated...
>
> >> Since it sounds like this is a very esoteric use case, you might want =
to
> >> schedule this last.  Right now it just distracts from the core discuss=
ion.
> >
> > ok for having it last, but it is not so esoteric.
> > Take for example the audio settings (which most likely exist for all
> > other vendors): you can select the type of interface
> > (analog/digital/usb), the port to use in case there is more than one,
> > suboptions like I2C or PCM, master/slave, and quite some other.
> > They could be set in a quite large vendor-specific interface (I saw
> > some tried it in an atom), but the configuration is fixed for the end
> > application, and - as you explained - will raise more problems than it
> > solves exposing these settings through dbus.
> > So the best is to run a couple of commands to set the interface
> > properly for the product and that's it.
>
> I understand.  But this is also why we have audio-settings atom.  So all
> such details can be easily put in there and its relevant driver.  If you
> want to have some simple configuration file that is read by your driver
> where the user can select between some common configurations that is
> fine as well.
>
> One can also add additional drivers / plugins out-of-tree that would be
> dynamically loaded and do whatever they desire.  But reading a file and
> blindly executing AT commands in a daemon that is running as root is
> just asking for trouble.  I don't really care what you do in your
> products, but I'm not taking security holes upstream.
>
> >>
> >> Have you considered just having your modem driver auto-magically setti=
ng
> >> the time into the modem and forgetting all this API business?
> >>
> >
> > I'll look into this with the customer who proposed it, most likely
> > reading this conversation already.
> >
>
> So as a hint, your customer might want to start engaging with us
> directly and skip the middle men.  We do have some experience with
> integration given that between oFono and its sister projects we control
> the Bluetooth stack, WiFi stack, cellular stack, NFC stack and the
> overall network management ;)
>
> > it's ok, GPLv2 just requires me to publish the changes I have done to
> > the code, not to fight to get them upstream.
> > I have posted this special case, it is public, so I won't discuss it
> > further here.
> > If Gemalto users want it, we will give it to them.
> >
>
> I can only advise you what is acceptable to the oFono upstream project.
> What you do in the end is really up to you and your customers.  But we
> do have certain standards with respect to security and code quality
> which we are not going to compromise on.
>
> >
> > Most of the options would make sense in a generic atom (like: which
> > satellites constellations to use for the fix (GPS, GLONASS, GALILEO,
> > Beidou, QZSS, ...), which to output, how to output them, NMEA version
> > to use, start/stop the receiver, start/stop the output, etc.
>
> So maybe you want to start there and propose some improvements to the
> location reporting APIs?
>
> > But some others would still require a vendor-specific plug-in, like on
> > which port to output the NMEA sentences, whether to exclude satellites
> > below a given angle, etc.
>
> It seems like this is a platform specific configuration and really
> doesn't belong being exported over D-Bus anyway.
>
> >> So fix gpsd.  We're not taking upstream a vendor specific NMEA API when
> >> location-reporting already exists.
> >
> > Changing it would make the dbus interface incompatible.
> > gpsd takes a device, not an fd, but the atom initialize the receiver
> > and opens the port.
>
> So? You can always come up with a simple pseudo-tty proxy?  That's like
> 20 minutes of work.  Or maybe 5 in Python.
>
> > This kind of linked mechanisms make policies, and are quite impossible
> > to break once done.
> > In my opinion, it is a bad design for linux, because the policies
> > should be a step higher, but it wasn't detected in time and now it has
> > to be like that.
> > You may have noticed that I didn't remove this atom from the plugin,
> > because there are now users for it.
> > And by the way: passing the fd most likely means that each client is
> > implementing its own  NMEA parser, with risks of bugs, duplication of
> > effort and lack of standardization. The atom encourages bad practices.
> >
>
> Ok, thanks for the rant, but I will have to disagree completely here.
> LocationReporting was done the way it was for very specific reasons.  We
> can't assume that the GPS port will be on one of the USB TTYs.  It may
> be this way on your products, but it definitely is not this way on
> others.  For example, it is exported through phonet or QMI on some device=
s.
>
> Many modems also need magic commands / setup prior to being able to use
> the GPS receiver.  So the LocationReporting API takes care of that.
> This also allows us to keep track of client lifetime.  So that if/when
> the client dies we can automatically turn off the GPS unit and save some
> battery.
>
> Honestly I'd really like to see GPS integrated properly into the kernel,
> with the ability for userspace daemons like oFono to provide
> drivers/devices to the kernel.  Maybe Pavel has some additional ideas on
> how we could accomplish that.
>
> >> Yes, but others do support MBIM + QMI.
> >
> > this might be a different use case, like all communication is qmi and
> > only carried over mbim frames. This would require a different plugin,
>
> Not all, but some, yes.
>
> > but I am not in this case.
>
> <snip>
>
> >>
> >> 2. Split the single monolithic gemalto driver into 3+ drivers.  One for
> >> MBIM+AT, one for QMI+AT, one for Serial/USB AT.  Or alternatively exte=
nd
> >> plugins/gobi or plugins/mbim with Gemalto specific model quirks.
> >
> > the second option is more interesting, but would make the behavior
> > switches in the plugin duplicated.
> > What about extracting the qmi and mbim initialization in a separate
> > file, so not to distract the reader?
>
> As mentioned earlier, we're not doing any Frankenstein drivers.
>
> > All modems are, after all, AT modems, with special initialization for
> > dedicated interfaces. It initializes mbim just like it does for gnss,
> > only this code takes more space.
>
> Are you talking about your modems here?  Because certainly not 'all'
> modems are AT modems.  Our modems for example are binary protocol based
> with AT commands bolted on top.  Also, many vendors do not provide AT
> ports for MBIM/QMI, etc based devices.
>

I am talking about the Gemalto modems in this plugin. They are all AT
modems, with extensions for the gprs-context.

Reading the ofono documentation, I kind of understood that the very
structure of ofono is so done that a plug-in can call the atoms that
it needs.
Was that all just advertisement?

And the Frankenstein idea was good, it is called also cherry-picking.
The drama that it got out of control is just... drama.

Gemalto prefers to use the AT interface because it is well understood,
easy to format, and has an excellent test coverage.
So it will remain the preferred interface when there is a choice
between it and something else.

MBIM is not even supported through the glib, but through the ell
library that is itself quite fresh (and for which there is little
advantage instead of the glib. Maybe because using glib you have to
listen to someone else's opinion for pushing changes).

I will think about the entire conversation and see how to proceed.

> Regards,
> -Denis

Regards,
Giacinto

--===============8034143536076560021==--

