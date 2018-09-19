Content-Type: multipart/mixed; boundary="===============2019663015922059596=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 19:28:20 +0300
Message-ID: <8ce15cf4-9505-c68c-8080-fc1ce97df3b8@jolla.com>
In-Reply-To: <0fb78129-194b-10c7-66f7-f857bb39521c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2019663015922059596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19/09/18 18:21, Denis Kenzior wrote:

> Hi Giacinto,
>
>> I would favour also renumbering with NONE on top, but I am not sure =

>> of the side effects everywhere, in case the values are used directly =

>> in commands.
>
> Actually there is no problem doing that.=C2=A0 The internal API is not =

> stable.=C2=A0 Besides, it will give all the guys who insist on maintainin=
g =

> out-of-tree plugins some extra work ;)
>

Anything in include is external API. We do maintain not just =

out-of-tree, but binary plugins. Backward (binary!) compatibility a must =

for us. Please do not break it.

-Slava

--===============2019663015922059596==--

