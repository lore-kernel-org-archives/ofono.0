Content-Type: multipart/mixed; boundary="===============8941771725646157269=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] Use specific vendor for phonesim stk
Date: Tue, 13 Jul 2010 09:56:59 -0500
Message-ID: <4C3C7EBB.8090705@gmail.com>
In-Reply-To: <1279017001-23915-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8941771725646157269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 07/13/2010 05:30 AM, Yang Gu wrote:
> ---
>  plugins/phonesim.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index d0cd7f3..9c5b2cb 100644
> --- a/plugins/phonesim.c
> +++ b/plugins/phonesim.c
> @@ -289,7 +289,7 @@ static void phonesim_pre_sim(struct ofono_modem *mode=
m)
>  	else
>  		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
>  =

> -	ofono_stk_create(modem, 0, "atmodem", data->chat);
> +	ofono_stk_create(modem, OFONO_VENDOR_PHONESIM, "atmodem", data->chat);
>  =

>  	if (sim)
>  		ofono_sim_inserted_notify(sim, TRUE);

Applied, thanks.

Regards,
-Denis

--===============8941771725646157269==--

