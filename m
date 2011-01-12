Content-Type: multipart/mixed; boundary="===============8291330468219987535=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/4] Added GPRS context provisioning driver API sources
Date: Wed, 12 Jan 2011 10:43:30 -0600
Message-ID: <4D2DDA32.8090907@gmail.com>
In-Reply-To: <1294814638.3873.69.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8291330468219987535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> +
>> +/*
>> + * Callback from provisioning plugin.
>> + * settings: list of struct ofono_gprs_provisioning_data
>> + *
>> + * It is responsibility of callback function to free settings-list
>> + * settings-list elements must be freed with ofono_gprs_provisioning_da=
ta_free()
>> + */
>> +typedef void (*ofono_gprs_provision_cb_t)(GSList *settings, void *userd=
ata);
>> +
>> +struct ofono_gprs_provision_driver {
>> +	const char *name;
>> +	int priority;
>> +	void (*get_settings) (struct ofono_modem *modem,
>> +				ofono_gprs_provision_cb_t cb,
>> +				void *userdata);
>> +};
> =

> So here is something we need to talk about. The nettime plugin
> infrastructure using a "pseudo" atom. So do we wanna do the same here or
> do we wanna change the nettime atom to something simple like this.
> =

> I like to have consistency here. Aki, Denis, thoughts?
> =


The nettime and history plugins can create their own D-Bus interfaces.
Hence the need for probe and remove.  Since the provisioning driver
might want to pre-parse its database, I believe it should follow the
same approach...

Regards,
-Denis

--===============8291330468219987535==--

