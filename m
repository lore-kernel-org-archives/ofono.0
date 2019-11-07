Content-Type: multipart/mixed; boundary="===============8304648549879283088=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH phonesim v3 1/2] Port to qt5
Date: Wed, 06 Nov 2019 18:10:50 -0600
Message-ID: <2f8a4999-021a-1f80-0023-0994f24ff73e@gmail.com>
In-Reply-To: <20191030203720.10302-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8304648549879283088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonah,

On 10/30/19 3:37 PM, Jonah Br=C3=BCchert wrote:
> From: Simon Busch <morphis@gravedo.de>
> =

> Co-authored-by: Martin Jansa <Martin.Jansa@gmail.com>
> Co-authored-by: Jonah Br=C3=BCchert <jbb.prv@gmx.de>
> Co-authored-by: Alexander Akulich <akulichalexander@gmail.com>
> ---
>   Makefile.am         |  4 +++-
>   configure.ac        | 15 ++++++++++++---
>   src/control.cpp     |  4 ++--
>   src/phonesim.cpp    |  2 +-
>   src/phonesim.h      |  2 +-
>   src/qsimcommand.cpp |  2 +-
>   src/qsmsmessage.cpp |  6 +++---
>   src/server.cpp      |  2 +-
>   src/server.h        |  2 +-
>   9 files changed, 25 insertions(+), 14 deletions(-)
> =


Sorry for the delay.  Took me a bit to sort out Qt5 on my VM.  Anyway, =

the changes look fine to me and things still appear to work.  So I went =

ahead and pushed both of these patches out.

Regards,
-Denis
--===============8304648549879283088==--

