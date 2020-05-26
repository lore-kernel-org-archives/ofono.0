Content-Type: multipart/mixed; boundary="===============2350897662924876043=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/7] quectel: EC21 needs aux channel to be the first mux
 channel
Date: Tue, 26 May 2020 16:14:45 +0000
Message-ID: <344edfdc-5119-698a-9544-6a49a939ec44@gmail.com>
In-Reply-To: <20200526101625.31871-5-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2350897662924876043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 5/26/20 5:16 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> The Quectel EC21 does only work correctly, if the mux channel used for
> aux is the first mux channel. It does only put it's URC messages in the
> first mux channel, so this has to be the aux channel in our case.
> ---
>   plugins/quectel.c | 51 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 38 insertions(+), 13 deletions(-)
> =

> diff --git a/plugins/quectel.c b/plugins/quectel.c
> index 1d312c45..9ff75516 100644
> --- a/plugins/quectel.c
> +++ b/plugins/quectel.c
> @@ -847,18 +847,38 @@ static void cmux_gatmux(struct ofono_modem *modem)
>   =

>   	g_at_mux_start(data->mux);
>   =

> -	data->modem =3D create_chat(modem, "Modem: ");
> -	if (!data->modem) {
> -		ofono_error("failed to create modem channel");
> -		close_serial(modem);
> -		return;
> -	}
> +	if (data->model =3D=3D QUECTEL_EC21) {
> +		data->aux =3D create_chat(modem, "Aux: ");
>   =

> -	data->aux =3D create_chat(modem, "Aux: ");
> -	if (!data->aux) {
> -		ofono_error("failed to create aux channel");
> -		close_serial(modem);
> -		return;
> +		if (!data->aux) {
> +			ofono_error("failed to create aux channel");
> +			close_serial(modem);
> +			return;
> +		}
> +
> +		data->modem =3D create_chat(modem, "Modem: ");
> +
> +		if (!data->modem) {
> +			ofono_error("failed to create modem channel");
> +			close_serial(modem);
> +			return;
> +		}
> +	} else {
> +		data->modem =3D create_chat(modem, "Modem: ");
> +
> +		if (!data->modem) {
> +			ofono_error("failed to create modem channel");
> +			close_serial(modem);
> +			return;
> +		}
> +
> +		data->aux =3D create_chat(modem, "Aux: ");
> +
> +		if (!data->aux) {
> +			ofono_error("failed to create aux channel");
> +			close_serial(modem);
> +			return;
> +		}
>   	}

Can we be smarter about this and just store the per-model creation =

sequence as an array or something?  Then have a loop that calls =

create_chat from the array info?  The proposed copy-pasting approach is =

not maintainable long term.

>   =

>   	setup_aux(modem);
> @@ -951,8 +971,13 @@ static void cmux_ngsm(struct ofono_modem *modem)
>   	 * the kernel does not yet support mapping the underlying serial device
>   	 * to its virtual gsm ttys, so hard-code gsmtty1 gsmtty2 for now
>   	 */
> -	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
> -	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
> +	if (data->model =3D=3D QUECTEL_EC21) {
> +		ofono_modem_set_string(modem, "Modem", "/dev/gsmtty2");
> +		ofono_modem_set_string(modem, "Aux", "/dev/gsmtty1");
> +	} else {
> +		ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
> +		ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
> +	}

Doesn't this break the logic in mux_ready_cb, particularly the 'check if =

the last virtual gsm tty's are created'

>   =

>   	/* wait for gsmtty devices to appear */
>   	if (!l_timeout_create_ms(100, mux_ready_cb, modem, NULL)) {
> =


Regards,
-Denis
--===============2350897662924876043==--

