Content-Type: multipart/mixed; boundary="===============6125535651675304342=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] sim800: add documentation and modify AUTHORS file
Date: Thu, 01 Nov 2018 09:48:24 -0500
Message-ID: <2552d5a0-6bfc-26c8-14f0-ee93b8ea8f03@gmail.com>
In-Reply-To: <1539624449-12221-2-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6125535651675304342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,

On 10/15/2018 12:27 PM, Clement Viel wrote:
> ---
>   AUTHORS              |  1 +

Please don't include AUTHORS changes.  One of the maintainers will take =

care of it.

>   doc/sim800-modem.txt | 11 +++++++++++
>   2 files changed, 12 insertions(+)
>   create mode 100644 doc/sim800-modem.txt
> =

> diff --git a/AUTHORS b/AUTHORS
> index 2d360e6..a8362c8 100644
> --- a/AUTHORS
> +++ b/AUTHORS
> @@ -138,3 +138,4 @@ Florent Beillonnet <florent.beillonnet@gmail.com>
>   Martin Hundeb=C3=B8ll <martin@geanix.com>
>   Julien Tournier <tournier.julien@gmail.com>
>   Nandini Rebello <nandini.rebello@intel.com>
> +Clement Viel <vielclement@gmail.com>
> diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
> new file mode 100644
> index 0000000..7220cb8
> --- /dev/null
> +++ b/doc/sim800-modem.txt
> @@ -0,0 +1,11 @@
> +SIM800 modem usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To enable SIM800 module support you need to put the following
> +udev rule into appropriate file in /{etc,lib}/udev/rules.d:
> +
> +KERNEL=3D=3D"ttyS2", ENV{OFONO_DRIVER}=3D"sim800"
> +
> +Sim800 driver code is merged with sim900's. So, to add modifications to =
sim800 driver, sim900.c file must be edited
> +accordingly.
> +To differentiate the two modems, developpers must use the "modem_type" f=
ield of sim900_data =

typo

structure.
> =


Also, we can't have people hand-editing driver code to distinguish =

between one device and another.  You've already went to the trouble of =

creating a separate sim800 driver (which I do not think is the right =

approach at all), why not take advantage of that fact with an =

appropriate probe() function or something?

Anyway, I still think you should be querying +CGMM or ATI or whatever to =

figure out the modem model automatically and not rely on the user to set =

this up.

Regards,
-Denis

--===============6125535651675304342==--

