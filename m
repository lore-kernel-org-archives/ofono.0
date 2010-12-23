Content-Type: multipart/mixed; boundary="===============4862531050619153477=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v3, Part2,
 1/3] nokiacdma: Add plugin and CDMA MO Call Support
Date: Thu, 23 Dec 2010 15:41:44 -0800
Message-ID: <4D13DE38.8010501@nokia.com>
In-Reply-To: <4D12B479.4020401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4862531050619153477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 12/22/2010 06:31 PM, ext Denis Kenzior wrote:
> Hi Dara,
>
> <snip>
>
>> +struct nokiacdma_data {
>> +	GAtChat *chat;
>> +	ofono_bool_t online;
>> +	ofono_bool_t registration_status;
>
> What is the purpose of the above two variables?
>
> <snip>
>
>> +static void nokiacdma_disconnect(gpointer user_data)
>> +{
>> +	struct ofono_modem *modem =3D user_data;
>> +	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
>> +
>> +	DBG("%p", modem);
>> +
>> +	g_at_chat_unref(data->chat);
>> +	data->chat =3D NULL;
>> +
>> +	data->chat =3D open_device(modem, "Device", "CDMA Device: ");
>> +	if (data->chat =3D=3D NULL)
>> +		return;
>> +
>> +	g_at_chat_set_disconnect_function(data->chat,
>> +			nokiacdma_disconnect, modem);
>> +}
>
> What are you trying to accomplish in this one?  on the huawei driver
> this is used to re-open the tty because it is HUP-ed when the ppp
> session ends (their way of signaling NO CARRIER).  However, I don't see
> you doing PPP yet, so I'm not so sure of the purpose here?
>
>> +
>> +/* power up hardware */
>> +static int nokiacdma_enable(struct ofono_modem *modem)
>> +{
>> +	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
>> +
>> +	DBG("%p", modem);
>> +
>> +	ofono_modem_set_boolean(modem, "no_sim_required", TRUE);
>> +
>> +	data->chat =3D open_device(modem, "Device", "CDMA Device: ");
>> +	if (data->chat =3D=3D NULL)
>> +		return -EINVAL;
>> +
>> +	g_at_chat_set_disconnect_function(data->chat,
>> +			nokiacdma_disconnect, modem);
>> +
>> +	if (getenv("OFONO_AT_DEBUG"))
>> +		g_at_chat_set_debug(data->chat, nokiacdma_debug,
>> +				"CDMA Generic: ");
>> +
>> +	return 0;
>> +}
>> +
>> +static int nokiacdma_disable(struct ofono_modem *modem)
>> +{
>> +	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
>> +
>> +	DBG("%p", modem);
>> +
>> +	if (data->chat) {
>> +		g_at_chat_cancel_all(data->chat);
>> +		g_at_chat_unregister_all(data->chat);
>> +		g_at_chat_unref(data->chat);
>> +		data->chat =3D NULL;
>> +	}
>> +
>> +	return 0;
>
> So enable and disable just open up the ports?
>
>> +}
>> +
>> +static void nokiacdma_pre_sim(struct ofono_modem *modem)
>> +{
>> +	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
>> +
>> +	ofono_cdma_voicecall_create(modem, 0, "cdmamodem",
>> +				data->chat);
>> +}
>> +
>> +static void nokiacdma_post_sim(struct ofono_modem *modem)
>> +{
>> +}
>> +
>> +static gboolean nokiacdma_set_online_cb(gpointer cb_data)
>> +{
>> +	struct cb_data *cbd =3D cb_data;
>> +	ofono_modem_online_cb_t cb =3D cbd->cb;
>> +
>> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
>> +
>> +	g_free(cbd);
>> +
>> +	/* do not call again */
>> +	return FALSE;
>> +}
>> +
>> +static void nokiacdma_set_online(struct ofono_modem *modem, ofono_bool_=
t online,
>> +				ofono_modem_online_cb_t cb, void *user_data)
>> +{
>> +	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
>> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
>> +
>> +	DBG("modem %p %s", modem, online ? "online" : "offline");
>> +
>> +	if (cbd =3D=3D NULL)
>> +		goto error;
>> +
>> +	data->online =3D online;
>> +
>> +	/* TODO: Fix this when network registration implemented */
>> +	if (online)
>> +		data->registration_status =3D
>> +		    NETWORK_REGISTRATION_STATUS_REGISTERED;
>> +
>> +	nokiacdma_set_online_cb(cbd);
>> +	return;
>> +
>> +error:
>> +	g_free(cbd);
>> +
>> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
>> +}
>
> I'm lost here.  What are you trying to accomplish?
>
> <snip>
>
> Regards,
> -Denis

Apologies for the confusion, all these are relics of integration with =

other experimental work and are not relevant to the MO Call feature =

submission. I'll clean this up and send new versions.

Thank you
Dara

--===============4862531050619153477==--

