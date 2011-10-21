Content-Type: multipart/mixed; boundary="===============7292062398730422769=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 03/15] include: Voice recognition in handsfree public
 api
Date: Thu, 20 Oct 2011 20:27:20 -0500
Message-ID: <4EA0CA78.7040003@gmail.com>
In-Reply-To: <1319128700-15841-4-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7292062398730422769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 10/20/2011 11:38 AM, Mikel Astiz wrote:
> ---
>  include/handsfree.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> =


OK, nitpicking time ;)

> diff --git a/include/handsfree.h b/include/handsfree.h
> index a4aa177..4ffd673 100644
> --- a/include/handsfree.h
> +++ b/include/handsfree.h
> @@ -31,6 +31,8 @@ extern "C" {
>  =

>  struct ofono_handsfree;
>  =

> +typedef void (*ofono_handsfree_cb_t)(const struct ofono_error *error,
> +					void *data);
>  typedef void (*ofono_handsfree_phone_cb_t)(const struct ofono_error *err=
or,
>  					const struct ofono_phone_number *number,
>  					void *data);
> @@ -43,10 +45,15 @@ struct ofono_handsfree_driver {
>  	void (*request_phone_number) (struct ofono_handsfree *hf,
>  					ofono_handsfree_phone_cb_t cb,
>  					void *data);
> +	void (*voice_recognition)(struct ofono_handsfree *cv,

And this should be *hf not *cv.

> +					ofono_bool_t enabled,
> +					ofono_handsfree_cb_t cb, void *data);
>  };
>  =

>  void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
>  						ofono_bool_t enabled);
> +void ofono_handsfree_set_voice_recognition(struct ofono_handsfree *hf,
> +						ofono_bool_t enabled);

Please rename this to ofono_handsfree_voice_recognition_notify.

>  =

>  int ofono_handsfree_driver_register(const struct ofono_handsfree_driver =
*d);
>  void ofono_handsfree_driver_unregister(

Regards,
-Denis

--===============7292062398730422769==--

