Content-Type: multipart/mixed; boundary="===============2230356124744522837=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv3 03/12] call-forwarding: Refactor
 cf_condition_find_with_cls() slightly
Date: Wed, 21 Mar 2012 13:45:26 +0200
Message-ID: <4F69BF56.6020101@intel.com>
In-Reply-To: <4F6917C2.2050001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2230356124744522837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 03/21/2012 01:50 AM, Denis Kenzior wrote:
>> +	return CFC(a)->cls - CFC(b)->cls;
>
> You're breaking const-correctness here.

Thanks for pointing this. The intention was to save a few instructions here=
, but =

just missed that.

> Also, why do you rename the function?  I do think we should have
> 'condition' or at least 'cond' in the name to make it clear what it
> does.  My vote is for cf_cond_compare...

Thanks, I agree, cf_cond_compare() would be more consistent and clear.

>> +static struct ofono_call_forwarding_condition *cf_find(GSList *l, int c=
ls)
>
> Same as above, at least name it cf_cond_find.  Also, I'd prefer changes
> to this function to be in a separate patch.

OK.

>> -static int cf_find_timeout(GSList *cf_list, int cls)
>> +static int cf_find_timeout(GSList *l, int cls)
>
> Same here, lets name this cf_cond_find_timeout

OK.

>> -static void cf_cond_list_print(GSList *list)
>> +static void cf_cond_list_print(GSList *l)
>>   {
>> -	GSList *l;
>> -	struct ofono_call_forwarding_condition *cond;
>> -
>> -	for (l =3D list; l; l =3D l->next) {
>> -		cond =3D l->data;
>> +	struct ofono_call_forwarding_condition *c;
>>
>> +	for (; l&&  (c =3D l->data); l =3D l->next)
>
> After going back and forth on this one, I'm actually against this style.
>   Mainly it is too hard to notice the assignment, inside the continuation
> check expression.  I'd really prefer that we assign c inside the for
> loop block.  Also, l->data should never be NULL, so in this case I'd
> rather crash and find out early than inadvertently covering it up.

OK, thanks. I agree on both points here.

>> +			number =3D new_cfu ? "" : phone_number_to_string(
>>   							&lc->phone_number);
>
> This part really belongs in a separate patch.

OK.

Thanks for the help, I will correct all these.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============2230356124744522837==--

