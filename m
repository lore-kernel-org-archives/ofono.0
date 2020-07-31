Content-Type: multipart/mixed; boundary="===============5078474529501186103=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT modem on Droid 4: where is my sms?
Date: Fri, 31 Jul 2020 08:43:38 -0500
Message-ID: <05afe4c6-a81b-77e5-6e1e-6cb9d0f8f6a6@gmail.com>
In-Reply-To: <20200731100750.GA22791@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5078474529501186103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 7/31/20 5:07 AM, Pavel Machek wrote:
> Hi!
> =

> I have problems with getting CNMA to work, so I'm exploring other
> possibilities. Apparently ofono should be able to work without
> that.. but is it working properly?
> =

> ofonod[5218]: < \r\n+CIEV: 1,3\r\n
> ofonod[5218]: < \r\n+CIEV: 1,4\r\n
> ofonod[5218]: < \r\n+CMTI: "ME",2\r\n
> ofonod[5218]: drivers/atmodem/sms.c:at_cmti_notify() Got a CMTI
> indication at ME, index: 2
> ofonod[5218]: > AT+CMGR=3D2\r
> ofonod[5218]: < \r\nOK\r\n

That's quite strange, CMGR response should have an intermediate response =

prefixed by +CMGR: prior to the OK.  Your modem is just weird ;)

> ofonod[5218]: > AT+CMGD=3D2\r
> ofonod[5218]: < \r\nOK\r\n
> ofonod[5218]: < \r\n+CIEV: 1,3\r\n
> ofonod[5218]: < \r\n+CIEV: 1,4\r\n
> =

> So.... modem told us we have new message and where it is, but then
> ofono ... deleted the message without delivering it...?
>

What the stock AT modem driver does is reads the message and deletes it rig=
ht =

away.  Somehow your modem says 'sure' to the read request without actually =

reading the message.  Maybe the firmware is just too slow or oFono is too f=
ast, =

or maybe this modem needs extra special magic.

Regards,
-Denis
--===============5078474529501186103==--

