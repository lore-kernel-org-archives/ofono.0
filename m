Content-Type: multipart/mixed; boundary="===============1832460772869377525=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: disable auto attach procedures with AUTOATT
Date: Mon, 20 Aug 2012 08:23:33 -0500
Message-ID: <50323A55.1050709@gmail.com>
In-Reply-To: <50321B49.7020008@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1832460772869377525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/20/2012 06:11 AM, Christopher Vogl wrote:
> Hi Denis,
>
> On 16/08/12 08:26, Denis Kenzior wrote:
>> Hi Christopher,
>>
>> On 08/16/2012 04:48 AM, Christopher Vogl wrote:
>>> ---
>>> plugins/telit.c | 6 ++++++
>>> 1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/plugins/telit.c b/plugins/telit.c
>>> index 6ae7249..feedd18 100644
>>> --- a/plugins/telit.c
>>> +++ b/plugins/telit.c
>>> @@ -307,6 +307,12 @@ static void cfun_enable_cb(gboolean ok,
>>> GAtResult *result, gpointer user_data)
>>>
>>> ofono_modem_set_powered(m, TRUE);
>>>
>>> + /*
>>> + * Tell the modem not to automatically initiate auto-attach
>>> + * proceedures on its own.
>>> + */
>>> + g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix, NULL, NULL,
>>> NULL);
>>
>> This line is over 80 character limit.
>
> This will not happen again now. I will correct that in the new patch.
>

Cool ;)

>>
>> Also, are you sure this can be sent even if the PIN is locked?
>
> I have tried it with and without PIN locked and I always get an OK back.
> Where would you logically put it? Better move it to 'post sim'?
>

If it needed to be done after the SIM PIN was entered, then the best =

place is in the gprs driver using a vendor quirk.  If it can always be =

sent, then doing it like you had originally is just fine.

Regards,
-Denis

--===============1832460772869377525==--

