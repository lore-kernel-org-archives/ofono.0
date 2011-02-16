Content-Type: multipart/mixed; boundary="===============7323592310717695131=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] src: out of bounds problem in smsutil
Date: Wed, 16 Feb 2011 10:02:58 -0600
Message-ID: <4D5BF532.7080701@gmail.com>
In-Reply-To: <4D5BF23A.4080308@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7323592310717695131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

>>>       }
>>>
>>>       /* Space for ranges, commas and terminator null */
>>> -    ret =3D g_new(char, len + nelem);
>>> +    ret =3D g_new0(char, len + nelem + 1);
>>
>> I'm having trouble seeing how the old code was wrong.  nelem contains
>> the number of elements.  Since the last element does not end with a
>> comma, the use of nelem + 1 in g_new is not necessary.  sprintf takes
>> care of adding the terminating null, so using g_new0 is also less
>> efficient.
>>
>> Are you adding channels that are 5 digits long by any chance?
> =

> Valgrind complains that we step outside the allocated memory by 1 byte
> since we loop the string with:
> =

> while (*topics !=3D '\0')
> =

> the allocated memory is the size of the string and any \0 ends up
> outside. At least that's my interpretation.
> =


It might be your loop is actually going past the end, not that the
terminating NULL is not within bounds returned from
cbs_topic_ranges_to_string.  If the original code was wrong then we
should be seeing valgrind report errors on the cbs code used in
unit/test-sms.c.  I'm not seeing this at all.

Regards,
-Denis

--===============7323592310717695131==--

