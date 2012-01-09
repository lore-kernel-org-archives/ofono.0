Content-Type: multipart/mixed; boundary="===============2786958147976419315=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH_v0 2/3] huawei: Add modem type detection
Date: Mon, 09 Jan 2012 16:59:19 +0100
Message-ID: <4F0B0ED7.60309@linux.intel.com>
In-Reply-To: <688E999A39D0DD478D9CFCDC485D64820FC8C851@SHSMSX101.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2786958147976419315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 01/09/2012 02:47 PM, Deng, Ying An wrote:
>>>
>>>>
>>>>    	DBG("%p", modem);
>>>>
>>>> -	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
>>>> -	sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
>>>> +	if (data->gsm =3D=3D TRUE) {
>>>> +		ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
>>>> +		sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
>>>>    					"atmodem", data->pcui);
>>>> +	} else {
>>>> +		ofono_devinfo_create(modem, 0, "cdmamodem", data->pcui);
>>>> +		/* Create sim atom only if sim is not embedded */
>>>> +		if (data->sim_state !=3D SIM_STATE_ROMSIM)
>>>> +			sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
>>>> +						"atmodem", data->pcui);
>>> I am really not sure that it is a good idea to just use the GSM SIM atom
>>> here. The EF structure will be different and we might cause more harm
>>> than doing any good in assuming that we get any proper EF fields.
>>>
>>> This is clearly the part where we need detailed information from Huawei
>>> on how this is suppose to work. And how this is suppose to be done for
>>> CDMA in the first place anyway.
>>
>> I agree, maybe Deng Yin An could ask Huawei how they (plan to) support
>> R-UIM in their modem e.g.
>> - Do they have some commands to read UIM file system
>> - And what does ROMSIM consist in (differences against R-UIM)?
>
> Almost all CDMA modems in Chinese market support UIM/RUIM, including EC12=
61.
> There're commands to check if UIM exists or ROMSIM exists.
> The CDMA dongles support AT commands include those to touch SMS, address =
book,
> the values includes field to see if it is from UIM/ROMSIM or NV inside do=
ngle.
> But I didn't see a command to touch raw FS directly.
>
>>

As previously indicated by Denis, the goal (if possible) is to use a =

unified SIM atom for GSM and CDMA.
So far, this should be possible as the R-UIM can be considered as an =

extension of SIM (R-UIM 3GPP2 specification C.S0023).
In practice, it is a matter of reading different EFs, while CHV/PIN =

handling, BDN, FDN, etc are the same.

Actually, with the R-UIM capable CDMA dongles we have, the PIN =

management appears to be exposed by standard AT commands (+CPIN, +CLCK). =

However, this needs to be confirmed an documented by the manufacturers.
Regarding FS reading/writing, this seems to be rather closed (at least =

through AT commands).

My suggestion is to skip for now all EFs reading in case of R-UIM, and =

support only the pin handling.
We can also think to retrieve the IMSI even if this Id is actually not =

mandatory for ConnMan (as the serial number is also considered).
Are you OK with this first approach?

Regards,

Philippe.

>>>> +	}
>>>>
>>>>    	if (sim&&   data->have_sim =3D=3D TRUE)
>>>>    		ofono_sim_inserted_notify(sim, TRUE);
>>>> @@ -670,6 +719,9 @@ static void huawei_post_sim(struct ofono_modem
>> *modem)
>>>>
>>>>    	DBG("%p", modem);
>>>>
>>>> +	if (data->gsm =3D=3D FALSE)
>>>> +		return;
>>>> +
>>>>    	if (data->voice =3D=3D TRUE) {
>>>>    		ofono_voicecall_create(modem, 0, "huaweimodem", data->pcui);
>>>>    		ofono_audio_settings_create(modem, 0,
>>>> @@ -695,6 +747,15 @@ static void huawei_post_online(struct
>> ofono_modem *modem)
>>>>
>>>>    	DBG("%p", modem);
>>>>
>>>> +	if (data->gsm =3D=3D FALSE) {
>>>> +		ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem",
>>>> +						data->pcui);
>>>> +
>>>> +		ofono_cdma_connman_create(modem, OFONO_VENDOR_HUAWEI,
>>>> +						"cdmamodem", data->modem);
>>>> +		return;
>>>> +	}
>>>> +
>>>>    	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI,
>> "atmodem", data->pcui);
>>>>
>>>>    	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
>>> Lets do if (data->have_gsm ... and if (data->have_cdma ...) separate
>>> here. I rather no degrade GSM to second class citizen.
>>>
>>> Regards
>>>
>>> Marce
>>
>> Kind regards,
>> Guillaume
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============2786958147976419315==--

