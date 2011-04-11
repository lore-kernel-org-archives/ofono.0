Content-Type: multipart/mixed; boundary="===============5821693304396617882=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@intel.com>
Subject: Re: [PATCH v2 3/8] emulator: add RING for HFP AG
Date: Mon, 11 Apr 2011 16:09:51 +0000
Message-ID: <4DA327CB.8030302@intel.com>
In-Reply-To: <4DA32366.9010509@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5821693304396617882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 11/04/2011 17:51, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 04/07/2011 11:33 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
>> ---
>>   src/emulator.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++-=
-------
>>   1 files changed, 73 insertions(+), 13 deletions(-)
>>
>> diff --git a/src/emulator.c b/src/emulator.c
>> index 2707592..f1ccfb3 100644
>> --- a/src/emulator.c
>> +++ b/src/emulator.c
>> @@ -37,6 +37,8 @@
>>   #define DUN_DNS_SERVER_1       "10.10.10.10"
>>   #define DUN_DNS_SERVER_2       "10.10.10.11"
>>
>> +#define RING_TIMEOUT 3
>> +
>>   struct ofono_emulator {
>>   	struct ofono_atom *atom;
>>   	enum ofono_emulator_type type;
>> @@ -49,6 +51,7 @@ struct ofono_emulator {
>>   	int events_mode;
>>   	gboolean events_ind;
>>   	GSList *indicators;
>> +	guint ring;
>
> Please name this callsetup_source.
>
>>   };
>>
>>   struct indicator {
>> @@ -177,6 +180,42 @@ error:
>>   	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
>>   }
>>
>> +static struct indicator *find_indicator(struct ofono_emulator *em,
>> +						const char *name, int *index)
>> +{
>> +	GSList *l;
>> +	int i;
>> +
>> +	for (i =3D 1, l =3D em->indicators; l; l =3D l->next, i++) {
>> +		struct indicator *ind =3D l->data;
>> +
>> +		if (g_str_equal(ind->name, name) =3D=3D TRUE) {
>> +			if (index)
>> +				*index =3D i;
>> +
>> +			return ind;
>> +		}
>
> To avoid nesting, this might be better written as:
>
> if (g_str_equal(ind->name, name) =3D=3D FALSE)
> 	continue;
>
> if (index)
> 	...
>
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static gboolean ring_cb(gpointer user_data)
>
> Please name this something like: send_callsetup_indicators
>
>> +{
>> +	struct ofono_emulator *em =3D user_data;
>> +	struct indicator *call_ind;
>> +
>> +	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP&&  em->slc =3D=3D FALSE)
>> +		return TRUE;
>> +
>> +	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
>> +
>> +	if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
>> +		g_at_server_send_unsolicited(em->server, "RING");
>> +
>> +	return TRUE;
>> +}
>> +
>>   static void brsf_cb(GAtServer *server, GAtServerRequestType type,
>>   			GAtResult *result, gpointer user_data)
>>   {
>> @@ -418,6 +457,11 @@ static void emulator_unregister(struct ofono_atom *=
atom)
>>   		em->source =3D 0;
>>   	}
>>
>> +	if (em->ring) {
>> +		g_source_remove(em->ring);
>> +		em->ring =3D 0;
>> +	}
>> +
>>   	for (l =3D em->indicators; l; l =3D l->next) {
>>   		struct indicator *ind =3D l->data;
>>
>> @@ -681,27 +725,43 @@ enum ofono_emulator_request_type ofono_emulator_re=
quest_get_type(
>>   void ofono_emulator_set_indicator(struct ofono_emulator *em,
>>   					const char *name, int value)
>>   {
>> -	GSList *l;
>>   	int i;
>>   	char buf[20];
>> +	struct indicator *ind;
>> +	struct indicator *call_ind;
>>
>> -	for (i =3D 1, l =3D em->indicators; l; l =3D l->next, i++) {
>> -		struct indicator *ind =3D l->data;
>> +	ind =3D find_indicator(em, name,&i);
>>
>> -		if (g_str_equal(ind->name, name) =3D=3D FALSE)
>> -			continue;
>> +	if (ind =3D=3D NULL || ind->value =3D=3D value || value<  ind->min
>> +			|| value>  ind->max)
>> +		return;
>>
>> -		if (ind->value =3D=3D value || value<  ind->min
>> -					|| value>  ind->max)
>> -			return;
>> +	ind->value =3D value;
>>
>> -		ind->value =3D value;
>> +	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
>>
>> -		if (em->events_mode =3D=3D 3&&  em->events_ind&&  em->slc) {
>> -			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
>> -			g_at_server_send_info(em->server, buf, TRUE);
>> -		}
>> +	if (em->events_mode =3D=3D 3&&  em->events_ind&&  em->slc) {
>> +		sprintf(buf, "+CIEV: %d,%d", i, ind->value);
>> +		g_at_server_send_info(em->server, buf, TRUE);
>
> Reminds me, this should be g_at_server_send_unsolicited
>
>> +	}
>>
>> +	/*
>> +	 * Ring timer should be started when callsetup indicator is set to
>> +	 *   Incoming
>> +	 * If there is no active call, a first RING should be sent just after
>> +	 *   the +CIEV
>> +	 * It should be stopped for all other values of callsetup
>> +	 */
>> +	if (g_str_equal(name, OFONO_EMULATOR_IND_CALLSETUP) =3D=3D FALSE)
>>   		return;
>> +
>> +	if (value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING&&  em->ring =3D=3D =
0) {
>> +		if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
>> +			ring_cb(em);
>> +
>> +		em->ring =3D g_timeout_add_seconds(RING_TIMEOUT, ring_cb, em);
>> +	} else if (value !=3D OFONO_EMULATOR_CALLSETUP_INCOMING&&  em->ring) {
>> +		g_source_remove(em->ring);
>> +		em->ring =3D 0;
>
> Do you really need to check for em->ring here?  You already return if
> the value of the indicator is already the same.  Also, it sounds like
> you should just start a timer and always call ring_cb when callsetup =3D=
=3D
> callsetup_incoming.  The CCWA/RING determination should be done in that
> function.
>
I agree with you that check of em->ring when callsetup becomes INCOMING =

is useless.
I thought that the second one, when callsetup is no more INCOMING, =

should be kept to stop the timer as soon as callsetup change states.
>>   	}
>>   }
>
> Regards,
> -Denis

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============5821693304396617882==--

