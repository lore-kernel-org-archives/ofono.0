Content-Type: multipart/mixed; boundary="===============7008139433669209150=="
MIME-Version: 1.0
From: Juha Korpi <juha.k.korpi@welho.com>
Subject: Re: Problems with voice call.
Date: Thu, 16 Jul 2009 21:36:45 +0300
Message-ID: <20090716213645.x0n06lmc0c8cwko0@webmail.welho.com>
In-Reply-To: <200907161146.28172.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7008139433669209150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

the experimental support was working fine. I was even able to send a SMS.

Thanks
Juha Korpi


Lainaus Denis Kenzior <denkenz@gmail.com>:

> Hi Juha,
>
>> I am using Nokia 6021 and there seems to be same problem(I guess):
>>
>> ofonod[8320]: Response line: +CPMS: ("ME","SM"),("ME","SM"),("MT")
>
> Your problem is a bit different.  CPMS here reports:
> mem1: "ME", "SM"
> mem2: "ME", "SM"
> mem3: "MT"
>
> oFono was confused by "MT" setting.  I've added experimental support for =
such
> devices.  Please report back if oFono gets further in the initialization
> process.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>




--===============7008139433669209150==--

