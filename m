Content-Type: multipart/mixed; boundary="===============7584861919233853324=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] ppp: using RX ACCM = 0 by default
Date: Thu, 07 Jan 2021 23:20:25 -0600
Message-ID: <2fdea865-ff1d-98a8-2a9b-f70bea28d017@gmail.com>
In-Reply-To: <20210107204017.3382-2-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7584861919233853324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 1/7/21 2:40 PM, s.e.golubtsov(a)gmail.com wrote:
> From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
> =

> Some modems such as Quectel EC200T do not honor the default value for
> the Async-Control-Character-Map (ACCM) configuration option defined in
> RFC 1548 6.2 as 0xffffffff. This patch suggests to use RX ACCM =3D 0 for
> Ofono by default as pppd does for instance. This will reduce PPP data
> overhead as well.
> ---
>   gatchat/gatppp.c  |  5 +++++
>   gatchat/gatppp.h  |  1 +
>   gatchat/ppp.h     |  1 +
>   gatchat/ppp_lcp.c | 15 ++++++++++++++-
>   4 files changed, 21 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7584861919233853324==--

