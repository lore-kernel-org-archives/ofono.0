Content-Type: multipart/mixed; boundary="===============0140643002291229071=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] emulator: Add API to force indicator event
Date: Tue, 13 Mar 2012 21:45:36 -0500
Message-ID: <4F600650.9010104@gmail.com>
In-Reply-To: <1331306815-13424-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0140643002291229071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/09/2012 09:26 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> For AT+CHLD=3D2, +CIEV unsollicited event for callheld should be sent even
> if it does not change
> ---
>  include/emulator.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/include/emulator.h b/include/emulator.h
> index 5cd894b..e6bfcbd 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -105,6 +105,9 @@ enum ofono_emulator_request_type ofono_emulator_reque=
st_get_type(
>  void ofono_emulator_set_indicator(struct ofono_emulator *em,
>  					const char *name, int value);
>  =

> +void ofono_emulator_indicator_set_forced(struct ofono_emulator *em,
> +					const char *name);
> +

Please name this ofono_emulator_set_indicator_forced for consistency.

>  #ifdef __cplusplus
>  }
>  #endif

Regards,
-Denis

--===============0140643002291229071==--

