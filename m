Content-Type: multipart/mixed; boundary="===============8174192379036211230=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v4, 3/5] nokiacdma: Add plugin and CDMA MO Call Support
Date: Mon, 10 Jan 2011 15:12:33 -0800
Message-ID: <4D2B9261.8010501@nokia.com>
In-Reply-To: <4D2B8A90.3040309@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8174192379036211230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 01/10/2011 02:39 PM, ext Denis Kenzior wrote:
> Hi Dara,
>
>> +static void nokiacdma_remove(struct ofono_modem *modem)
>> +{
>> +	struct nokiacdma_data *data =3D ofono_modem_get_data(modem);
>> +
>> +	DBG("%p", modem);
>> +
>> +	ofono_modem_set_data(modem, NULL);
>> +
>> +	if (data->chat)
>> +		g_at_chat_unref(data->chat);
>
> Feel free to skip the NULL check, g_at_chat_unref handles this just fine.
>

I'll remove this

>> +
>> +	g_free(data);
>> +}
>> +
>
> <snip>
>
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
>> +static void nokiacdma_set_online(struct ofono_modem *modem,
>> +				ofono_bool_t online,
>> +				ofono_modem_online_cb_t cb, void *user_data)
>> +{
>> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
>> +
>> +	DBG("modem %p %s", modem, online ? "online" : "offline");
>> +
>> +	/* TODO: Add implementation to control modem online status */
>> +	g_idle_add(nokiacdma_set_online_cb, cbd);
>> +}
>> +
>
> I'm really lost in the above two functions.  If you don't have an
> implementation, you can just skip it.  oFono should do the right thing
> and automatically bring devices up into online state if set_online is
> missing.
>

OK - we'll skip it as discussed and I'll include this in the patch rebase.

Thank you
Dara

--===============8174192379036211230==--

