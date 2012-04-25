Content-Type: multipart/mixed; boundary="===============3766700510569564177=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv4 12/13] call-forwarding: Cache ss TYPE_ALL modifications
Date: Wed, 25 Apr 2012 13:59:39 +0300
Message-ID: <4F97D91B.30103@intel.com>
In-Reply-To: <4F95CBC3.60808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3766700510569564177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 04/24/2012 12:38 AM, Denis Kenzior wrote:
>> static gboolean cf_ss_control(int type, const char *sc,
>>
>>   	switch (cf->ss_req->cf_type) {
>>   	case CALL_FORWARDING_TYPE_ALL:
>> +		cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
>>   		cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
>>   		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
>>   		break;
>
> I don't believe this would work for non-queries.  For example, lets say
> the user runs a registration operation on CALL_FORWARDING_TYPE_ALL and
> that fails for whatever reason.  Now the cached flag is set (perhaps
> erroneously)

Sorry, simply overlooked this.

Thanks for the help, I will correct the issues and prepare another patchset.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============3766700510569564177==--

