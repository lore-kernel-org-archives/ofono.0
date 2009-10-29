Content-Type: multipart/mixed; boundary="===============6295521583453544598=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH] Inserted the GSM syntax option in modem.conf.
Date: Thu, 29 Oct 2009 15:11:06 +0100
Message-ID: <4AE9A27A.6070202@gmail.com>
In-Reply-To: <1256824416.5768.39.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6295521583453544598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Marcel Holtmann wrote:
> Hi Ryan,
> =

>> Since the modems need to be setup in particular ways, this patch
>> allows for the GSM syntax to be specified by the configuration file.
>> ---
>>  plugins/atgen.c     |    9 ++++++++-
>>  plugins/modemconf.c |    6 ++++++
>>  2 files changed, 14 insertions(+), 1 deletions(-)
>>
>> diff --git a/plugins/atgen.c b/plugins/atgen.c
>> index db59e36..67a1e8c 100644
>> --- a/plugins/atgen.c
>> +++ b/plugins/atgen.c
>> @@ -117,7 +117,14 @@ static int atgen_enable(struct ofono_modem *modem)
>>  		return -EIO;
>>  	}
>>  =

>> -	syntax =3D g_at_syntax_new_gsmv1();
>> +	value =3D ofono_modem_get_string(modem, "GsmSyntax");
>> +	if (value && g_str_equal(value, "GSM_V1"))
>> +		syntax =3D g_at_syntax_new_gsmv1();
>> +	else if (value && g_str_equal(value, "GSM_Permissive"))
>> +		syntax =3D g_at_syntax_new_gsm_permissive();
>> +	else if (value)
>> +		return -EINVAL;
>> +
> =

> first of all, stop checking value all the time. It is fine to have
> nested ifs here. And second you duplicate GSM in the parameter name and
> also in the value. So just call it V1 and Permissive.
> =


Will do.

>>  	chat =3D g_at_chat_new(channel, syntax);
>>  	g_at_syntax_unref(syntax);
>>  	g_io_channel_unref(channel);
>> diff --git a/plugins/modemconf.c b/plugins/modemconf.c
>> index 6b317e6..a5e5824 100644
>> --- a/plugins/modemconf.c
>> +++ b/plugins/modemconf.c
>> @@ -138,6 +138,12 @@ static int set_device(struct ofono_modem *modem,
>>  	} else
>>  		ofono_modem_set_string(modem, "Rtscts", "on");
>>  =

>> +	value =3D g_key_file_get_string(keyfile, group, "GsmSyntax", NULL);
>> +	if (value) {
>> +		ofono_modem_set_string(modem, "GsmSyntax", value);
>> +		g_free(value);
>> +	} else
>> +		ofono_modem_set_string(modem, "GsmSyntax", "GSM_V1");
>>  =

> =

> Did you check that this applies cleanly against latest GIT tree?
> =


You got me there. The 2 outstanding patches for modemconf need to be =

applied first (wooops). I will make a new set of patches for all the =

modemconf changes.

Greetings,
Ryan

> Regards
> =

> Marcel
> =

>=20

--===============6295521583453544598==--

