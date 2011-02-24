Content-Type: multipart/mixed; boundary="===============1061298164139100340=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 1/2] emulator: add CMER support
Date: Thu, 24 Feb 2011 11:56:55 +0100
Message-ID: <4D663977.7020909@linux.intel.com>
In-Reply-To: <4D656A5C.4010103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1061298164139100340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

Le 23/02/2011 21:13, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 02/23/2011 01:00 PM, Fr=C3=A9d=C3=A9ric Danis wrote:
>> ---
>>   src/emulator.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>   1 files changed, 105 insertions(+), 2 deletions(-)
>
> I applied this patch, but one comment below:
>
>>
>> diff --git a/src/emulator.c b/src/emulator.c
>> index f0ca8c8..ca36c0e 100644
>> --- a/src/emulator.c
>> +++ b/src/emulator.c
>> @@ -43,6 +43,8 @@ struct ofono_emulator {
>>   	GAtServer *server;
>>   	GAtPPP *ppp;
>>   	guint source;
>> +	int events_mode;
>> +	gboolean events_ind;
>>   	GSList *indicators;
>>   };
>>
>> @@ -251,6 +253,103 @@ fail:
>>   	}
>>   }
>>
>> +static void cmer_cb(GAtServer *server, GAtServerRequestType type,
>> +			GAtResult *result, gpointer user_data)
>> +{
>> +	struct ofono_emulator *em =3D user_data;
>> +	char buf[32];
>> +
>> +	switch (type) {
>> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
>> +		sprintf(buf, "+CMER: %d,0,0,%d,0", em->events_mode,
>> +						em->events_ind);
>> +		g_at_server_send_info(em->server, buf, TRUE);
>> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
>> +		break;
>> +
>> +	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
>> +		sprintf(buf, "+CMER: (0,3),(0),(0),(0,1),(0)");
>> +		g_at_server_send_info(em->server, buf, TRUE);
>> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
>> +		break;
>> +
>> +	case G_AT_SERVER_REQUEST_TYPE_SET:
>> +	{
>> +		GAtResultIter iter;
>> +		int mode;
>> +		int ind =3D em->events_ind;
>> +		int val;
>> +
>> +		g_at_result_iter_init(&iter, result);
>> +		g_at_result_iter_next(&iter, "");
>> +
>> +		/* mode */
>> +		if (g_at_result_iter_next_number(&iter,&mode) =3D=3D FALSE)
>> +			goto fail;
>> +
>> +		if ((mode !=3D 0)&&  (mode !=3D 3))
>> +			goto fail;
>> +
>> +		/* keyp */
>> +		if (g_at_result_iter_next_number(&iter,&val) =3D=3D FALSE) {
>> +			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
>> +				goto done;
>> +			goto fail;
>> +		}
>
>> From what I understand you're trying to enable something like:
>
> +CMER=3D3,,1 right?
>
> So this code does accomplish this, but it also allows silliness like this:
>
> +CMER=3D3,"foobar",,1
>
> You might want to make a special version of next_number that would
> actually check that either the number is given, or the field is empty.
>

The current version check that the parameter is a number or the end =

(skip_next returns false) :
AT+CMER=3D3,0,0,1,0 or AT+CMER=3D3,0 are supported.

Currently void parameter are not supported (AT+CMER=3D3,,,1).

I will send a patch to support number or void parameter.

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============1061298164139100340==--

