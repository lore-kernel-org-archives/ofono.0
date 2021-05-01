Content-Type: multipart/mixed; boundary="===============8780419404787135708=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] simutil: Fill unused part of AID with FFs
Date: Sun, 02 May 2021 01:39:27 +0300
Message-ID: <2ad49b33-acca-9fc3-5c82-83f1d756999f@jolla.com>
In-Reply-To: <1b396bfc-bb2b-66a8-ee52-74723b7b1250@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8780419404787135708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30.4.2021 17.54, Denis Kenzior wrote:
> Hi Slava,
>
> On 4/29/21 11:09 AM, Slava Monich wrote:
>> Correct handling of short AIDs will take more than that, but
>> leaving part of the array uninitialized is wrong in any case.
>> ---
>> =C2=A0 src/simutil.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/src/simutil.c b/src/simutil.c
>> index 5d2aa6a2..e648c918 100644
>> --- a/src/simutil.c
>> +++ b/src/simutil.c
>> @@ -1588,6 +1588,7 @@ GSList *sim_parse_app_template_entries(const =

>> unsigned char *buffer, int len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto error;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(app=
.aid, aid, app.aid_len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(app.aid + app.aid_len=
, 0xff, 16 - app.aid_len);
>
> Would it not be easier to fix sim-auth to take aid_len into account =

> instead of hard-coding 16?=C2=A0 It seems like sim_auth_register is the =

> only one affected, but I didn't look deeply.


AFAICT it's not that trivial but feel free to disregard this patch - it =

doesn't make much sense to fix it half-way.


Rebards,

-Slava

--===============8780419404787135708==--

