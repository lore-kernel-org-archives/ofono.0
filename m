Content-Type: multipart/mixed; boundary="===============6473458101543289925=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Thu, 04 Oct 2018 23:09:44 -0500
Message-ID: <e4bf5417-581a-cc25-c90b-04c17a013e59@gmail.com>
In-Reply-To: <CAKSBH7Gw_jc93AGGZsi+ZmZy910BJ6DdYOxwUF8bzmjeReHKvw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6473458101543289925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> Not according to any compiler I tried.  I literally tested this before
>> sending the above email on both GCC 7.3 and GCC 8.2.  So what compiler
>> are you using?
> =

> default ubuntu 18.04 compiler:
> gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0

This was the same on my box.  I bet you were just missing the

if (auth_to_foo() < 0) part

> I will submit a new patch later today.
> Would you please comment on the [PATCH 4/6] too, about the plugins, so
> I will take care of both together?
> =


Done.  And please re-submit the entire series.  Otherwise I get lost =

what version goes with what.

Regards,
-Denis

--===============6473458101543289925==--

