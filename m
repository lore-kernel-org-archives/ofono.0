Content-Type: multipart/mixed; boundary="===============4846546080975888297=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v3, Part1,
 4/5] cdmamodem: Add CDMA voicecall driver support for MO Call
Date: Thu, 23 Dec 2010 15:36:55 -0800
Message-ID: <4D13DD17.8050302@nokia.com>
In-Reply-To: <4D12A562.5020603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4846546080975888297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

Thank you for reviewing these.

On 12/22/2010 05:26 PM, ext Denis Kenzior wrote:
> Hi Dara,
>
> <snip>
>
>> +
>> +struct voicecall_driver {
>> +	struct ofono_cdma_voicecall *vc;
>> +	unsigned int local_release;
>
> What is the use of these two variables?
>
>> +	GAtChat *chat;
>> +	unsigned int vendor;
>> +};
>> +
>> +struct change_state_req {
>> +	struct ofono_cdma_voicecall *vc;
>> +	ofono_cdma_voicecall_cb_t cb;
>> +	void *data;
>> +};
>
> is cb_data not good enough for some reason? :)
>
>> +
>> +static void at_dial_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>> +{
>> +	struct cb_data *cbd =3D user_data;
>> +	ofono_cdma_voicecall_cb_t cb =3D cbd->cb;
>> +	struct ofono_error error;
>> +
>> +	decode_at_error(&error, g_at_result_final_response(result));
>> +
>> +	if (!ok)
>> +		goto out;
>
> This if statement serves no purpose
>
>> +
>> +out:
>
> And neither does the label
>
>> +	cb(&error, cbd->data);
>> +}
>> +
>> +static void at_dial(struct ofono_cdma_voicecall *vc,
>> +				const struct ofono_cdma_phone_number *ph,
>> +				ofono_cdma_voicecall_cb_t cb, void *data)
>> +{
>> +	struct voicecall_driver *vd =3D ofono_cdma_voicecall_get_data(vc);
>> +	struct cb_data *cbd =3D cb_data_new(cb, data);
>> +	char buf[256];
>> +
>> +	if (cbd =3D=3D NULL)
>> +		goto error;
>> +
>> +	cbd->user =3D vc;
>
> Why are you assigning cbd->user and never making use of it?

For all of your above comments, yes they shouldn't be there - I will =

clean these up.
>
>> +
>> +	snprintf(buf, sizeof(buf), "AT+CDV=3D%s", ph->number);
>> +
>> +	if (g_at_chat_send(vd->chat, buf, none_prefix,
>> +				at_dial_cb, cbd, g_free)>  0)
>> +		return;
>> +
>> +error:
>> +	g_free(cbd);
>> +
>> +	CALLBACK_WITH_FAILURE(cb, data);
>> +}
>> +
>> +static void at_template(const char *cmd,
>> +				struct ofono_cdma_voicecall *vc,
>> +				GAtResultFunc result_cb,
>> +				ofono_cdma_voicecall_cb_t cb, void *data)
>> +{
>> +	struct voicecall_driver *vd =3D ofono_cdma_voicecall_get_data(vc);
>> +	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1=
);
>> +
>> +	if (req =3D=3D NULL)
>> +		goto error;
>> +
>> +	req->vc =3D vc;
>> +	req->cb =3D cb;
>> +	req->data =3D data;
>> +
>> +	if (g_at_chat_send(vd->chat, cmd, none_prefix,
>> +				result_cb, req, g_free)>  0)
>> +		return;
>> +
>> +error:
>> +	g_free(req);
>> +
>> +	CALLBACK_WITH_FAILURE(cb, data);
>> +}
>> +
>> +static void at_hangup_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
>> +{
>> +	struct change_state_req *req =3D user_data;
>> +
>> +	if (!ok) {
>> +		ofono_error("hangup failed.");
>> +		return;
>
> Please don't do this.  If the hangup fails you never return from the
> operation and will cause the cdma-voicecall atom to stall forever.
> decoding the error and calling the callback is good enough.

Thanks for spotting this, I will fix it.
>
>> +	}
>> +
>> +	ofono_cdma_voicecall_disconnected(req->vc,
>> +				OFONO_DISCONNECT_REASON_LOCAL_HANGUP, NULL);
>
> Fair enough, but this should really come via a modem unsolicited
> notification.

Agreed, I can either mark it with a TODO to make this clear or remove =

the disconnect reason support altogether.
>
>> +		CALLBACK_WITH_SUCCESS(req->cb, req->data);
>
> This is not necessary if you call the callback up above.  And why the
> different indentation?
>
>> +}
>> +
>> +static void at_hangup(struct ofono_cdma_voicecall *vc,
>> +			ofono_cdma_voicecall_cb_t cb, void *data)
>> +{
>> +	/* Hangup active call */
>> +	at_template("AT+CHV", vc, at_hangup_cb, cb, data);
>> +}
>> +
>> +static int at_voicecall_probe(struct ofono_cdma_voicecall *vc,
>> +		unsigned int vendor, void *data)
>> +{
>> +	GAtChat *chat =3D data;
>> +	struct voicecall_driver *vd;
>> +
>> +	vd =3D g_try_new0(struct voicecall_driver, 1);
>> +	if (vd =3D=3D NULL)
>> +		return -ENOMEM;
>> +
>> +	vd->chat =3D g_at_chat_clone(chat);
>> +	vd->vendor =3D vendor;
>> +
>> +	ofono_cdma_voicecall_set_data(vc, vd);
>> +
>> +	ofono_cdma_voicecall_register(vc);
>> +
>> +	return 0;
>> +}
>> +
>> +static void at_voicecall_remove(struct ofono_cdma_voicecall *vc)
>> +{
>> +	struct voicecall_driver *vd =3D ofono_cdma_voicecall_get_data(vc);
>> +
>> +	ofono_cdma_voicecall_set_data(vc, NULL);
>> +
>> +	g_at_chat_unref(vd->chat);
>> +	g_free(vd);
>> +}
>> +
>> +static struct ofono_cdma_voicecall_driver driver =3D {
>> +	.name			=3D "cdmamodem",
>> +	.probe			=3D at_voicecall_probe,
>> +	.remove			=3D at_voicecall_remove,
>> +	.dial			=3D at_dial,
>> +	.hangup			=3D at_hangup,
>> +};
>> +
>> +void cdma_at_voicecall_init()
>> +{
>> +	ofono_cdma_voicecall_driver_register(&driver);
>> +}
>> +
>> +void cdma_at_voicecall_exit()
>> +{
>> +	ofono_cdma_voicecall_driver_unregister(&driver);
>> +}
>
> Regards,
> -Denis

Thanks
Dara

--===============4846546080975888297==--

