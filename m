Content-Type: multipart/mixed; boundary="===============4869903960095477785=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] huawei: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 13:49:41 +0100
Message-ID: <568DE01DA537804BA73470071BAC288939006AA4@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1312375333.3373.25.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4869903960095477785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > > > > We call disable before we call remove, but the only thing that
> I
> > > have
> > > > > not checked is what happens to this if we have not succeeded
> with
> > > > > enable
> > > > > yet. So if I remember this right, then disable is always called
> > > (even
> > > > > if
> > > > > enable has not yet called set_powered), but I need Denis to
> confirm
> > > > > this.
> > > >
> > > > Except in the unplug test.
> > >
> > > it is just the race condition for the time enable is running. Once
> the
> > > modem is properly enabled, even the unplug case is fine.
> > >
> > > ofonod[14344]: plugins/udev.c:udev_event() subsystem net remove
> > > ofonod[14344]: plugins/udev.c:remove_modem()
> > > /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.1/net/wwan0
> > > ofonod[14344]: src/modem.c:get_modem_property() modem 0x7beff0
> property
> > > Path
> > > ofonod[14344]: src/modem.c:ofono_modem_remove() 0x7beff0
> > > ofonod[14344]: src/modem.c:modem_unregister() 0x7beff0
> > > ofonod[14344]: src/modem.c:modem_change_state() old state: 2, new
> > > state: 0
> > > ofonod[14344]: src/modem.c:flush_atoms()
> > > ofonod[14344]: Example Network Time Remove for modem: 0x7beff0
> > > ofonod[14344]: Example History Remove for modem: 0x7beff0
> > > ofonod[14344]: src/gprs.c:gprs_context_unregister() 0x7be230,
> 0x7bc8c0
> > > ofonod[14344]: src/gprs.c:gprs_context_remove() atom: 0x7be270
> > > ofonod[14344]: drivers/atmodem/gprs-
> context.c:at_gprs_context_remove()
> > > ofonod[14344]: Unregistered handle for channel 1: 0x10000
> > > ofonod[14344]: src/gprs.c:gprs_unregister() 0x7bc8c0
> > > ofonod[14344]: src/gprs.c:gprs_remove() atom: 0x7bd840
> > > ofonod[14344]: plugins/push-
> notification.c:push_notification_cleanup()
> > > 0x7ba6a0
> > > ofonod[14344]: plugins/smart-messaging.c:smart_messaging_cleanup()
> > > 0x7ba640
> > > ofonod[14344]: src/sms.c:sms_remove() atom: 0x7bf300
> > > ofonod[14344]: src/radio-settings.c:radio_settings_remove() atom:
> > > 0x7bea90
> > > ofonod[14344]: src/phonebook.c:phonebook_remove() atom: 0x7ba400
> > > ofonod[14344]: src/sim.c:sim_remove() atom: 0x7b8b00
> > > ofonod[14344]: src/modem.c:devinfo_remove() atom: 0x7b8d00
> > > ofonod[14344]: plugins/huawei.c:huawei_disable() 0x7beff0
> > > ofonod[14344]: plugins/huawei.c:huawei_remove() 0x7beff0
> > >
> > > We do call disable before we call remove in the "clean" unplug
> case. So
> > > that is not the problem.
> >
> > Ok, I get it.
> =

> I will check with Denis if we are going to do something more
> sophisticated or leave this up to the modem plugins to figure it out.
> However I went back through the code and came up with this conclusion.
> =

> We do not need to check anything in the disable callback, since if
> enable succeeds or fails, we clean up the poll sources. And if enable
> never succeeds, then disable is never called. So that should be just
> fine. No leaks here.
> =

> The only thing that I have not checked is if we can actually call the
> disable modem D-Bus function while enable is in progress and what
> happens in that case. I just do not have had time to confirm this case
> and what is the order of callbacks and events in that case. Or if we
> just block that D-Bus.
> =

> So right now, when we have to clean something up, the only rare case is
> that when enabling was in progress and we unplug the dongle during
> that.
> This means that your original patches were correct and fixed this case.
> I did some simplification in the SIM state polling free function and
> added comments to all of them and applied them.
> =

> While doing that, I realized also another race condition in the Huawei
> modem plugin, where the online enabling polling might race against some
> calling disable. I fixed that one as well.

Ok this is perfect.

Thanks for the 'complete' fix.

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4869903960095477785==--

