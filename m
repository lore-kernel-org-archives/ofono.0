Content-Type: multipart/mixed; boundary="===============7893613609998260023=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Gobi: Enable SIM driver forcing
Date: Mon, 02 May 2016 22:21:25 -0500
Message-ID: <57281935.9000800@gmail.com>
In-Reply-To: <1462206794-14322-1-git-send-email-m.chaplet@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7893613609998260023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 05/02/2016 11:33 AM, Martin Chaplet wrote:
> Let modem detect part overload default SIM driver by using an additional
> property named "ForceSimLegacy" (boolean).
>
> Signed-off-by: Martin Chaplet <m.chaplet@kerlink.fr>

No Signed-off-by please.

> ---
>   plugins/gobi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 4daa459..aad423d 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -418,7 +418,7 @@ static void gobi_pre_sim(struct ofono_modem *modem)
>
>   	ofono_devinfo_create(modem, 0, "qmimodem", data->device);
>
> -	if (data->features & GOBI_UIM)
> +	if ( (data->features & GOBI_UIM) && !ofono_modem_get_boolean(modem, "Fo=
rceSimLegacy") )

Not our style.  Also the logic would be cleaner if we do something like:

const char *sim_driver;

if (data->features & GOBI_UIM)
	sim_driver =3D "qmimodem";
else if (data->features & GOBI_DMS)
	sim_driver =3D "qmimodem-legacy";

if (ofono_modem_get_boolean(modem, "ForceSimLegacy"))
	sim_driver =3D "qmimodem-legacy";

ofono_sim_create(...);

>   		ofono_sim_create(modem, 0, "qmimodem", data->device);
>   	else if (data->features & GOBI_DMS)
>   		ofono_sim_create(modem, 0, "qmimodem-legacy", data->device);
>

Regards,
-Denis

--===============7893613609998260023==--

