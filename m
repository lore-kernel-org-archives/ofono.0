Content-Type: multipart/mixed; boundary="===============5563380792153446893=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: Re: driver callback naming
Date: Sun, 30 Aug 2009 16:00:26 -0400
Message-ID: <20090830160026.75672609@mycelium.queued.net>
In-Reply-To: <200908301345.45643.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5563380792153446893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Aug 2009 13:45:45 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Andres,
> =

> > static struct ofono_modem_driver g1_driver =3D {
> >         .name =3D "HTC G1",
> >         .probe =3D g1_probe,
> >         .enable =3D g1_enable,
> >         .disable =3D g1_disable,
> >         .remove =3D g1_remove,
> >         .populate =3D g1_populate,
> > };
> >
> =

> So the current intention:
> .probe - Detect whether device is really supported by the plugin,
> initialize any data structures specific to the device
> .remove - Destroy data structures
> .enable - Perform power up
> .disable - Perform power down
> .populate - Populate the atoms supported by this device (e.g. netreg, =

> voicecall, etc)  This is called by the core after every power cycle,
> when the device is brought up.
> =


Thanks!  See patch below.


> >
> > Of course, I'm also wondering why there needs to be two separate
> > layers of calls in the first place.  Why not have drivers register
> > everything from within probe, call ofono_set_powered(modem, TRUE)
> > once the device is ready, and be done with it?
> =

> The reason for this is e.g. airplane mode, where you physically want
> to turn off the device.  Another case is for battery / power reasons,
> e.g. a netbook with a USB modem that is not being used.
> =


Fair enough.  In the kernel, we have callbacks named suspend/resume
to handle that. =


> > The only reason why this doesn't blow up in the generic_at plugin is
> > because the driver_data is leaked.  If one were to free it from
> > generic_at_exit in the wrong place (since it's allocated from
> > generic_at_init, it would make sense to free it in generic_at_exit),
> > one would see the same SEGV/SIGBUS/SIGILL errors upon ctrl-c.
> =

> So the leak has now been fixed.
> =

> I think you're being unnecessarily harsh here.  To be fair, the
> generic_at driver does something like this at init:

My criticism is simply w/ the naming.  'enable'/'disable' doesn't imply
anything about power.  powerup/powerdown, poweron/poweroff,
suspend/resume would all imply power state changes (at least the latter
would be familiar to those who do kernel stuff).  Having comments that
describe what the callbacks do would also work, though.




From 80a7b54d52201dfd7d8b590457450ae0a4f72888 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Sun, 30 Aug 2009 15:56:16 -0400
Subject: [PATCH] Add comments to ofono_modem_driver struct

Document what all the callbacks do.
---
 include/modem.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index 0a5ef60..4303024 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -50,10 +50,19 @@ ofono_bool_t ofono_modem_get_powered(struct ofono_modem=
 *modem);
 =

 struct ofono_modem_driver {
 	const char *name;
+
+	/* probe - Detect existence of device and initialize any
+	 * device-specific data structures */
 	int (*probe)(struct ofono_modem *modem);
+	/* remove - Destroy data structures allocated during probe */
 	int (*remove)(struct ofono_modem *modem);
+
+	/* enable - Power up device */
 	int (*enable)(struct ofono_modem *modem);
+	/* disable - Power down device */
 	int (*disable)(struct ofono_modem *modem);
+
+	/* populate - Populate the atoms supported by this device */
 	int (*populate)(struct ofono_modem *modem);
 };
 =

-- =

1.6.3.3




--===============5563380792153446893==--

