Content-Type: multipart/mixed; boundary="===============5605743865157090338=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2] atmodem: Poll SIM state after having entered PIN
Date: Tue, 17 Apr 2012 12:15:38 +0200
Message-ID: <4F8D42CA.4050102@linux.intel.com>
In-Reply-To: <1334655416.16897.195.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5605743865157090338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 17/04/2012 11:36, Marcel Holtmann wrote:
> Hi Guillaume,
>
>> Some modems use SIM notification to check SIM state.
>> If not do some poll using atutil helper.
>> ---
>>   drivers/atmodem/sim.c |   28 ++++++++++++++++++++++++++++
>>   1 files changed, 28 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
>> index c51b1d4..269079a 100644
>> --- a/drivers/atmodem/sim.c
>> +++ b/drivers/atmodem/sim.c
>> @@ -51,6 +51,7 @@ struct sim_data {
>>   	GAtChat *chat;
>>   	unsigned int vendor;
>>   	guint ready_id;
>> +	struct at_util_sim_state_query *sim_state_query;
>>   };
>>
>>   static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
>> @@ -972,6 +973,23 @@ static void at_epev_notify(GAtResult *result, gpoin=
ter user_data)
>>   	sd->ready_id =3D 0;
>>   }
>>
>> +static void sim_state_cb(gboolean present, gpointer user_data)
>> +{
>> +	struct cb_data *cbd =3D user_data;
>> +	struct sim_data *sd =3D cbd->user;
>> +	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
>> +
>> +	at_util_sim_state_query_free(sd->sim_state_query);
>> +	sd->sim_state_query =3D NULL;
>> +
>> +	if (present =3D=3D 1)
>> +		CALLBACK_WITH_SUCCESS(cb, cbd->data);
>> +	else
>> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
>> +
>> +	g_free(cbd);
>> +}
>> +
>>   static void at_pin_send_cb(gboolean ok, GAtResult *result,
>>   				gpointer user_data)
>>   {
>> @@ -1005,6 +1023,13 @@ static void at_pin_send_cb(gboolean ok, GAtResult=
 *result,
>>   		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
>>   							at_epev_notify,
>>   							FALSE, cbd, g_free);
>> +		/*
>> +		 * After pin is entered, SIM state is check by doing
>> +		 * some polling if modem doesn't use notification.
>> +		 */
>> +	default:
>> +		sd->sim_state_query =3D at_util_sim_state_query_new(sd->chat,
>> +						2, 20, sim_state_cb, cbd);
>>   		return;
>>   	}
> this part just looks wrong. You are now also doing CPIN polling for the
> Ericsson and ST-Ericsson cards.
>

Ok I can fix it easily.

>>
>> @@ -1246,6 +1271,9 @@ static void at_sim_remove(struct ofono_sim *sim)
>>   {
>>   	struct sim_data *sd =3D ofono_sim_get_data(sim);
>>
>> +	/* Cleanup potential SIM state polling */
>> +	at_util_sim_state_query_free(sd->sim_state_query);
>> +
> Who owns the cbd data in this case? Are we not leaking that here?
>

Yes, we are. I see 2 options here:
a- Tweaking current at_util_sim_state_query_new(GAtChat *chat,
                         guint interval, guint num_times,
                         at_util_sim_inserted_cb_t cb,
                         void *userdata, GDestroyNotify data_destroy); =

in adding a destroyer for user data

b- Implementing new gpointer at_util_sim_state_query_get_data(struct =

at_util_sim_state_query *req); and free user_data during remove

Or maybe you have another solution?

>>   	ofono_sim_set_data(sim, NULL);
>>
>>   	g_at_chat_unref(sd->chat);

Kind regards,
Guillaume


--===============5605743865157090338==--

