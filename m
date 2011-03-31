Content-Type: multipart/mixed; boundary="===============8766096726200491458=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] stkutil: Complete the TLV parsing/builder to
 support BIP commands
Date: Thu, 31 Mar 2011 10:37:47 -0500
Message-ID: <4D949FCB.9080908@gmail.com>
In-Reply-To: <4D94596B.8070008@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8766096726200491458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>> +        }
>>> +    }
>>> +
>>> +    *apn =3D g_try_malloc(offset + 1);
>>> +    if (*apn =3D=3D NULL)
>>> +        return FALSE;
>>> +
>>> +    memcpy(*apn, decoded_apn, offset);
>>> +    (*apn)[offset] =3D '\0';
>>
>> *apn =3D g_strdup(decoded_apn);
>>
>> is really just fine ;)
>>
>>>
> =

> Ok, I'm just going to use g_strndup to get the string null terminated.
> =

> =


Might be easier to null terminate decoded_apn and use g_strdup.  That
might be a bit easier to read (and a more common variation) then trying
to use g_strndup.

>>> +/* Defined in TS 102.223 Section 8.56 */
>>> +enum stk_channel_status {
>>> +    STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED =3D 0x00,
>>> +    STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED =3D    0x01,
>>> +    STK_CHANNEL_TCP_IN_CLOSED_STATE =3D        0x02,
>>> +    STK_CHANNEL_TCP_IN_LISTEN_STATE =3D        0x03,
>>> +    STK_CHANNEL_TCP_IN_ESTABLISHED_STATE =3D        0x04,
>>> +    STK_CHANNEL_LINK_DROPPED =3D            0x05,
>>> +};
>>> +
>>
>> You're playing serious magic here, but fair enough.
> =

> =

> Here, I'm introducing these enums to list only the different channel
> status but they can't be used indeed as direct values for the channel
> status TLV parsing/building.
> =

> Note that for the section:
> =

> enum stk_qualifier_open_channel {
>     STK_OPEN_CHANNEL_ON_DEMAND =3D            0x00,
>     STK_OPEN_CHANNEL_IMMEDIATE =3D            0x01,
>     STK_OPEN_CHANNEL_AUTOMATIC_RECONNECTION =3D    0x02,
>     STK_OPEN_CHANNEL_IMMEDIATE_IN_BACKGROUND_MODE =3D    0x04,
> };
> =

> The purpose of these enums is to use them as bit masks. Maybe #defines
> could be more appropriate?

I'd almost suggest booleans or 3 separate enums instead.  However, it is
fine to use enums in such a manner (though I don't see the point of 0x00
value).  It might be better to indicate they're flags / bits in the enum
name.  e.g. STK_OPEN_CHANNEL_FLAG_IMMEDIATE,
STK_OEPN_CHANNEL_FLAG_BACKGROUND, etc.

Regards,
-Denis

--===============8766096726200491458==--

