Content-Type: multipart/mixed; boundary="===============4332011471676941724=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 08/20] include: add set preferred ue mode api
Date: Mon, 11 Apr 2011 14:34:52 -0500
Message-ID: <4DA357DC.80309@gmail.com>
In-Reply-To: <1302517218-2147-9-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4332011471676941724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

On 04/11/2011 05:20 AM, Vijay Nayani wrote:
> ---
>  include/modem.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/include/modem.h b/include/modem.h
> index 5a34370..e416f50 100644
> --- a/include/modem.h
> +++ b/include/modem.h
> @@ -51,6 +51,8 @@ void ofono_modem_reset(struct ofono_modem *modem);
>  void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t pow=
ered);
>  ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
>  =

> +void ofono_modem_set_preferred_ue_mode(struct ofono_modem *modem, int mo=
de);
> +

Are you assuming that the UE mode cannot be changed? If so, doesn't this
map to +CEMODE AT command? Doesn't it allow a set operation to change
the UE mode?

>  ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
>  =

>  ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem);

Regards,
-Denis

--===============4332011471676941724==--

