Content-Type: multipart/mixed; boundary="===============1382567367324766459=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Handsfree profile plugins update
Date: Mon, 19 Oct 2009 17:12:44 -0500
Message-ID: <200910191712.45209.denkenz@gmail.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089B871C95@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1382567367324766459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Hi,
>
> Attached is update patch for handsfree profile plugin. I move most stuff =
in
> drivers/hfpmodem/hfp.c into plugins/hfp.c and simplify them. GSList *indi=
es
> is replaced as two indexable arrays (cind_names and cind_values), to
> improve efficiency when we need access name and value by index. The whole
> logic is the same comparing with previous patch.
>
> Thanks for Denis and Gustavo for comments. Please review it.

This patch has been applied with some additional fixes by me.  Please let m=
e =

know if I broke something.

Regards,
-Denis

--===============1382567367324766459==--

