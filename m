Content-Type: multipart/mixed; boundary="===============2657411648213264761=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 05/12] handsfree: Supported AG features exposed in D-Bus
Date: Fri, 21 Oct 2011 14:32:59 -0500
Message-ID: <4EA1C8EB.6090204@gmail.com>
In-Reply-To: <1319215897-6310-6-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2657411648213264761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 10/21/2011 11:51 AM, Mikel Astiz wrote:
> ---
>  src/handsfree.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 58 insertions(+), 0 deletions(-)
> =

> diff --git a/src/handsfree.c b/src/handsfree.c
> index 24f2349..27af31c 100644
> --- a/src/handsfree.c
> +++ b/src/handsfree.c
> @@ -41,9 +41,12 @@
>  #include "ofono.h"
>  #include "common.h"
>  =

> +#define MAX_AG_FEATURE_COUNT 32
> +

So you probably meant 33 here right?

>  static GSList *g_drivers =3D NULL;
>  =

>  struct ofono_handsfree {
> +	unsigned int ag_features;
>  	ofono_bool_t inband_ringing;
>  	ofono_bool_t voice_recognition;
>  	ofono_bool_t voice_recognition_pending;
> @@ -54,6 +57,54 @@ struct ofono_handsfree {
>  	DBusMessage *pending;
>  };
>  =

> +static void append_ag_features(struct ofono_handsfree *hf, char **featur=
es)
> +{
> +	unsigned int bit;
> +	int feature_count =3D 0;
> +
> +	for (bit =3D 1; bit !=3D 0; bit <<=3D 1) {
> +		if (hf->ag_features & bit) {
> +			char *name =3D NULL;
> +
> +			switch ((enum hfp_ag_feature) bit) {
> +			case HFP_AG_FEATURE_VOICE_RECOG:
> +				name =3D "voice-recognition";
> +				break;
> +			case HFP_AG_FEATURE_ATTACH_VOICE_TAG:
> +				name =3D "attach-voice-tag";
> +				break;
> +			default:
> +				continue;
> +			}
> +
> +			features[feature_count++] =3D name;
> +		}
> +	}
> +
> +	features[feature_count] =3D NULL;
> +}
> +

This function seemed way too complicated for what you were trying to
accomplish.

> +void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,
> +					unsigned int ag_features)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(hf->atom);
> +	char **features;
> +
> +	if (hf->ag_features =3D=3D ag_features)
> +		return;
> +
> +	hf->ag_features =3D ag_features;
> +
> +	features =3D g_new0(char *, MAX_AG_FEATURE_COUNT + 1);
> +	append_ag_features(hf, features);
> +	ofono_dbus_signal_array_property_changed(conn, path,
> +						OFONO_HANDSFREE_INTERFACE,
> +						"Features", DBUS_TYPE_STRING,
> +						&features);
> +	g_free(features);

I also didn't like this part.  The AG features should be set by the atom
driver prior to calling ofono_handsfree_register.  And since the BRSF
cannot be changed during the lifetime of the atom, there's no need for
signaling the property and the rest of the logic in this implementation.

> +}
> +
>  void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
>  						ofono_bool_t enabled)
>  {
> @@ -102,6 +153,7 @@ static DBusMessage *handsfree_get_properties(DBusConn=
ection *conn,
>  	DBusMessageIter dict;
>  	dbus_bool_t inband_ringing;
>  	dbus_bool_t voice_recognition;
> +	char **features;
>  =

>  	reply =3D dbus_message_new_method_return(msg);
>  	if (reply =3D=3D NULL)
> @@ -121,6 +173,12 @@ static DBusMessage *handsfree_get_properties(DBusCon=
nection *conn,
>  	ofono_dbus_dict_append(&dict, "VoiceRecognition", DBUS_TYPE_BOOLEAN,
>  				&voice_recognition);
>  =

> +	features =3D g_new0(char *, MAX_AG_FEATURE_COUNT + 1);
> +	append_ag_features(hf, features);
> +	ofono_dbus_dict_append_array(&dict, "Features", DBUS_TYPE_STRING,
> +					&features);
> +	g_free(features);
> +
>  	dbus_message_iter_close_container(&iter, &dict);
>  =

>  	return reply;

I went ahead and pushed my own version of this patch.  Please review it
and let me know if you find any problems.

Regards,
-Denis

--===============2657411648213264761==--

