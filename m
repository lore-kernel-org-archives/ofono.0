Content-Type: multipart/mixed; boundary="===============5031863902243904531=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: use default ACCM when sending LCP codes 1-7
Date: Mon, 26 Apr 2010 15:32:08 -0500
Message-ID: <201004261532.08812.denkenz@gmail.com>
In-Reply-To: <1272307476-22148-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5031863902243904531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> According to the spec, you must transmit all Link Configuration,
> Termination, and Code-Reject packets as if no options had been
> negotiated.  This requires that when encoding we use the
> default ACCM of 0xffffffff when sending these types of packets.
> ---
>  gatchat/gatppp.c |   10 ++++++++++
>  gatchat/ppp_cp.c |    8 ++++++++
>  gatchat/ppp_cp.h |    2 ++
>  3 files changed, 20 insertions(+), 0 deletions(-)
> =


This patch has been applied, thanks.

Regards,
-Denis

--===============5031863902243904531==--

