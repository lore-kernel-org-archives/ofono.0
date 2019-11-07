Content-Type: multipart/mixed; boundary="===============4134141744375820286=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: Re: [PATCH phonesim v3 1/2] Port to qt5
Date: Thu, 07 Nov 2019 11:26:30 +0100
Message-ID: <471e6980-7528-f449-69a8-d280d73017d3@gmx.de>
In-Reply-To: <2f8a4999-021a-1f80-0023-0994f24ff73e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4134141744375820286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you very much for applying the patches!

As mentioned earlier I have worked on a few additional commits to
completely replace all deprecated Qt APIs.

This is not strictly required until Qt6 is released, but will basically
allow to run on Qt6 right when it's released with just a few build
system changes.

If you are interested, just let me know when you have time to review
those as adding those patches is obviously not urgent.

In addition I added a cmake build system which allowed me to work with
Qt's QtCreator IDE, but I can very well understand if you don't want to
switch the build system and would leave that patch out.

I pushed the patches to KDE's GitLab instance
https://invent.kde.org/jbbgameich/ofono-phonesim/commits/master for now,
but would of course send them to the mailing list for review later.


Kind regards,

Jonah


> Hi Jonah,
>
> On 10/30/19 3:37 PM, Jonah Br=C3=BCchert wrote:
>> From: Simon Busch <morphis@gravedo.de>
>>
>> Co-authored-by: Martin Jansa <Martin.Jansa@gmail.com>
>> Co-authored-by: Jonah Br=C3=BCchert <jbb.prv@gmx.de>
>> Co-authored-by: Alexander Akulich <akulichalexander@gmail.com>
>> ---
>> =C2=A0 Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 +++-
>> =C2=A0 configure.ac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++=
+++++++---
>> =C2=A0 src/control.cpp=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>> =C2=A0 src/phonesim.cpp=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 src/phonesim.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 src/qsimcommand.cpp |=C2=A0 2 +-
>> =C2=A0 src/qsmsmessage.cpp |=C2=A0 6 +++---
>> =C2=A0 src/server.cpp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 src/server.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
>> =C2=A0 9 files changed, 25 insertions(+), 14 deletions(-)
>>
>
> Sorry for the delay.=C2=A0 Took me a bit to sort out Qt5 on my VM. Anyway,
> the changes look fine to me and things still appear to work.=C2=A0 So I
> went ahead and pushed both of these patches out.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
--===============4134141744375820286==--

