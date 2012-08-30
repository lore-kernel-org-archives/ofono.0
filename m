Content-Type: multipart/mixed; boundary="===============0616005474086421211=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/4] stkagent: Add new API to get digit response on
 single key press
Date: Thu, 30 Aug 2012 17:00:05 -0500
Message-ID: <503FE265.80500@gmail.com>
In-Reply-To: <1346160082-11077-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0616005474086421211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 08/28/2012 08:21 AM, Philippe Nunes wrote:
> ---
>   src/stkagent.c |   32 ++++++++++++++++++++++++++++++++
>   src/stkagent.h |    5 +++++
>   2 files changed, 37 insertions(+)
>

Patch has been applied, however...

> diff --git a/src/stkagent.c b/src/stkagent.c
> index 7c3f697..63b82f3 100644
> --- a/src/stkagent.c
> +++ b/src/stkagent.c
> @@ -584,6 +584,38 @@ int stk_agent_request_digit(struct stk_agent *agent,=
 const char *text,
>   	return 0;
>   }
>
> +int stk_agent_request_quick_digit(struct stk_agent *agent, const char *t=
ext,
> +				const struct stk_icon_id *icon,
> +				stk_agent_string_cb cb, void *user_data,
> +				ofono_destroy_func destroy, int timeout)

The indentation is not in line with the coding standard item M4.  I =

amended this patch manually here and...

> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
> +							OFONO_SIM_APP_INTERFACE,
> +							"RequestQuickDigit");
> +	if (agent->msg =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	dbus_message_append_args(agent->msg,
> +					DBUS_TYPE_STRING,&text,
> +					DBUS_TYPE_BYTE,&icon->id,
> +					DBUS_TYPE_INVALID);
> +
> +	if (dbus_connection_send_with_reply(conn, agent->msg,&agent->call,
> +						timeout) =3D=3D FALSE ||
> +			agent->call =3D=3D NULL)
> +		return -EIO;
> +
> +	agent->user_cb =3D cb;
> +	agent->user_data =3D user_data;
> +	agent->user_destroy =3D destroy;
> +
> +	dbus_pending_call_set_notify(agent->call, get_digit_cb, agent, NULL);
> +
> +	return 0;
> +}
> +
>   static void get_key_cb(DBusPendingCall *call, void *data)
>   {
>   	struct stk_agent *agent =3D data;
> diff --git a/src/stkagent.h b/src/stkagent.h
> index 6e267fc..f66f038 100644
> --- a/src/stkagent.h
> +++ b/src/stkagent.h
> @@ -102,6 +102,11 @@ int stk_agent_request_digit(struct stk_agent *agent,=
 const char *text,
>   				stk_agent_string_cb cb, void *user_data,
>   				ofono_destroy_func destroy, int timeout);
>
> +int stk_agent_request_quick_digit(struct stk_agent *agent, const char *t=
ext,
> +				const struct stk_icon_id *icon,
> +				stk_agent_string_cb cb, void *user_data,
> +				ofono_destroy_func destroy, int timeout);
> +

here

>   int stk_agent_request_key(struct stk_agent *agent, const char *text,
>   				const struct stk_icon_id *icon,
>   				ofono_bool_t unicode_charset,

Regards,
-Denis

--===============0616005474086421211==--

