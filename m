Content-Type: multipart/mixed; boundary="===============2983044438371554865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH ppp] ppp: Apply configuration options from a DCE request
 if ACK it
Date: Mon, 04 Jan 2021 11:20:11 -0600
Message-ID: <9030bebb-1d58-8e5b-55fc-d357ebd4ebc7@gmail.com>
In-Reply-To: <20210101210412.23976-1-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2983044438371554865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 1/1/21 3:04 PM, s.e.golubtsov(a)gmail.com wrote:
> From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
> =

> Apply configuration options if the DCE sends a PPP LCP configure request
> and the DTE is going to ACK the request. Otherwise some options such as
> the ACCM may not correspond to the configuration negotiated with the
> DCE.
> ---
>   gatchat/ppp_cp.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> =

> diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
> index f3f2cc4f..371055e4 100644
> --- a/gatchat/ppp_cp.c
> +++ b/gatchat/ppp_cp.c
> @@ -660,9 +660,12 @@ static void pppcp_generate_event(struct pppcp_data *=
data,
>   	if (actions & SCR)
>   		pppcp_send_configure_request(data);
>   =

> -	if (actions & SCA)
> +	if (actions & SCA) {
> +		/* Apply local options */
> +		if (data->driver->rca)
> +			data->driver->rca(data, packet);

So this is incorrect.  You're applying options of the wrong 'side'.  See my =

reply in the other thread for  a more detailed explanation.

>   		pppcp_send_configure_ack(data, packet);
> -	else if (actions & SCN)
> +	} else if (actions & SCN)
>   		pppcp_send_configure_nak(data, packet);
>   =

>   	if (actions & STR)
> =


Regards,
-Denis
--===============2983044438371554865==--

