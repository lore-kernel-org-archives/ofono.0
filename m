Content-Type: multipart/mixed; boundary="===============1673880850531290547=="
MIME-Version: 1.0
From: Jan Pohanka <xhpohanka@gmail.com>
Subject: Re: setup ofono for telit h910 on embedded system
Date: Thu, 09 Feb 2012 12:39:19 +0100
Message-ID: <op.v9etbte2yxxkfz@localhost.localdomain>
In-Reply-To: <4F339FDC.8030700@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1673880850531290547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear Nicolas,

>
> I'm not so familiar with device exposing ttyACM interfaces, but i think
> that the problem is here, the  cdc_acm driver is not linked with telit
> devices, Could you try with the following patch?
>

I will try the patch as soon as possible, thank you. Just FYI I have tried  =

also the ttyS1 because H910 can be controlled through USB (ttACM)  =

interface and through UART also. Unfortunately the result was the same.

regards
Jan

-- =

Tato zpr=C3=A1va byla vytvo=C5=99ena p=C5=99evratn=C3=BDm po=C5=A1tovn=C3=
=ADm klientem Opery:  =

http://www.opera.com/mail/

--===============1673880850531290547==--

