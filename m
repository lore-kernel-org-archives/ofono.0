Content-Type: multipart/mixed; boundary="===============3758671660346618362=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 02/12] ofono.h: add cdma-providers
Date: Fri, 09 Dec 2011 05:52:41 -0600
Message-ID: <4EE1F689.2080004@gmail.com>
In-Reply-To: <1323355803-22096-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3758671660346618362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 12/08/2011 08:49 AM, Philippe Nunes wrote:
> ---
>  src/ofono.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/src/ofono.h b/src/ofono.h
> index bfb534d..a26c06d 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -487,6 +487,10 @@ void __ofono_gprs_provision_free_settings(
>  #include <ofono/gnss.h>
>  #include <ofono/cdma-sms.h>
>  #include <ofono/cdma-netreg.h>
> +
> +#include <ofono/cdma-providers.h>
> +ofono_bool_t __ofono_cdma_providers_get_name(const char *sid, char **nam=
e);
> +

Similarly, please name this cdma_provision_get_name..

>  #include <ofono/private-network.h>
>  =

>  void __ofono_private_network_release(int id);

Regards,
-Denis

--===============3758671660346618362==--

