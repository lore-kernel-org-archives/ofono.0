Content-Type: multipart/mixed; boundary="===============2235561023053012868=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/8] sim: AID session management
Date: Thu, 02 Nov 2017 12:10:06 -0500
Message-ID: <31043784-5be2-f056-6ff1-49801f96b1c8@gmail.com>
In-Reply-To: <1509557628-15121-3-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2235561023053012868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/01/2017 12:33 PM, James Prestwood wrote:
> Accessing an AID requires opening a channel to that application.
> This patch implements session management API's so that other atoms
> can access a given AID. Now any atom can get a session ID from the
> sim atom. This will either reuse an existing session or open a new
> channel. Once done, the atom should release the session which will
> automatically close the channel when no atoms are using it.
> =

> The major functional change to the sim atom is the AID discovery
> phase of initialization. Now, the sim atom is not 'ready' until AID
> discovery finishes where before, the sim was 'ready' after the IMSI
> had been obtained. If application discovery is not supported then
> the the sim atom behaves as it did before.
> ---
>   src/sim.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 204 insertions(+)
> =

> diff --git a/src/sim.c b/src/sim.c
> index 88c0421..53eb048 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -48,6 +48,25 @@
>   =

>   #define SIM_FLAG_READING_SPN	0x1
>   =

> +/*
> + * A new session object will be created if a USim/ISim applications are
> + * found during app discovery. Any concurrent file/logical access to
> + * these applications will share the same session ID.
> + */
> +struct ofono_aid_session {
> +	struct sim_app_record record;
> +	struct ofono_sim_context *context;
> +	int session_id;
> +	int ref;
> +};
> +
> +/* callback data for opening a new session */
> +struct sdata {
> +	void *data;
> +	ofono_sim_get_session_cb_t cb;
> +	struct ofono_aid_session *session;
> +};
> +

You have to be careful here because sdata objects are not tracked =

anywhere.  So if the SIM atom is removed (e.g. due to USB hot-unplug or =

whatever) then there is potential for memory leaks.

>   struct ofono_sim {
>   	int flags;
>   =

> @@ -114,6 +133,8 @@ struct ofono_sim {
>   	void *driver_data;
>   	struct ofono_atom *atom;
>   	unsigned int hfp_watch;
> +
> +	GSList *aid_sessions;

It may be easier to keep a GSList of sim_app_records directly and have =

ofono_aid_session reference that list.

>   };
>   =

>   struct msisdn_set_request {
> @@ -1434,6 +1455,36 @@ static void sim_set_ready(struct ofono_sim *sim)
>   	call_state_watches(sim);
>   }
>   =

> +static void discover_apps_cb(const struct ofono_error *error,
> +		const unsigned char *dataobj,
> +		int len, void *data)
> +{
> +	GSList *list;
> +	GSList *iter;
> +	struct ofono_sim *sim =3D data;
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
> +		return;
> +
> +	list =3D sim_parse_app_template_entries(dataobj, len);
> +	iter =3D list;
> + > +	while (iter) {
> +		struct sim_app_record *app =3D iter->data;
> +		struct ofono_aid_session *s =3D g_try_new0(
> +				struct ofono_aid_session, 1);
> +
> +		memcpy(&s->record, app, sizeof(struct sim_app_record));
> +		sim->aid_sessions =3D g_slist_prepend(sim->aid_sessions, s);
> +
> +		g_free(app);
> +
> +		iter =3D g_slist_next(iter);
> +	}
> +
> +	g_slist_free(list);
> +}
> +
>   static void sim_imsi_obtained(struct ofono_sim *sim, const char *imsi)
>   {
>   	DBusConnection *conn =3D ofono_dbus_get_connection();
> @@ -1844,6 +1895,12 @@ static void sim_initialize_after_pin(struct ofono_=
sim *sim)
>   {
>   	sim->context =3D ofono_sim_context_create(sim);
>   =

> +	/*
> +	 * Discover applications on SIM
> +	 */
> +	if (sim->driver->list_apps)
> +		sim->driver->list_apps(sim, discover_apps_cb, sim);
> +
>   	ofono_sim_read(sim->context, SIM_EFPHASE_FILEID,
>   			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>   			sim_efphase_read_cb, sim);
> @@ -2450,6 +2507,9 @@ static void sim_free_main_state(struct ofono_sim *s=
im)
>   		ofono_sim_context_free(sim->context);
>   		sim->context =3D NULL;
>   	}
> +
> +	if (sim->aid_sessions)
> +		g_slist_free(sim->aid_sessions);
>   }
>   =

>   static void sim_free_state(struct ofono_sim *sim)
> @@ -3304,3 +3364,147 @@ void __ofono_sim_refresh(struct ofono_sim *sim, G=
SList *file_list,
>   		}
>   	}
>   }
> +
> +struct sim_app_record **ofono_sim_get_aid_list(struct ofono_sim *sim)

