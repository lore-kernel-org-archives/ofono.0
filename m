Content-Type: multipart/mixed; boundary="===============0332729771885393628=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: enabling simtoolkit for xmm7modem
Date: Thu, 07 Mar 2019 10:21:56 -0600
Message-ID: <6ccee3ed-b8e7-6555-73f6-1394fbeb4f20@gmail.com>
In-Reply-To: <1551873273-32334-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0332729771885393628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 03/06/2019 05:54 AM, Antara Borwankar wrote:
> added code to enable and initialize stk in xmm7modem plugin
> ---
>   plugins/xmm7xxx.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> =

> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
> index 90e52fb..83ed263 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c
> @@ -1223,6 +1223,16 @@ static void xmm7xxx_pre_sim(struct ofono_modem *mo=
dem)
>   	DBG("%p", modem);
>   =

>   	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
> +
> +	ofono_stk_create(modem, 0, "atmodem", data->chat);
> +
> +	/*	enabling stk	*/
> +	g_at_chat_send(data->chat,
> +		"AT+CFUN=3D6", none_prefix, NULL, NULL, NULL);
> +	/*	sim reset to get stk menu command	*/
> +	g_at_chat_send(data->chat,
> +		"AT+CFUN=3D27,1", none_prefix, NULL, NULL, NULL);
> +

So as a general rule, there should be no AT commands in =

pre_sim/post_sim/post_online.  It is almost always not what you want.

So the question is, where do these belong.  You're adding them in =

pre_sim, so logically they might belong as part of the .enable sequence?

I'm guessing this is to work around the issue of powering off and on a =

modem with a SIM inserted, right?  e.g. since the modem is not being =

brought fully down, it is caching / keeping whatever SIM state it =

already discovered.

Regards,
-Denis

>   	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_IFX, "atmodem",
>   					data->chat);
>   }
> =



--===============0332729771885393628==--

