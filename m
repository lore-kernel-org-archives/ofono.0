Content-Type: multipart/mixed; boundary="===============3972935879982852792=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: Re: [PATCH 4/6] gemalto: handle sim is inserted or removed URCs
Date: Fri, 16 Mar 2018 14:28:05 +0100
Message-ID: <a6430159-0f4b-277c-9d3d-3c4c8cca6d33@smile.fr>
In-Reply-To: <9a9cd20d-6877-08bd-0ba9-7b4facc6c91e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3972935879982852792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 15/03/2018 18:26, Denis Kenzior wrote:
> Hi Gabriel,
>
> On 03/15/2018 07:49 AM, Gabriel Lucas wrote:
>> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
>>
>> +=C2=A0=C2=A0=C2=A0 g_at_result_iter_init(&iter, result);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next(&iter, "+CIEV:"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>
> So generally +CIEV indication is an <index>,<value> syntax.
We receive this kind of signal: +CIEV: simstatus,<status>.
In this code, Mariem is ensuring the index is simstatus.
Do you prefer us to use g_at_result_iter_next to handle the index ?
Or even to use "+CIEV: simstatus" as prefix in the register function ?
>> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next_unquoted_string(&iter, &i=
nd_str))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>
> Does Gemalto use some other syntax here?=C2=A0 If so, you might want to =

> document a simple example above.
I've added a comment
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_inserted_notify(si=
m, FALSE);
>> +=C2=A0=C2=A0=C2=A0 } else if(status =3D=3D 1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_inserted_notify(si=
m, TRUE);
>> +=C2=A0=C2=A0=C2=A0 }
>
> Okay, but simpler written as ofono_sim_inserted_notify(sim, status);
The thing is we don't only receive the status 0 and 1. We also have 4 =

(ALS3) and
5 (ALS3 + PHS8P). Only the first two should be used.

Best regards,
Gabriel

--===============3972935879982852792==--

