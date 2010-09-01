Content-Type: multipart/mixed; boundary="===============1783306986676476967=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/11] Driver API changed to accept DCS and any format
 string
Date: Wed, 01 Sep 2010 10:37:44 -0500
Message-ID: <4C7E7348.9070202@gmail.com>
In-Reply-To: <1283338836-13572-9-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1783306986676476967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/01/2010 06:00 AM, Jeevaka Badrappan wrote:
> ---
>  include/ussd.h |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> =

> diff --git a/include/ussd.h b/include/ussd.h
> index 96e04cb..e3b43f7 100644
> --- a/include/ussd.h
> +++ b/include/ussd.h
> @@ -45,13 +45,15 @@ struct ofono_ussd_driver {
>  	const char *name;
>  	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
>  	void (*remove)(struct ofono_ussd *ussd);
> -	void (*request)(struct ofono_ussd *ussd, const char *str,
> -				ofono_ussd_cb_t, void *data);
> +	void (*request)(struct ofono_ussd *ussd, int dcs,
> +                    const unsigned char *str, int str_len,
> +                    ofono_ussd_cb_t, void *data);
>  	void (*cancel)(struct ofono_ussd *ussd,
>  				ofono_ussd_cb_t cb, void *data);
>  };
>  =

> -void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *=
str);
> +void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
> +                       const unsigned char *str, int str_len);
>  =

>  int ofono_ussd_driver_register(const struct ofono_ussd_driver *d);
>  void ofono_ussd_driver_unregister(const struct ofono_ussd_driver *d);

This patch modifies the driver API.  All driver changes resulting from
this patch should follow after this patch.  I'd move this patch to slot
#2 and patch #2 and #10 should come right after.

Regards,
-Denis

--===============1783306986676476967==--