That way you can make this private API (__ofono_sim_get_aid_list) and =

simply return a GSList.  E.g. sim->aid_list or something.

> +{
> +	GSList *iter =3D sim->aid_sessions;
> +	int len;
> +	struct sim_app_record **ret;
> +	int i =3D 0;
> +
> +	if (!iter) {
> +		DBG("AID list not found");
> +		return NULL;
> +	}
> +
> +	len =3D g_slist_length(iter);
> +	ret =3D g_try_new0(struct sim_app_record *,
> +			len + 1);
> +
> +	while (iter) {
> +		struct ofono_aid_session *s =3D iter->data;
> +
> +		ret[i++] =3D &s->record;
> +
> +		iter =3D g_slist_next(iter);
> +	}
> +
> +	return ret;
> +}
> +
> +static struct ofono_aid_session *find_session_by_aid(struct ofono_sim *s=
im,
> +		unsigned char *aid)
> +{
> +	GSList *iter =3D sim->aid_sessions;
> +
> +	while (iter) {
> +		struct ofono_aid_session *session =3D iter->data;
> +
> +		if (!memcmp(session->record.aid, aid, 16))
> +			return session;
> +
> +		iter =3D g_slist_next(iter);
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct ofono_aid_session *find_session_by_id(struct ofono_sim *si=
m,
> +		int session_id)
> +{
> +	GSList *iter =3D sim->aid_sessions;
> +
> +	while (iter) {
> +		struct ofono_aid_session *session =3D iter->data;
> +
> +		if (session->session_id =3D=3D session_id)
> +			return session;
> +
> +		iter =3D g_slist_next(iter);
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct sdata *cb_data_new(ofono_sim_get_session_cb_t cb, void *da=
ta,
> +		struct ofono_aid_session *session)
> +{
> +	struct sdata *cbd =3D g_try_new0(struct sdata, 1);
> +
> +	cbd->cb =3D cb;
> +	cbd->data =3D data;
> +	cbd->session =3D session;
> +
> +	return cbd;
> +}
> +
> +static void open_channel_cb(const struct ofono_error *error, int session=
_id,
> +		void *data)
> +{
> +	struct sdata *cbd =3D data;
> +	struct ofono_aid_session *session =3D cbd->session;
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		session->ref =3D 0;
> +		session->session_id =3D -1;
> +		goto end;
> +	}
> +
> +	session->session_id =3D session_id;
> +
> +end:
> +	cbd->cb(session->session_id, cbd->data);
> +
> +	g_free(cbd);
> +}
> +
> +int ofono_sim_get_session(struct ofono_sim *sim, unsigned char *aid,
> +		ofono_sim_get_session_cb_t cb, void *data)
> +{
> +	struct sdata *cbd;
> +	struct ofono_aid_session *session =3D find_session_by_aid(sim, aid);
> +
> +	if (!session) {
> +		DBG("AID not found");
> +		return 0;

So in general we make a function return either true/false or if it =

returns an int, then it should return -errno or 0 on success.  So in =

this case return -ENOENT.

> +	}
> +
> +	if (!sim->driver->open_channel || !sim->driver->close_channel) {
> +		DBG("sim driver does not support opening logical channels");
> +		return 0;

return -ENOTSUP

> +	}
> +
> +	/* increase ref to ensure the session doesn't get cleaned up */
> +	session->ref++;
s> +
> +	if (session->session_id =3D=3D 0) {
> +		/* AID found but no session has been opened */
> +		cbd =3D cb_data_new(cb, data, session);
> +		sim->driver->open_channel(sim, aid, open_channel_cb, cbd);

So what happens if two atoms call this one after the other?  Eg. before =

the open_channel_cb was called?

> +	} else {
> +		cb(session->session_id, data);
> +	}
> +
> +	return 1;
> +}
> +
> +int ofono_sim_release_session(struct ofono_sim *sim, int session_id)
> +{
> +	struct ofono_aid_session *session =3D find_session_by_id(sim, session_i=
d);
> +
> +	if (!session) {
> +		DBG("Session %d not found", session_id);
> +		return 0;
> +	}
> +
> +	session->ref--;
> +
> +	/* if nobody is using this session, close the channel */
> +	if (session->ref <=3D 0) {
> +		sim->driver->close_channel(sim, session_id, NULL, NULL);
> +		session->session_id =3D 0;
> +		session->ref =3D 0;
> +	}
> +
> +	return 1;
> +}
> =


Regards,
-Denis

--===============2235561023053012868==--

