Content-Type: multipart/mixed; boundary="===============4142422893507435276=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] fix PPP timer issues
Date: Wed, 24 Mar 2010 23:05:31 -0500
Message-ID: <201003242305.31702.denkenz@gmail.com>
In-Reply-To: <1269487588-14046-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4142422893507435276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> These patches fix a few problems with the way timeouts are handled in
> PPP.
> =

> Kristen Carlson Accardi (2):
>   switch to g_timeout_add_seconds()
>   use separate timers for PPP config and terminate
> =

>  gatchat/ppp_cp.c |  103
>  ++++++++++++++++++++++++++++------------------------- gatchat/ppp_cp.h |=
  =

>  15 +++++---
>  2 files changed, 64 insertions(+), 54 deletions(-)
> =


Both patches have been applied, thanks.

Regards,
-Denis

--===============4142422893507435276==--

