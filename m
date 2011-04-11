Content-Type: multipart/mixed; boundary="===============6137947534584685440=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/8] emulator: add incoming call API
Date: Mon, 11 Apr 2011 10:52:24 -0500
Message-ID: <4DA323B8.9040104@gmail.com>
In-Reply-To: <1302194040-18811-5-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6137947534584685440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/07/2011 11:33 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  include/emulator.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/include/emulator.h b/include/emulator.h
> index 5cd894b..55e3b9c 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -105,6 +105,9 @@ enum ofono_emulator_request_type ofono_emulator_reque=
st_get_type(
>  void ofono_emulator_set_indicator(struct ofono_emulator *em,
>  					const char *name, int value);
>  =

> +void ofono_emulator_incoming_call(struct ofono_emulator *em,
> +					struct ofono_call *call);
> +

I don't like this.  I'd rather we add

struct ofono_call *__ofono_voicecall_find_call_with_status(struct
ofono_voicecall *vc, int status) to ofono.h/voiecall.c

>  #ifdef __cplusplus
>  }
>  #endif

Regards,
-Denis

--===============6137947534584685440==--

