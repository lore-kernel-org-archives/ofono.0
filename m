Content-Type: multipart/mixed; boundary="===============0646124453589959779=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v4 1/3] huawei: detect possible secondary device
Date: Thu, 20 May 2010 13:46:26 +0300
Message-ID: <87aaruonp9.fsf@potku.valot.fi>
In-Reply-To: <201005191934.10749.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0646124453589959779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,

Hi Denis,

>>  struct huawei_data {
>> -	GAtChat *chat;
>> +	GAtChat *chat, *event;
>>  };
>> =

>
> Minor nitpick, but we prefer:
> GAtChat *chat;
> GAtChat *event;
>
> in structures.

Changed.

>> @@ -80,6 +81,11 @@ static void huawei_debug(const char *str, void
>>  *user_data) ofono_info("%s", str);
>>  }
>> =

>> +static void huawei_event_debug(const char *str, void *user_data)
>> +{
>> +	ofono_info("* %s", str);
>> +}
>> +
>
> There is no need for a separate function here.  user_data can be used for =

> this:
>
> const char *prefix =3D user_data;
> ofono_info("%s: %s", prefix, str);

I did it like this:

g_at_chat_set_debug(data->chat, huawei_debug, "");

g_at_chat_set_debug(data->event, huawei_debug, "EventChannel: ");

>> @@ -120,6 +140,20 @@ static int huawei_enable(struct ofono_modem *modem)
>>  	if (getenv("OFONO_AT_DEBUG"))
>>  		g_at_chat_set_debug(data->chat, huawei_debug, NULL);
>> =

>> +	data->event =3D create_port(modem_device);
>> +
>
> Event port using the modem device again?

Good catch. I actually fixed this, but commited to the wrong patch. I
moved that part now from patch 3 to patch 1.

>> +	if (data->event) {
>> +		g_at_chat_cancel_all(data->event);
>> +		g_at_chat_unregister_all(data->event);
>> +	}
>> +
>
> You might want to unref event here instead of cfun_disable

Done.

-- =

Kalle Valo

--===============0646124453589959779==--

