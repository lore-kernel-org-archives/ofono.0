Content-Type: multipart/mixed; boundary="===============3748952006058023641=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v3 2/3] emulator: add drivers to request/release private
 network from ConnMan
Date: Wed, 04 May 2011 23:11:13 -0500
Message-ID: <4DC22361.5000906@gmail.com>
In-Reply-To: <1304433883-3806-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3748952006058023641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/03/2011 09:44 AM, Guillaume Zajac wrote:
> ---
>  include/emulator.h |   18 +++++++++++
>  src/emulator.c     |   83 +++++++++++++++++++++++++++++++++++++++-------=
-----
>  2 files changed, 81 insertions(+), 20 deletions(-)

Please remember to separate patches according to directories whenever
possible.  See HACKING for more details.  This should be two patches,
one for include and one for emulator.

> =

> diff --git a/include/emulator.h b/include/emulator.h
> index 5cd894b..a7fc23b 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -105,6 +105,24 @@ enum ofono_emulator_request_type ofono_emulator_requ=
est_get_type(
>  void ofono_emulator_set_indicator(struct ofono_emulator *em,
>  					const char *name, int value);
>  =

> +ofono_bool_t ofono_emulator_setup_ppp(struct ofono_emulator *em, int fd,
> +				const char *server_ip, const char *peer_ip,
> +				const char *primary_dns,
> +				const char *secondary_dns);
> +
> +int ofono_emulator_get_uid(struct ofono_emulator *em);
> +

I'm not particularly happy with this, we should try to de-couple the
private network provider from the emulator.  We might end up with other
consumers later.

> +struct emulator_network_provision_driver {
> +	char *name;
> +	int (*get_settings)(struct ofono_emulator *em);
> +	void (*release)(int uid);
> +};
> +

I'd say you're on the right track here, but modeling this even closer to
gprs-provision might be a good idea.  Except you'll need to use a
callback, so something like:

struct ofono_private_network_settings {
	...
};

typedef (ofono_private_network_cb_t)(...);

struct ofono_private_network_driver {
	char *name;
	int (*request)(ofono_private_network_cb_t cb, void *data);
	void (*release)(int id);
};

> +int ofono_emulator_network_driver_register(
> +			const struct emulator_network_provision_driver *d);
> +void ofono_emulator_network_driver_unregister(
> +			const struct emulator_network_provision_driver *d);
> +

And then add __ofono_private_network_request / release to src/ofono.h
for now.  Similar to how gprs_provision does things.

>  #ifdef __cplusplus
>  }
>  #endif

Regards,
-Denis

--===============3748952006058023641==--

