Content-Type: multipart/mixed; boundary="===============2891415313942039431=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 3/4] gprs: Use sim SPN watch API
Date: Tue, 17 Jan 2012 13:46:33 +0200
Message-ID: <4F155F99.1070809@intel.com>
In-Reply-To: <4F138B80.3060304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2891415313942039431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 01/16/2012 04:29 AM, Denis Kenzior wrote:
>> @@ -94,7 +94,9 @@ struct ofono_gprs {
[...]
>> +	unsigned int sim_watch;
>
> This is actually not necessary, the sim atom is always guaranteed to be
> there prior to the gprs atom.

Thanks, this should make it simpler.

>>   static void gprs_unregister(struct ofono_atom *atom)
[...]
>> +	if (gprs->sim)
>> +		sim_unregister(gprs,&gprs->spn_watch,&gprs->sim_watch,
>> +				&gprs->sim);
>
> Why do you have this here and in gprs_unregister?

Good point, this can be removed.

>> +static void spn_read_cb(const char *spn, const char *dc, void *data)
>>   {
>> -	struct ofono_gprs *gprs	=3D userdata;
>> -	char *spn =3D NULL;
>> -	struct ofono_atom *sim_atom;
>> -	struct ofono_sim *sim =3D NULL;
>> +	struct ofono_gprs *gprs	=3D data;
>> +
>> +	if (gprs->spn_watch =3D=3D 0)
>> +		return;
>
> Not sure I follow why you need this?

You are right, this isn't necessary.

>> +	ofono_sim_remove_spn_watch(gprs->sim,&gprs->spn_watch);
>>
>> -	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(gprs->atom=
),
>> -						OFONO_ATOM_TYPE_SIM);
>> -	if (sim_atom) {
>> -		sim =3D __ofono_atom_get_data(sim_atom);
>> -		provision_contexts(gprs, ofono_sim_get_mcc(sim),
>> -					ofono_sim_get_mnc(sim), spn);
>> -	}
>> +	if (gprs->sim !=3D NULL&&  spn !=3D NULL)
>
> And this might be overly paranoid given that you're getting called by
> the sim atom.
>
> I tend to like the philosophy of 'crash early'.  This lets you know very
> quickly if something is wrong without obfuscating the cause.

Good catch, these checks are redundant indeed, thanks.

>>   void ofono_gprs_register(struct ofono_gprs *gprs)
>>   {
[...]
>> +	if (gprs->sim =3D=3D NULL)
>> +		ofono_gprs_finish_register(gprs);
>>
>> -	if (gprs->contexts =3D=3D NULL&&  sim !=3D NULL) {
>> -		/* Get Service Provider Name from SIM for provisioning */
>> -		gprs->sim_context =3D ofono_sim_context_create(sim);
>> +	gprs_load_settings(gprs, ofono_sim_get_imsi(gprs->sim));
>
> If sim is null we still try to load the settings? Wouldn't this crash?

Thanks for the comments, I will correct all these.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============2891415313942039431==--

