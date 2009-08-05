Content-Type: multipart/mixed; boundary="===============3805710093761601623=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Implement writing EF-MBDN on SetProperty or Enhanced
 Voicemail IE.
Date: Wed, 05 Aug 2009 13:59:00 -0500
Message-ID: <200908051359.00649.denkenz@gmail.com>
In-Reply-To: <1249456120-10263-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3805710093761601623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> I've not tested this on a real SIM yet.
> ---
>  src/message-waiting.c |   51
> ++++++++++++++++++++++++++++++++++++------------ src/simutil.c         |  =

> 27 +++++++++++++++++++++++++
>  src/simutil.h         |    2 +
>  src/smsutil.c         |   47 +++++++++++++++++++++++++++++---------------
>  src/smsutil.h         |    8 +++++++
>  5 files changed, 106 insertions(+), 29 deletions(-)

I've broken up your patch into several smaller patches, but should be =

otherwise unchanged.  Should now be upstream.

Thanks,
-Denis

--===============3805710093761601623==--

