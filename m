Content-Type: multipart/mixed; boundary="===============1350180863548774337=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 4/6] cdma-connman: Add public api to notify connection
 is lost
Date: Wed, 02 Nov 2011 10:33:07 -0500
Message-ID: <4EB162B3.9020307@gmail.com>
In-Reply-To: <1320230281-20743-5-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1350180863548774337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 11/02/2011 05:37 AM, Guillaume Zajac wrote:
> ---
>  include/cdma-connman.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/include/cdma-connman.h b/include/cdma-connman.h
> index b8efe0b..7a115bf 100644
> --- a/include/cdma-connman.h
> +++ b/include/cdma-connman.h
> @@ -64,6 +64,8 @@ int ofono_cdma_connman_driver_register(
>  void ofono_cdma_connman_driver_unregister(
>  				const struct ofono_cdma_connman_driver *d);
>  =

> +void ofono_cdma_connman_deactivated(struct ofono_cdma_connman *cm);
> +
>  struct ofono_cdma_connman *ofono_cdma_connman_create(
>  						struct ofono_modem *modem,
>  						unsigned int vendor,

Patch has been applied, thanks.

Regards,
-Denis

--===============1350180863548774337==--

