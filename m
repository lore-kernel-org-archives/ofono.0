Content-Type: multipart/mixed; boundary="===============2196129240447362657=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: [PATCH 1/1] udev: set driver for serial drivers
Date: Fri, 08 Sep 2017 08:25:31 -0700
Message-ID: <20170908152531.GA3@computer.craftyguy.net>
In-Reply-To: <20170908080717.4441-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2196129240447362657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,
I applied the patch below after the first patch, looks like I inched
ahead a little further but something is still causing udevng to give
up and tear everything down (output clipped to include only changes
from the last attempt before this patch):

ofonod[10523]: plugins/udevng.c:udev_start()
ofonod[10523]: plugins/udevng.c:enumerate_devices()
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[10523]: plugins/udevng.c:add_serial_device() /sys/devices/platform/6=
8000000.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[10523]: plugins/udevng.c:add_serial_device() /devices/platform/68000=
000.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[10523]: plugins/udevng.c:add_serial_device() (null) (n900)
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
....
this repeats a lot
...
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[10523]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[10523]: plugins/udevng.c:create_modem() /sys/devices/platform/680000=
00.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[10523]: plugins/udevng.c:create_modem() driver=3Dn900
ofonod[10523]: src/modem.c:ofono_modem_create() name: (null), type: n900
ofonod[10523]: plugins/udevng.c:destroy_modem() /sys/devices/platform/68000=
000.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[10523]: src/modem.c:ofono_modem_remove() 0x64f0b0
ofonod[10523]: src/private-network.c:ofono_private_network_driver_register(=
) driver: 0x635334, name: Example Private Network Driver


-Clayton



On Fri, Sep 08, 2017 at 10:07:17AM +0200, Jonas Bonn wrote:
>The switch away from udev.c to udevng.c for serial modems ended up
>having a hardcoded driver "legacy" set on them.  This breaks as the
>setup routine for the device will never be found this way.  This patch
>sets the correct driver for the device.
>---
>Hi Clayton,
>
>Here's another patch that hopefully gets the N900 a bit further down
>the road to initialization.  Apply this _on top of_ the earlier patch
>I sent you; they are both needed.
>
>Cheers,
>Jonas
>
> plugins/udevng.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/plugins/udevng.c b/plugins/udevng.c
>index 241fcda..5767259 100644
>--- a/plugins/udevng.c
>+++ b/plugins/udevng.c
>@@ -1335,7 +1335,7 @@ static void add_serial_device(struct udev_device *de=
v)
> 		modem->type =3D MODEM_TYPE_SERIAL;
> 		modem->syspath =3D g_strdup(syspath);
> 		modem->devname =3D g_strdup(devname);
>-		modem->driver =3D g_strdup("legacy");
>+		modem->driver =3D g_strdup(driver);
>
> 		g_hash_table_replace(modem_list, modem->syspath, modem);
> 	}
>-- =

>2.9.3
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>https://lists.ofono.org/mailman/listinfo/ofono


--===============2196129240447362657==--

