Content-Type: multipart/mixed; boundary="===============6929582261447221454=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/11] __ofono_call_barring_is_busy internal api for
 STK-Send USSD
Date: Wed, 01 Sep 2010 10:22:25 -0500
Message-ID: <4C7E6FB1.1000603@gmail.com>
In-Reply-To: <1283338836-13572-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6929582261447221454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/01/2010 06:00 AM, Jeevaka Badrappan wrote:
> ---
>  src/call-barring.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/src/call-barring.c b/src/call-barring.c
> index 7607f3f..b58499a 100644
> --- a/src/call-barring.c
> +++ b/src/call-barring.c
> @@ -580,6 +580,11 @@ static void cb_unregister_ss_controls(struct ofono_c=
all_barring *cb)
>  	__ofono_ussd_passwd_unregister(cb->ussd, "353");
>  }
>  =

> +gboolean __ofono_call_barring_is_busy( struct ofono_call_barring *cb)
> +{
> +	return cb->pending ? TRUE: FALSE;
> +}
> +
>  static inline void cb_append_property(struct ofono_call_barring *cb,
>  					DBusMessageIter *dict, int start,
>  					int end, int cls, const char *property)

The rule of thumb for patch submissions is to:
- Make sure all related chunks are together in one patch
- Chunks are only related to the particular change being described
- Unless impossible / extremely hard, the code should compile after each
individual patch.

In this case, please merge the chunks from patch #8 related to call
barring into this patch.

Regards,
-Denis

--===============6929582261447221454==--

