Content-Type: multipart/mixed; boundary="===============6900315051164394813=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] sim: added ImsPrivateIdentity to SimManager
Date: Mon, 06 Nov 2017 16:23:38 -0600
Message-ID: <0a6a87cc-f586-6efd-10e7-2f0c2d52e248@gmail.com>
In-Reply-To: <1509990574-19950-4-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6900315051164394813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/06/2017 11:49 AM, James Prestwood wrote:
> If the ISIM AID is found a new AID based context will be
> created and the EFIMPI file will be read from the SIM
> which contains the ImsPrivateIdentity.
> ---
>   src/ofono.h |  2 ++
>   src/sim.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> =

> diff --git a/src/ofono.h b/src/ofono.h
> index 007cd13..7e96c96 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -419,6 +419,8 @@ enum sim_app_type __ofono_sim_session_get_type(
>   unsigned char *__ofono_sim_session_get_aid(
>   		struct ofono_sim_aid_session *session);
>   =

> +const char *__ofono_sim_get_ims_private_id(struct ofono_sim *sim);
> +

get_impi()

>   #include <ofono/stk.h>
>   =

>   typedef void (*__ofono_sms_sim_download_cb_t)(ofono_bool_t ok,
> diff --git a/src/sim.c b/src/sim.c
> index 23a6395..5da11d1 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -126,6 +126,7 @@ struct ofono_sim {
>   	struct sim_fs *simfs_isim;
>   	struct ofono_sim_context *context;
>   	struct ofono_sim_context *early_context;
> +	struct ofono_sim_context *isim_context;
>   =

>   	unsigned char *iidf_image;
>   	unsigned int *iidf_watch_ids;
> @@ -138,6 +139,7 @@ struct ofono_sim {
>   =

>   	GSList *aid_sessions;
>   	GSList *aid_list;
> +	char *ims_identity;

char *impi;

>   };
>   =

>   struct msisdn_set_request {
> @@ -409,6 +411,10 @@ static DBusMessage *sim_get_properties(DBusConnectio=
n *conn,
>   		ofono_dbus_dict_append(&dict, "ServiceProviderName",
>   					DBUS_TYPE_STRING, &sim->spn);
>   =

> +	if (sim->ims_identity)
> +		ofono_dbus_dict_append(&dict, "ImsPrivateIdentity",
> +					DBUS_TYPE_STRING, &sim->ims_identity);
> +
>   	fdn =3D sim->fixed_dialing;
>   	ofono_dbus_dict_append(&dict, "FixedDialing", DBUS_TYPE_BOOLEAN, &fdn);
>   =

> @@ -1458,6 +1464,25 @@ static void sim_set_ready(struct ofono_sim *sim)
>   	call_state_watches(sim);
>   }
>   =

> +static void impi_read_cb(int ok, int total_length, int record,
> +		const unsigned char *data,
> +		int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +
> +	if (!ok) {
> +		DBG("error reading IMPI");
> +		return;
> +	}
> +
> +	if (data[0] !=3D 0x80) {
> +		DBG("invalid TLV tag 0x%02x", data[0]);
> +		return;
> +	}
> +
> +	sim->ims_identity =3D g_strndup((const char *)data + 2, data[1]);
> +}
> +
>   static void discover_apps_cb(const struct ofono_error *error,
>   		const unsigned char *dataobj,
>   		int len, void *data)
> @@ -1490,6 +1515,12 @@ static void discover_apps_cb(const struct ofono_er=
ror *error,
>   			 * the FS structure so the ISIM EF's can be accessed.
>   			 */
>   			sim->simfs_isim =3D sim_fs_new(sim, sim->driver);
> +			sim->isim_context =3D ofono_sim_context_create_isim(
> +					sim);
> +			/* attempt to get the NAI from EFimpi */
> +			ofono_sim_read_bytes(sim->isim_context,
> +					SIM_ISIM_EFIMPI_FILEID, 0, 255, NULL,
> +					0, impi_read_cb, sim);
>   		}
>   =

>   		iter =3D g_slist_next(iter);
> @@ -2558,6 +2589,14 @@ static void sim_free_main_state(struct ofono_sim *=
sim)
>   		sim->context =3D NULL;
>   	}
>   =

> +	if (sim->isim_context) {
> +		ofono_sim_context_free(sim->isim_context);
> +		sim->isim_context =3D NULL;
> +	}
> +
> +	if (sim->ims_identity)
> +		g_free(sim->ims_identity);
> +
>   	if (sim->aid_sessions)
>   		g_slist_free_full(sim->aid_sessions, aid_session_free);
>   }
> @@ -3417,6 +3456,11 @@ void __ofono_sim_refresh(struct ofono_sim *sim, GS=
List *file_list,
>   	}
>   }
>   =

> +const char *__ofono_sim_get_ims_private_id(struct ofono_sim *sim)
> +{
> +	return sim->ims_identity;
> +}
> +
>   static void open_channel_cb(const struct ofono_error *error, int sessio=
n_id,
>   		void *data);
>   =

> =


Regards,
-Denis

--===============6900315051164394813==--

