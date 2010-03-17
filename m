Content-Type: multipart/mixed; boundary="===============7968583041187110555=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8][RFC] Add functions to notify core of SIM
 insertion/removal or request polling.
Date: Wed, 17 Mar 2010 17:01:39 -0600
Message-ID: <201003171801.40175.denkenz@gmail.com>
In-Reply-To: <1268688044-3568-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7968583041187110555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Implement optional polling.  Polling is mandatory according to the
> specification but on most hardware it will me impractical because
> there will be vendor specific unsolicited notifications that can be
> used instead.  Modem plugins need to handle them.
> ---

So I've been going back and forth on this one and my opinion is we should n=
ot =

do the poll in the core.  The modem has to do it anyway, so let the modem d=
o =

it and tell us when it happens.  Most vendors provide unsolicited notificat=
ions =

for SIM Toolkit events anyway.  Let us treat it the same way as voicecalls.=
  =

The standard does not define any unsolicited responses for call state =

notifications, yet in practice all modem vendors provide this.

Keep this code around and let us re-examine this decision if we ever need t=
o =

implement POLLING ON / POLLING OFF / POLLING INTERVAL commands.  Based on a=
ll =

the vendor specific docs I have these are intercepted by the modem and we n=
ever =

see them anyway.

>  include/sim.h |   21 ++++++-
>  src/sim.c     |  197
>  ++++++++++++++++++++++++++++++++++++++++++++++++++------- 2 files =

changed,
>  195 insertions(+), 23 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 6ff29f7..fdfe2e8 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -106,6 +106,8 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const stru=
ct
>  ofono_error *error, typedef void (*ofono_sim_locked_cb_t)(const struct
>  ofono_error *error, int locked, void *data);
> =

> +typedef void (*ofono_sim_cb_t)(const struct ofono_error *error, void
>  *data); +
>  struct ofono_sim_driver {
>  	const char *name;
>  	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
> @@ -152,6 +154,12 @@ struct ofono_sim_driver {
>  	void (*envelope)(struct ofono_sim *sim, int length,
>  				const guint8 *command,
>  				ofono_sim_read_cb_t cb, void *data);
> +	void (*status)(struct ofono_sim *sim, ofono_sim_cb_t cb, void *data);
> +	void (*fetch)(struct ofono_sim *sim, int length,
> +			ofono_sim_read_cb_t cb, void *data);

So three things here: First the STK details should be moved to a separate a=
tom =

since they are highly vendor specific.

Second, why are we bothering with fetch, can't we simply use =

ofono_sim_proactive_command_notify to send us the apdu directly?

And we should get rid of status if we're not doing polling.

> +	void (*terminal_response)(struct ofono_sim *sim, int length,
> +			const unsigned char *value, ofono_sim_write_cb_t cb,

to be more consistent, value first, then length.

> +			void *data);
>  };

Regards,
-Denis

--===============7968583041187110555==--

