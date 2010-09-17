Content-Type: multipart/mixed; boundary="===============4829138000520137476=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [RFC PATCH v1 2/2] huawei: fix online logic
Date: Fri, 17 Sep 2010 16:58:32 +0300
Message-ID: <87sk18cvzr.fsf@potku.valot.fi>
In-Reply-To: <1284728032.2405.215.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4829138000520137476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hi Marcel,

>>  plugins/huawei.c |   79 ++++++++++++++++++++++++++++++++++++++---------=
-------
>>  1 files changed, 55 insertions(+), 24 deletions(-)
>> =

>> diff --git a/plugins/huawei.c b/plugins/huawei.c
>> index ad1c3ae..0b4e65e 100644
>> --- a/plugins/huawei.c
>> +++ b/plugins/huawei.c
>> @@ -78,6 +78,7 @@ struct huawei_data {
>>  	gboolean voice;
>>  	guint query_sim_state;
>>  	guint sim_poll_count;
>> +	struct cb_data *online_cbd;
>>  };
>
> doing it like this make me suspisious that this is the right approach.
> No other modem plugin has to do it this way. Why does Huawei?

I have no idea, it may very well be that doing the initialisation wrong.
But the problem at hand I have it is that huawei_post_online() makes
assumptions about sim_state:

	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
		data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
		data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
								data->modem);

		if (data->gprs && data->gc)
			ofono_gprs_add_context(data->gprs, data->gc);
	}

And currently (with my setup) data->sim_state will be
HUAWEI_SIM_STATE_INVALID_OR_LOCKED when post_online() is called and
hence gprs context is not initialised. I didn't add the sim_state checks
so I can't comment why they are needed. But this is the commit which
added them:

  commit f01de438bd4f834a27f9c36e74e6a1067f778a21
  Author: Jo.o Paulo Rechi Vita <jprvita@profusion.mobi>
  Date:   Thu Aug 5 16:13:08 2010 -0300

    huawei: Fix SIM state logic
    =

    Add support for voice-only SIM cards and enable phonebook atom for
    non-voice modems.

I don't have that much time to work on this, I just want to get huawei
working again. But I'll try to do something.

I'm guessing ofono_sim_inserted_notify() has something to do this. When
I did some quick tests, IIRC I was able to see HUAWEI_SIM_STATE_VALID
only after I had called ofono_sim_inserted_notify(). =


I think the way you are after is that we would first receive
HUAWEI_SIM_STATE_VALID (or the three other valid states) and only then
call ofono_sim_inserted_notify(). At least to me that would make sense.
I just don't know how to do that because I see only later in the
initialisation phase.

Thoughts?

-- =

Kalle Valo

--===============4829138000520137476==--

