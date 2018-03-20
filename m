Content-Type: multipart/mixed; boundary="===============2102676768936675008=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: Re: [PATCH 4/6] gemalto: handle sim is inserted or removed URCs
Date: Tue, 20 Mar 2018 09:37:10 +0100
Message-ID: <a8c0d0fa-adaf-cca8-da70-997b94a90d08@smile.fr>
In-Reply-To: <eb26b058-ae40-367a-6fdc-b7e341e75370@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2102676768936675008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 19/03/2018 18:10, Denis Kenzior wrote:
> Hi Gabriel, Mariem,
>
> On 03/19/2018 11:26 AM, Gabriel Lucas wrote:
>> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
>>
>> ---
>> =C2=A0 plugins/gemalto.c | 78 =

>> ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>> =C2=A0 1 file changed, 74 insertions(+), 4 deletions(-)
>>
>> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
>> index 5573606..029e09d 100644
>> --- a/plugins/gemalto.c
>> +++ b/plugins/gemalto.c
>> @@ -57,6 +57,8 @@
>> =C2=A0 #define GEMALTO_MODEL_PHS8P=C2=A0=C2=A0=C2=A0=C2=A0 "0053"
>> =C2=A0 #define GEMALTO_MODEL_ALS3=C2=A0=C2=A0=C2=A0=C2=A0 "0061"
>> =C2=A0 +static void gemalto_ciev_notify(GAtResult *result, gpointer =

>> user_data);
>> +
>
> Please note doc/coding-style.txt item M17.=C2=A0 I silently re-structured =

> this patch to avoid the need for this forward-declaration.
>
> Patch has been applied, thanks!
>
> Regards,
> -Denis

Thank you, that's better that way

Best regards,
Gabriel

--===============2102676768936675008==--

