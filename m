Content-Type: multipart/mixed; boundary="===============5790415262133106889=="
MIME-Version: 1.0
From: Thiago Cangussu de Castro Gomes <thiagoc@syst.com.br>
Subject: Re: Connecting with Huawei E226
Date: Fri, 27 Aug 2010 09:58:33 -0300
Message-ID: <AANLkTimPTy-bXSCJNXFiAo8U8+SLe0KzQ18AxdzGZvJy@mail.gmail.com>
In-Reply-To: <1282896123.6841.76.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5790415262133106889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
On Fri, Aug 27, 2010 at 5:02 AM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> Hi Thiago,
>
>> >> I forgot also to mention that I used list-context to see if the
>> >> enable-modem was successful. The test B is the one that fails.
>> >
>> > From the logs it seems Test A is what fails since we never add any ato=
ms
>> > in that one. =C2=A0Basically the problem is that your modem firmware n=
ever
>> > tells us that the SIM has been initialized by sending us a ^SIMST
>> > notification.
>> >
>> > Kalle's patch relies on SIMST being delivered eventually. =C2=A0Since =
it
>> > never does, oFono is under the impression that your SIM is invalid. =
=C2=A0We
>> > probably need to query SYSINFO a few more times in this case, but it
>> > seems all Huawei firmwares act slightly differently here.
>>
>> Is there something else I can do to help solve this issue? I tried
>> another modem, a ZTE MF110, that is not working either. I installed
>> wvdial on my MeeGo machine and was able to connect using both the
>> Huawei and ZTE modems. I also tested the devices under Ubuntu Lucid
>> and Fedora 13 (both with Networkmanager) and they worked out of the
>> box.
>
> the problem is that neither wvdial nor NM are proper telephony stacks.
> They are both in the end just dialers. So that comparison is not helping
> us since oFono has to do way more work before we can just "dial" an
> Internet connection.
>
> We get this fixed, but not as quick as you might like us too. The Huawei
> and ZTE modems are showing race condition behavior. And that is mainly
> because oFono is just too fast and they can't initialize the SIM fast
> enough for us.

I understand. I mixed up two problems and that got confusing. The ZTE
modem is not showing the race condition issue. It didn't showed up
when I called list-modems. That is why I tested it with other
software, just to be sure it works with linux (MeeGo in this case). I
will test again with the ZTE modem and send the logs to the list.

I am reading the code and some specs from 3GPP, but it's all new stuff
to me and you will probably fix this before I can even understand what
is really going on :) For now I'll keep testing the new code and
sending the logs to the list.

Regards,
Thiago

--===============5790415262133106889==--

