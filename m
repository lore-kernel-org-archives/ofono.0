Content-Type: multipart/mixed; boundary="===============7234309579724398473=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] gprs: Add list_active_contexts
Date: Mon, 12 Aug 2019 15:34:48 -0500
Message-ID: <846e4b06-d0cb-78a2-33a8-2de1d2fd2f3c@gmail.com>
In-Reply-To: <20190812201826.28535-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7234309579724398473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/12/19 3:18 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> This is useful for instance during startup where early
> activated contexts can be listed at a suitable point in time.
> ---
>   include/gprs.h | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/include/gprs.h b/include/gprs.h
> index 988d6102..c276517f 100644
> --- a/include/gprs.h
> +++ b/include/gprs.h
> @@ -45,6 +45,8 @@ struct ofono_gprs_driver {
>   				ofono_gprs_cb_t cb, void *data);
>   	void (*attached_status)(struct ofono_gprs *gprs,
>   					ofono_gprs_status_cb_t cb, void *data);
> +	void (*list_active_contexts)(struct ofono_gprs *gprs,
> +					ofono_gprs_status_cb_t cb, void *data);

Using ofono_gprs_status_cb_t is a bit confusing.  Do you really need the =

number of contexts?  The core can easily compute this anyway if it cares.

Otherwise just use ofono_gprs_cb_t.

>   };
>   =

>   enum gprs_suspend_cause {
> =


Regards,
-Denis

--===============7234309579724398473==--

