Content-Type: multipart/mixed; boundary="===============9146293662112227413=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Telit HE910: CMER command problem
Date: Tue, 04 Dec 2012 23:40:25 -0600
Message-ID: <50BEDE49.7030601@gmail.com>
In-Reply-To: <50C0B87E.2090702@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9146293662112227413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mingli,

On 12/06/2012 09:23 AM, Ming Li Wu wrote:
> Hello,
>
> I am using Telit HE910 modem,
>
> After sending AT+CMER=3D3,0,0,2 I always got "sim card is busy".
>
> The followoing is the part of log:
> ofonod[446]: Aux: > AT+CMER=3D3,0,0,2\r
> ofonod[446]: Aux: < \r\n+CME ERROR: 14\r\n
> ofonod[446]: +CMER not supported by this modem. If this is an error
> please submit patches to support this hardware
>
> My question is :
> How important is this command.?
> I mean what the worst consequence will be if I just ignore this error
> message,
>

CMER is used to set the appropriate CIND mode.  For Telit this is mainly =

used for signal strength reporting, so if this is not set correctly =

there might be some side-effects in that area.

Regards,
-Denis

--===============9146293662112227413==--

