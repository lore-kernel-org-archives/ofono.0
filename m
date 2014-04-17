Content-Type: multipart/mixed; boundary="===============0338856838772892220=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Thu, 17 Apr 2014 11:24:02 +0300
Message-ID: <534F8FA2.9020709@jolla.com>
In-Reply-To: <534F539A.3010700@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0338856838772892220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
It's for custom provisioning plugins.

Service provider name is passed to the provisioning plugin but not used =

there at all. This patch makes it possible to utilize it for AP matching.

Regards,
-Slava


On 17/04/14 07:07, Denis Kenzior wrote:
> Hi Slava,
>
> On 04/16/2014 09:00 AM, Slava Monich wrote:
>> This gives the provisioning plugin more information to work with and
>> improves the chance of automatically picking the right AP in case if
>> we have more than one for the same mcc/mnc combination.
>> ---
>>   include/gprs-provision.h |  1 +
>>   plugins/mbpi.c           | 47 ++++++++++++++++++++++++++++++++++++++++=
+++----
>>   2 files changed, 44 insertions(+), 4 deletions(-)
>>
> I fail to see the point for this patch.  It makes no sense on its own.
>
>> diff --git a/include/gprs-provision.h b/include/gprs-provision.h
>> index e9eec61..0129cd0 100644
>> --- a/include/gprs-provision.h
>> +++ b/include/gprs-provision.h
>> @@ -31,6 +31,7 @@ extern "C" {
>>   struct ofono_gprs_provision_data {
>>   	enum ofono_gprs_context_type type;
>>   	enum ofono_gprs_proto proto;
>> +	char *provider_name;
> I fail to see why this would be required here?  It is not utilized
> anywhere else...
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>


--===============0338856838772892220==--

