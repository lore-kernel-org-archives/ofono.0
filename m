Content-Type: multipart/mixed; boundary="===============0866564083496214198=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v2 03/10] ublox: query USBCONF for applicable devices
Date: Wed, 13 Mar 2019 21:30:39 +0100
Message-ID: <0ffaa16f-7be2-9c77-7542-f87c3223443e@norrbonn.se>
In-Reply-To: <20190313202324.16369-3-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0866564083496214198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 13/03/2019 21:23, Jonas Bonn wrote:
> The TOBY L2 series of modems presents a number of different
> configurations with different throughtput characteristics.  These
> configurations are packaged up as USB profiles; moreover, changing the
> profile actually changes the USB model ID so this is even more like
> selecting a different "device" altogether.  Nonetheless, all we need to
> know is which profile is selected in order to set things up correctly
> and this can be queried directly.
> =

> This patch adds a call to UUSBCONF for applicable modems in order to
> query the USB configuration to find out which profile is active.
> ---
>   plugins/ublox.c | 86 +++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 62 insertions(+), 24 deletions(-)
> =

> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index 20e20567..e6891f21 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -46,7 +46,8 @@
>   =

>   #include <drivers/ubloxmodem/ubloxmodem.h>
>   =

> -static const char *none_prefix[] =3D { NULL };
> +static const char * const uusbconf_prefix[] =3D { "+UUSBCONF:", NULL };
> +static const char * const none_prefix[] =3D { NULL };

Of course, I got conned by checkpatch into making this change... it's =

certainly correct but making the pointer const doesn't play well with =

the rest of ofono so it's not sane to actually change this now.

I'll let you review the rest of the series before resubmitting... if you =

want to get past this, though, just drop the const from the pointer.

Sorry for the noise... my bad.

/Jonas

--===============0866564083496214198==--

