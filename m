Content-Type: multipart/mixed; boundary="===============7271844636514103992=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v6 2/5] private-network: add header into include and
 Makefile.am
Date: Wed, 25 May 2011 05:38:08 -0500
Message-ID: <4DDCDC10.20801@gmail.com>
In-Reply-To: <1305799112-14289-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7271844636514103992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/19/2011 04:58 AM, Guillaume Zajac wrote:
> ---
>  Makefile.am               |    4 +-
>  include/private-network.h |   56 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 58 insertions(+), 2 deletions(-)
>  create mode 100644 include/private-network.h

I applied this patch, however I did fix up a few things afterwards:

> +typedef void (ofono_private_network_cb_t)(

Please make sure that this is a pointer, e.g. typedef void (*foo)(...);

> +		void *data,
> +		const struct ofono_private_network_settings *settings);

It is customary to have the userdata pointer as the last argument

Regards,
-Denis

--===============7271844636514103992==--

