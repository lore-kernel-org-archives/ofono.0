Content-Type: multipart/mixed; boundary="===============1290475537705377303=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] stk: Add parser for send ussd commands
Date: Fri, 18 Jun 2010 14:04:27 -0500
Message-ID: <201006181404.27354.denkenz@gmail.com>
In-Reply-To: <1276770911-8817-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1290475537705377303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> ---
>  src/stkutil.c |   61
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ =

src/stkutil.h | =

>    9 ++++++++
>  2 files changed, 70 insertions(+), 0 deletions(-)

Patches 1, 2 and 5 have been applied.  As discussed previously we're skippi=
ng =

patches 3 and 4 for now.  Please note that I broke Patch 2 into two patches=
 (1 =

for decode_ussd in smsutil.[ch] and one for the unit test), but did not do =
any =

modifications beyond that.

Again, please watch out for this.  If your patch touches something in two o=
r =

more directories of oFono, please send multiple patches.

Regards,
-Denis

--===============1290475537705377303==--

