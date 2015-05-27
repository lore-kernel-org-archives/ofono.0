Content-Type: multipart/mixed; boundary="===============8153549726895245087=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: bug reactivating primary context?
Date: Wed, 27 May 2015 19:07:17 +0200
Message-ID: <5565F9C5.2070607@dynamicdevices.co.uk>
In-Reply-To: <55649D90.80603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8153549726895245087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 26/05/2015 18:21, Denis Kenzior wrote:
> Hi Mike,
>
> On 05/26/2015 10:38 AM, Mike Williams wrote:
>> All,
>>
>> Using connman/ofono to connect to a cellular network, the first time
>> activating the GPRS context works. After deactivation, the next
>> activation fails with an unknown error. I believe this is related to
>> this issue:
>> https://lists.01.org/pipermail/ofono/2015-May/015745.html
>>
>> Looking through the code, it looks like at_gprs_activate_primary()
>> fails at:
>>
>>         if (g_at_chat_send(gcd->chat, buf, none_prefix,
>>                                 at_cgdcont_cb, gc, NULL) > 0)
>>                 return;
>>
>> g_at_chat_send() is returning NULL from at_chat_send_common() because
>> the chat command_queue is NULL.
>
> That generally happens because the underlying AT command port for the
> GAtChat has been closed (most likely due to a serial line hangup).
>
> What modem are you using?  Some manufacturers' modems are known to
> have this issue: whenever the PPP connection is dropped, the AT
> command port is closed by the modem.  Issuing AT&C0 should disable
> this behavior, but some modems do not honor that command. =


I'd like just to verify that this isn't an issue for Cinterion devices /
plugin.  Is it fair to assume that if there is an issue with context
activation and deactivation then I would not have a ppp0 interface
brought up after running the context deactivation and activation test
scripts?

[ all working - connected on ppp0 ]
/usr/lib/ofono/test/deactivate-context
/usr/lib/ofono/test/activate-context
[ all working - connected on ppp0 ]

That all seems OK here on Cinterion EHS6.

Thanks,

Alex


--===============8153549726895245087==--

