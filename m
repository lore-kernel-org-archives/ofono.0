Content-Type: multipart/mixed; boundary="===============1168630245103854965=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: Re: [PATCH phonesim v2 1/8] Port to qt5
Date: Tue, 29 Oct 2019 17:58:55 +0100
Message-ID: <573bce36-4371-fdfc-b934-09df46c9e4a6@gmx.de>
In-Reply-To: <2cc8ae14-7914-cffc-ff8a-9826cef7c123@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1168630245103854965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

first of all, thanks for the review!

The current structure of the commits is purely for historical reasons,
since this is a collection of patches by different people that are all
required for the Qt5 port. The Signed-off-by exist for the same reason,
because the people who originally did the affected patches used them.

If you want I can squash them together and group the changes into a
commit by content, not by author.

Am 29.10.19 um 17:06 schrieb Denis Kenzior:
> Hi Jonah,
>
> On 10/27/19 11:30 AM, Jonah Br=C3=BCchert wrote:
>> From: Simon Busch <morphis@gravedo.de>
>>
>> Signed-off-by: Simon Busch <morphis@gravedo.de>
>> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
>
> We don't use Signed-off-by, so please drop this in the future.
>
>> ---
>> =C2=A0 Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 configure.ac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>> =C2=A0 src/control.cpp=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0 src/qsimcommand.cpp | 2 +-
>> =C2=A0 src/qsmsmessage.cpp | 2 +-
>> =C2=A0 5 files changed, 8 insertions(+), 8 deletions(-)
>>
>
> In general we prefer the commits to be separated out between build
> changes and actual code changes.
>
>> diff --git a/Makefile.am b/Makefile.am
>> index 2a6fccf..8c99b04 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -46,7 +46,7 @@ nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \
>>
>> =C2=A0 src_phonesim_LDADD =3D $(QT_LIBS)
>>
>> -AM_CXXFLAGS =3D -Wall $(QT_CFLAGS)
>> +AM_CXXFLAGS =3D -Wall $(QT_CFLAGS) -fPIC -fPIE
>
> You set -fPIE here but remove it in patch 6.=C2=A0 Do you want to squash
> these two together?
>
>>
>> =C2=A0 AM_CPPFLAGS =3D -I$(top_srcdir)/src -I$(top_builddir)/src
>>
>
> Regards,
> -Denis
--===============1168630245103854965==--

