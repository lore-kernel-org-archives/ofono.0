Content-Type: multipart/mixed; boundary="===============9059541012197873316=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: Fix leak in pppcp_send_protocol_reject
Date: Mon, 21 Jun 2010 09:22:25 -0500
Message-ID: <201006210922.26088.denkenz@gmail.com>
In-Reply-To: <1277112339-15009-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9059541012197873316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Free the reject pppcp packet after ppp_transmit.
> ---
>  gatchat/ppp_cp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =


Good catch.  Patch has been applied, thanks.

Regards,
-Denis

--===============9059541012197873316==--

