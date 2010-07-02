Content-Type: multipart/mixed; boundary="===============8102003062833584301=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/3] huawei: Add Huawei EM770 modem support
Date: Fri, 02 Jul 2010 08:57:18 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F681B8B@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1277996820.3052.21.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8102003062833584301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
> Hi Zhenhua Zhang,
> =

>> Huawei EM770W is a 3G WCDMA modem that supports
>> HSPA/UMTS/EDGE/GPRS/GSM data service and WCDMA/GSM short message
>> services. It also has voice call capability that supports both 2G
>>  and 3G network. --- plugins/huawei.c    |   31
>>  ++++++++++++++++++++++++++++++- plugins/ofono.rules |    3 +++
>>  plugins/udev.c      |    3 +++
>>  3 files changed, 36 insertions(+), 1 deletions(-)
>> =

>> diff --git a/plugins/udev.c b/plugins/udev.c
>> index 09ee93e..7d34b0b 100644
>> --- a/plugins/udev.c
>> +++ b/plugins/udev.c
>> @@ -227,6 +227,9 @@ static void add_huawei(struct ofono_modem *modem,
>>  		const char *name =3D udev_list_entry_get_name(entry);
>>  		type =3D udev_list_entry_get_value(entry);
>> =

>> +		if (g_str_equal(name, "ID_MODEL_ID") =3D=3D TRUE)
>> +			ofono_modem_set_string(modem, "Model", type);
>> +
> =

> so this is the part that I don't like. I prefer we have some udev
> rules that create OFONO_HUAWEI_VOICE=3D1 and we use that as indicator
> to enable voice capabilities or not. =


Okay. Will resend out patches and rebase it to latest git tree. Thanks.
 =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============8102003062833584301==--

