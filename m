Content-Type: multipart/mixed; boundary="===============3059920713103099635=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: SMS, Packet service and multiplexing
Date: Wed, 13 May 2009 20:34:49 +0200
Message-ID: <4A0B12C9.9060909@eclis.ch>
In-Reply-To: <200905131314.19664.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3059920713103099635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Denis Kenzior a =C3=A9crit :
> On Wednesday 13 May 2009 12:51:11 Jean-Christian de Rivaz wrote:
>> After taking a overview of the code, I cannot found how SMS and packet
> =

> oFono is by no means a finished product, there are plenty of areas that a=
re =

> still not finished, SMS being one of them.  We're actively working on SMS=
 at =

> the moment.  Some initial SMS utilities were pushed out yesterday.

I see it now after a git pull. Thanks.

>> service are handled. Using packet service will require some multiplexing
>> as I understand.
> =

> Again, this is not yet supported in oFono, patches and ideas are welcome.

I work on a project where we use a Wavecom modem. We chose to use a =

second serial line to handle the PPP stream. If Ofono have working SMS =

and packet service multiplexing, we will probably evaluate it use into a =

next revision of the project product so we can save a serial line.

Regards,

Jean-Christian de Rivaz

--===============3059920713103099635==--

