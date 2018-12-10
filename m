Content-Type: multipart/mixed; boundary="===============7973564148410804995=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] xmm7xxx: implementation of coex functionality
Date: Mon, 10 Dec 2018 15:22:34 -0600
Message-ID: <3551a121-1b92-45f4-4b00-e72375d2c230@gmail.com>
In-Reply-To: <1544361997-26868-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7973564148410804995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 12/09/2018 07:26 AM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>
> =

> Added implementation for coex functionality for xmm7xxx modem
> ---
>   plugins/xmm7xxx.c | 936 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   1 file changed, 935 insertions(+), 1 deletion(-)
> =

> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
> index 195f96b..9ebe8b6 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c

<snip>

> +
> +void xmm_get_band_string(int lte_band, char *band)
> +{
> +	int band_lte =3D lte_band-NET_BAND_LTE_1+1;

doc/coding-style.txt item M1

> +	if (lte_band >=3D NET_BAND_LTE_1 && lte_band <=3D NET_BAND_LTE_43)
> +		sprintf(band, "BAND_LTE_%d", band_lte);
> +	else
> +		sprintf(band, "INVALID");
> +}
> +
<snip>

> +static DBusMessage *coex_get_plmn_history(DBusConnection *conn,
> +			DBusMessage *msg, void *data)
> +{
> +	struct xmm7xxx_coex *coex =3D data;
> +
> +	if (coex->pending)
> +		return __ofono_error_busy(msg);
> +
> +

No double empty lines please

> +	if (!g_at_chat_send(coex->chat, "AT+XNVMPLMN=3D2,2", xnvmplmn_prefix,
> +				coex_get_plmn_history_cb, coex, NULL))
> +		return __ofono_error_failed(msg);
> +
> +	coex->pending =3D dbus_message_ref(msg);
> +	return NULL;
> +}
> +

<snip>

> +static void coex_cleanup(void *data)
> +{
> +	struct xmm7xxx_coex *coex =3D data;
> +
> +	if (coex->pending)
> +		__ofono_dbus_pending_reply(&coex->pending,
> +					__ofono_error_canceled(coex->pending));
> +
> +	if (coex->session_agent) {
> +		coex_agent_free(coex->session_agent);
> +
> +		g_at_chat_send(coex->chat, "AT+XNRTCWS=3D0", none_prefix,
> +					NULL, NULL, NULL);
> +	}

So who is freeing the coex structure?  Have you tried this in valgrind?

It also looks like coex_default_agent_notify() doesn't reset =

coex->session_agent to NULL, so you are probably crashing here...

> +}
> +
> +static int xmm_coex_enable(struct ofono_modem *modem, void *data)
> +{
> +	struct xmm7xxx_coex *coex;
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D ofono_modem_get_path(modem);
> +	coex =3D g_new0(struct xmm7xxx_coex, 1);
> +
> +	DBG("coex enable");
> +
> +	coex->chat =3D data;
> +	coex->modem =3D modem;
> +	coex->bt_active =3D 0;
> +	coex->wlan_active =3D 0;
> +	coex->wlan_bw =3D WLAN_BW_20MHZ;
> +	coex->lte_band =3D g_strdup("INVALID");

Hm, it might be more elegant to bootstrap this info and then register =

the D-Bus interface, but okay.

> +	coex->session_agent =3D NULL;
> +
> +	if (g_at_chat_send(coex->chat, "AT+XCCINFO=3D1", none_prefix,
> +				NULL, NULL, NULL) < 0)

g_at_chat_send returns a uint, with 0 meaning error.  So this if =

statement is not doing anything...

> +		goto out;
> +
> +	if (!g_dbus_register_interface(conn, path, OFONO_COEX_INTERFACE,
> +					coex_methods,
> +					coex_signals,
> +					NULL, coex, coex_cleanup)) {
> +		ofono_error("Could not register %s interface under %s",
> +					OFONO_COEX_INTERFACE, path);
> +		goto out;
> +	}
> +
> +	ofono_modem_add_interface(modem, OFONO_COEX_INTERFACE);
> +
> +	g_at_chat_register(coex->chat, "+XNRTCWSW:", xmm_coex_w_notify,
> +					FALSE, coex, NULL);
> +	g_at_chat_register(coex->chat, "+XNRTCWSB:", xmm_coex_b_notify,
> +					FALSE, coex, NULL);
> +	g_at_chat_register(coex->chat, "+XCCINFO:", xmm_lte_band_notify,
> +					FALSE, coex, NULL);
> +	return 0;
> +
> +out:
> +	g_free(coex->lte_band);
> +	g_free(coex);
> +	return -EIO;
> +}
> +
> +/* Coex Implementation Ends*/
> +
>   static void xmm7xxx_debug(const char *str, void *user_data)
>   {
>   	const char *prefix =3D user_data;

<snip>

> @@ -377,7 +1312,6 @@ static int xmm7xxx_probe(struct ofono_modem *modem)
>   		return -ENOMEM;
>   =

>   	ofono_modem_set_data(modem, data);
> -

This is a spurious change, please take it out.

>   	return 0;
>   }
>   =

> =


Regards,
-Denis

--===============7973564148410804995==--

