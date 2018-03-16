Content-Type: multipart/mixed; boundary="===============3896154415000733460=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] gemalto: handle sim is inserted or removed URCs
Date: Fri, 16 Mar 2018 09:03:22 -0500
Message-ID: <3a3ffd63-06ca-a9e7-c523-650000dd4b59@gmail.com>
In-Reply-To: <a6430159-0f4b-277c-9d3d-3c4c8cca6d33@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3896154415000733460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 03/16/2018 08:28 AM, Gabriel Lucas wrote:
> Hi Denis,
> =

> On 15/03/2018 18:26, Denis Kenzior wrote:
>> Hi Gabriel,
>>
>> On 03/15/2018 07:49 AM, Gabriel Lucas wrote:
>>> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
>>>
>>> +=C2=A0=C2=A0=C2=A0 g_at_result_iter_init(&iter, result);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next(&iter, "+CIEV:"))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +
>>
>> So generally +CIEV indication is an <index>,<value> syntax.
> We receive this kind of signal: +CIEV: simstatus,<status>.
> In this code, Mariem is ensuring the index is simstatus.
> Do you prefer us to use g_at_result_iter_next to handle the index ?
> Or even to use "+CIEV: simstatus" as prefix in the register function ?

Okay, that makes sense now.  Gemalto should really fix their firmware as =

this syntax is not really correct, but nothing we can do about it now. =

I would stick with the current approach.

>>> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next_unquoted_string(&iter, &=
ind_str))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>
>> Does Gemalto use some other syntax here?=C2=A0 If so, you might want to =

>> document a simple example above.
> I've added a comment
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_inserted_notify(s=
im, FALSE);
>>> +=C2=A0=C2=A0=C2=A0 } else if(status =3D=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_inserted_notify(s=
im, TRUE);
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> Okay, but simpler written as ofono_sim_inserted_notify(sim, status);
> The thing is we don't only receive the status 0 and 1. We also have 4 =

> (ALS3) and
> 5 (ALS3 + PHS8P). Only the first two should be used.

In that case I would use a switch/case statement, add a case label =

/comment for the other possibilities and what they mean and simply use a =

'break' statement for those.

Regards,
-Denis

--===============3896154415000733460==--

