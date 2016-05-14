Content-Type: multipart/mixed; boundary="===============6793378659851952493=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins/ril: complete modem power off process
Date: Fri, 13 May 2016 20:57:51 -0500
Message-ID: <5736861F.6000504@gmail.com>
In-Reply-To: <1463032263-6366-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6793378659851952493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 05/12/2016 12:51 AM, caiwen.zhang(a)intel.com wrote:
> From: caiwen Zhang <caiwen.zhang@intel.com>
>
> ---
>   plugins/ril.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>

I went ahead and applied this patch, however, see below:

> diff --git a/plugins/ril.c b/plugins/ril.c
> index 2298bb6..2ea3fb5 100644
> --- a/plugins/ril.c
> +++ b/plugins/ril.c
> @@ -409,15 +409,30 @@ int ril_enable(struct ofono_modem *modem)
>   	return -EINPROGRESS;
>   }
>
> +static void power_off_cb(struct ril_msg *message, gpointer user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	struct ril_data *rd =3D cbd->user;
> +	struct ofono_modem *modem =3D cbd->data;
> +
> +	if (rd) {
> +		g_ril_unref(rd->ril);

It seems GRil doesn't gracefully handle g_ril_unrefs from within a =

result callback.  Have you tried running this with valgrind?

We might need to come up with a fix for GRil...

> +		rd->ril =3D NULL;
> +	}
> +
> +	ofono_modem_set_powered(modem, FALSE);
> +}
> +
>   int ril_disable(struct ofono_modem *modem)
>   {
>   	struct ril_data *rd =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(NULL, modem, rd);
>
>   	DBG("%p", modem);
>
> -	ril_send_power(rd, FALSE, NULL, NULL);
> +	ril_send_power(rd, FALSE, power_off_cb, cbd);
>
> -	return 0;
> +	return -EINPROGRESS;
>   }
>
>   static struct ofono_modem_driver ril_driver =3D {
>

Regards,
-Denis

--===============6793378659851952493==--

