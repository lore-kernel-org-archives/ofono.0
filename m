Content-Type: multipart/mixed; boundary="===============7183379973984797744=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: pass vendor at sim atom creation
Date: Thu, 16 Aug 2012 01:18:02 -0500
Message-ID: <502C909A.9010409@gmail.com>
In-Reply-To: <1345107708-24484-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7183379973984797744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/16/2012 04:01 AM, Christopher Vogl wrote:
> ---
>   plugins/telit.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>

Patch has been applied, however...

> diff --git a/plugins/telit.c b/plugins/telit.c
> index 6ae7249..08ce4ad 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -552,7 +552,7 @@ static void telit_pre_sim(struct ofono_modem *modem)
>   	DBG("%p", modem);
>
>   	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
> -	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
> +	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem", da=
ta->chat);

Please be mindful of the 80 character per line limit.  I amended the =

patch for you, just this time... ;)

>   	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
>   }
>

Regards,
-Denis

--===============7183379973984797744==--

