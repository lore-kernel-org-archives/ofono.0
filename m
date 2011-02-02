Content-Type: multipart/mixed; boundary="===============8688945225494632897=="
MIME-Version: 1.0
From: Ramakrishna, AnandX <anandx.ramakrishna@intel.com>
Subject: RE: [PATCH v8] ifx: Adding modem selftest for Infineon modem
Date: Wed, 02 Feb 2011 10:07:47 -0800
Message-ID: <8F72E7245587B740B3CF41CCF57DAF3757A4B9FD11@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1296631794.1520.305.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8688945225494632897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

I am replying to this email behalf of Robertino.

I appreciate if you can review my comments/proposed solution before I submi=
t the next patch.

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Marcel Holtmann
Sent: Tuesday, February 01, 2011 11:30 PM
To: ofono(a)ofono.org
Subject: Re: [PATCH v8] ifx: Adding modem selftest for Infineon modem

Hi Robertino,

> Infineon modem selftest, during ifx_enable().
> Two steps trigger, with timeout. In case one
> fails, modem will not power up.
> =

> ---
>  plugins/ifx.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++-=
-----
>  1 files changed, 51 insertions(+), 7 deletions(-)
> =

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 411c012..0250f64 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -524,21 +524,57 @@ static gboolean mux_timeout_cb(gpointer user_data)
>  	struct ofono_modem *modem =3D user_data;
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
>  =

> -	ofono_error("Timeout with multiplexer setup");
> +	ofono_error("Timeout with modem and multiplexer setup");
>  =

>  	data->mux_init_timeout =3D 0;
>  =

> -	g_at_chat_unref(data->dlcs[AUX_DLC]);
> -	data->dlcs[AUX_DLC] =3D NULL;
> +	if(data->dlcs[AUX_DLC]) {
> +		g_at_chat_unref(data->dlcs[AUX_DLC]);
> +		data->dlcs[AUX_DLC] =3D NULL;
> +	}
>  =

> -	g_io_channel_unref(data->device);
> -	data->device =3D NULL;
> +	if(data->device) {
> +		g_io_channel_unref(data->device);
> +		data->device =3D NULL;
> +	}

what are these suppose to be doing? This is in the timeout handler and
the timeout will only ever be triggered if data->dlcs[AUX_DLC] is
actually valid. If it gets triggered otherwise then you forgot to
disable the timer. So these should not be needed.

Proposed solution in the selftest callback:

static void rtc_gti_selftest_cb(gboolean ok, GAtResult *result,
                     gpointer user_data)
{
       struct ofono_modem *modem =3D user_data;
       struct ifx_data *data =3D ofono_modem_get_data(modem);

       if (ok) =

              return;

       ofono_error("at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");

       g_at_chat_cancel_all(data->dlcs[AUX_DLC]);

       if (data->mux_init_timeout > 0) {
              g_source_remove(data->mux_init_timeout);
              data->mux_init_timeout =3D 0;
       }

       if(data->dlcs[AUX_DLC]) {
              g_at_chat_unref(data->dlcs[AUX_DLC]);
              data->dlcs[AUX_DLC] =3D NULL;
       }

       if(data->device) {
              g_io_channel_unref(data->device);
              data->device =3D NULL;
       }

       ofono_modem_set_powered(modem, FALSE);
}

However, please follow our coding style. It is ... if<space>( ...

Will take care

>  	ofono_modem_set_powered(modem, FALSE);
>  =

>  	return FALSE;
>  }
>  =

> +static void dev_ver_selftest_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +
> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (ok)
> +		return;
> +
> +	ofono_error("ERROR:IFX Selftest at(a)vers:device_version_id()"
> +			"-FAILED");
> +	g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
> +		shutdown_device(data);

You do need to watch out for such really simple issues with the coding
style. Please get them fixed before submitting a patch.

Will take care.

Now to the fact of using shutdown_device() here. That is not really a
good idea. That function can only be used after you have the MUX up and
running since it takes care of taking down the MUX or restoring the line
discipline. However you have not done that yet.

Will not use shutdown_device(), will use proposed solution as mentioned abo=
ve.


> +}
> +
> +static void rtc_gti_selftest_cb(gboolean ok, GAtResult *result,
> +			gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (ok)
> +		return;
> +
> +	ofono_error("ERROR:IFX Selftest"
> +		"at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");

And I would prefer if you just leave the "ERROR:IFX Selftest" part out
here. It is clear that it is an error since ofono_error() says so and
also tells syslog about it.

Will code as  ofono_error("at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");

> +
> +	g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
> +	shutdown_device(data);
> +}
> +
>  static int ifx_enable(struct ofono_modem *modem)
>  {
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
> @@ -592,13 +628,21 @@ static int ifx_enable(struct ofono_modem *modem)
>  	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
>  					NULL, NULL, NULL);
>  =

> +	/* Execute Modem Self tests */
> +	g_at_chat_send(chat, "at(a)rtc:rtc_gti_test_verify_32khz()",
> +		NULL, rtc_gti_selftest_cb, modem, NULL);
> +
> +	g_at_chat_send(chat, "at(a)vers:device_version_id()",
> +		NULL, dev_ver_selftest_cb, modem, NULL);
> +
> +	/* Enable  MUX Channels */
>  	data->frame_size =3D 1509;
>  =

>  	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
>  					mux_setup_cb, modem, NULL);
>  =

> -	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
> -								modem);
> +	data->mux_init_timeout =3D g_timeout_add_seconds(
> +		10, mux_timeout_cb, modem);

Please keep the original style with 10, mux_timeout_cb in the original
line.

Do you mean?
      data->mux_init_timeout =3D g_timeout_add_seconds(10, mux_timeout_cb,
      					              modem);

And you might wanna still add the comment about expected execution time
of the selftest commands.

 Will add comments as
"total self test  execution takes less than 2 secs, used 10 secs  to cover =
both selftest and  mux setup time"

Regards

Marcel

Regards,
Anand


_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============8688945225494632897==--

