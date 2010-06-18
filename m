Content-Type: multipart/mixed; boundary="===============5155185390361546437=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Enabling PDP Context support in atmodem.
Date: Fri, 18 Jun 2010 12:57:58 -0500
Message-ID: <201006181257.58444.denkenz@gmail.com>
In-Reply-To: <AANLkTinDk9-gwLP0pC_8Wqud8MXotrAkVxYHBPP7rmys@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5155185390361546437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

> From d30d8658767de97b0ffb45697616604fb1576741 Mon Sep 17 00:00:00 2001
> From: arun <arunlee@gmail.com>
> Date: Thu, 17 Jun 2010 21:42:00 +0300
> Subject: [PATCH] Enabling PDP Context support in atmodem.
> =

> ---
>  plugins/atgen.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =


Your patch looks good, however it seems there's some extra junk appended at =

the end of the patch.  Git is getting confused and cannot apply it.  Please =

rebase and resubmit:

denkenz(a)localhost ~/ofono-master $ git am ~/merge/\[PATCH\]\ Enabling\ PD=
P\ =

Context\ support\ in\ atmodem..mbox =

Applying: Enabling PDP Context support in atmodem.
fatal: patch fragment without header at line 46: @@ -50,6 +50,8 =

@@<br>=EF=BF=BD#include &lt;ofono/voicecall.h&gt;<br>=EF=BF=BD<br>=EF=BF=BD=
#include =

&lt;drivers/atmodem/sim-poll.h&gt;<br>+#include =

&lt;ofono/gprs.h&gt;<br>+#include &lt;ofono/gprs-context.h&gt;<br>=EF=BF=BD=
<br>=EF=BF=BDstatic =

const char *tty_opts[] =3D {<br>
Patch failed at 0001 Enabling PDP Context support in atmodem.
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Thanks,
-Denis

--===============5155185390361546437==--

