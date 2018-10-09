Content-Type: multipart/mixed; boundary="===============2807753468866489152=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] netmon: Added netmon driver for xmm7modem
Date: Tue, 09 Oct 2018 12:56:32 -0500
Message-ID: <4907c3b3-8022-4cdc-95dc-2d02b9119e6e@gmail.com>
In-Reply-To: <1539085295-4427-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2807753468866489152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 10/09/2018 06:41 AM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>
> =

> adding netmon driver for xmm7modem which uses intel proprietary
> AT command +XMCI
> ---
>   drivers/xmm7modem/netmon.c    | 264 +++++++++++++++++++++++++++++++++++=
+++++++
>   drivers/xmm7modem/xmm7modem.c |   3 +-
>   drivers/xmm7modem/xmm7modem.h |   3 +
>   3 files changed, 269 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/xmm7modem/netmon.c
> =


Applied with a few tweaks:

> +static void xmm7modem_netmon_request_update(struct ofono_netmon *netmon,
> +					ofono_netmon_cb_t cb, void *data)
> +{
> +	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +	DBG("xmm7modem netmon request update");
> +
> +	if (g_at_chat_send(nmd->chat, "AT+XMCI=3D1", xmci_prefix,
> +				xmci_cb, cbd, g_free) =3D=3D 0) {
> +		CALLBACK_WITH_FAILURE(cb, data);
> +	}

I changed this part to
if (g_at_chat_send(...) > 0)
	return;

CALLBACK_WITH_FAILURE(...);

> +}
> +

<snip>

> +static int xmm7modem_netmon_probe(struct ofono_netmon *netmon,
> +					unsigned int vendor, void *user)
> +{
> +	GAtChat *chat =3D user;
> +	struct netmon_driver_data *nmd;
> +
> +	DBG("xmm7modem netmon probe");
> +
> +	nmd =3D g_new0(struct netmon_driver_data, 1);
> +	if (nmd =3D=3D NULL)
> +		return -ENOMEM;

g_new0 cannot fail (it aborts if memory isn't available).  So this if =

statement was removed.

> +
> +	nmd->chat =3D g_at_chat_clone(chat);
> +
> +	ofono_netmon_set_data(netmon, nmd);
> +
> +	g_idle_add(ril_delayed_register, netmon);
> +
> +	return 0;
> +}
> +

Regards,
-Denis

--===============2807753468866489152==--

