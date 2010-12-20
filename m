Content-Type: multipart/mixed; boundary="===============4152306263472317291=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH 1/5] cdma-sms: Add CDMA SMS Support
Date: Mon, 20 Dec 2010 13:22:51 -0800
Message-ID: <4D0FC92B.3040900@nokia.com>
In-Reply-To: <4D0FBD0D.6010605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4152306263472317291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 12/20/2010 12:31 PM, ext Denis Kenzior wrote:
> Hi Lei,
>
> On 12/08/2010 06:35 PM, Lei Yu wrote:
>> ---
>>   Makefile.am        |    2 +-
>>   include/cdma-sms.h |   69 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   include/dbus.h     |    4 +++
>>   src/ofono.h        |    2 +
>
> Can you do me a favor and split this up into two patches? One for dbus.h
> and one for cdma-sms.h.  You can lump the ofono.h changes with your atom
> implementation in src/
>

Yes, I will split this up when I submit v2 of this serie of patches.

>>   4 files changed, 76 insertions(+), 1 deletions(-)
>>   create mode 100644 include/cdma-sms.h
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index cdb3166..13cbc37 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -14,7 +14,7 @@ include_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
>>   			include/gprs.h include/gprs-context.h \
>>   			include/radio-settings.h include/stk.h \
>>   			include/audio-settings.h include/nettime.h \
>> -			include/ctm.h
>> +			include/ctm.h include/cdma-sms.h
>>
>>   nodist_include_HEADERS =3D include/version.h
>>
>> diff --git a/include/cdma-sms.h b/include/cdma-sms.h
>> new file mode 100644
>> index 0000000..2e7834d
>> --- /dev/null
>> +++ b/include/cdma-sms.h
>> @@ -0,0 +1,69 @@
>> +/*
>> + *
>> + *  oFono - Open Source Telephony
>> + *
>> + *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  published by the Free Software Foundation.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-13=
01  USA
>> + *
>> + */
>> +
>> +#ifndef __OFONO_CDMASMS_H
>> +#define __OFONO_CDMASMS_H
>
> I suggest using the prefix OFONO_CDMA_
>

Will use OFONO_CDMA_ in v2 of the patch.

>> +
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>> +#include<ofono/types.h>
>> +
>> +struct ofono_cdmasms;
>
> So this would become ofono_cdma_sms...
>

Will change everything from ofono_cdmaxxx to ofono_cdma_xxx.

>> +
>> +typedef void (*ofono_cdmasms_submit_cb_t)(const struct ofono_error *err=
or,
>> +				void *data);
>> +
>> +struct ofono_cdmasms_driver {
>> +	const char *name;
>> +	int (*probe)(struct ofono_cdmasms *cdmasms, unsigned int vendor,
>> +			void *data);
>> +	void (*remove)(struct ofono_cdmasms *cdmasms);
>> +	void (*submit)(struct ofono_cdmasms *cdmasms, unsigned char *tpdu,
>> +			int tpdu_len, ofono_cdmasms_submit_cb_t cb, void *data);
>> +};
>> +
>> +void ofono_cdmasms_deliver_notify(struct ofono_cdmasms *cdmasms,
>> +				unsigned char *pdu, int tpdu_len);
>> +
>> +int ofono_cdmasms_driver_register(const struct ofono_cdmasms_driver *d);
>> +void ofono_cdmasms_driver_unregister(const struct ofono_cdmasms_driver =
*d);
>> +
>> +struct ofono_cdmasms *ofono_cdmasms_create(struct ofono_modem *modem,
>> +					unsigned int vendor,
>> +					const char *driver, void *data);
>> +
>> +void ofono_cdmasms_register(struct ofono_cdmasms *cdmasms);
>> +void ofono_cdmasms_remove(struct ofono_cdmasms *cdmasms);
>> +
>> +void ofono_cdmasms_set_data(struct ofono_cdmasms *cdmasms, void *data);
>> +void *ofono_cdmasms_get_data(struct ofono_cdmasms *cdmasms);
>> +
>> +struct ofono_atom *ofono_cdmasms_get_atom(struct ofono_cdmasms *cdmasms=
);
>> +
>
> Why do you need this one?  I don't see it being used anywhere
>

Will remove. Thanks for pointing this out.

>> +const char *ofono_cdmasms_get_path(struct ofono_cdmasms *cdmasms);
>
> And this one?  Perhaps replacing this by a static function or even
> calling ofono_atom_get_path() is sufficient.
>

Yes, ofono_atom_get_path() is sufficient. Will remove this and
replace with ofono_atom_get_path().

>> +
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>> +#endif /* __OFONO_CDMASMS_H */
>> diff --git a/include/dbus.h b/include/dbus.h
>> index 9e29afb..0587e16 100644
>> --- a/include/dbus.h
>> +++ b/include/dbus.h
>> @@ -55,6 +55,10 @@ extern "C" {
>>   #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
>>   #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
>>
>> +/* CDMA Interfaces */
>> +#define OFONO_CDMA_MESSAGE_MANAGER_INTERFACE "org.ofono.cdma.MessageMan=
ager"
>> +
>> +
>
> Why two empty lines?
>

Will fix this coding style problem.

>>   /* Essentially a{sv} */
>>   #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS=
_STRING \
>>   					DBUS_TYPE_STRING_AS_STRING \
>> diff --git a/src/ofono.h b/src/ofono.h
>> index 792134b..9eb58fa 100644
>> --- a/src/ofono.h
>> +++ b/src/ofono.h
>> @@ -126,6 +126,8 @@ enum ofono_atom_type {
>>   	OFONO_ATOM_TYPE_STK =3D 20,
>>   	OFONO_ATOM_TYPE_NETTIME =3D 21,
>>   	OFONO_ATOM_TYPE_CTM =3D 22,
>> +	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
>
> This does not seem related...
>

Will remove. Thought this will save you some merge work. :-)

>> +	OFONO_ATOM_TYPE_CDMA_MESSAGE_MANAGER =3D 24,
>>   };
>>
>>   enum ofono_atom_watch_condition {
>
> Regards,
> -Denis

Regards,
Lei

--===============4152306263472317291==--

