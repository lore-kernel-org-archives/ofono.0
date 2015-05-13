Content-Type: multipart/mixed; boundary="===============3356377305747022052=="
MIME-Version: 1.0
From: Philip Paeps <philip@trouble.is>
Subject: Re: [PATCH 1/4] tc65: Replace tc65 plugin with cinterion plugin
Date: Wed, 13 May 2015 17:18:21 +0200
Message-ID: <20150513151821.GC28082@rincewind.trouble.is>
In-Reply-To: <1431451382-7788-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3356377305747022052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 2015-05-12 18:22:59 (+0100), Alex J Lennon <ajlennon@dynamicdevices.co=
.uk> wrote:
> [...]

Just paging through this driver this afternoon.  Sorry for not reviewing
the earlier patches.  This caught my eye:

> +static void cinterion_set_online(struct ofono_modem *modem, ofono_bool_t=
 online,
> +			ofono_modem_online_cb_t cb, void *user_data)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D7";
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
> +		return;
> +
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +}

Doesn't this expand into a use after free bug if g_at_chat_send() fails?

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============3356377305747022052==--

