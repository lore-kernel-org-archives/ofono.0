Content-Type: multipart/mixed; boundary="===============5705578609289797894=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: fix event generation on close
Date: Fri, 02 Apr 2010 13:07:54 -0500
Message-ID: <201004021307.54553.denkenz@gmail.com>
In-Reply-To: <1270229298-5936-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5705578609289797894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Prevents too early transition to PPP_DEAD
> ---
>  gatchat/gatppp.c  |    4 +---
>  gatchat/ppp.h     |    1 -
>  gatchat/ppp_lcp.c |   17 ++++-------------
>  3 files changed, 5 insertions(+), 17 deletions(-)

This patch has been applied, thanks.

Regards,
-Denis

--===============5705578609289797894==--

