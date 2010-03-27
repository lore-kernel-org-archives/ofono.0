Content-Type: multipart/mixed; boundary="===============0149850784839951973=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] ppp authentication bug fixes (resend)
Date: Fri, 26 Mar 2010 23:02:22 -0700
Message-ID: <1269669742.11714.193.camel@localhost.localdomain>
In-Reply-To: <1269664610-31900-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0149850784839951973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Here are a couple bug fixes for the PPP authentication.  First patch
> fixes the seg fault when the secret is empty, as reported by marcel.
> Second, if we do fail to authenticate, we need to change ppp phases
> to terminate the link.
> =

> Kristen Carlson Accardi (2):
>   ppp: allow empty secret for chap challenge
>   ppp: send PPP_FAIL when authentication fails
> =

>  gatchat/ppp_auth.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

this is funny. Even now patch 1/2 is missing on my side. However it
seems that Denis can see it, so he took care of it.

Regards

Marcel



--===============0149850784839951973==--

