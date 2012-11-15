Content-Type: multipart/mixed; boundary="===============2058186684951045472=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] alcatel: create sim atom with vendor alcatel
Date: Thu, 15 Nov 2012 12:32:00 -0600
Message-ID: <50A53520.8020907@gmail.com>
In-Reply-To: <1352891320-29766-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2058186684951045472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 11/14/2012 05:08 AM, Cedric Jehasse wrote:
> From: Cedric Jehasse<cedric.jehasse@softathome.com>
>
> ---
>   plugins/alcatel.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

Patch has been applied, but I had to amend it.

>
> diff --git a/plugins/alcatel.c b/plugins/alcatel.c
> index 8005170..e3e7086 100644
> --- a/plugins/alcatel.c
> +++ b/plugins/alcatel.c
> @@ -230,7 +230,7 @@ static void alcatel_pre_sim(struct ofono_modem *modem)
>   	DBG("%p", modem);
>
>   	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
> -	sim =3D ofono_sim_create(modem, 0, "atmodem", data->aux);
> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_ALCATEL, "atmodem", data->=
aux);

Please make sure to stay within 80 characters per line.

>
>   	if (sim&&  data->have_sim =3D=3D TRUE)
>   		ofono_sim_inserted_notify(sim, TRUE);

Regards,
-Denis

--===============2058186684951045472==--

