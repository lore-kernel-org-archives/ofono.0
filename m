Content-Type: multipart/mixed; boundary="===============1433762339025948073=="
MIME-Version: 1.0
From: Nicolas Serafini <nicolas.serafini@sensefly.com>
Subject: Re: [PATCH] mbim: add optional copy of TEMP_FAILURE_RETRY macro (fix
 musl compile)
Date: Mon, 28 Jan 2019 15:19:56 +0000
Message-ID: <20190128161950.00004190@sensefly.com>
In-Reply-To: <99537250-8354-4976-95A4-5EF7362DBBED@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1433762339025948073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jan 2019 13:34:37 +0100 Marcel Holtmann <marcel@holtmann.org> =
wrote:

Hi Marcel,

>Hi Nicolas,
>
>> TEMP_FAILURE_RETRY is not available on musl.
>> =

>> Signed-off-by: Nicolas Serafini <nicolas.serafini@sensefly.com>
>> ---
>> drivers/mbimmodem/mbim.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> =

>> diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
>> index 54b18acf..4b040528 100644
>> --- a/drivers/mbimmodem/mbim.c
>> +++ b/drivers/mbimmodem/mbim.c
>> @@ -37,6 +37,16 @@
>> #include "mbim-message.h"
>> #include "mbim-private.h"
>> =

>> +/* taken from glibc unistd.h for musl support */
>> +#ifndef TEMP_FAILURE_RETRY
>> +#define TEMP_FAILURE_RETRY(expression)             \
>> +  (__extension__                                   \
>> +    ({ long int __result;                          \
>> +       do __result =3D (long int) (expression);      \
>> +       while (__result =3D=3D -1L && errno =3D=3D EINTR);  \
>> +       __result; }))
>> +#endif
>> +
>
>or you use the notation that is used in src/storage.h and maybe even
>move it to a more common place. The TFR macro is used in various
>places.

Yes it's a good idea, what do you think about putting it in the "include/ty=
pes.h" file.

>
>Regards
>
>Marcel
>

Regards

Nicolas

--===============1433762339025948073==--

