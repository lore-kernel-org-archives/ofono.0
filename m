Content-Type: multipart/mixed; boundary="===============6984234346657426471=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/8] Add an atom for STK,
 move envelope command to stk driver.
Date: Thu, 15 Apr 2010 16:18:55 -0500
Message-ID: <201004151618.56103.denkenz@gmail.com>
In-Reply-To: <1270795741-7156-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6984234346657426471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
>  Makefile.am           |    4 +-
>  drivers/atmodem/sim.c |   77 -------------------
>  include/sim.h         |    3 -
>  include/stk.h         |   71 +++++++++++++++++
>  src/cbs.c             |   10 ++-
>  src/modem.c           |    1 +
>  src/ofono.h           |    4 +-
>  src/sim.c             |   37 ---------
>  src/stk.c             |  201
>  +++++++++++++++++++++++++++++++++++++++++++++++++ 9 files changed, 287
>  insertions(+), 121 deletions(-)
>  create mode 100644 include/stk.h
>  create mode 100644 src/stk.c
> =


This patch has been applied, thanks.

Regards,
-Denis

--===============6984234346657426471==--

