Content-Type: multipart/mixed; boundary="===============0730090135074017554=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: Re: [PATCH 3/7] emulator: add RING for HFP AG
Date: Tue, 05 Apr 2011 17:49:05 +0200
Message-ID: <4D9B39F1.5010304@linux.intel.com>
In-Reply-To: <1302018031-12401-4-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0730090135074017554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

j'aime pas cette variable

+	gboolean active_call;

d'autant plus que call est le premier indicateur de la liste, c'est donc =

une copie de ((struct indicator*)indicators->data)->value

On 04/05/2011 05:40 PM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>   src/emulator.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/src/emulator.c b/src/emulator.c
> index 2707592..104693d 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -37,6 +37,8 @@
>   #define DUN_DNS_SERVER_1       "10.10.10.10"
>   #define DUN_DNS_SERVER_2       "10.10.10.11"
>
> +#define RING_TIMEOUT 3
> +
>   struct ofono_emulator {
>   	struct ofono_atom *atom;
>   	enum ofono_emulator_type type;
> @@ -49,6 +51,8 @@ struct ofono_emulator {
>   	int events_mode;
>   	gboolean events_ind;
>   	GSList *indicators;
> +	guint ring;
> +	gboolean active_call;
>   };
>
>   struct indicator {
> @@ -177,6 +181,18 @@ error:
>   	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
>   }
>
> +static gboolean ring_cb(gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +
> +	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP&&  em->slc =3D=3D FALSE)
> +		return TRUE;
> +
> +	g_at_server_send_unsolicited(em->server, "RING");
> +
> +	return TRUE;
> +}
> +
>   static void brsf_cb(GAtServer *server, GAtServerRequestType type,
>   			GAtResult *result, gpointer user_data)
>   {
> @@ -418,6 +434,11 @@ static void emulator_unregister(struct ofono_atom *a=
tom)
>   		em->source =3D 0;
>   	}
>
> +	if (em->ring) {
> +		g_source_remove(em->ring);
> +		em->ring =3D 0;
> +	}
> +
>   	for (l =3D em->indicators; l; l =3D l->next) {
>   		struct indicator *ind =3D l->data;
>
> @@ -697,11 +718,35 @@ void ofono_emulator_set_indicator(struct ofono_emul=
ator *em,
>
>   		ind->value =3D value;
>
> +		if (g_str_equal(name, OFONO_EMULATOR_IND_CALL) =3D=3D TRUE)
> +			em->active_call =3D value;
> +
>   		if (em->events_mode =3D=3D 3&&  em->events_ind&&  em->slc) {
>   			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
>   			g_at_server_send_info(em->server, buf, TRUE);
>   		}
>
> +		/*
> +		 * Ring timer should be started when callsetup indicator
> +		 * is set to Incoming, but only if there is no active or held
> +		 * call (active indicator set to 1)
> +		 * It should be stopped for all other values of callsetup
> +		 */
> +		if (g_str_equal(name, OFONO_EMULATOR_IND_CALLSETUP) =3D=3D TRUE) {
> +			if (value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING&&
> +					!em->active_call&&  em->ring =3D=3D 0) {
> +				ring_cb(em);
> +				em->ring =3D g_timeout_add_seconds(RING_TIMEOUT,
> +								ring_cb, em);
> +			}
> +
> +			if (value !=3D OFONO_EMULATOR_CALLSETUP_INCOMING&&
> +					em->ring) {
> +				g_source_remove(em->ring);
> +				em->ring =3D 0;
> +			}
> +		}
> +
>   		return;
>   	}
>   }


--===============0730090135074017554==--

