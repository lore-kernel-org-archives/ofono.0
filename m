Content-Type: multipart/mixed; boundary="===============2766793153116988907=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: [PATCH] plugins/ril.c: avoid create a gril each time enable ril
 modem
Date: Tue, 12 Jan 2016 14:48:28 -0500
Message-ID: <5695588C.3020009@canonical.com>
In-Reply-To: <1452569999-15593-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2766793153116988907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/11/2016 10:39 PM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> ---
>   plugins/ril.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/plugins/ril.c b/plugins/ril.c
> index ea50d76..688a5bf 100644
> --- a/plugins/ril.c
> +++ b/plugins/ril.c
> @@ -400,9 +400,13 @@ static gboolean connect_rild(gpointer user_data)
>   int ril_enable(struct ofono_modem *modem)
>   {
>   	int ret;
> +  struct ril_data *rd =3D ofono_modem_get_data(modem);
>
>   	DBG("");
>
> +	if (rd->ril)
> +		return 0;
> +
>   	ret =3D create_gril(modem);
>   	if (ret < 0)
>   		g_timeout_add_seconds(RILD_CONNECT_RETRY_TIME_S,
>

Caiwen --

Thanks for the patch! It looks you are catching a valid error scenario, =

however although your fix avoids duplicate gril instances from being
created, the correct fix involves cleaning up the gril instance in =

ril_disable(), in addition to calling ril_send_power(rd, FALSE, ...).

This scenario is something we never actually exercised on Ubuntu Touch, =

as we always power the modem on boot, and only power it off when the =

system shuts down.

Regards,
/tony



--===============2766793153116988907==--

