Content-Type: multipart/mixed; boundary="===============5865974996511932840=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [V3 PATCH 1/3] PPP: Fix transmit ACCM and receive ACCM setting
 issue
Date: Mon, 14 Feb 2011 14:25:47 -0600
Message-ID: <4D598FCB.1050500@gmail.com>
In-Reply-To: <1297503675-32491-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5865974996511932840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 02/12/2011 03:41 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> Tramsmit ACCM and receive ACCM is mixed up.
> According to RFC1662 Section 7.1, ACCM Configuration Option is
> used to inform the peer which control characters MUST remain
> mapped when the peer sends them.
> ---
>  gatchat/ppp_lcp.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============5865974996511932840==--

