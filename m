Content-Type: multipart/mixed; boundary="===============5347817860796615718=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Ofono with Sagem Hilo GPRS
Date: Tue, 01 Jun 2010 23:46:24 +0200
Message-ID: <AANLkTik2eSxX2SKAex706K0m8VHtJ0atXQw-YCfdN578@mail.gmail.com>
In-Reply-To: <201006011617.30618.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5347817860796615718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 1 June 2010 23:17, Denis Kenzior <denkenz@gmail.com> wrote:
>> >> ofonod[3221]: src/modem.c:get_modem_property() modem 0x8142058 proper=
ty
>> >> =C2=A0status-poll-interval ofonod[3221]: > AT+CSIM=3D8,A0F200C0\r
>> >> ofonod[3221]: < AT+CSIM=3D8,A0F200C0\r\r\n+CME ERROR: 3\r\n
>> >
>> > The culprit was sim polling which performs CSIM pdus to detect a dead
>> > SIM. Your modem doesn't seem to support CSIM command, so returns an er=
ror
>> > and oFono foolishly thinks the SIM has been removed.
>>
>> Not if the +CME ERROR is sent withing 5 seconds. =C2=A0Only if there is =
a 5
>> second or longer lag between the AT+CSIM=3D... and the response (success
>> or error), it decides the card is dead.
>
> Thanks for the correction. =C2=A0I was hitting a slightly different issue=
 with HSO
> modem and atgen that was also resulting in sim removal.
>
> Looking at the logs again, it seems that this response causes the poll to
> signal sim removal:
>
> ofonod[3253]: > AT+CRSM=3D192,28618\r
> ofonod[3253]: < A
> ofonod[3253]: < T+CRSM=3D192,28618\r
> ofonod[3253]: < \000
> ofonod[3253]: src/message-waiting.c:mw_remove() atom: 0x9ac6c00
> ofonod[3253]: src/phonebook.c:phonebook_remove() atom: 0x9ac6a98
> ofonod[3253]: src/sms.c:sms_remove() atom: 0x9ac69c0
> ofonod[3253]: src/ssn.c:ssn_remove() atom: 0x9ac68f0
> ofonod[3253]: src/call-barring.c:call_barring_remove() atom: 0x9ac6880
> ofonod[3253]: src/call-meter.c:call_meter_remove() atom: 0x9ac6780
> ofonod[3253]: src/network.c:netreg_remove() atom: 0x9ac62e8
> ofonod[3253]: src/call-settings.c:call_settings_remove() atom: 0x9ac64f8
> ofonod[3253]: src/call-forwarding.c:call_forwarding_remove() atom: 0x9ac6=
418
> ofonod[3253]: src/ussd.c:ussd_remove() atom: 0x9ac4e70
> ofonod[3253]: src/modem.c:set_modem_property() modem 0x9ac4058 property
> status-poll-interval
> ofonod[3253]: src/modem.c:unregister_property() property 0x9ac49d8
>
> Seems we try to read EFmwis and get back a '\0' as a response. =C2=A0This=
 probably
> stalls the gatchat queue and causes the sim poll timeout to fire. =C2=A0O=
r is there
> something else going on I'm not seeing?

Yes, it seems there's not much we can do when the queue gets stuck so
for each of these modems we need a custom driver.  The sim polling
code thinks the card is dead because it counts the timeout from the
moment it submits the STATUS poll to the queue, not the moment the
command is executed.  We need to either disable the polling or start
timer when the command is sent to modem.

If the device doesn't have a removable card, and there's a
vendor-specific PROACTIVE COMMAND notification then there's no point
polling.  If the card is removable and modem doesn't support AT+CSIM,
we can send the status through AT+CRSM instead, maybe
atmodem/sim-poll.c should have a quirk for that.

Regards,
Andrew

--===============5347817860796615718==--

