Content-Type: multipart/mixed; boundary="===============6586918570950576429=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 12/12] qmi: use standard endian macros
Date: Thu, 29 Mar 2018 18:35:34 +0200
Message-ID: <62bc7d95-5651-1f04-99f9-81b338b3549e@southpole.se>
In-Reply-To: <ef78e1a9-473c-6fef-0eeb-865687a6cd55@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6586918570950576429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 29/03/18 17:33, Denis Kenzior wrote:
> Hi Jonas,
>
> On 03/29/2018 08:58 AM, Jonas Bonn wrote:
>> ---
>> =C2=A0 drivers/qmimodem/qmi.c | 58 =

>> +++++++++++++++++++++++++-------------------------
>> =C2=A0 1 file changed, 29 insertions(+), 29 deletions(-)
>>
>
> Won't be taking this one.=C2=A0 If we're sticking to glib, then we should =

> use glib macros.=C2=A0 ell has its own versions of these, so this is just =

> extra churn for no benefit.

I suspected that would be the case. :)=C2=A0 No worries... I'll drop it.

But what I really don't get is is what the point is of ell providing =

functionality that's already provided in libc.=C2=A0 GLib did this for =

portability reasons, but ell targets Linux and that means glibc, uclibc, =

and musl and they all provide these standard things.=C2=A0 libell as a =

complement to libc makes sense; there are aspects of libell that are =

_seriously_ awesome.=C2=A0 But l_strdup, endian macros, l_malloc, etc. are =

just reinventing the wheel, as you put it yesterday.=C2=A0 As a programmer,=
 I =

know the semantics of strdup... but now I need to use l_strdup, the =

semantics of which I can't know without checking; this, unfortunately, =

is a good way of scaring people away from your project.

/Jonas

>
> Regards,
> -Denis


--===============6586918570950576429==--

