Content-Type: multipart/mixed; boundary="===============0662639100490589394=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Core support for packet switched bearer reporting
Date: Fri, 07 Jan 2011 10:25:32 -0600
Message-ID: <4D273E7C.7080605@gmail.com>
In-Reply-To: <1294416127-22432-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0662639100490589394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/07/2011 10:02 AM, R=C3=A9mi Denis-Courmont wrote:
> ---
>  include/gprs.h |    2 ++
>  src/gprs.c     |   32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 0 deletions(-)
> =


please see the 'Submitting patches' section in HACKING

> diff --git a/include/gprs.h b/include/gprs.h
> index 1c1d116..cd62f2f 100644
> --- a/include/gprs.h
> +++ b/include/gprs.h
> @@ -59,6 +59,8 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs, =
int status, int tech);
>  void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
>  void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
>  void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
> +void ofono_gprs_bearer_notify(struct ofono_gprs *gprs,
> +				unsigned int cid, int bearer);
>  =

>  int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
>  void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
> diff --git a/src/gprs.c b/src/gprs.c
> index bd52676..3d4b1a8 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -107,6 +107,7 @@ struct context_settings {
>  =

>  struct pri_context {
>  	ofono_bool_t active;
> +	int bearer;
>  	enum ofono_gprs_context_type type;
>  	char name[MAX_CONTEXT_NAME_LENGTH + 1];
>  	char message_proxy[MAX_MESSAGE_PROXY_LENGTH + 1];
> @@ -596,6 +597,13 @@ static void append_context_properties(struct pri_con=
text *ctx,
>  	value =3D ctx->active;
>  	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN, &value);
>  =

> +	if (ctx->active) {
> +		const char *bearer =3D packet_bearer_to_string(ctx->bearer);
> +
> +		ofono_dbus_dict_append(dict, "Bearer",
> +					DBUS_TYPE_STRING, &bearer);
> +	}
> +
>  	ofono_dbus_dict_append(dict, "Type", DBUS_TYPE_STRING, &type);
>  =

>  	ofono_dbus_dict_append(dict, "Protocol", DBUS_TYPE_STRING, &proto);
> @@ -1591,6 +1599,7 @@ static struct pri_context *add_context(struct ofono=
_gprs *gprs,
>  		return NULL;
>  	}
>  =

> +	context->bearer =3D -1;

You might also want to reset the bearer to -1 when the context is
deactivated.

>  	context->id =3D id;
>  =

>  	DBG("Registering new context");
> @@ -2001,6 +2010,29 @@ void ofono_gprs_add_context(struct ofono_gprs *gpr=
s,
>  	__ofono_atom_register(gc->atom, gprs_context_unregister);
>  }
>  =

> +void ofono_gprs_bearer_notify(struct ofono_gprs *gprs,
> +				unsigned int cid, int bearer)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	GSList *l;
> +	const char *value =3D packet_bearer_to_string(bearer);

Why bother running this operation before you're sure you're going to
emit the signal?  Please move this down.

> +
> +	for (l =3D gprs->contexts; l; l =3D l->next) {
> +		struct pri_context *ctx =3D l->data;
> +
> +		if (ctx->context.cid !=3D cid)
> +			continue;
> +
> +		if (ctx->bearer =3D=3D bearer)
> +			continue;

Shouldn't this be return instead of continue?

> +
> +		ctx->bearer =3D bearer;
> +		ofono_dbus_signal_property_changed(conn, ctx->path,
> +					OFONO_CONNECTION_CONTEXT_INTERFACE,
> +					"Bearer", DBUS_TYPE_STRING, &value);
> +	}
> +}
> +
>  void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
>  					unsigned int cid)
>  {

Regards,
-Denis

--===============0662639100490589394==--

