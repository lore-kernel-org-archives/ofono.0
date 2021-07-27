Content-Type: multipart/mixed; boundary="===============7993145583504652948=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Tue, 27 Jul 2021 16:02:11 +0100
Message-ID: <89eb7908-9a19-5058-a962-4e6963015a9d@dynamicdevices.co.uk>
In-Reply-To: <a581d123-5632-ec7f-208e-e7ef7a96a00b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7993145583504652948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Please see below:

On 27/07/2021 15:38, Denis Kenzior wrote:
> Hi Alex,
>
> On 7/20/21 11:11 AM, Alex J Lennon wrote:
>> Hi all,
>>
>> I'm doing a bit of work with Ofono again, extending support for a =

>> Quectel EG91 - handling additional cell strength information which =

>> seems necessary for LTE.
>>
>> I'm using Quectel's AT+QCOPS which is returning some negative signal =

>> strengths and after some investigation I've spotted that =

>> gatresult::g_at_result_iter_next_number() doesn't handle negative =

>> numbers.
>
> AT commands do not have a concept of negative numbers.=C2=A0 v.250 Sectio=
n =

> 5.3.1:
> <number> may be a string of one or more characters from "0" through =

> "9" representing a decimal
> integer value. Commands that expect a <number> are noted in the =

> description of the command (see
> clause 6).
>
> I don't recall any other vendor using negative values in AT commands.
>
> If you want to add a negative number parser to GAtChat, then please =

> make it a separate method, so that it is very clear that a vendor =

> 'extension' is being worked around.
>
> Regards,
> -Denis


The team at Ofono are suggesting that Quectel (EG91) should not be =

returning negative numbers in AT command responses

These are returned to an AT+QCOPS command where signal strength is given.

Can you comment?

Thanks,

Alex

--===============7993145583504652948==--

