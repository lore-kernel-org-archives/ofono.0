Content-Type: multipart/mixed; boundary="===============8776579005062421864=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: AT modem on Droid 4: where is my sms?
Date: Fri, 31 Jul 2020 16:41:12 +0200
Message-ID: <7733d88b-05d1-1b76-ed92-9a9eff076cbf@kerlink.fr>
In-Reply-To: <05afe4c6-a81b-77e5-6e1e-6cb9d0f8f6a6@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8776579005062421864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 7/31/20 3:43 PM, Denis Kenzior wrote:
> Hi Pavel,
>
> On 7/31/20 5:07 AM, Pavel Machek wrote:
>> Hi!
>>
>> I have problems with getting CNMA to work, so I'm exploring other
>> possibilities. Apparently ofono should be able to work without
>> that.. but is it working properly?
>>
>> ofonod[5218]: < \r\n+CIEV: 1,3\r\n
>> ofonod[5218]: < \r\n+CIEV: 1,4\r\n
>> ofonod[5218]: < \r\n+CMTI: "ME",2\r\n
>> ofonod[5218]: drivers/atmodem/sms.c:at_cmti_notify() Got a CMTI
>> indication at ME, index: 2
>> ofonod[5218]: > AT+CMGR=3D2\r
>> ofonod[5218]: < \r\nOK\r\n
>
> That's quite strange, CMGR response should have an intermediate
> response prefixed by +CMGR: prior to the OK.=C2=A0 Your modem is just wei=
rd ;)
Just my guess. This can happen if another process (other than Ofono) is
reading the tty channel.
>
>> ofonod[5218]: > AT+CMGD=3D2\r
>> ofonod[5218]: < \r\nOK\r\n
>> ofonod[5218]: < \r\n+CIEV: 1,3\r\n
>> ofonod[5218]: < \r\n+CIEV: 1,4\r\n
>>
>> So.... modem told us we have new message and where it is, but then
>> ofono ... deleted the message without delivering it...?
>>
>
> What the stock AT modem driver does is reads the message and deletes
> it right away.=C2=A0 Somehow your modem says 'sure' to the read request
> without actually reading the message.=C2=A0 Maybe the firmware is just too
> slow or oFono is too fast, or maybe this modem needs extra special magic.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
--===============8776579005062421864==--

