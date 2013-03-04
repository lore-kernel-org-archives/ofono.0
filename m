Content-Type: multipart/mixed; boundary="===============6512758792718525994=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 02/10] handsfree-audio: Move SCO to handsfree-audio.c
Date: Mon, 04 Mar 2013 12:44:49 -0300
Message-ID: <CAKT1EBexBCj+Xz3NJrg7=oyJitYVk4DXMS-r0QnPfW_3YpDuQQ@mail.gmail.com>
In-Reply-To: <5130FF6E.1030807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6512758792718525994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On Fri, Mar 1, 2013 at 4:20 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Claudio,
>
>
> On 02/28/2013 12:52 PM, Claudio Takahasi wrote:
>>
>>   This patch moves the SCO socket handling from hfp_hf_bluez5 plugin to
>>   handsfree-audio.c file.
>>
>>   This is the initial step to be able to support sending the file
>>   descriptor through the Agent NewConnection method.
>> ---
>>   plugins/hfp_hf_bluez5.c | 102
>> +----------------------------------------------
>>   src/handsfree-audio.c   | 103
>> +++++++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 103 insertions(+), 102 deletions(-)
>>
>
> <snip>
>
>
>> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
>> index b2d4b97..14488ac 100644
>> --- a/src/handsfree-audio.c
>> +++ b/src/handsfree-audio.c
>> @@ -25,12 +25,19 @@
>>
>>   #include<errno.h>
>>   #include<stdio.h>
>> +#include<stdint.h>
>>   #include<string.h>
>> +#include<fcntl.h>
>> +#include<unistd.h>
>> +#include<sys/socket.h>
>>
>>   #include<gdbus.h>
>> +#include<gatchat.h>
>
>
> Why do you need this?

drivers/hfpmodem/slc.h requires:
struct hfp_slc_info {
        GAtChat *chat;
...
}

>
>>
>> +#include<drivers/hfpmodem/slc.h>
>
>
> Or this?
enum hfp_version {
....
HFP_VERSION_1_6
....
}


>
>
>>   #include<ofono/handsfree-audio.h>
>>
>> +#include "bluetooth.h"
>>   #include "ofono.h"
>>
>>   #define HFP_AUDIO_MANAGER_INTERFACE   OFONO_SERVICE
>> ".HandsfreeAudioManager"
>> @@ -60,6 +67,97 @@ struct agent {
>>   static struct agent *agent =3D NULL;
>>   static int ref_count =3D 0;
>>   static GSList *card_list =3D 0;
>> +static guint sco_watch =3D 0;
>> +static uint16_t local_hfp_version =3D HFP_VERSION_1_6;
>
>
> Why do we need this?

We gonna need it later to set the socket options for SCO: CVSD or
Transparent (mSBC). I will try to post-pone it until we really need
it.

BlueZ uses the values directly instead of defines/enum, this approach
will avoid "#include<drivers/hfpmodem/slc.h>". Move the "enum
hfp_version" to a new header (eg: bluetooth.h ) without GAtChat
dependency is another alternative. Which approach do you prefer?

>
>
>> +
>> +static ofono_bool_t slc_match(struct ofono_modem *modem, void *userdata)
>> +{
>> +       const char *remote =3D userdata;
>> +       const char *value =3D ofono_modem_get_string(modem, "Remote");
>> +
>> +       if (value =3D=3D NULL)
>> +               return FALSE;
>> +
>> +       /* Make sure SLC has been established */
>> +       if (ofono_modem_get_powered(modem) !=3D TRUE)
>> +               return FALSE;
>> +
>> +       return g_str_equal(remote, value);
>
>
> The matching should be done on cards, not modems.

Yes, I know. My approach was: move the code first and fix it later
making clear which changes are required when the code was moved from
hfp_hf_bluez5.c to src/handsfree-audio.c

Regards,
Claudio

Regards,
Claudio

--===============6512758792718525994==--

