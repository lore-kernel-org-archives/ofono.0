Content-Type: multipart/mixed; boundary="===============1049513515096002636=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/5] smsutil: Status report assembly
Date: Mon, 21 Jun 2010 16:09:21 -0500
Message-ID: <201006211609.21953.denkenz@gmail.com>
In-Reply-To: <1276780498-7573-2-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1049513515096002636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  src/smsutil.c |  183
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ =

src/smsutil.h | =

>   31 ++++++++++
>  2 files changed, 214 insertions(+), 0 deletions(-)
> =


I pushed patches 1, 3 and 4 in this series upstream and refactored them.  =

Mostly just the code-flow was tweaked and made easier to follow.

I'm happy to report status reports are now working for me on T-Mobile USA & =

mbm.

Regards,
-Denis=20

--===============1049513515096002636==--

