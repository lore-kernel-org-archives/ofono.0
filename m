Content-Type: multipart/mixed; boundary="===============5364062740415816654=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv4 10/13] call-forwarding: CFU unset, update conditionals
Date: Wed, 25 Apr 2012 13:58:30 +0300
Message-ID: <4F97D8D6.6070505@intel.com>
In-Reply-To: <4F95C453.6010504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5364062740415816654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 04/24/2012 12:06 AM, Denis Kenzior wrote:
>>static void set_query_cf_callback(const struct ofono_error *error, int to=
tal,
[...]
>> +	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL) {
>> +		cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
>
> I'm not quite following why we need to set this flag here?

The intention was to cache for the cases we can:

- CFU is set.
- CFU is unset (this also triggers the re-querying of conditionals).

If the logic is correct, perhaps, I could document this better. It probably =

needs the in place comment.

>> +		/*
>> +		 * CFU has been disabled, conditionals need to be updated
>> +		 */
>> +		if (is_cfu_enabled(cf) =3D=3D FALSE)
>> +			cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
>
> Would it make more sense to make this decision in set_property_request()?

Sure, this makes sense and will save a bit. Initially I placed the check th=
ere, =

but then tried to optimize for some corner case. Just forgot to move it bac=
k =

after reversing that optimization. Sorry, my fault.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============5364062740415816654==--

