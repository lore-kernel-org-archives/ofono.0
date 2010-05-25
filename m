Content-Type: multipart/mixed; boundary="===============1126861046119344165=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH] huawei: follow sim state change notifications
Date: Tue, 25 May 2010 11:34:23 +0300
Message-ID: <871vd0mlbk.fsf@potku.valot.fi>
In-Reply-To: <1274774518.27220.121.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1126861046119344165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hi Marcel,

>> +enum huawei_state {
>> +	HUAWEI_DISABLED,
>> +	HUAWEI_DISABLE,
>> +	HUAWEI_ENABLE,
>> +	HUAWEI_ENABLED,
>> +};
>> +
>
> is this really needed? I don't see why you want it. Where is the race
> condition that you are trying to fix with it.

I tried to avoid calling ofono_modem_set_powered() subsequent times. For
example, this was the case I was worried about:

1. AT^SYSINFO returns 1 and we call ofono_modem_set_powered(modem, TRUE)

2. Later on (for some reason) we receive ^SIMST: 1 and again call
   ofono_modem_set_powered(modem, TRUE)

But now that I think more about this, I was just too careful here. We
don't need that state variable here.

>>  struct huawei_data {
>>  	GAtChat *chat;
>>  	GAtChat *event;
>> +	gint sim_state;
>> +	enum huawei_state state;
>>  };
>
> I think the sim_state should be just enough.

You are right. I'll remove the state variable and send v2.

Thanks for the review.

-- =

Kalle Valo

--===============1126861046119344165==--

