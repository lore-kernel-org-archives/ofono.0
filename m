Content-Type: multipart/mixed; boundary="===============3081163723840575324=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 7/7] Add g_at_server_register to register callback
Date: Thu, 04 Mar 2010 09:41:54 +0800
Message-ID: <4B8F0FE2.2050003@intel.com>
In-Reply-To: <201003031328.16832.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3081163723840575324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/04/2010 03:28 AM, Denis Kenzior wrote:
> Hi Zhenhua,
>
>> ---
>>   gatchat/gatserver.c |   47
> +++++++++++++++++++++++++++++++++++++++++++++++
>>   gatchat/gatserver.h |    6 ++++++
>>   2 files changed, 53 insertions(+), 0 deletions(-)
>>
>> +guint g_at_server_register(GAtServer *server, const char *prefix,
>> +					GAtServerCommandType type,
>> +					GAtServerNotifyFunc notify,
>> +					gpointer user_data,
>> +					GDestroyNotify destroy_notify);
>
> Return a gboolean here.  And where's my unregister function?

OK. g_at_server_unregister will be added next time. :-)

>> +
>>   #ifdef __cplusplus
>>   }
>>   #endif
>>
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============3081163723840575324==--

