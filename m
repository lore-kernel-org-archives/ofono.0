Content-Type: multipart/mixed; boundary="===============7268048472263596583=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Fri, 06 Aug 2021 15:49:24 +0100
Message-ID: <d9bb5080-c501-84e6-3d68-eead1020c830@dynamicdevices.co.uk>
In-Reply-To: <8b36e889-4803-870f-884e-da4a41ee70a5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7268048472263596583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 06/08/2021 15:44, Denis Kenzior wrote:
> Hi Alex,
>
>>
>> OK - they say it's fine and you say it's not. I don't have the time =

>> to be the middle-man here.
>>
>
> I'm fairly certain your vendor's firmware is not following the =

> relevant standards, but it sounds like they don't want to fix it. What =

> can I do? :)

Yeah I think you are right and I am getting really irritated with them =

giving me the run-around tbh.

>
>> Although I'd like to, clearly I won't be able to contribute this =

>> Quectel support upstream.
>>
>
> Why does it even matter?=C2=A0 I told you very early on that it would be =

> acceptable to add a new g_at_result_* method that handles negative =

> integers.
>
> Regards,
> -Denis

Yeah ok - what name do you suggest?

Also there's a bigger problem here I think, which is that if I parse =

negative values and try to pass them back via e.g. netmon interface then =

Ofono is treating anything negative in there as an error.

And the DBUS implementation is unsigned for values based on the thinking =

that AT responses are non-negative.

So actually there are a number of invasive changes that seem to need to =

be made to support negative numbers?

Alex


--===============7268048472263596583==--

