Content-Type: multipart/mixed; boundary="===============4709550160944860077=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/21] bluetooth: Add Btio library for DUN
Date: Thu, 13 Jan 2011 17:31:33 -0600
Message-ID: <4D2F8B55.7050705@gmail.com>
In-Reply-To: <1294852564-1258-3-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4709550160944860077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 01/12/2011 11:15 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> From: Zhenhua Zhang <zhenhua.zhang@intel.com>
> =

> Btio library is the low level socket API for BT RFCOMM connection. We
> share the same library among BlueZ, Obex and oFono. So make sure you
> synchronize to other two projects when you make changes to btio.[ch].
> ---
>  Makefile.am  |    8 +-
>  btio/btio.c  | 1299 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  btio/btio.h  |   97 +++++
>  configure.ac |    5 +
>  4 files changed, 1407 insertions(+), 2 deletions(-)
>  create mode 100644 btio/btio.c
>  create mode 100644 btio/btio.h
> =


This patch has been applied, thanks.

Regards,
-Denis

--===============4709550160944860077==--

