Content-Type: multipart/mixed; boundary="===============1786416842379591413=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH v4 4/8] gprs: Add private APIs for
 adding/activating/removing hidden PDP contexts
Date: Fri, 10 Jun 2011 11:44:51 +0200
Message-ID: <4DF1E793.1050608@linux.intel.com>
In-Reply-To: <4DE5D9B9.6090506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1786416842379591413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 06/01/2011 08:18 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 05/20/2011 11:26 AM, Philippe Nunes wrote:
>> ---
>>   src/gprs.c  |  239 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   src/ofono.h |   24 ++++++
>>   2 files changed, 263 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/gprs.c b/src/gprs.c
>> index 9657a3e..86d95bc 100644
>> --- a/src/gprs.c
>> +++ b/src/gprs.c
>> @@ -147,6 +147,8 @@ struct pri_context {
>>   	struct ofono_gprs_primary_context context;
>>   	struct ofono_gprs_context *context_driver;
>>   	struct ofono_gprs *gprs;
>> +	void *notify;
>> +	void *notify_data;
>>   };
>>
>
> Modifying pri_context for this does not seem like a good idea, I suggest
> you make your own structure since pretty much all the members of this
> structure are not relevant to what you're trying to accomplish.
>
> As a general philosophy we prefer clearer code (even if there's more of
> it) than trying to complicate the logic of code designed for a
> completely different purpose.
>

Ok, I can remove this callback pointer since this callback is only =

needed for the private primary context created by the STK atom.

