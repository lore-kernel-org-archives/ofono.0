Content-Type: multipart/mixed; boundary="===============4353459316407636672=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: Re: [PATCH] hso: Don't access freed data, in hso_set_online
Date: Mon, 27 Feb 2012 19:59:32 +0000
Message-ID: <874nucgi8r.fsf@neil-laptop.ossau.uklinux.net>
In-Reply-To: <1330308448.3392.14.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4353459316407636672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Neil,
>
>>  plugins/hso.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> =

>> diff --git a/plugins/hso.c b/plugins/hso.c
>> index 4834c56..697beaa 100644
>> --- a/plugins/hso.c
>> +++ b/plugins/hso.c
>> @@ -422,7 +422,7 @@ static void hso_set_online(struct ofono_modem *modem=
, ofono_bool_t online,
>>  =

>>  	g_free(cbd);
>>  =

>> -	CALLBACK_WITH_FAILURE(cb, cbd->data);
>> +	CALLBACK_WITH_FAILURE(cb, user_data);
>>  }
>
> just put the g_free last. See plugins/ifx.c for example. It seems I
> fixed most of the plugins, but forgot this one.

OK, will do, thanks.

    Neil

--===============4353459316407636672==--

