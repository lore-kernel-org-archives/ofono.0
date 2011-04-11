Content-Type: multipart/mixed; boundary="===============7359846015982798299=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH v2 7/8] voicecall: add +CHUP support for HFP emulator
Date: Mon, 11 Apr 2011 18:44:58 +0200
Message-ID: <4DA3300A.1000208@linux.intel.com>
In-Reply-To: <4DA3289C.1030808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7359846015982798299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 11/04/2011 18:13, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 04/07/2011 11:33 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
>> ---
>>   src/voicecall.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   1 files changed, 108 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index cf02bb6..8aec0a0 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -60,6 +60,7 @@ struct ofono_voicecall {
>>   	GQueue *toneq;
>>   	guint tone_source;
>>   	unsigned int hfp_watch;
>> +	GSList *hfp_release_list;
>
> I'd rather not do this, you're not really avoiding a race condition with
> MPTY hangups or HangupAll here.  I'd rather we re-use release_queue but
> add additional sanity checking.  Perhaps adding a callback parameter to
> voicecalls_release_next might make this easy.  In general we need to
> think some more about how to avoid clashes between the D-Bus API and the
> emulator.
>
>>   };
>>
>>   struct voicecall {
>> @@ -95,6 +96,11 @@ struct tone_queue_entry {
>>   	int id;
>>   };
>>
>> +struct emulator_release {
>> +	struct ofono_voicecall *vc;
>> +	struct ofono_emulator *em;
>> +};
>> +
>>   static const char *default_en_list[] =3D { "911", "112", NULL };
>>   static const char *default_en_list_no_sim[] =3D { "119", "118", "999",=
 "110",
>>   						"08", "000", NULL };
>> @@ -102,6 +108,7 @@ static const char *default_en_list_no_sim[] =3D { "1=
19", "118", "999", "110",
>>   static void generic_callback(const struct ofono_error *error, void *da=
ta);
>>   static void multirelease_callback(const struct ofono_error *err, void =
*data);
>>   static gboolean tone_request_run(gpointer user_data);
>> +static void emulator_release_next(struct emulator_release *er);
>>
>>   static gint call_compare_by_id(gconstpointer a, gconstpointer b)
>>   {
>> @@ -2344,6 +2351,10 @@ static void voicecall_unregister(struct ofono_ato=
m *atom)
>>   						OFONO_ATOM_TYPE_EMULATOR_HFP,
>>   						emulator_remove_handler,
>>   						"A");
>> +	__ofono_modem_foreach_registered_atom(modem,
>> +						OFONO_ATOM_TYPE_EMULATOR_HFP,
>> +						emulator_remove_handler,
>> +						"+CHUP");
>>
>>   	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
>>
>> @@ -2558,6 +2569,102 @@ fail:
>>   	};
>>   }
>>
>> +static void emulator_multirelease_callback(const struct ofono_error *er=
ror,
>> +						void *data)
>> +{
>> +	struct emulator_release *er =3D data;
>> +	struct ofono_voicecall *vc =3D er->vc;
>> +
>> +	if (vc->hfp_release_list !=3D NULL) {
>> +		emulator_release_next(er);
>> +		return;
>> +	}
>> +
>> +	emulator_generic_cb(error, er->em);
>> +
>> +	g_free(er);
>> +}
>> +
>> +static void emulator_release_next(struct emulator_release *er)
>> +{
>> +	struct ofono_voicecall *vc;
>> +	struct voicecall *call;
>> +
>> +	vc =3D er->vc;
>> +
>> +	call =3D vc->hfp_release_list->data;
>> +
>> +	vc->hfp_release_list =3D g_slist_remove(vc->hfp_release_list, call);
>> +
>> +	vc->driver->release_specific(vc, call->call->id,
>> +				emulator_multirelease_callback, er);
>> +}
>> +
>> +static void emulator_chup_cb(struct ofono_emulator *em,
>> +			struct ofono_emulator_request *req, void *userdata)
>> +{
>> +	struct ofono_voicecall *vc =3D userdata;
>> +	struct ofono_error result;
>> +	struct emulator_release *er;
>> +	GSList *l;
>> +	struct voicecall *call;
>> +
>> +	result.error =3D 0;
>> +
>> +	switch (ofono_emulator_request_get_type(req)) {
>> +	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
>> +		if (vc->driver->release_specific =3D=3D NULL&&
>> +				vc->driver->hangup_active =3D=3D NULL)
>> +			goto fail;
>> +
>> +		if (vc->driver->hangup_active) {
>> +			vc->driver->hangup_active(vc, emulator_generic_cb, em);
>> +			goto done;
>> +		}
>> +
>> +		/* if there is already a CHUP pending we return an error */
>> +		if (vc->hfp_release_list)
>> +			goto fail;
>
> Why are you checking this here?  Shouldn't you check this before
> potentially sending a hangup_active?
As far as I understand AT+CHUP, it releases all active calls (active + =

incoming + dialing + alerting), so we do not need a call list and are =

not able to know that we already perform one.

Is it correct ?
>
>> +
>> +		er =3D g_try_new0(struct emulator_release, 1);
>
> For simple structures (e.g. under 1k or so) it is fine to simply use g_ne=
w0
>
>> +		if (er =3D=3D NULL) {
>> +			ofono_error("Unable to allocate release structure");
>> +			goto fail;
>> +		}
>> +
>> +		er->vc =3D vc;
>> +		er->em =3D em;
>> +
>> +		for (l =3D vc->call_list; l; l =3D l->next) {
>> +			call =3D l->data;
>> +
>> +			if (call->call->status =3D=3D CALL_STATUS_WAITING ||
>> +					call->call->status =3D=3D CALL_STATUS_HELD)
>> +				continue;
>> +
>> +			vc->hfp_release_list =3D g_slist_prepend(
>> +						vc->hfp_release_list,
>> +						l->data);
>> +		}
>> +
>> +		if (vc->hfp_release_list =3D=3D NULL) {
>> +			g_free(er);
>> +			goto fail;
>> +		}
>> +
>> +		emulator_release_next(er);
>> +
>> +done:
>> +		dial_request_user_cancel(vc, NULL);
>> +		break;
>> +
>> +	default:
>> +fail:
>> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
>> +		ofono_emulator_send_final(em,&result);
>> +	};
>> +}
>> +
>>   static void emulator_hfp_watch(struct ofono_atom *atom,
>>   				enum ofono_atom_watch_condition cond,
>>   				void *data)
>> @@ -2570,6 +2677,7 @@ static void emulator_hfp_watch(struct ofono_atom *=
atom,
>>   	notify_emulator_call_status(data);
>>
>>   	ofono_emulator_add_handler(em, "A", emulator_ata_cb, data, NULL);
>> +	ofono_emulator_add_handler(em, "+CHUP", emulator_chup_cb, data, NULL);
>>   }
>>
>>   void ofono_voicecall_register(struct ofono_voicecall *vc)
>
> Regards,
> -Denis

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============7359846015982798299==--

