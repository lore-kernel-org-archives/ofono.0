Content-Type: multipart/mixed; boundary="===============2678850033178491796=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 23:48:24 +0300
Message-ID: <3362056b-a4d5-d51f-7c23-8e1fef2c130a@jolla.com>
In-Reply-To: <15b88dc7-f0bc-67c7-3963-5339f4c45613@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2678850033178491796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19/09/18 19:54, Slava Monich wrote:
> On 19/09/18 19:32, Denis Kenzior wrote:
>> Hi Slava,
>>
>>> Anything in include is external API. We do maintain not just =

>>> out-of-tree, but binary plugins. Backward (binary!) compatibility a =

>>> must for us. Please do not break it.
>>
>> That is why we have 'OFONO_API_SUBJECT_TO_CHANGE' as a reminder. We =

>> mean it.=C2=A0 D-Bus API is stable, we never made any guarantees about t=
he =

>> internal APIs.
>>
>
> I understand that! It makes things easier for you guys.
>
> But we had to avoid certain compile-time dependencies in ofono, and a =

> straightforward (and perhaps the only) way to achieve that was to use =

> binary plugins. For us plugin API is not subject to change (plugins =

> don't necessarily get upgraded together with ofono), meaning more =

> changes between our fork and upstream in case if upstream breaks it, =

> more maintenance work and more room for errors. Obviously, I would =

> like to keep differences to a minimum.
>
> I'm just humbly asking - if there's a way to keep plugin API backward =

> compatible, please do it that way. There is at least one person in the =

> world who would appreciate it.
>

Actually, in our fork we have already modified enum =

ofono_gprs_auth_method and that's what we have there:

enum ofono_gprs_auth_method {
 =C2=A0=C2=A0=C2=A0 OFONO_GPRS_AUTH_METHOD_ANY =3D 0,
 =C2=A0=C2=A0=C2=A0 OFONO_GPRS_AUTH_METHOD_NONE,
 =C2=A0=C2=A0=C2=A0 OFONO_GPRS_AUTH_METHOD_CHAP,
 =C2=A0=C2=A0=C2=A0 OFONO_GPRS_AUTH_METHOD_PAP,
};

(ANY =3D PAP_CHAP, and don't ask me why we added new values to the =

beginning of the enum - it was before we started using binary plugins). =

I would be more than happy if upstream started to use the same enum!

Cheers,
-Slava

--===============2678850033178491796==--

