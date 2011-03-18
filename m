Content-Type: multipart/mixed; boundary="===============8802060942055101495=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 4/4] emulator: add +COPS support
Date: Fri, 18 Mar 2011 10:13:52 +0100
Message-ID: <4D832250.3080106@linux.intel.com>
In-Reply-To: <4D827AA4.4080306@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8802060942055101495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 17/03/2011 22:18, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 03/17/2011 11:50 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
>> This needs to be in emulator as HFP plugin should answer AT+COPS requests
>> even when oFono is not registered on network.
>> ---
>>   src/emulator.c |   72 ++++++++++++++++++++++++++++++++++++++++++++
>>   src/network.c  |   90 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++----
>>   2 files changed, 155 insertions(+), 7 deletions(-)
>>
>> diff --git a/src/emulator.c b/src/emulator.c
>> index 864e50b..eb4f49e 100644
>> --- a/src/emulator.c
>> +++ b/src/emulator.c
>> @@ -49,6 +49,8 @@ struct ofono_emulator {
>>   	int events_mode;
>>   	gboolean events_ind;
>>   	GSList *indicators;
>> +	char op_name[17];
>> +	int net_mode;
>>   };
>>
>>   struct indicator {
>> @@ -387,6 +389,59 @@ fail:
>>   	}
>>   }
>>
>> +static void cops_cb(GAtServer *server, GAtServerRequestType type,
>> +			GAtResult *result, gpointer user_data)
>> +{
>> +	struct ofono_emulator *em =3D user_data;
>> +	char buf[32];
>> +
>> +	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP&&  em->slc =3D=3D FALSE) {
>> +		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
>> +		return;
>> +	}
>> +
>
> There's no need for this if you use ofono_emulator_add_handler since the
> handler_proxy will take care of this detail.
>
>> +	switch (type) {
>> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
>> +		sprintf(buf, "+COPS: %d,0,\"%s\"", em->net_mode, em->op_name);
>> +		g_at_server_send_info(em->server, buf, TRUE);
>> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
>> +		break;
>> +
>> +	case G_AT_SERVER_REQUEST_TYPE_SET:
>> +	{
>> +		GAtResultIter iter;
>> +		int val;
>> +
>> +		g_at_result_iter_init(&iter, result);
>> +		g_at_result_iter_next(&iter, "");
>> +
>> +		if (!g_at_result_iter_next_number(&iter,&val))
>> +			goto fail;
>> +
>> +		if (val !=3D 3)
>> +			goto fail;
>> +
>> +		if (!g_at_result_iter_next_number(&iter,&val))
>> +			goto fail;
>> +
>> +		if (val !=3D 0)
>> +			goto fail;
>> +
>> +		/* check there is no more parameter */
>> +		if (g_at_result_iter_skip_next(&iter))
>> +			goto fail;
>> +
>> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
>> +		break;
>> +	}
>> +
>> +	default:
>> +fail:
>> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
>> +		break;
>> +	}
>> +}
>> +
>
> Please move this function to netreg.c.  This should make this patch
> quite a bit simpler.
>
> <snip>
>
> Regards,
> -Denis

If this is moved to netreg.c, AT+COPS requests will not be handled when =

oFono modem is not online.
I understand that there is no problem to reply ERROR to AT+COPS?, but I =

think this is wrong for AT+COPS=3D3,0.
This is why I do this in emulator.c.

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============8802060942055101495==--

