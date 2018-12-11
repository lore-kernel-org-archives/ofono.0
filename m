Content-Type: multipart/mixed; boundary="===============8186076307942511999=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: GPIO power management
Date: Tue, 11 Dec 2018 15:14:37 +0100
Message-ID: <0d9c6562-3c34-5082-32f5-e39057f037d5@geanix.com>
In-Reply-To: <3b3c087f-7207-0b62-43ad-68d5b7644df2@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8186076307942511999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 10/12/2018 18.27, Denis Kenzior wrote:
> Hi Martin,
> =

> On 12/10/2018 08:14 AM, Martin Hundeb=C3=B8ll wrote:
>> Hi,
>>
>> I previously submitted pacthes[1] for the Quectel M95 modem, and now =

>> finally have the time needed to address the review comments.
>>
>> In the meantime, my hardware has changed (modem chip remains the same =

>> though), and so I would like to add more generic power management the =

>> ofono driver.
>>
>> I would assume that I cannot be the first with the urge to control =

>> modem power using GPIOs (found one example in =

>> ofono/plugins/nokia-gpio.c), so =

> =

> Maybe not the first, but nobody has brought this up for oh ~8 years or =

> so.=C2=A0 So might as well treat yourself as the first ;)

I see.. Maybe I will not be the last then :)

>> it might make sense to add GPIO helper in a common object, and use =

>> libgpiod in there?
> =

> We will not be adding any further dependencies on GLib based libraries =

> for oFono as GLib use is going to be deprecated over time (in favor of =

> ell).=C2=A0 This is especially true for a small library like libgpiod.

I don't think libgpiod i GLib based:

ldd /usr/lib/libgpiod.so
         linux-vdso.so.1 (0x00007ffe90977000)
         libc.so.6 =3D> /usr/lib/libc.so.6 (0x00007f325b3d4000)
         /usr/lib64/ld-linux-x86-64.so.2 (0x00007f325b5b4000)

> So this has to be done either inside oFono itself or preferably as a set =

> of class(es) inside ell.

As long as it is only a matter of setting a single GPIO on/off, then I =

think a helper in common/gpio.{c,h} should be enough - something like =

this from my little test program:

static bool gpio_set(uint32_t chip, uint32_t line, uint8_t value)
{
         struct gpiohandle_request req =3D {0};
         char path[] =3D "/dev/gpiochipXX";
         int ret, fd;

         snprintf(path, sizeof(path), "/dev/gpiochip%u", chip);
         fd =3D open(path, O_RDWR | O_CLOEXEC);
         if (fd < 0) {
                 error(0, errno, "open: %s", path);
                 return false;
         }

         req.lineoffsets[0] =3D line;
         req.lines =3D 1;
         req.flags =3D GPIOHANDLE_REQUEST_OUTPUT;
         req.default_values[0] =3D !!value;
         strncpy(req.consumer_label, "ofono", sizeof(req.consumer_label));

         ret =3D ioctl(fd, GPIO_GET_LINEHANDLE_IOCTL, &req);
         if (ret < 0) {
                 error(0, errno, "ioctl");
                 return false;
         }

         return true;
}

>>
>> If that would be acceptable, a way to configure such GPIO =

>> numbers/names is needed. Should this be done with an OFONO_CONFIG env =

>> attribute in the udev rules?
> =

> That is ultimately up to the driver.=C2=A0 Serial devices have to rely on =

> udev rules or configuration files, so either should be fine.

udev rules it is then.

>>
>> Actually, I face a similar configuration issue with UART flow control. =

>> My first board uses the M95 modem without flow control, and the new =

>> board enables flow control. This should also be a configuration =

>> parameter somewhere in the stack.
> =

> This is really up to the driver.=C2=A0 Do note that GAtChat itself is =

> ignorant of flow control.=C2=A0 So you can enable this on the uart, but =

> that's about it.

OK, I'll make the "RtcCts" option conditional on another udev setting then.

Thanks,
Martin

>>
>> [1] https://lists.ofono.org/pipermail/ofono/2018-August/018293.html
>>
> =

> Regards,
> -Denis

--===============8186076307942511999==--

