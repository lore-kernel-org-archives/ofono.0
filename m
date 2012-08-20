Content-Type: multipart/mixed; boundary="===============3626520538756354347=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH] telit: disable auto attach procedures with AUTOATT
Date: Mon, 20 Aug 2012 13:11:05 +0200
Message-ID: <50321B49.7020008@hale.at>
In-Reply-To: <502C92A2.3010506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3626520538756354347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 16/08/12 08:26, Denis Kenzior wrote:
> Hi Christopher,
>
> On 08/16/2012 04:48 AM, Christopher Vogl wrote:
>> ---
>>   plugins/telit.c |    6 ++++++
>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/plugins/telit.c b/plugins/telit.c
>> index 6ae7249..feedd18 100644
>> --- a/plugins/telit.c
>> +++ b/plugins/telit.c
>> @@ -307,6 +307,12 @@ static void cfun_enable_cb(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>
>>       ofono_modem_set_powered(m, TRUE);
>>
>> +    /*
>> +     * Tell the modem not to automatically initiate auto-attach
>> +     * proceedures on its own.
>> +     */
>> +    g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix, NULL, =

>> NULL, NULL);
>
> This line is over 80 character limit.

This will not happen again now. I will correct that in the new patch.

>
> Also, are you sure this can be sent even if the PIN is locked?

I have tried it with and without PIN locked and I always get an OK back.
Where would you logically put it? Better move it to 'post sim'?

Regards,
Christopher


--
Scanned by MailScanner.


--===============3626520538756354347==--

