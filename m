Content-Type: multipart/mixed; boundary="===============7314606886185589526=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 19:54:22 +0300
Message-ID: <15b88dc7-f0bc-67c7-3963-5339f4c45613@jolla.com>
In-Reply-To: <9b74d1aa-9d2d-aaee-b510-003f79c6ff73@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7314606886185589526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19/09/18 19:32, Denis Kenzior wrote:
> Hi Slava,
>
>> Anything in include is external API. We do maintain not just =

>> out-of-tree, but binary plugins. Backward (binary!) compatibility a =

>> must for us. Please do not break it.
>
> That is why we have 'OFONO_API_SUBJECT_TO_CHANGE' as a reminder. We =

> mean it.=C2=A0 D-Bus API is stable, we never made any guarantees about th=
e =

> internal APIs.
>

I understand that! It makes things easier for you guys.

But we had to avoid certain compile-time dependencies in ofono, and a =

straightforward (and perhaps the only) way to achieve that was to use =

binary plugins. For us plugin API is not subject to change (plugins =

don't necessarily get upgraded together with ofono), meaning more =

changes between our fork and upstream in case if upstream breaks it, =

more maintenance work and more room for errors. Obviously, I would like =

to keep differences to a minimum.

I'm just humbly asking - if there's a way to keep plugin API backward =

compatible, please do it that way. There is at least one person in the =

world who would appreciate it.

Cheers,
-Slava

--===============7314606886185589526==--

