Content-Type: multipart/mixed; boundary="===============4272221351018796350=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] emulator: add API to set network mode and name
Date: Thu, 17 Mar 2011 16:15:35 -0500
Message-ID: <4D8279F7.40302@gmail.com>
In-Reply-To: <1300380656-8757-4-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4272221351018796350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/17/2011 11:50 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  include/emulator.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/include/emulator.h b/include/emulator.h
> index 701decd..509ec71 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -101,6 +101,11 @@ enum ofono_emulator_request_type ofono_emulator_requ=
est_get_type(
>  void ofono_emulator_set_indicator(struct ofono_emulator *em,
>  					const char *name, int value);
>  =

> +void ofono_emulator_set_network_name(struct ofono_emulator *em,
> +					const char *name);
> +
> +void ofono_emulator_set_network_mode(struct ofono_emulator *em, int mode=
);
> +

I'd really rather do this inside netreg.c itself.

>  #ifdef __cplusplus
>  }
>  #endif

Regards,
-Denis

--===============4272221351018796350==--

