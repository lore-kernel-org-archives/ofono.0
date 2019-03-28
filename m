Content-Type: multipart/mixed; boundary="===============3378550152836913877=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] sim: Added set function for CardSlotCount and
 ActiveCardSlot
Date: Wed, 27 Mar 2019 21:20:56 -0500
Message-ID: <97703cc4-d2fe-d3ad-cd3c-a60155deef9c@gmail.com>
In-Reply-To: <1553688589-23308-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3378550152836913877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 03/27/2019 07:09 AM, Antara Borwankar wrote:
> Adding set function definition for CardSlotCount and ActiveCardSlot
> properties.
> ---
>   include/sim.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> =

> diff --git a/include/sim.h b/include/sim.h
> index fad4c0d..be5d82f 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -132,6 +132,9 @@ typedef void (*ofono_sim_close_channel_cb_t)(const st=
ruct ofono_error *error,
>   typedef void (*ofono_sim_logical_access_cb_t)(const struct ofono_error =
*error,
>   		const unsigned char *resp, unsigned int len, void *data);
>   =

> +typedef void (*ofono_sim_active_slot_change_cb_t)(const struct ofono_err=
or *error,
> +					void *data);
> +

ofono_sim_set_active_card_slot_cb_t

>   struct ofono_sim_driver {
>   	const char *name;
>   	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
> @@ -205,6 +208,8 @@ struct ofono_sim_driver {
>   	void (*logical_access)(struct ofono_sim *sim, int session_id,
>   			const unsigned char *pdu, unsigned int len,
>   			ofono_sim_logical_access_cb_t cb, void *data);
> +	void (*set_active_sim)(struct ofono_sim *sim, unsigned int index,

Lets call this set_active_card_slot to be consistent with the D-Bus API

> +			ofono_sim_active_slot_change_cb_t cb, void *data);
>   };
>   =

>   int ofono_sim_driver_register(const struct ofono_sim_driver *d);
> @@ -219,6 +224,9 @@ void ofono_sim_remove(struct ofono_sim *sim);
>   =

>   void ofono_sim_set_data(struct ofono_sim *sim, void *data);
>   void *ofono_sim_get_data(struct ofono_sim *sim);
> +void ofono_sim_set_card_slot_num(struct ofono_sim *sim, unsigned int val=
);

ofono_sim_set_card_slot_count

> +void ofono_sim_set_active_card_slot_num(struct ofono_sim *sim,
> +					unsigned int val);

ofono_sim_set_active_card_slot

>   =

>   const char *ofono_sim_get_imsi(struct ofono_sim *sim);
>   const char *ofono_sim_get_mcc(struct ofono_sim *sim);
> =


Regards,
-Denis

--===============3378550152836913877==--

