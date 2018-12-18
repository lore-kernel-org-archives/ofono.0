Content-Type: multipart/mixed; boundary="===============5941550355117729383=="
MIME-Version: 1.0
From: Tarmo Kuuse <tarmo.kuuse@gmail.com>
Subject: Re: GPIO power management
Date: Tue, 18 Dec 2018 14:24:22 +0200
Message-ID: <4ad557de-1575-4393-8ce8-dc68c7cd757f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5941550355117729383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>>> I previously submitted pacthes[1] for the Quectel M95 modem, and now =

>>> finally have the time needed to address the review comments.
>>>
>>> In the meantime, my hardware has changed (modem chip remains the same =

>>> though), and so I would like to add more generic power management the =

>>> ofono driver.
>>>
>>> I would assume that I cannot be the first with the urge to control =

>>> modem power using GPIOs (found one example in =

>>> ofono/plugins/nokia-gpio.c), so =

>> =

>> Maybe not the first, but nobody has brought this up for oh ~8 years or =

>> so.  So might as well treat yourself as the first ;)
> =

> I see.. Maybe I will not be the last then :)

You are certainly not the last. I have a Beaglebone-derived device with =

a slightly wobbly Quectel UC20 connected to a slightly wobbly USB host =

controller. As a preventative measure I plan to toggle reset of both the =

USB controller and GSM module before a dial-up session is (re)started.

>>> it might make sense to add GPIO helper in a common object, and use =

>>> libgpiod in there?
>> =

>> We will not be adding any further dependencies on GLib based libraries =

>> for oFono as GLib use is going to be deprecated over time (in favor of =

>> ell).  This is especially true for a small library like libgpiod.
> =

> I don't think libgpiod i GLib based:
> =

> ldd /usr/lib/libgpiod.so
>          linux-vdso.so.1 (0x00007ffe90977000)
>          libc.so.6 =3D> /usr/lib/libc.so.6 (0x00007f325b3d4000)
>          /usr/lib64/ld-linux-x86-64.so.2 (0x00007f325b5b4000)
> =

>> So this has to be done either inside oFono itself or preferably as a set =

>> of class(es) inside ell.
> =

> As long as it is only a matter of setting a single GPIO on/off, then I =

> think a helper in common/gpio.{c,h} should be enough - something like =

> this from my little test program:
> =

> static bool gpio_set(uint32_t chip, uint32_t line, uint8_t value)
> {
>          struct gpiohandle_request req =3D {0};
>          char path[] =3D "/dev/gpiochipXX";
>          int ret, fd;
> =

>          snprintf(path, sizeof(path), "/dev/gpiochip%u", chip);
>          fd =3D open(path, O_RDWR | O_CLOEXEC);
>          if (fd < 0) {
>                  error(0, errno, "open: %s", path);
>                  return false;
>          }
> =

>          req.lineoffsets[0] =3D line;
>          req.lines =3D 1;
>          req.flags =3D GPIOHANDLE_REQUEST_OUTPUT;
>          req.default_values[0] =3D !!value;
>          strncpy(req.consumer_label, "ofono", sizeof(req.consumer_label));
> =

>          ret =3D ioctl(fd, GPIO_GET_LINEHANDLE_IOCTL, &req);
>          if (ret < 0) {
>                  error(0, errno, "ioctl");
>                  return false;
>          }
> =

>          return true;
> }

Do I assume correctly that this is a work in progress? I'm going to hack =

out a prototype to test the wobbliness countermeasures, but I'd like to =

have a rough idea of how temporary my hack would end up being.

>>> If that would be acceptable, a way to configure such GPIO =

>>> numbers/names is needed. Should this be done with an OFONO_CONFIG env =

>>> attribute in the udev rules?
>> =

>> That is ultimately up to the driver.  Serial devices have to rely on =

>> udev rules or configuration files, so either should be fine.
> =

> udev rules it is then
Are the Ofono udev rules documented anywhere? I can see two .rules files =

in the plugins directory, but they're a bit cryptic.

-- =

Kind regards,
Tarmo

--===============5941550355117729383==--

