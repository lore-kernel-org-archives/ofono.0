Content-Type: multipart/mixed; boundary="===============5607011579163619268=="
MIME-Version: 1.0
From: Mike Williams <mike@mikebwilliams.com>
Subject: Re: bug reactivating primary context?
Date: Wed, 27 May 2015 12:52:22 -0400
Message-ID: <CANPyyuMeLV+UTUVzYqnH8rWwCJ4_mjUYDnVxje9KDYpw1V4YSQ@mail.gmail.com>
In-Reply-To: <55649D90.80603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5607011579163619268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

On Tue, May 26, 2015 at 12:21 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mike,
>
> On 05/26/2015 10:38 AM, Mike Williams wrote:
>>
>> All,
>>
>> Using connman/ofono to connect to a cellular network, the first time
>> activating the GPRS context works. After deactivation, the next
>> activation fails with an unknown error. I believe this is related to
>> this issue:
>> https://lists.01.org/pipermail/ofono/2015-May/015745.html
>>
>> Looking through the code, it looks like at_gprs_activate_primary() fails
>> at:
>>
>>         if (g_at_chat_send(gcd->chat, buf, none_prefix,
>>                                 at_cgdcont_cb, gc, NULL) > 0)
>>                 return;
>>
>> g_at_chat_send() is returning NULL from at_chat_send_common() because
>> the chat command_queue is NULL.
>
>
> That generally happens because the underlying AT command port for the
> GAtChat has been closed (most likely due to a serial line hangup).
>
> What modem are you using?  Some manufacturers' modems are known to have t=
his
> issue: whenever the PPP connection is dropped, the AT command port is clo=
sed
> by the modem.  Issuing AT&C0 should disable this behavior, but some modems
> do not honor that command.

It looks like AT&C0 is correctly being issued, from the logs here:

ofonod[1398]: plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
ofonod[1398]: Modem: > AT&C0\r
ofonod[1398]: PCUI: > AT&C0\r
ofonod[1398]: PCUI: < \r\nOK\r\n

I'm using a Huawei e173:
ofonod[2008]: Modem: < ATE0 +CMEE=3D1\r\r\nOK\r\n
ofonod[2008]: PCUI: < \r\nManufacturer: huawei\r\nModel:
E173L\r\nRevision: 21.106.04.00.982\r\nIMEI: 868387000063372\r\n+GCAP:
+CGSM,+DS,+ES\r\n\r\nOK\r\n

Is there any way I can see if the modem is closing the command port?

Mike

--===============5607011579163619268==--

