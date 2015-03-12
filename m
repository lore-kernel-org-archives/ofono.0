Content-Type: multipart/mixed; boundary="===============4418453360823883573=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Telit HE910 general fixes for gprs, sms and voicecall
Date: Thu, 12 Mar 2015 11:56:42 -0500
Message-ID: <5501C54A.8090108@gmail.com>
In-Reply-To: <CAH4ZQwuAG1nv7oUAMh1H7cg-bsvT0gnb88aFYkbqqVfYvd0q7A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4418453360823883573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

 > =E2=80=8BCFUN=3D4 always turns SIM off, even in new firmware.

I'm pretty sure we requested that they change this.  But its been a =

while and I did not follow up whether this change made it into the =

official firmware.

> The reason for this fix is because sometimes ofono is started when the
> modem is already attached to the system, or it is in an inconsistent stat=
e.

oFono powers down the modem when exiting.  So this should not be a =

problem in normal circumstances.

Regards,
-Denis


--===============4418453360823883573==--

