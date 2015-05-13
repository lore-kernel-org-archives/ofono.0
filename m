Content-Type: multipart/mixed; boundary="===============2617735441424231538=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] tc65: Replace tc65 plugin with cinterion plugin
Date: Wed, 13 May 2015 15:58:32 -0500
Message-ID: <5553BAF8.7090109@gmail.com>
In-Reply-To: <20150513151821.GC28082@rincewind.trouble.is>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2617735441424231538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

 >> +static void cinterion_set_online(struct ofono_modem *modem, =

ofono_bool_t online,
>> +			ofono_modem_online_cb_t cb, void *user_data)
>> +{
>> +	GAtChat *chat =3D ofono_modem_get_data(modem);
>> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
>> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D7";
>> +
>> +	DBG("modem %p %s", modem, online ? "online" : "offline");
>> +
>> +	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
>> +		return;
>> +
>> +	g_free(cbd);
>> +
>> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
>> +}
>
> Doesn't this expand into a use after free bug if g_at_chat_send() fails?
>

Yes it does!  I fixed a few more occurrences of this bug.  Thanks for =

pointing it out.

Regards,
-Denis

--===============2617735441424231538==--

