Content-Type: multipart/mixed; boundary="===============4096955957959835056=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 1/1] Enable some atoms for hso modem
Date: Sun, 19 Sep 2010 15:37:32 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A7F0250@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C936621.3080109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4096955957959835056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Marcel,

>> +
>> +static void hso_post_sim(struct ofono_modem *modem)
>> +{
>> +	struct hso_data *data =3D ofono_modem_get_data(modem);
>> +
>> +	DBG("%p", modem);
>> +
>> +	ofono_phonebook_create(modem, 0, "atmodem", data->app);
>> +}
>> +
>
>This is OK

So I will send the patch to enable phonebook only:)


Regards,
-Yang

--===============4096955957959835056==--

