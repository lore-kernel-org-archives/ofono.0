Content-Type: multipart/mixed; boundary="===============6892315925519222721=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Implement HandsfreeGateway Interface
Date: Thu, 04 Feb 2010 11:02:04 -0800
Message-ID: <20100204190204.GA16538@jh-x301>
In-Reply-To: <1265309291-5940-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6892315925519222721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Thu, Feb 04, 2010, Gustavo F. Padovan wrote:
> Create a interface where a Handsfree agent can register and use BlueZ to
> handle the rfcomm and sco links.
> =

> Many thanks to Zhenhua Zhang <zhenhua.zhang@intel.com> for his
> prototype on this code.
> ---
>  audio/device.c  |    3 +
>  audio/gateway.c |  447 +++++++++++++++++++++++++++++++++++++++++--------=
------
>  audio/gateway.h |   14 +-
>  audio/manager.c |   19 +--
>  audio/unix.c    |   13 +-
>  doc/hfp-api.txt |   82 ++++++++++
>  6 files changed, 445 insertions(+), 133 deletions(-)
>  create mode 100644 doc/hfp-api.txt

I didn't find any more obvious issues with this last version so the two
patches are now finally pushed upstream. Thanks.

Johan

--===============6892315925519222721==--

