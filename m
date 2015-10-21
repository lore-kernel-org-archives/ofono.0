Content-Type: multipart/mixed; boundary="===============0417955203302965903=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2 v3] emulator: add codec negotiation support
Date: Tue, 20 Oct 2015 21:56:05 -0500
Message-ID: <5626FEC5.3040003@gmail.com>
In-Reply-To: <1445346081-7871-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0417955203302965903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 10/20/2015 08:01 AM, Simon Fels wrote:
> ---
>   include/emulator.h |   6 ++
>   src/emulator.c     | 248 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   2 files changed, 254 insertions(+)
>

Just a couple of small nitpicks below:

> diff --git a/include/emulator.h b/include/emulator.h
> index 15dc61c..36153ef 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -112,6 +112,12 @@ void ofono_emulator_set_hf_indicator_active(struct o=
fono_emulator *em,
>   void ofono_emulator_set_handsfree_card(struct ofono_emulator *em,
>   					struct ofono_handsfree_card *card);
>
> +typedef void (*ofono_emulator_codec_negotiation_cb)(int err, void *data);
> +
> +int ofono_emulator_start_codec_negotiation(struct ofono_emulator *em,
> +						unsigned char codec,
> +						ofono_emulator_codec_negotiation_cb cb, void *data);

Please make sure not to go over 80 chars / line.  Even if you need to =

indent arguments 2-4 less than what is required by our style guidelines.

> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/src/emulator.c b/src/emulator.c
> index 626dec3..e16312e 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -27,6 +27,7 @@
>   #include <string.h>
>   #include <unistd.h>
>   #include <stdbool.h>
> +#include <errno.h>
>
>   #include <glib.h>
>
> @@ -39,6 +40,15 @@
>
>   #define RING_TIMEOUT 3
>
> +#define CVSD_OFFSET 0
> +#define MSBC_OFFSET 1
> +#define CODECS_COUNT (MSBC_OFFSET + 1)
> +
> +struct hfp_codec_info {
> +	unsigned char type;
> +	ofono_bool_t supported;
> +};
> +
>   struct ofono_emulator {
>   	struct ofono_atom *atom;
>   	enum ofono_emulator_type type;
> @@ -50,6 +60,13 @@ struct ofono_emulator {
>   	guint callsetup_source;
>   	int pns_id;
>   	struct ofono_handsfree_card *card;
> +	struct hfp_codec_info r_codecs[CODECS_COUNT];
> +	unsigned char negotiated_codec;
> +	unsigned char proposed_codec;
> +	guint delay_sco;

Is this still needed?

> +	ofono_emulator_codec_negotiation_cb codec_negotiation_cb;
> +	void *codec_negotiation_data;
> +	ofono_bool_t bac_received;
>   	bool slc : 1;
>   	unsigned int events_mode : 2;
>   	bool events_ind : 1;
> @@ -938,6 +955,168 @@ fail:
>   	}
>   }
>
> +static void bac_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	GAtResultIter iter;
> +	int val;
> +
> +	DBG("");
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		/*
> +		 * CVSD codec is mandatory and must come first.
> +		 * See HFP v1.6 4.34.1
> +		 */
> +		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE ||
> +				val !=3D HFP_CODEC_CVSD)
> +			goto fail;
> +
> +		em->bac_received =3D TRUE;
> +
> +		em->negotiated_codec =3D 0;
> +		em->r_codecs[CVSD_OFFSET].supported =3D TRUE;
> +
> +		while (g_at_result_iter_next_number(&iter, &val)) {
> +			switch (val) {
> +			case HFP_CODEC_MSBC:
> +				em->r_codecs[MSBC_OFFSET].supported =3D TRUE;
> +				break;
> +			default:
> +				DBG("Unsupported HFP codec %d", val);
> +				break;
> +			}
> +		}
> +
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +
> +		/*
> +		 * If we're currently in the process of selecting a codec
> +		 * we have to restart that now
> +		 */
> +		if (em->proposed_codec)
> +			ofono_emulator_start_codec_negotiation(em, 0, NULL, NULL);
> +
> +		break;
> +
> +	default:
> +fail:
> +		DBG("Process AT+BAC failed");
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);

