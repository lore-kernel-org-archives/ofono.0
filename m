Content-Type: multipart/mixed; boundary="===============7158362976020963651=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v2 3/3] speedupcdma: register to cdma network registration
 atom.
Date: Sat, 23 Jul 2011 17:00:55 +0200
Message-ID: <1311433255.21109.347.camel@aeonflux>
In-Reply-To: <1311394170-7381-4-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7158362976020963651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  plugins/speedupcdma.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
> index b7e54a1..14189aa 100644
> --- a/plugins/speedupcdma.c
> +++ b/plugins/speedupcdma.c
> @@ -36,6 +36,7 @@
>  #include <ofono/modem.h>
>  #include <ofono/devinfo.h>
>  #include <ofono/cdma-connman.h>
> +#include <ofono/cdma-netreg.h>
>  #include <ofono/log.h>
>  =

>  #include <drivers/atmodem/atutil.h>
> @@ -181,6 +182,8 @@ static void speedupcdma_post_online(struct ofono_mode=
m *modem)
>  =

>  	DBG("%p", modem);
>  =

> +	ofono_cdma_netreg_create(modem, 0, "cdmamodem", data->chat);
> +
>  	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);

earlier you mentioned that the Speed Up modems have more than one TTY. I
don't think it is a good idea to run the netreg handling on the same TTY
where we will eventually establish the PPP connection.

Regards

Marcel



--===============7158362976020963651==--

