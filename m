Content-Type: multipart/mixed; boundary="===============8855718446337041254=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH v3 2/2] plugins: add ctm create to ifx plugin
Date: Fri, 14 Jan 2011 08:27:51 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802D5A104@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1294964100.3873.109.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8855718446337041254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

ofono-bounces(a)ofono.org wrote:
> Hi Jeevaka,
> =

>>  plugins/ifx.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>> =

>> diff --git a/plugins/ifx.c b/plugins/ifx.c index c0a69c2..08b0001
>> 100644 --- a/plugins/ifx.c
>> +++ b/plugins/ifx.c
>> @@ -57,6 +57,7 @@
>>  #include <ofono/radio-settings.h>
>>  #include <ofono/audio-settings.h>
>>  #include <ofono/stk.h>
>> +#include <ofono/ctm.h>
>>  #include <ofono/log.h>
>> =

>>  #include <drivers/atmodem/atutil.h>
>> @@ -700,6 +701,7 @@ static void ifx_post_sim(struct ofono_modem
>> *modem) =

>> =

>>  	DBG("%p", modem);
>> =

>> +	ofono_ctm_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);
> =

> so no emergency calls with CTM are possible? Or do we have to
> potentially also handle that? =

> =


Emergency calls are possible. I'll move the ctm_create to pre_sim state.

Regards,
Jeevaka

--===============8855718446337041254==--

