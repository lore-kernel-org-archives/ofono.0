Content-Type: multipart/mixed; boundary="===============6297927319977790230=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] use ofono_error instead of DBG for errors
Date: Fri, 17 Dec 2010 10:29:29 -0600
Message-ID: <4D0B8FE9.50109@gmail.com>
In-Reply-To: <1292522679-15454-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6297927319977790230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 12/16/2010 12:04 PM, Gustavo F. Padovan wrote:
> ---
>  src/call-barring.c    |    6 +++---
>  src/call-forwarding.c |    8 ++++----
>  src/call-meter.c      |    6 +++---
>  src/call-settings.c   |   14 +++++++-------
>  src/cbs.c             |    2 +-
>  src/ctm.c             |    4 ++--
>  src/gprs.c            |    6 +++---
>  src/network.c         |    8 ++++----
>  src/radio-settings.c  |   12 ++++++------
>  src/sms.c             |    4 ++--
>  src/ussd.c            |    2 +-
>  src/voicecall.c       |    6 +++---
>  12 files changed, 39 insertions(+), 39 deletions(-)
> =


Actually some of these should be DBG and not ofono_error.  In many of
these cases the input depends on the user (e.g. having the right
password, etc) so reporting an error is the wrong thing to do.  In other
cases the error depends on the network state, etc.

