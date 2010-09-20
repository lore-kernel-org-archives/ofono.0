Content-Type: multipart/mixed; boundary="===============2108668858712375268=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [RFC PATCH v1 1/2] huawei: poll sim state
Date: Mon, 20 Sep 2010 15:29:44 +0300
Message-ID: <87sk14wqbr.fsf@potku.valot.fi>
In-Reply-To: <1284727731.2405.214.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2108668858712375268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,
>
>> On my Huawei E1552 when I plug in the modem (ie. cold start) with PIN lo=
cked
>> SIM, the sim state is 255 (HUAWEI_SIM_STATE_NOT_EXISTENT). As the modem
>> doesn't send ^SIMST notifications, poll the sim state until it's ready.
>> =

>> In theory it might be possible to do this better, for example follow
>> ^BOOT notifications or something, but it's unknown what parameter we
>> should check for.
>

[...]

>> +	if (sim_state =3D=3D HUAWEI_SIM_STATE_NOT_EXISTENT) {
>>  		ofono_sim_inserted_notify(data->sim, FALSE);
>> +
>> +		/* SIM is not ready, try again a bit later */
>> +		return TRUE;
>> +	}
>>  	else
>>  		ofono_sim_inserted_notify(data->sim, TRUE);
>
> Coding style. } else on the same line. You should know this by now ;)

Oops :)

> Also in this case since you do return TRUE anyway from the if block, why
> bother with else. Just don't.

Good point. I changed that.
>> +	if (rerun && data->sim_poll_count < MAX_SIM_POLL_COUNT) {
>> +		data->sim_poll_count++;
>> +		data->query_sim_state =3D g_timeout_add_seconds(2,
>> +								query_sim_state,
>> +								modem);
>
> Now I don't like the query_sim_state name. It should sim_poll_timeout or
> something similar. At least make it clear that it is timeout.

I didn't know if you talked only about about the name of structure field
or also about the function name? I only changed the structure name.

>> +
>> +	/* query_sim_state(modem); */
>>  }
>
> What is this ???

A leftover from my tests. Removed

>>  static GAtChat *create_port(const char *device)
>> @@ -546,6 +586,9 @@ static int huawei_disable(struct ofono_modem *modem)
>>  =

>>  	DBG("%p", modem);
>>  =

>> +	if (data->query_sim_state)
>> +		g_source_remove(data->query_sim_state);
>> +
>
> You need to set the timeout variable also to 0. Otherwise you have some
> funny side effect then next time enabling the modem.
>
> Also I prefer check for the timeout variables with > 0.

Fixed.

I'll send v2 shortly.

-- =

Kalle Valo

--===============2108668858712375268==--

