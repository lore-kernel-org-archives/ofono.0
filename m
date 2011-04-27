Content-Type: multipart/mixed; boundary="===============6280366977269087460=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 2/4] emulator: add routine to request/release private
 network from ConnMan
Date: Tue, 26 Apr 2011 22:25:45 -0500
Message-ID: <4DB78CB9.1000008@gmail.com>
In-Reply-To: <1303473993-3606-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6280366977269087460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 04/22/2011 07:06 AM, Guillaume Zajac wrote:
> ---
>  include/emulator.h |   10 +++++++
>  src/emulator.c     |   75 ++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 78 insertions(+), 7 deletions(-)
> =

> diff --git a/include/emulator.h b/include/emulator.h
> index 5cd894b..29abf55 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -105,6 +105,16 @@ enum ofono_emulator_request_type ofono_emulator_requ=
est_get_type(
>  void ofono_emulator_set_indicator(struct ofono_emulator *em,
>  					const char *name, int value);
>  =

> +typedef void (*network_request)(struct ofono_error *, int *,
> +				const char **, const char **,
> +				const char **, const char **);
> +typedef void (*network_release)(void);
> +
> +void ofono_emulator_add_network_request_cb(struct ofono_emulator *em,
> +							network_request cb);
> +void ofono_emulator_add_network_release_cb(struct ofono_emulator *em,
> +							network_release cb);
> +

I really don't like this, you're re-inventing the wheel here.  We
already solved this pattern a while ago ;)  I suggest you look at
include/gprs-provision.h and examples/provision.c

>  #ifdef __cplusplus
>  }
>  #endif

Regards,
-Denis

--===============6280366977269087460==--

