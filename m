Content-Type: multipart/mixed; boundary="===============8897128223285584199=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 11/19] stkutil: Add setup menu proactive command parser
Date: Wed, 12 May 2010 16:53:01 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731DE14AD3@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201005111421.27125.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8897128223285584199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


>> @@ -281,8 +281,9 @@ static gboolean parse_dataobj_alpha_id(struct
>>  comprehension_tlv_iter *iter, char *utf8;
>>
>>  	len =3D comprehension_tlv_iter_get_length(iter);
>> -	if (len < 1)
>> -		return FALSE;
>> +
>> +	if (len =3D=3D 0)
>> +		return TRUE;
>>
>>  	data =3D comprehension_tlv_iter_get_data(iter);
>>  	utf8 =3D sim_string_to_utf8(data, len);
>
>There is no mention that the Alpha identifier can be present and empty, so
>returning TRUE on a len 0 is not actually correct.  The only exception so =
far
>seems to be text string which explicitly allows NULL strings.

Thus alpha_id seems to be another exception. For ber-tlv setup menu, alpha =
identifier is mandatory, so sometimes we have to create an empty alpha id o=
bject with len equals 0. See the case "set up menu 1.1.3" in 102.384 (page =
333) for an example.

>
>> @@ -373,8 +374,10 @@ static gboolean parse_dataobj_item(struct
>>  comprehension_tlv_iter *iter, char *utf8;
>>
>>  	len =3D comprehension_tlv_iter_get_length(iter);
>> -	if (len < 2)
>> -		return FALSE;
>> +
>> +	if (len =3D=3D 0)
>> +		return TRUE;
>> +
>>
>
>Same with this one...

This one is another exception. See the same case as above. I plan to check =
all the mandatory dataobj and let len might equal to 0, how do you think of?

>> +
>> +		if (tag =3D=3D STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE
>||
>> +			tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
>> +
>> +			if (tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
>> +				struct stk_item *item =3D dataobj;
>> +				/* either return is FALSE or item is empty */
>> +				if (item->id =3D=3D 0)
>> +					g_free(item);
>> +				else
>> +					*list =3D g_slist_prepend(*list, item);
>> +			} else
>> +				*list =3D g_slist_prepend(*list, dataobj);
>> +		} else
>> +			l =3D l->next;
>> +
>> +		if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
>> +			break;
>>  	}
>>
>
>I really don't like this.  I understand why you're doing it this way, but =
lets
>try to make this more elegant.  Either add another FLAG saying that the it=
ems
>are actually in a list, or parse the item list separately.
>
>e.g.
>
>parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID,
>			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
>			&obj->alpha_id,
>			STK_DATA_OBJECT_TYPE_ITEM,
>			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM |
>DATAOBJ_FLAG_LIST,
>			&obj->items, ...
>
>or
>
>/* Parse only until item list */
>parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID,
>			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
>			&obj->alpha_id,
>			STK_DATA_OBJECT_TYPE_ITEM,
>			STK_DATA_OBJECT_TYPE_INVALID);
>
>/* Manually parse item list */
>...
>
>/* Parse rest */
>...
>

The second approach is hard to be implemented: We have moved comprehension_=
tlv_iter_next() to parse_dataobj(), when manually parsing item list, I have=
 to get the next one to see if it's an item object. Then we have to rollbac=
k one if the next is not an item dataobj. =

I like the first approach (Actually it's similar to my solution ;)) and wil=
l send patch based on this. =




Regards,
-Yang

--===============8897128223285584199==--

