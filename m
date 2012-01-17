Content-Type: multipart/mixed; boundary="===============8732981003278126098=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 4/4] network: Use sim SPN watch API
Date: Tue, 17 Jan 2012 13:46:59 +0200
Message-ID: <4F155FB3.9040102@intel.com>
In-Reply-To: <4F138813.8090608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8732981003278126098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 01/16/2012 04:14 AM, Denis Kenzior wrote:
>> +static void spn_read_cb(const char *spn, const char *dc, void *data)
[...]
>> +	gboolean had_spn =3D netreg->spn !=3D NULL&&  strlen(netreg->spn)>  0;
>>
>>   	g_free(netreg->spn);
>>   	netreg->spn =3D NULL;
>> +	netreg->flags&=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
>> +				NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
[...]
>> +	if (netreg->current_operator)
>> +		netreg_emit_operator_display_name(netreg);
>
> This function ends up calling netreg_emit_operator_display_name twice,
> once if had_spn is true and once here.  That doesn't seem quite right.
>
> The original implementation was actually reacting to a SIM refresh,
> basically if any of the SPN files was updated, we'd switch to operator
> name as reported by NITZ (e.g. from +COPS) and wait for the SPN/CPHS SPN
> reading to finish.  Then issue another signal.
>
> In your implementation it is likely safe to simply always emit, in which
> case you do not need any of the above logic.  Given the likelihood of
> the above scenario it is probably fine to simply wait for the new
> SPN/CPHS name to be read before emitting the signal.

Thanks for the explanation here. You are right, I just missed this. This wo=
uld =

be better approach indeed.

>> +	g_free(netreg->spn);
>> +	netreg->spn =3D NULL;
>
> With the above in mind, you could actually access netreg->spn directly
> from the sim atom and save some memory, but the current implementation
> is fine as well.

I had this in mind, just wasn't sure whether this would keep the logic inta=
ct. I =

will try to do so.

Thanks for the help! I will prepare and send another patch.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============8732981003278126098==--

