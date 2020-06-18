Content-Type: multipart/mixed; boundary="===============3914663979225431500=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] create stk atom for Esim Handling
Date: Thu, 18 Jun 2020 15:32:36 -0500
Message-ID: <0acd4a00-a264-0d43-64b8-b374d90feaf7@gmail.com>
In-Reply-To: <1591859177-23599-1-git-send-email-shweta2.jain@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3914663979225431500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shweta,

On 6/11/20 2:06 AM, shweta wrote:
> From: Shweta Jain <shweta2.jain@intel.com>
> =

> ---
>   plugins/xmm7xxx.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> =


This patch does not apply cleanly.  In fact, I see three distinct series fr=
om =

you and it isn't clear in what order I would even apply these.  Since it lo=
oks =

like all these series are related, can you please rebase all patches on top=
 of =

git HEAD (for example, via 'git pull --rebase') and resubmit the entire set=
 as a =

single series?

> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
> index 6afc8cb..3959583 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c
> @@ -123,6 +123,8 @@ struct xmm7xxx_data {
>   	int coex_lte_id;
>   	int coex_wlan_id;
>   	int coex_bt_id;
> +	ofono_bool_t stk_enable;
> +	ofono_bool_t enable_euicc;
>   };
>   =

>   /* eUICC Implementation */
> @@ -1888,7 +1890,10 @@ static void switch_sim_state_status(struct ofono_m=
odem *modem, int status)
>   			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
>   			data->sms_phonebook_added =3D TRUE;
>   		}
> -
> +		break;
> +	case 18:
> +		data->enable_euicc=3DTRUE;
> +		ofono_warn("Esim State With no Profile %d  ", status);

why ofono_warn?

>   		break;
>   	default:
>   		ofono_warn("Unknown SIM state %d received", status);
> @@ -2077,15 +2082,24 @@ static void xmm7xxx_pre_sim(struct ofono_modem *m=
odem)
>   	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_XMM, "atmodem",
>   					data->chat);
>   	xmm_euicc_enable(modem, data->chat);
> +	ofono_stk_create(modem, OFONO_VENDOR_XMM, "atmodem", data->chat);

Generally STK isn't available until the PIN has been entered, and thus shou=
ld be =

available only in post_sim state.  Is esim somehow different?

>   }
>   =

>   static void set_online_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
>   {
>   	struct cb_data *cbd =3D user_data;
>   	ofono_modem_online_cb_t cb =3D cbd->cb;
> +	char * strng =3D cbd->cb;

What does this do??

> +	DBG("");

Hmm, not sure what compiler you're using, but C99 doesn't support mixed =

declarations and expressions.  Nor does our coding style.  Please move this =

after all the variable declaration block.

>   	struct ofono_error error;
> -
> +	struct ofono_modem *modem =3D cbd->data;
> +	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
>   	decode_at_error(&error, g_at_result_final_response(result));
> +	if(data->enable_euicc=3D=3DTRUE && data->stk_enable=3D=3DTRUE )
> +	{
> +	  g_at_chat_send(data->chat, "AT+CFUN=3D16", none_prefix,
> +						NULL, NULL, NULL);
> +	}

Okay, but this is not following our coding style.  Refer to doc/coding-styl=
e.txt =

for details.

>   	cb(&error, cbd->data);
>   }
>   =

> @@ -2108,8 +2122,10 @@ static void xmm7xxx_set_online(struct ofono_modem =
*modem, ofono_bool_t online,
>   		data->coex_wlan_id =3D 0;
>   		g_at_chat_unregister(data->chat, data->coex_bt_id);
>   		data->coex_bt_id =3D 0;
> +		data->stk_enable=3DFALSE;
>   	}
> -
> +	else
> +	 data->stk_enable=3DTRUE;

Coding style is all wrong here...

>   	if (g_at_chat_send(data->chat, command, none_prefix,
>   					set_online_cb, cbd, g_free) > 0) {
>   		if (online)
> =


Regards,
-Denis
--===============3914663979225431500==--

