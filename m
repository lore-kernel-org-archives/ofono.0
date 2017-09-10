Content-Type: multipart/mixed; boundary="===============2905215021724504246=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] isimodem: Use correct callback for pin status
Date: Sun, 10 Sep 2017 12:47:16 -0500
Message-ID: <3aff6e05-ef53-a36d-360a-45b06ea94918@gmail.com>
In-Reply-To: <20170910164128.GA3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2905215021724504246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clayton,

On 09/10/2017 11:41 AM, Clayton Craft wrote:
> This fixes the segfault I experienced on enabling the modem by using
> the correct callback for pin status response.
> =

> =

> drivers/isimodem/sim.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
> index 4379a159..cea50972 100644
> --- a/drivers/isimodem/sim.c
> +++ b/drivers/isimodem/sim.c
> @@ -450,7 +450,7 @@ static void check_sec_response(const GIsiMessage =

> *msg, void *opaque,
>                      uint8_t success, uint8_t failure)
> {
>      struct isi_cb_data *cbd =3D opaque;
> -    ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
> +    ofono_query_facility_lock_cb_t cb =3D cbd->cb;
>      struct ofono_sim *sim =3D cbd->user;
>      uint8_t id;
>      uint8_t cause;
> @@ -465,7 +465,7 @@ static void check_sec_response(const GIsiMessage =

> *msg, void *opaque,
>      if (id =3D=3D success) {
>          DBG("%s", sec_message_id_name(id));
>          sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_NONE);
> -        CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +        CALLBACK_WITH_SUCCESS(cb, OFONO_SIM_PASSWORD_NONE, sim);

check_sec_response is used when entering / enabling / disabling a PIN. =

So you might be hacking around your particular issue, but breaking others.

The real fix is to implement a proper callback for isi_query_locked. =

The previously submitted (2010 or so?) driver code might give you hints =

on what the actual callback should look like.

>          return;
>      }
> =


Regards,
-Denis

--===============2905215021724504246==--

