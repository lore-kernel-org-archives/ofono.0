Content-Type: multipart/mixed; boundary="===============0226998717436386975=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Ofono with Sagem Hilo GPRS
Date: Tue, 01 Jun 2010 22:34:28 +0200
Message-ID: <AANLkTikGb7A1owSRix_siZnFOvAiFYisw6pm5ujwJdF7@mail.gmail.com>
In-Reply-To: <201006011411.49380.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0226998717436386975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 1 June 2010 21:11, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Yoann,
>
> <snip>
>
>> ofonod[3221]: src/modem.c:get_modem_property() modem 0x8142058 property
>> =C2=A0status-poll-interval ofonod[3221]: > AT+CSIM=3D8,A0F200C0\r
>> ofonod[3221]: < AT+CSIM=3D8,A0F200C0\r\r\n+CME ERROR: 3\r\n
>>
>
> The culprit was sim polling which performs CSIM pdus to detect a dead SIM.
> Your modem doesn't seem to support CSIM command, so returns an error and =
oFono
> foolishly thinks the SIM has been removed.

Not if the +CME ERROR is sent withing 5 seconds.  Only if there is a 5
second or longer lag between the AT+CSIM=3D... and the response (success
or error), it decides the card is dead.

Regards,

--===============0226998717436386975==--

