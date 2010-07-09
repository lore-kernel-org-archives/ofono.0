Content-Type: multipart/mixed; boundary="===============1863316047227909610=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] ppp: Add MAX_IPCP_FAILURE to avoid timeout quickly
Date: Fri, 09 Jul 2010 09:54:02 -0300
Message-ID: <1278680042.10421.100.camel@localhost.localdomain>
In-Reply-To: <1278665631-22082-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1863316047227909610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> We use IPCP NAK response to stall the progress of acquiring the client
> IP address from DHCP server. So we need to increase the max failure of
> NAKs in IPCP handshaking.
> ---
>  gatchat/ppp_cp.c   |    8 ++++++--
>  gatchat/ppp_cp.h   |    2 +-
>  gatchat/ppp_ipcp.c |   10 +++++++++-
>  gatchat/ppp_lcp.c  |    2 +-
>  4 files changed, 17 insertions(+), 5 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============1863316047227909610==--

