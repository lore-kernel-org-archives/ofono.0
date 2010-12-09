Content-Type: multipart/mixed; boundary="===============0649293483389680529=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] cdma-voicecall: Add CDMA MO Call Support
Date: Thu, 09 Dec 2010 02:05:58 -0600
Message-ID: <4D008DE6.6080200@gmail.com>
In-Reply-To: <1291748978.3053.23.camel@dardoyle-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0649293483389680529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

>> If not, then using an enum defined in include/cdma-voicecall.h would be
>> better.  One major benefit of defining a dedicated enum for CDMA is the
>> compiler checking that all enum values are being handled.  If you re-use
>> the GSM version you would have to resort to using default statements.
>> This causes you to lose that extra compiler sanity checking, not to
>> mention is against rule M12 of the coding style.  And yes I know we're
>> not always consistent with this one ;)
>>
> =

> This is our preference- we can move the cdma enum from /src/common.h
> into include/cdma-voicecall.h if you would prefer that location?

I'm fine with doing that.

Regards,
-Denis

--===============0649293483389680529==--