>>   static void gprs_netreg_update(struct ofono_gprs *gprs);
>> @@ -356,6 +358,35 @@ static struct pri_context *gprs_context_by_path(str=
uct ofono_gprs *gprs,
>>   	return NULL;
>>   }
>>
>> +static struct pri_context *gprs_context_by_id(struct ofono_gprs *gprs,
>> +						unsigned int id)
>> +{
>> +	GSList *l;
>> +
>> +	for (l =3D gprs->contexts; l; l =3D l->next) {
>> +		struct pri_context *ctx =3D l->data;
>> +
>> +		if (ctx->id =3D=3D id)
>> +			return ctx;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct pri_context *gprs_get_default_context(struct ofono_gprs *=
gprs)
>> +{
>> +	GSList *l;
>> +
>> +	for (l =3D gprs->contexts; l; l =3D l->next) {
>> +		struct pri_context *ctx =3D l->data;
>> +
>> +		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_INTERNET)
>> +			return ctx;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   static void context_settings_free(struct context_settings *settings)
>>   {
>>   	if (settings->ipv4) {
>> @@ -537,6 +568,9 @@ static void signal_settings(struct pri_context *ctx,=
 const char *prop,
>>   	DBusMessageIter iter;
>>   	struct context_settings *settings;
>>
>> +	if (path =3D=3D NULL)
>> +		return;
>> +
>>   	signal =3D dbus_message_new_signal(path,
>>   					OFONO_CONNECTION_CONTEXT_INTERFACE,
>>   					"PropertyChanged");
>> @@ -2968,3 +3002,208 @@ void *ofono_gprs_get_data(struct ofono_gprs *gpr=
s)
>>   {
>>   	return gprs->driver_data;
>>   }
>> +
>> +unsigned int __ofono_gprs_add_pdp_context(struct ofono_gprs *gprs,
>> +				enum ofono_gprs_context_type context_type,
>> +				enum ofono_gprs_proto proto,
>> +				const char *apn,
>> +				const char *username,
>> +				const char *password,
>> +				const char *host)
>
> What is the purpose of the host parameter? Doesn't STK use IP addresses
> for the destination?
>

Here, the purpose of the host parameter is to set the interface with a =

special host route (id the IP stream with this host/destination address =

has to go through this interface).
Indeed, I need to bind the UDP/TCP socket to the interface created =

precisely for STK purpose.
But, I can remove this parameter since you suggested to make =

pri_setproxy (gprs.c) into a utility function and call it from stk.c

>> +{
>
> Returning int here would be better:
>
>> +	unsigned int id;
>> +	struct pri_context *context;
>> +	struct pri_context *default_ctx =3D NULL;
>> +	const char *name;
>> +
>> +	/* Sanity check */
>> +	if (apn&&  strlen(apn)>  OFONO_GPRS_MAX_APN_LENGTH)
>> +		return 0;
>
> Then you can return meaningful error here, e.g. -EINVAL
>
>> +
>> +	if (username&&  strlen(username)>  OFONO_GPRS_MAX_USERNAME_LENGTH)
>> +		return 0;
>> +
>> +	if (password&&  strlen(password)>  OFONO_GPRS_MAX_PASSWORD_LENGTH)
>> +		return 0;
>> +
>> +	if (apn =3D=3D NULL || (username =3D=3D NULL&&  password =3D=3D NULL))=
 {
>> +		/* take the default primary internet context */
>> +		default_ctx =3D gprs_get_default_context(gprs);
>> +
>> +		if (default_ctx =3D=3D NULL&&  apn =3D=3D NULL)
>> +			return 0;
>
> Maybe ENOENT here
>
>> +	}
>> +
>> +	if (apn&&  is_valid_apn(apn) =3D=3D FALSE)
>> +		return 0;
>> +
>
> etc
>
> This will allow you to return meaningful terminal responses in case
> things fail.
>
>> +	name =3D gprs_context_default_name(context_type);
>> +	if (name =3D=3D NULL)
>> +		return 0;
>> +
>> +	if (gprs->last_context_id)
>> +		id =3D idmap_alloc_next(gprs->pid_map, gprs->last_context_id);
>> +	else
>> +		id =3D idmap_alloc(gprs->pid_map);
>> +
>> +	if (id>  idmap_get_max(gprs->pid_map))
>> +		return 0;
>> +
>> +	context =3D pri_context_create(gprs, name, context_type);
>> +	if (context =3D=3D NULL) {
>> +		idmap_put(gprs->pid_map, id);
>> +		return 0;
>> +	}
>> +
>
> As mentioned previously, I don't see the point of creating pri_context
> structure for this.  So you can rip much of this stuff out.


I don't understand why you think we don't need to create a pri_context.
Could you clarify please?

Even if no parameters are provided by the UICC (id use default =

parameters), I still need to setup a dedicated primary context with =

defaults parameters since we can't double-activate an existing primary =

context.

>
>> +	context->id =3D id;
>> +
>> +	if (username !=3D NULL)
>> +		strcpy(context->context.username, username);
>> +
>> +	if (password !=3D NULL)
>> +		strcpy(context->context.password, password);
>> +
>> +	if (username =3D=3D NULL&&  password =3D=3D NULL&&  default_ctx) {
>> +		if (default_ctx->context.username)
>> +			strcpy(context->context.username,
>> +					default_ctx->context.username);
>> +		if (default_ctx->context.password)
>> +			strcpy(context->context.password,
>> +					default_ctx->context.password);
>> +	}
>> +
>> +	if (apn)
>> +		strcpy(context->context.apn, apn);
>> +	else if (default_ctx) {
>> +		strcpy(context->context.apn, default_ctx->context.apn);
>> +		if (default_ctx->context.username)
>> +			strcpy(context->context.username,
>> +					default_ctx->context.username);
>> +		if (default_ctx->context.password)
>> +			strcpy(context->context.password,
>> +					default_ctx->context.password);
>> +	}
>> +
>> +	context->context.proto =3D proto;
>> +
>> +	gprs->last_context_id =3D id;
>> +	gprs->contexts =3D g_slist_append(gprs->contexts, context);
>> +
>> +	return id;
>> +}
>> +
>> +static void activate_request_callback(const struct ofono_error *error,
>> +					void *data)
>> +{
>> +	struct pri_context *ctx =3D data;
>> +	struct ofono_gprs_context *gc =3D ctx->context_driver;
>> +
>> +	DBG("%p", ctx);
>> +
>> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>> +		DBG("Activating context failed with error: %s",
>> +				telephony_error_to_str(error));
>> +		context_settings_free(ctx->context_driver->settings);
>> +		release_context(ctx);
>> +
>> +		if (ctx->notify)
>> +			((__ofono_gprs_add_pdp_context_cb_t) ctx->notify)
>> +				(-ENOSYS, NULL, NULL, ctx->notify_data);
>> +		return;
>> +	}
>> +
>> +	ctx->active =3D TRUE;
>> +
>> +	if (gc->settings->interface !=3D NULL) {
>> +		pri_ifupdown(gc->settings->interface, TRUE);
>> +
>> +		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_STK&&
>> +						gc->settings->ipv4) {
>> +			pri_set_ipv4_addr(gc->settings->interface,
>> +							gc->settings->ipv4->ip);
>> +		}
>> +	}
>> +
>> +	if (ctx->notify&&  gc->settings->ipv4)
>> +		((__ofono_gprs_add_pdp_context_cb_t) ctx->notify)
>> +					(0, gc->settings->interface,
>> +						gc->settings->ipv4->ip,
>> +						ctx->notify_data);
>> +}
>> +
>> +int __ofono_gprs_activate_pdp_context(struct ofono_gprs *gprs, unsigned=
 int id,
>> +					__ofono_gprs_add_pdp_context_cb_t cb,
>> +					void *data)
>> +{
>> +	struct pri_context *ctx;
>> +	struct ofono_gprs_context *gc;
>> +
>> +	ctx =3D gprs_context_by_id(gprs, id);
>> +	if (ctx =3D=3D NULL)
>> +		return -EINVAL;
>> +
>> +	if (ctx->active =3D=3D TRUE)
>> +		return 0;
>> +
>> +	if (assign_context(ctx) =3D=3D FALSE)
>> +		return -ENOSYS;
>> +
>> +	gc =3D ctx->context_driver;
>> +
>> +	ctx->notify =3D cb;
>> +	ctx->notify_data =3D data;
>> +
>> +	gc->driver->activate_primary(gc,&ctx->context,
>> +					activate_request_callback, ctx);
>> +	return 0;
>> +}
>> +
>> +static void remove_request_callback(const struct ofono_error *error,
>> +					void *data)
>> +{
>> +	struct pri_context *ctx =3D data;
>> +	struct ofono_gprs *gprs =3D ctx->gprs;
>> +	int err =3D 0;
>> +
>> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>> +		DBG("Removing context failed with error: %s",
>> +				telephony_error_to_str(error));
>> +		err =3D -ENOSYS;
>> +	}
>> +
>> +	pri_reset_context_settings(ctx);
>> +	release_context(ctx);
>> +	idmap_put(gprs->pid_map, ctx->id);
>> +	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
>> +
>> +	if (ctx->notify)
>> +		((__ofono_gprs_remove_pdp_context_cb_t) ctx->notify)
>> +				(err, ctx->notify_data);
>> +}
>> +
>> +int __ofono_gprs_remove_pdp_context(struct ofono_gprs *gprs, unsigned i=
nt id,
>> +					__ofono_gprs_remove_pdp_context_cb_t cb,
>> +					void *data)
>> +{
>> +	struct pri_context *ctx;
>> +
>> +	ctx =3D gprs_context_by_id(gprs, id);
>> +	if (ctx =3D=3D NULL)
>> +		return -EINVAL;
>> +
>> +	if (ctx->active) {
>> +		struct ofono_gprs_context *gc =3D ctx->context_driver;
>> +
>> +		ctx->notify =3D cb;
>> +		ctx->notify_data =3D data;
>> +
>> +		gc->driver->deactivate_primary(gc, ctx->context.cid,
>> +					remove_request_callback, ctx);
>> +		return -EINPROGRESS;
>> +	}
>> +
>> +	idmap_put(gprs->pid_map, ctx->id);
>> +	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
>> +
>> +	return 0;
>> +}
>> diff --git a/src/ofono.h b/src/ofono.h
>> index 82d7e34..ee5864d 100644
>> --- a/src/ofono.h
>> +++ b/src/ofono.h
>> @@ -239,6 +239,30 @@ gboolean __ofono_call_settings_is_busy(struct ofono=
_call_settings *cs);
>>   #include<ofono/phonebook.h>
>>   #include<ofono/gprs.h>
>>   #include<ofono/gprs-context.h>
>> +
>> +typedef void (*__ofono_gprs_add_pdp_context_cb_t)(int error,
>> +						const char *interface,
>> +						const char *ip,
>> +						void *data);
>> +
>> +typedef void (*__ofono_gprs_remove_pdp_context_cb_t)(int error, void *d=
ata);
>> +
>> +unsigned int __ofono_gprs_add_pdp_context(struct ofono_gprs *gprs,
>> +					enum ofono_gprs_context_type type,
>> +					enum ofono_gprs_proto proto,
>> +					const char *apn,
>> +					const char *username,
>> +					const char *password,
>> +					const char *host);
>> +
>
> I don't think this is needed at all.  All STK needs to do is just say
> 'please activate a context with these params'.  You can pretty much get
> away with __ofono_gprs_activate_context and __ofono_gprs_deactivate_conte=
xt.
>

When "on link demand" mode is requested, we just need to setup the PDP =

context and return the PDP identifier. The PDP context activation is =

done only once we receive a proactive command SEND DATA with the =

qualifier "Send data immediately".
So, I don't see how to differentiate this mode without the API =

"__ofono_gprs_add_pdp_context".


>> +int __ofono_gprs_remove_pdp_context(struct ofono_gprs *gprs, unsigned i=
nt id,
>> +					__ofono_gprs_remove_pdp_context_cb_t cb,
>> +					void *data);
>> +
>
> Are you sure you really need the callback function here?  The spec is a
> little fuzzy on when the terminal response is actually sent.


At first sight, yes, that was also my opinion but then I saw the =

examples in annex I (TS 102 223).

For Close channel, we can see the following sequence:

UICC		     Terminal 				SGSN

|--------------------->	|				|
|    Close Channel	|				|
|			| -------------------------->   |
|			| Deactivate PDP context request|
|			| <-----------------------------|
|			| Deactivate PDP context accept |
|<----------------------
    Terminal response

That's why, I introduced the callback to trigger the Terminal response.

Regards,

Philippe.

>
>> +int __ofono_gprs_activate_pdp_context(struct ofono_gprs *gprs, unsigned=
 int id,
>> +					__ofono_gprs_add_pdp_context_cb_t cb,
>> +					void *data);
>> +
>>   #include<ofono/radio-settings.h>
>>   #include<ofono/audio-settings.h>
>>   #include<ofono/ctm.h>
>
> Regards,
> -Denis
>


--===============1786416842379591413==--

