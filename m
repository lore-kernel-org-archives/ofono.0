Content-Type: multipart/mixed; boundary="===============1285770146061262468=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2 2/4] emulator: add routine to request/release private
 network from ConnMan
Date: Thu, 28 Apr 2011 15:29:01 +0200
Message-ID: <4DB96B9D.1030406@linux.intel.com>
In-Reply-To: <4DB78CB9.1000008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1285770146061262468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 27/04/2011 05:25, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 04/22/2011 07:06 AM, Guillaume Zajac wrote:
>> ---
>>   include/emulator.h |   10 +++++++
>>   src/emulator.c     |   75 ++++++++++++++++++++++++++++++++++++++++++++=
+++-----
>>   2 files changed, 78 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/emulator.h b/include/emulator.h
>> index 5cd894b..29abf55 100644
>> --- a/include/emulator.h
>> +++ b/include/emulator.h
>> @@ -105,6 +105,16 @@ enum ofono_emulator_request_type ofono_emulator_req=
uest_get_type(
>>   void ofono_emulator_set_indicator(struct ofono_emulator *em,
>>   					const char *name, int value);
>>
>> +typedef void (*network_request)(struct ofono_error *, int *,
>> +				const char **, const char **,
>> +				const char **, const char **);
>> +typedef void (*network_release)(void);
>> +
>> +void ofono_emulator_add_network_request_cb(struct ofono_emulator *em,
>> +							network_request cb);
>> +void ofono_emulator_add_network_release_cb(struct ofono_emulator *em,
>> +							network_release cb);
>> +
> I really don't like this, you're re-inventing the wheel here.  We
> already solved this pattern a while ago ;)  I suggest you look at
> include/gprs-provision.h and examples/provision.c

In looking the example, I should create some emulator network drivers to =

get settings and release the network like:

struct emulator_network{
     ...
}

struct emulator_network_provision_driver{
     char *name;
     (void)(*get_settings)(struct emulator_network **out_en);
     (void)(*release)(void);
}

and un/register drivers into emulator.c

>>   #ifdef __cplusplus
>>   }
>>   #endif
> Regards,
> -Denis
>

Kind regards,
Guillaume

--===============1285770146061262468==--