In theory our codec-negotiation procedure might have failed, do we want =

to call the callback here as well?

> +		break;
> +	}
> +}
> +
> +static void finish_codec_negotiation(struct ofono_emulator *em,
> +			int err)
> +{
> +	if (em->codec_negotiation_cb =3D=3D NULL)
> +		return;
> +
> +	em->codec_negotiation_cb(err, em->codec_negotiation_data);
> +
> +	em->codec_negotiation_cb =3D NULL;
> +	em->codec_negotiation_data =3D NULL;
> +}
> +
> +static void connect_sco(struct ofono_emulator *em)
> +{
> +	int err;
> +
> +	DBG("");
> +
> +	em->delay_sco =3D 0;

What does this do?

> +
> +	err =3D ofono_handsfree_card_connect_sco(em->card);

ofono_handsfree_card_connect_sco function does not check for em->card =

being NULL.

> +	if (err =3D=3D 0) {
> +		finish_codec_negotiation(em, 0);
> +		return;
> +	}
> +
> +	/* If we have another codec we can try then lets do that */
> +	if (em->negotiated_codec !=3D HFP_CODEC_CVSD) {
> +		ofono_emulator_start_codec_negotiation(em, HFP_CODEC_CVSD,
> +							em->codec_negotiation_cb,
> +							em->codec_negotiation_data);

Over 80 characters here again.  Indent less if you need to.

ofono_handsfree_card_connect_sco won't really fail unless the kernel is =

not configured properly.  I'm unsure of the practical utility of this =

logic.  Would it be simpler to mark the wideband / negotiated codec as =

unsupported and simply error out here?

> +		return;
> +	}
> +
> +	finish_codec_negotiation(em, -EIO);
> +}
> +
> +static void bcs_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	GAtResultIter iter;
> +	int val;
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		if (!g_at_result_iter_next_number(&iter, &val))
> +			break;
> +
> +		if (em->proposed_codec !=3D val) {
> +			em->proposed_codec =3D 0;
> +			break;
> +		}
> +
> +		em->proposed_codec =3D 0;
> +		em->negotiated_codec =3D val;
> +
> +		DBG("negotiated codec %d", val);
> +
> +		if (em->card !=3D NULL)
> +			ofono_handsfree_card_set_codec(em->card,
> +							em->negotiated_codec);
> +
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +
> +		connect_sco(em);
> +
> +		return;
> +	default:
> +		break;
> +	}
> +
> +	finish_codec_negotiation(em, -EIO);
> +
> +	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +}
> +
> +static void bcc_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
> +

No need for an empty line here.

> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +
> +		if (!em->negotiated_codec) {
> +			ofono_emulator_start_codec_negotiation(em, 0, NULL, NULL);

Over 80 characters / line here.

It seems we would have a potential race condition here.  Lets say HF =

sends AT+BCC, we call ofono_emulator_start_codec_negotiation.  Right =

after, the AG calls HandsfreeCard.Connect.  This will result in two +BCS =

unsolicited notifications being sent out.

We might want to put in a guard where we don't send another +BCS =

notification until the HF has sent us back a +BCS or +BAC command. =

Also, in the case of HF initiated connections, it probably makes sense =

to reject any immediately subsequent attempts to establish the audio =

connection by the AG side with an -EALREADY.

> +			return;
> +		}
> +
> +		connect_sco(em);
> +
> +		return;
> +	default:
> +		break;
> +	}
> +
> +	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +}
> +
>   static void emulator_add_indicator(struct ofono_emulator *em, const cha=
r* name,
>   					int min, int max, int dflt,
>   					gboolean mandatory)
> @@ -1047,6 +1226,9 @@ void ofono_emulator_register(struct ofono_emulator =
*em, int fd)
>   		g_at_server_register(em->server, "+BIA", bia_cb, em, NULL);
>   		g_at_server_register(em->server, "+BIND", bind_cb, em, NULL);
>   		g_at_server_register(em->server, "+BIEV", biev_cb, em, NULL);
> +		g_at_server_register(em->server, "+BAC", bac_cb, em, NULL);
> +		g_at_server_register(em->server, "+BCC", bcc_cb, em, NULL);
> +		g_at_server_register(em->server, "+BCS", bcs_cb, em, NULL);
>   	}
>
>   	__ofono_atom_register(em->atom, emulator_unregister);
> @@ -1101,6 +1283,7 @@ struct ofono_emulator *ofono_emulator_create(struct=
 ofono_modem *modem,
>   	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_CONTROL;
>   	em->l_features |=3D HFP_AG_FEATURE_EXTENDED_RES_CODE;
>   	em->l_features |=3D HFP_AG_FEATURE_HF_INDICATORS;
> +	em->l_features |=3D HFP_AG_FEATURE_CODEC_NEGOTIATION;
>   	em->events_mode =3D 3;	/* default mode is forwarding events */
>   	em->cmee_mode =3D 0;	/* CME ERROR disabled by default */
>
> @@ -1476,3 +1659,68 @@ void ofono_emulator_set_handsfree_card(struct ofon=
o_emulator *em,
>
>   	em->card =3D card;
>   }
> +
> +static unsigned char select_codec(struct ofono_emulator *em)
> +{
> +	if (ofono_handsfree_audio_has_wideband() &&
> +			em->r_codecs[MSBC_OFFSET].supported)
> +		return HFP_CODEC_MSBC;
> +
> +	/* CVSD is mandatory for both sides */
> +	return HFP_CODEC_CVSD;
> +}
> +
> +int ofono_emulator_start_codec_negotiation(struct ofono_emulator *em,
> +						unsigned char codec,

What is the theoretical purpose of this codec parameter?  Is the intent =

to only use it for the fallback use case in connect_sco() above?  If so, =

then we probably need to handle it some other way and remove this =

parameter from the public API.

> +						ofono_emulator_codec_negotiation_cb cb, void *data)
> +{
> +	char buf[64];
> +	unsigned char selected_codec;
> +
> +	if (em =3D=3D NULL)
> +		return -EINVAL;
> +
> +	if (cb !=3D NULL && em->codec_negotiation_cb !=3D NULL)
> +		return -EALREADY;
> +
> +	if (!em->bac_received || em->negotiated_codec > 0) {
> +		/*
> +		 * Report we're done even if we don't have done any
> +		 * negotiation as the other side may have to clean up.
> +		 */
> +		cb(0, data);
> +
> +		/*
> +		 * If we didn't received any +BAC during the SLC setup the
> +		 * remote side doesn't support codec negotiation and we can
> +		 * directly connect our card. Otherwise if we got +BAC and
> +		 * already have a negotiated codec we can proceed here
> +		 * without doing any negotiation again.
> +		 */
> +		ofono_handsfree_card_connect_sco(em->card);
> +
> +		return 0;
> +	}
> +
> +	if (codec > 0) {
> +		selected_codec =3D codec;
> +		goto done;
> +	}
> +
> +	selected_codec =3D select_codec(em);
> +	if (!selected_codec) {
> +		DBG("Failed to selected HFP codec");
> +		return -EINVAL;
> +	}
> +
> +done:
> +	em->proposed_codec =3D selected_codec;
> +
> +	em->codec_negotiation_cb =3D cb;
> +	em->codec_negotiation_data =3D data;
> +
> +	snprintf(buf, 64, "+BCS: %d", selected_codec);
> +	g_at_server_send_unsolicited(em->server, buf);
> +
> +	return 0;
> +}
>

Regards,
-Denis

--===============0417955203302965903==--

