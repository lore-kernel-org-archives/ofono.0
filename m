Content-Type: multipart/mixed; boundary="===============3125406324419376933=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv3 06/12] call-forwarding: Don't run conditional queries if
 cfu is active
Date: Wed, 21 Mar 2012 13:49:39 +0200
Message-ID: <4F69C053.1020205@intel.com>
In-Reply-To: <4F691C2B.9070406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3125406324419376933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 03/21/2012 02:09 AM, Denis Kenzior wrote:
>>   static inline void get_query_next_cf_cond(struct ofono_call_forwarding=
 *cf)
>> @@ -565,7 +564,9 @@ static DBusMessage *cf_get_properties(DBusConnection=
 *conn, DBusMessage *msg,
>>
>>   	cf->pending =3D dbus_message_ref(msg);
>>   	cf->query_next =3D 0;
>> -
>> +	cf->query_end =3D is_cfu_enabled(cf) ?
>> +					CALL_FORWARDING_TYPE_UNCONDITIONAL :
>> +					CALL_FORWARDING_TYPE_NOT_REACHABLE;
>>   	get_query_next_cf_cond(cf);
>>
>>   	return NULL;
>
> What if we're running GetProperties for the first time and CFU is active
> at the network, but for some reason (e.g. driver doesn't implement it)
> the SIM call forwarding rules are absent.  Won't we query conditional
> CFs needlessly here?

Good point and thanks for pointing this. I will correct so, that once the C=
FU is =

discovered and active, the conditional queries will be skipped.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============3125406324419376933==--