> diff --git a/src/call-barring.c b/src/call-barring.c
> index bb15530..95f489e 100644
> --- a/src/call-barring.c
> +++ b/src/call-barring.c
> @@ -327,7 +327,7 @@ static void cb_ss_set_lock_callback(const struct ofon=
o_error *error,
>  	struct ofono_call_barring *cb =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Enabling/disabling Call Barring via SS failed");
> +		ofono_error("Enabling/disabling Call Barring via SS failed");
>  		__ofono_dbus_pending_reply(&cb->pending,
>  					__ofono_error_failed(cb->pending));
>  		return;

For instance, this one requires PIN2

> @@ -733,7 +733,7 @@ static void set_lock_callback(const struct ofono_erro=
r *error, void *data)
>  	struct ofono_call_barring *cb =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Enabling/disabling a lock failed");
> +		ofono_error("Enabling/disabling a lock failed");
>  		__ofono_dbus_pending_reply(&cb->pending,
>  					__ofono_error_failed(cb->pending));
>  		return;

Same as above

> @@ -883,7 +883,7 @@ static void disable_all_callback(const struct ofono_e=
rror *error, void *data)
>  	struct ofono_call_barring *cb =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Disabling all barring failed");
> +		ofono_error("Disabling all barring failed");
>  		__ofono_dbus_pending_reply(&cb->pending,
>  					__ofono_error_failed(cb->pending));

And here

>  		return;
> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index bb8aa37..9a2fd85 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -549,7 +549,7 @@ static void set_property_callback(const struct ofono_=
error *error, void *data)
>  	struct ofono_call_forwarding *cf =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error occurred during set/erasure");
> +		ofono_error("Error occurred during set/erasure");
>  		__ofono_dbus_pending_reply(&cf->pending,
>  					__ofono_error_failed(cf->pending));
>  		return;
> @@ -674,7 +674,7 @@ static void disable_conditional_callback(const struct=
 ofono_error *error,
>  	struct ofono_call_forwarding *cf =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error occurred during conditional erasure");
> +		ofono_error("Error occurred during conditional erasure");
>  =

>  		__ofono_dbus_pending_reply(&cf->pending,
>  					__ofono_error_failed(cf->pending));
> @@ -692,7 +692,7 @@ static void disable_all_callback(const struct ofono_e=
rror *error, void *data)
>  	struct ofono_call_forwarding *cf =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error occurred during erasure of all");
> +		ofono_error("Error occurred during erasure of all");
>  =

>  		__ofono_dbus_pending_reply(&cf->pending,
>  					__ofono_error_failed(cf->pending));
> @@ -877,7 +877,7 @@ static void cf_ss_control_callback(const struct ofono=
_error *error, void *data)
>  	struct ofono_call_forwarding *cf =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error occurred during cf ss control set/erasure");
> +		ofono_error("Error occurred during cf ss control set/erasure");
>  =

>  		__ofono_dbus_pending_reply(&cf->pending,
>  					__ofono_error_failed(cf->pending));

These depend on the network state and can fail...

> diff --git a/src/call-meter.c b/src/call-meter.c
> index ac3ae6b..8a45d15 100644
> --- a/src/call-meter.c
> +++ b/src/call-meter.c
> @@ -336,7 +336,7 @@ static void set_acm_max_callback(const struct ofono_e=
rror *error, void *data)
>  	struct ofono_call_meter *cm =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Setting acm_max failed");
> +		ofono_error("Setting acm_max failed");
>  		__ofono_dbus_pending_reply(&cm->pending,
>  					__ofono_error_failed(cm->pending));
>  		return;
> @@ -397,7 +397,7 @@ static void set_puct_callback(const struct ofono_erro=
r *error, void *data)
>  	struct ofono_call_meter *cm =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("setting puct failed");
> +		ofono_error("setting puct failed");
>  		__ofono_dbus_pending_reply(&cm->pending,
>  					__ofono_error_failed(cm->pending));
>  		return;
> @@ -594,7 +594,7 @@ static void acm_reset_callback(const struct ofono_err=
or *error, void *data)
>  	struct ofono_call_meter *cm =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("reseting acm failed");
> +		ofono_error("reseting acm failed");
>  		__ofono_dbus_pending_reply(&cm->pending,
>  					__ofono_error_failed(cm->pending));
>  		return;

All these require PIN2

> diff --git a/src/call-settings.c b/src/call-settings.c
> index 49a7fb0..6ed85a1 100644
> --- a/src/call-settings.c
> +++ b/src/call-settings.c
> @@ -372,7 +372,7 @@ static void cw_ss_query_callback(const struct ofono_e=
rror *error, int status,
>  	struct ofono_call_settings *cs =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("setting CW via SS failed");
> +		ofono_error("setting CW via SS failed");
>  =

>  		cs->flags &=3D ~CALL_SETTINGS_FLAG_CACHED;
>  		__ofono_dbus_pending_reply(&cs->pending,
> @@ -391,7 +391,7 @@ static void cw_ss_set_callback(const struct ofono_err=
or *error, void *data)
>  	struct ofono_call_settings *cs =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("setting CW via SS failed");
> +		ofono_error("setting CW via SS failed");
>  		__ofono_dbus_pending_reply(&cs->pending,
>  					__ofono_error_failed(cs->pending));
>  =

> @@ -528,7 +528,7 @@ static void clip_colp_colr_ss_query_cb(const struct o=
fono_error *error,
>  	const char *value;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error occurred during ss control query");
> +		ofono_error("Error occurred during ss control query");
>  		__ofono_dbus_pending_reply(&cs->pending,
>  					__ofono_error_failed(cs->pending));
>  =

> @@ -628,7 +628,7 @@ static void clir_ss_query_callback(const struct ofono=
_error *error,
>  	const char *value;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("setting clir via SS failed");
> +		ofono_error("setting clir via SS failed");
>  		__ofono_dbus_pending_reply(&cs->pending,
>  					__ofono_error_failed(cs->pending));
>  =

> @@ -676,7 +676,7 @@ static void clir_ss_set_callback(const struct ofono_e=
rror *error, void *data)
>  	struct ofono_call_settings *cs =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("setting clir via SS failed");
> +		ofono_error("setting clir via SS failed");
>  		__ofono_dbus_pending_reply(&cs->pending,
>  					__ofono_error_failed(cs->pending));
>  =

> @@ -1007,7 +1007,7 @@ static void clir_set_callback(const struct ofono_er=
ror *error, void *data)
>  	struct ofono_call_settings *cs =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("setting clir failed");
> +		ofono_error("setting clir failed");
>  		__ofono_dbus_pending_reply(&cs->pending,
>  					__ofono_error_failed(cs->pending));
>  =

> @@ -1069,7 +1069,7 @@ static void cw_set_callback(const struct ofono_erro=
r *error, void *data)
>  	struct ofono_call_settings *cs =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error occurred during CW set");
> +		ofono_error("Error occurred during CW set");
>  =

>  		__ofono_dbus_pending_reply(&cs->pending,
>  					__ofono_error_failed(cs->pending));

These can all depend on the network state..

> diff --git a/src/cbs.c b/src/cbs.c
> index 8e4afc1..2694f56 100644
> --- a/src/cbs.c
> +++ b/src/cbs.c
> @@ -344,7 +344,7 @@ static void cbs_set_topics_cb(const struct ofono_erro=
r *error, void *data)
>  		g_slist_free(cbs->new_topics);
>  		cbs->new_topics =3D NULL;
>  =

> -		DBG("Setting Cell Broadcast topics failed");
> +		ofono_error("Setting Cell Broadcast topics failed");
>  		__ofono_dbus_pending_reply(&cbs->pending,
>  					__ofono_error_failed(cbs->pending));
>  		return;

This one is probably valid

> diff --git a/src/ctm.c b/src/ctm.c
> index 1df34c2..2c82c2e 100644
> --- a/src/ctm.c
> +++ b/src/ctm.c
> @@ -90,7 +90,7 @@ static void ctm_set_enabled_callback(const struct ofono=
_error *error,
>  	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error setting ctm enabled property");
> +		ofono_error("Error setting ctm enabled property");
>  =

>  		reply =3D __ofono_error_failed(ctm->pending);
>  		__ofono_dbus_pending_reply(&ctm->pending, reply);
> @@ -116,7 +116,7 @@ static void ctm_query_enabled_callback(const struct o=
fono_error *error,
>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		DBusMessage *reply;
>  =

> -		DBG("Error during ctm enabled query");
> +		ofono_error("Error during ctm enabled query");
>  =

>  		reply =3D __ofono_error_failed(ctm->pending);
>  		__ofono_dbus_pending_reply(&ctm->pending, reply);

And these ones as well

> diff --git a/src/gprs.c b/src/gprs.c
> index 58166f8..d767db9 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -661,7 +661,7 @@ static void pri_activate_callback(const struct ofono_=
error *error,
>  	DBG("%p %s", ctx, interface);
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Activating context failed with error: %s",
> +		ofono_error("Activating context failed with error: %s",
>  				telephony_error_to_str(error));
>  		__ofono_dbus_pending_reply(&ctx->pending,
>  					__ofono_error_failed(ctx->pending));

This one can fail, e.g. invalid username / password

> @@ -699,7 +699,7 @@ static void pri_deactivate_callback(const struct ofon=
o_error *error, void *data)
>  	dbus_bool_t value;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Deactivating context failed with error: %s",
> +		ofono_error("Deactivating context failed with error: %s",
>  				telephony_error_to_str(error));
>  		__ofono_dbus_pending_reply(&ctx->pending,
>  					__ofono_error_failed(ctx->pending));
> @@ -1657,7 +1657,7 @@ static void gprs_deactivate_for_remove(const struct=
 ofono_error *error,
>  	const char *atompath;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Removing context failed with error: %s",
> +		ofono_error("Removing context failed with error: %s",
>  				telephony_error_to_str(error));
>  =

>  		__ofono_dbus_pending_reply(&gprs->pending,

Rest are probably valid

> diff --git a/src/network.c b/src/network.c
> index 95af5d4..2529819 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -181,7 +181,7 @@ static void registration_status_callback(const struct=
 ofono_error *error,
>  	struct ofono_netreg *netreg =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error during registration status query");
> +		ofono_error("Error during registration status query");
>  		return;
>  	}
>  =

> @@ -1214,7 +1214,7 @@ static void current_operator_callback(const struct =
ofono_error *error,
>  		current =3D NULL;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error during current operator");
> +		ofono_error("Error during current operator");
>  		return;
>  	}
>  =

> @@ -1352,7 +1352,7 @@ static void signal_strength_callback(const struct o=
fono_error *error,
>  	struct ofono_netreg *netreg =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error during signal strength query");
> +		ofono_error("Error during signal strength query");
>  		return;
>  	}
>  =

> @@ -1366,7 +1366,7 @@ static void init_registration_status(const struct o=
fono_error *error,
>  	struct ofono_netreg *netreg =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error during registration status query");
> +		ofono_error("Error during registration status query");
>  		return;
>  	}
>  =


I'm fine with these being changed

> diff --git a/src/radio-settings.c b/src/radio-settings.c
> index 7a1f34b..bfc8f9b 100644
> --- a/src/radio-settings.c
> +++ b/src/radio-settings.c
> @@ -251,7 +251,7 @@ static void radio_fast_dormancy_set_callback(const st=
ruct ofono_error *error,
>  	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error setting fast dormancy");
> +		ofono_error("Error setting fast dormancy");
>  =

>  		rs->fast_dormancy_pending =3D rs->fast_dormancy;
>  =

> @@ -304,7 +304,7 @@ static void radio_band_set_callback(const struct ofon=
o_error *error,
>  	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error setting radio frequency band");
> +		ofono_error("Error setting radio frequency band");
>  =

>  		rs->pending_band_gsm =3D rs->band_gsm;
>  		rs->pending_band_umts =3D rs->band_umts;
> @@ -348,7 +348,7 @@ static void radio_mode_set_callback(const struct ofon=
o_error *error, void *data)
>  	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error setting radio access mode");
> +		ofono_error("Error setting radio access mode");
>  =

>  		rs->pending_mode =3D rs->mode;
>  =

> @@ -381,7 +381,7 @@ static void radio_fast_dormancy_query_callback(const =
struct ofono_error *error,
>  	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error during fast dormancy query");
> +		ofono_error("Error during fast dormancy query");
>  =

>  		reply =3D __ofono_error_failed(rs->pending);
>  		__ofono_dbus_pending_reply(&rs->pending, reply);
> @@ -413,7 +413,7 @@ static void radio_band_query_callback(const struct of=
ono_error *error,
>  	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error during radio frequency band query");
> +		ofono_error("Error during radio frequency band query");
>  =

>  		reply =3D __ofono_error_failed(rs->pending);
>  		__ofono_dbus_pending_reply(&rs->pending, reply);
> @@ -446,7 +446,7 @@ static void radio_rat_mode_query_callback(const struc=
t ofono_error *error,
>  	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error during radio access mode query");
> +		ofono_error("Error during radio access mode query");
>  =

>  		reply =3D __ofono_error_failed(rs->pending);
>  		__ofono_dbus_pending_reply(&rs->pending, reply);

I'm fine with the above since they're local queries, not going to the
network.

> diff --git a/src/sms.c b/src/sms.c
> index 163eab0..d77948c 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -576,7 +576,7 @@ static void bearer_set_callback(const struct ofono_er=
ror *error, void *data)
>  	struct ofono_sms *sms =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Setting Bearer failed");
> +		ofono_error("Setting Bearer failed");
>  		__ofono_dbus_pending_reply(&sms->pending,
>  					__ofono_error_failed(sms->pending));

This one is valid

>  		return;
> @@ -611,7 +611,7 @@ static void sca_set_callback(const struct ofono_error=
 *error, void *data)
>  	struct ofono_sms *sms =3D data;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Setting SCA failed");
> +		ofono_error("Setting SCA failed");
>  		__ofono_dbus_pending_reply(&sms->pending,
>  					__ofono_error_failed(sms->pending));

This one is valid

>  		return;
> diff --git a/src/ussd.c b/src/ussd.c
> index e0c89cd..97502b2 100644
> --- a/src/ussd.c
> +++ b/src/ussd.c
> @@ -656,7 +656,7 @@ static void ussd_cancel_callback(const struct ofono_e=
rror *error, void *data)
>  	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("ussd cancel failed with error: %s",
> +		ofono_error("ussd cancel failed with error: %s",
>  				telephony_error_to_str(error));

This one is valid

>  =

>  		reply =3D __ofono_error_failed(ussd->cancel);
> diff --git a/src/voicecall.c b/src/voicecall.c
> index dbf3e9a..d7aef46 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -1079,7 +1079,7 @@ static struct voicecall *dial_handle_result(struct =
ofono_voicecall *vc,
>  	*need_to_emit =3D FALSE;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Dial callback returned error: %s",
> +		ofono_error("Dial callback returned error: %s",
>  			telephony_error_to_str(error));
>  =

>  		return NULL;
> @@ -1398,7 +1398,7 @@ static void private_chat_callback(const struct ofon=
o_error *error, void *data)
>  	GSList *old;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("command failed with error: %s",
> +		ofono_error("command failed with error: %s",
>  				telephony_error_to_str(error));
>  		__ofono_dbus_pending_reply(&vc->pending,
>  					__ofono_error_failed(vc->pending));
> @@ -1498,7 +1498,7 @@ static void multiparty_create_callback(const struct=
 ofono_error *error,
>  	GSList *old;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("command failed with error: %s",
> +		ofono_error("command failed with error: %s",
>  				telephony_error_to_str(error));
>  		__ofono_dbus_pending_reply(&vc->pending,
>  					__ofono_error_failed(vc->pending));

These can all fail due to network conditions, and should not really be
printed.

Regards,
-Denis

--===============6297927319977790230==--

