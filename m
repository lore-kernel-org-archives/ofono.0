Content-Type: multipart/mixed; boundary="===============8725436338293654123=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPIO power management
Date: Tue, 11 Dec 2018 10:34:39 -0600
Message-ID: <bc365c7d-912b-27c3-6bbb-bf927593bbe8@gmail.com>
In-Reply-To: <0d9c6562-3c34-5082-32f5-e39057f037d5@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8725436338293654123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>>> it might make sense to add GPIO helper in a common object, and use =

>>> libgpiod in there?
>>
>> We will not be adding any further dependencies on GLib based libraries =

>> for oFono as GLib use is going to be deprecated over time (in favor of =

>> ell).=C2=A0 This is especially true for a small library like libgpiod.
> =

> I don't think libgpiod i GLib based:
> =


Ah, good to know.  Not sure why I assumed that.  But in general we'd be =

very careful about introducing any new dependencies.  In fact once we =

migrate to ell we can start dropping some (like libdbus-1)

>> So this has to be done either inside oFono itself or preferably as a =

>> set of class(es) inside ell.
> =

> As long as it is only a matter of setting a single GPIO on/off, then I =

> think a helper in common/gpio.{c,h} should be enough - something like =

> this from my little test program:
> =

> static bool gpio_set(uint32_t chip, uint32_t line, uint8_t value)
> {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpiohandle_request req=
 =3D {0};
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char path[] =3D "/dev/gpiochi=
pXX";
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret, fd;
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof(path), =
"/dev/gpiochip%u", chip);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open(path, O_RDWR | O_=
CLOEXEC);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fd < 0) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 error(0, errno, "open: %s", path);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return false;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req.lineoffsets[0] =3D line;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req.lines =3D 1;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req.flags =3D GPIOHANDLE_REQU=
EST_OUTPUT;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req.default_values[0] =3D !!v=
alue;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(req.consumer_label, "=
ofono", sizeof(req.consumer_label));
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ioctl(fd, GPIO_GET_LI=
NEHANDLE_IOCTL, &req);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 error(0, errno, "ioctl");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return false;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> }
> =


Looks simple enough.  Since ell is now a required dependency, then you =

might as well start introducing it into ell.  This can start small / =

primitive and grow as needed.

But if you want to keep it inside ofono.git/src, that is also fine.

Regards,
-Denis

--===============8725436338293654123==--

