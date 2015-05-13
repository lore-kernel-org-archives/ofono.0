Content-Type: multipart/mixed; boundary="===============5888086505392677457=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: [PATCH 1/4] tc65: Replace tc65 plugin with cinterion plugin
Date: Wed, 13 May 2015 18:11:32 +0200
Message-ID: <555377B4.1020400@dynamicdevices.co.uk>
In-Reply-To: <20150513151821.GC28082@rincewind.trouble.is>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5888086505392677457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 13/05/2015 17:18, Philip Paeps wrote:
> On 2015-05-12 18:22:59 (+0100), Alex J Lennon <ajlennon@dynamicdevices.=
co.uk> wrote:
>> [...]
> Just paging through this driver this afternoon.  Sorry for not reviewing
> the earlier patches.  This caught my eye:
>
>> +static void cinterion_set_online(struct ofono_modem *modem, ofono_bool_=
t online,
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
> Doesn't this expand into a use after free bug if g_at_chat_send() fails?
>

Yes I see what you mean. I also see other plugins (e.g. ublox) reverse
the order of the free and callback.

Have provided a patch to bring the cinterion plugin into line.

Regards,

Alex


--===============5888086505392677457==--

