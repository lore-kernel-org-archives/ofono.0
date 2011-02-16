Content-Type: multipart/mixed; boundary="===============6615930567064655996=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH 1/1] src: out of bounds problem in smsutil
Date: Wed, 16 Feb 2011 17:13:12 +0100
Message-ID: <4D5BF798.3070003@stericsson.com>
In-Reply-To: <4D5BF532.7080701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6615930567064655996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>> Valgrind complains that we step outside the allocated memory by 1 byte
>> since we loop the string with:
>>
>> while (*topics !=3D '\0')
>>
>> the allocated memory is the size of the string and any \0 ends up
>> outside. At least that's my interpretation.
>>
>
> It might be your loop is actually going past the end, not that the
> terminating NULL is not within bounds returned from
> cbs_topic_ranges_to_string.  If the original code was wrong then we
> should be seeing valgrind report errors on the cbs code used in
> unit/test-sms.c.  I'm not seeing this at all.

Yes you absolutely correct, we step it an extra time in one case.

Please disregard the patch.

Regards
Andreas

--===============6615930567064655996==--

