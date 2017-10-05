Content-Type: multipart/mixed; boundary="===============5809120419344884423=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] nokia-gpio: do not create links to gpios in /dev/cmt
Date: Thu, 05 Oct 2017 11:33:08 -0500
Message-ID: <cce8249a-99f0-2881-4916-c26410eec7e0@gmail.com>
In-Reply-To: <20170927025607.21224-1-clayton@craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5809120419344884423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 09:56 PM, Clayton Craft wrote:
> The nokia-gpio plugin should not try to create symlinks to relevant gpio
> pins under /dev/cmt, since the location it is looking is no longer
> correct on newer kernels and it might change again in the future. This
> patch removes code from nokia-gpio that tries to create a symlink.
> =

> Users will now need to symlink the modem gpios to /dev/cmt themselves.
> On the 4.13 kernel, this can be done by, for example, adding a udev rule
> to:
>   # ln -sf /sys/bus/hsi/devices/n900-modem /dev/cmt
> ---
>   plugins/nokia-gpio.c | 67 ++++-----------------------------------------=
-------
>   1 file changed, 4 insertions(+), 63 deletions(-)
> =


plugins/nokia-gpio.c:146:12: error: =E2=80=98dir_exists=E2=80=99 defined bu=
t not used =

[-Werror=3Dunused-function]
  static int dir_exists(char const *filename)
             ^~~~~~~~~~
cc1: error: unrecognized command line option =E2=80=98-Wno-format-truncatio=
n=E2=80=99 =

[-Werror]
cc1: all warnings being treated as errors

I amended your commit to take out that function as well and applied the =

patch.

Regards,
-Denis


--===============5809120419344884423==--

