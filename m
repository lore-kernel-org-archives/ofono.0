Content-Type: multipart/mixed; boundary="===============2376393146452951883=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH 1/5] modem: clean up atoms on modem_unregister
Date: Mon, 25 Apr 2016 06:55:07 +0000
Message-ID: <571DBF4C.5040501@actia.se>
In-Reply-To: <571A7A9B.3010806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2376393146452951883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/22/2016 09:25 PM, Denis Kenzior wrote:
> Hi John,
>
> On 04/22/2016 08:07 AM, John Ernberg wrote:
>> From: John Ernberg <john.ernberg@actia.se>
>>
>> This resolves a crash that can happen when a e.g. usb modem is removed.
>> ---
>>   src/modem.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/src/modem.c b/src/modem.c
>> index a89fa48..4968839 100644
>> --- a/src/modem.c
>> +++ b/src/modem.c
>> @@ -2071,6 +2071,9 @@ static void modem_unregister(struct ofono_modem =

>> *modem)
>>       if (modem->powered =3D=3D TRUE)
>>           set_powered(modem, FALSE);
>>
>
> So in theory, set_powered calls flush_atoms...
>
>> +    if (modem->atoms)
>> +        flush_atoms(modem, MODEM_STATE_POWER_OFF);
>> +
>
> So why is this needed?
>
> Do you have a stack trace handy?
>
>> __ofono_watchlist_free(modem->atom_watches);
>>       modem->atom_watches =3D NULL;
>>
>>
>
> Regards,
> -Denis
I cannot reproduce this one where the atoms remained anymore and I don't =

seem to have any saved stack traces.
So let's drop this part of the series and assume PEBKAC for now.

Best regards // John Ernberg
--===============2376393146452951883==--

