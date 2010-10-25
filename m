Content-Type: multipart/mixed; boundary="===============9047974208279223290=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/6] radio settings: add FastDormancy property
Date: Mon, 25 Oct 2010 16:30:01 +0200
Message-ID: <1288017001.3613.7.camel@aeonflux>
In-Reply-To: <1288013290-6124-2-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9047974208279223290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

>  include/radio-settings.h |   11 ++++
>  src/radio-settings.c     |  134 ++++++++++++++++++++++++++++++++++++++++=
+----
>  2 files changed, 133 insertions(+), 12 deletions(-)
> =

> diff --git a/include/radio-settings.h b/include/radio-settings.h
> index d41ec0b..a6b19d0 100644
> --- a/include/radio-settings.h
> +++ b/include/radio-settings.h
> @@ -42,6 +42,10 @@ typedef void (*ofono_radio_settings_rat_mode_set_cb_t)=
(const struct ofono_error
>  typedef void (*ofono_radio_settings_rat_mode_query_cb_t)(const struct of=
ono_error *error,
>  						enum ofono_radio_access_mode mode,
>  						void *data);
> +typedef void (*ofono_radio_settings_fast_dormancy_set_cb_t)(const struct=
 ofono_error *error,
> +							void *data);
> +typedef void (*ofono_radio_settings_fast_dormancy_query_cb_t)(const stru=
ct ofono_error *error,
> +							int enable, void *data);
>  =

>  struct ofono_radio_settings_driver {
>  	const char *name;
> @@ -55,6 +59,13 @@ struct ofono_radio_settings_driver {
>  				enum ofono_radio_access_mode mode,
>  				ofono_radio_settings_rat_mode_set_cb_t cb,
>  				void *data);
> +	void (*query_fast_dormancy)(struct ofono_radio_settings *rs,
> +			ofono_radio_settings_fast_dormancy_query_cb_t cb,
> +			void *data);
> +	void (*set_fast_dormancy)(struct ofono_radio_settings *rs,
> +				int enable,
> +				ofono_radio_settings_fast_dormancy_set_cb_t,
> +				void *data);
>  };
>  =

>  int ofono_radio_settings_driver_register(const struct ofono_radio_settin=
gs_driver *d);
> diff --git a/src/radio-settings.c b/src/radio-settings.c
> index 3306be6..5441481 100644
> --- a/src/radio-settings.c
> +++ b/src/radio-settings.c
> @@ -33,7 +33,7 @@
>  #include "ofono.h"
>  #include "common.h"
>  =

> -#define RADIO_SETTINGS_MODE_CACHED 0x1
> +#define RADIO_SETTINGS_FLAG_CACHED 0x1
>  =

>  static GSList *g_drivers =3D NULL;
>  =

> @@ -42,6 +42,8 @@ struct ofono_radio_settings {
>  	int flags;
>  	enum ofono_radio_access_mode mode;
>  	enum ofono_radio_access_mode pending_mode;
> +	int fast_dormancy;
> +	int fast_dormancy_pending;
>  	const struct ofono_radio_settings_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> @@ -91,8 +93,6 @@ static DBusMessage *radio_get_properties_reply(DBusMess=
age *msg,
>  	DBusMessageIter iter;
>  	DBusMessageIter dict;
>  =

> -	const char *mode =3D radio_access_mode_to_string(rs->mode);
> -
>  	reply =3D dbus_message_new_method_return(msg);
>  	if (!reply)
>  		return NULL;
> @@ -103,14 +103,60 @@ static DBusMessage *radio_get_properties_reply(DBus=
Message *msg,
>  					OFONO_PROPERTIES_ARRAY_SIGNATURE,
>  					&dict);
>  =

> -	ofono_dbus_dict_append(&dict, "TechnologyPreference",
> +	if ((int)rs->mode !=3D -1) {
> +		const char *mode =3D radio_access_mode_to_string(rs->mode);
> +		ofono_dbus_dict_append(&dict, "TechnologyPreference",
>  					DBUS_TYPE_STRING, &mode);

what is up with this (int) rs->mode cast here. That looks highly wrong
to me. The mode is an enum so please don't hack around it like this.

If mode can be invalid or not present then we need to extend this enum
with an initial value of OFONO_RADIO_ACCESS_MODE_UNKNOWN, but not hack
some cast magic into it.

Or you use some flags like for the cached value.

And I would propose the same for fast dormancy value. Lets store it as a
boolean and have a flag if it is present or not.

Regards

Marcel



--===============9047974208279223290==--

