Content-Type: multipart/mixed; boundary="===============2197637315354950338=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] huawei: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 11:17:20 +0100
Message-ID: <568DE01DA537804BA73470071BAC288939006987@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1312366315.3373.15.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2197637315354950338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > > We call disable before we call remove, but the only thing that I
> have
> > > not checked is what happens to this if we have not succeeded with
> > > enable
> > > yet. So if I remember this right, then disable is always called
> (even
> > > if
> > > enable has not yet called set_powered), but I need Denis to confirm
> > > this.
> >
> > Except in the unplug test.
> =

> it is just the race condition for the time enable is running. Once the
> modem is properly enabled, even the unplug case is fine.
> =

> ofonod[14344]: plugins/udev.c:udev_event() subsystem net remove
> ofonod[14344]: plugins/udev.c:remove_modem()
> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.1/net/wwan0
> ofonod[14344]: src/modem.c:get_modem_property() modem 0x7beff0 property
> Path
> ofonod[14344]: src/modem.c:ofono_modem_remove() 0x7beff0
> ofonod[14344]: src/modem.c:modem_unregister() 0x7beff0
> ofonod[14344]: src/modem.c:modem_change_state() old state: 2, new
> state: 0
> ofonod[14344]: src/modem.c:flush_atoms()
> ofonod[14344]: Example Network Time Remove for modem: 0x7beff0
> ofonod[14344]: Example History Remove for modem: 0x7beff0
> ofonod[14344]: src/gprs.c:gprs_context_unregister() 0x7be230, 0x7bc8c0
> ofonod[14344]: src/gprs.c:gprs_context_remove() atom: 0x7be270
> ofonod[14344]: drivers/atmodem/gprs-context.c:at_gprs_context_remove()
> ofonod[14344]: Unregistered handle for channel 1: 0x10000
> ofonod[14344]: src/gprs.c:gprs_unregister() 0x7bc8c0
> ofonod[14344]: src/gprs.c:gprs_remove() atom: 0x7bd840
> ofonod[14344]: plugins/push-notification.c:push_notification_cleanup()
> 0x7ba6a0
> ofonod[14344]: plugins/smart-messaging.c:smart_messaging_cleanup()
> 0x7ba640
> ofonod[14344]: src/sms.c:sms_remove() atom: 0x7bf300
> ofonod[14344]: src/radio-settings.c:radio_settings_remove() atom:
> 0x7bea90
> ofonod[14344]: src/phonebook.c:phonebook_remove() atom: 0x7ba400
> ofonod[14344]: src/sim.c:sim_remove() atom: 0x7b8b00
> ofonod[14344]: src/modem.c:devinfo_remove() atom: 0x7b8d00
> ofonod[14344]: plugins/huawei.c:huawei_disable() 0x7beff0
> ofonod[14344]: plugins/huawei.c:huawei_remove() 0x7beff0
> =

> We do call disable before we call remove in the "clean" unplug case. So
> that is not the problem.

Ok, I get it.

Thanks,

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


--===============2197637315354950338==--

