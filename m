Content-Type: multipart/mixed; boundary="===============4811461198139349147=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 01/20] bug.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Fri, 23 Jul 2010 16:59:57 -0500
Message-ID: <4C4A10DD.3090501@gmail.com>
In-Reply-To: <1279922224.26204.134.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4811461198139349147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

>> Second, please actually check that your code passes make distcheck:
>>
>>   CCLD   unit/test-idmap
>>   CC     unit/test-sms.o
>>   CC     src/smsutil.o
>> ../src/smsutil.c:40:17: error: bug.h: No such file or directory
>> make[2]: *** [src/smsutil.o] Error 1
>> make[1]: *** [all] Error 2
>> make: *** [distcheck] Error 1
> =

> another FAIL. However, I am hitting another one in missing
> ofono/types.h, even after having pulled the tip as of today. Is that one
> known? Anyway, fixing this one.
> =


Make distcheck passes fine on $HEAD for me.

Regards,
-Denis

--===============4811461198139349147==--

