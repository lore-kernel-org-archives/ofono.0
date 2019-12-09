Content-Type: multipart/mixed; boundary="===============0977656424677424438=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: 4G LTE GPRS Attach error?
Date: Mon, 09 Dec 2019 16:21:37 +0100
Message-ID: <e7304a36-adeb-1c24-63f7-5be46c34d854@norrbonn.se>
In-Reply-To: <CAA=hcWRhEX9iBDqq_2aaHF6dtFdXZZd1kfYY=ARnTpESzBV4Eg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0977656424677424438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 20/11/2019 10:39, JH wrote:
> Sorry missing the subject, I further checked, it is not SIM issue,
> then I am confused, does the 4G LTE is really using the old 2G GRPS?
> =

> Appreciate comments what is that error really means?
> =

> Thank you.
> =

> - jh
> =

> On 11/20/19, JH <jupiter.hce@gmail.com> wrote:
>> Hi,
>>
>> I have two 4G LTE devices, one can connect to 4G network, one could
>> not and has following error from connman log file:
>>
>> Failed to change property: /ubloxqmi_0/context1
>> org.ofono.ConnectionContext.Active: org.ofono.Error.AttachInProgress
>> GPRS Attach is in progress
>>
>> Does the error indicate the SIM is not activated? Or what could be the
>> problem?

No, quite the opposite.  It pretty much indicates that the SIM is =

activated and it is in the process of connecting to the network.

Don't be confused by the GPRS terminology, there.  I think even for LTE =

you'll get this message while attaching to the default bearer.

Is that the last message in the log?  If yes, I would run with debug =

output and check what's going on in more detail.

/Jonas

>>
>> Thank you.
>>
>> Kind regards,
>>
>> - jh
>>
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
>=20
--===============0977656424677424438==--

