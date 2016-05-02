Content-Type: multipart/mixed; boundary="===============2128087313981838022=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Gobi: Enable SIM driver "manual" config
Date: Mon, 02 May 2016 10:13:40 -0500
Message-ID: <57276EA4.1070306@gmail.com>
In-Reply-To: <1462200163-15827-2-git-send-email-m.chaplet@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2128087313981838022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 05/02/2016 09:42 AM, Martin Chaplet wrote:
> Let modem detect part overload default SIM driver by using an additional
> property named "Simdriver".
> It allows QMI modems with buggy UIM interface to be supported by forcing
> legacy driver.
> ---
>   plugins/gobi.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 4daa459..09c9d95 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -413,12 +413,16 @@ error:
>   static void gobi_pre_sim(struct ofono_modem *modem)
>   {
>   	struct gobi_data *data =3D ofono_modem_get_data(modem);
> +	const char * simdriver;
>
>   	DBG("%p", modem);
>
>   	ofono_devinfo_create(modem, 0, "qmimodem", data->device);
>
> -	if (data->features & GOBI_UIM)
> +	simdriver =3D ofono_modem_get_string(modem,"Simdriver");

Can we name this ForceSimLegacy and make it a boolean?

> +	if(simdriver !=3D NULL)
> +		ofono_sim_create(modem, 0, simdriver, data->device);
> +	else if (data->features & GOBI_UIM)
>   		ofono_sim_create(modem, 0, "qmimodem", data->device);
>   	else if (data->features & GOBI_DMS)
>   		ofono_sim_create(modem, 0, "qmimodem-legacy", data->device);
>

Regards,
-Denis

--===============2128087313981838022==--

