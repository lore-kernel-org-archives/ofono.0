Content-Type: multipart/mixed; boundary="===============7047336494910838222=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Dealing with modem hangs
Date: Mon, 24 Mar 2014 16:04:54 -0500
Message-ID: <53309DF6.9000003@gmail.com>
In-Reply-To: <CADV-EXG+jXowODbok4Yqf1OCYQxKGA9oodsQmVt0MqpJ08ZGUw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7047336494910838222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yevhen,

On 03/24/2014 03:45 PM, Yevhen Kyriukha wrote:
> I use 3G modems connected to unattended terminals for a long time.
> I use ofono for managing 2G connections.
>
> All this time I'm suffering from modem hangs: during establishing 2G
> connection modem may hang, i.e. it stops reacting on AT commands to
> specific port.
> I'd tested a lot of modems of different brands before selecting one.
> And I have to say that *every* model has such issue.
>

Most commonly this is a sign that the AT command responses are not =

formatted properly.  Are you running the v250 parser by any chance?  The =

permissive parser is more forgiving.

> So I created a workaround for this (patched ofono):
> When I send AT command I start a timer that fires when no response is
> received during some timeout. So if timeout is reached I send
> AT+CFUN=3D1,1
> command that makes modem reset.
> After that modem can be usable again.

If the modem responds to AT commands, then the likely cause is something =

else.  Most 'real' hardware deals with true modem firmware crashes =

differently.

>
> I was surprised that ofono doesn't have such functionality.
>
> So I think ofono should have some sort of mechanism to reset the modem
> if it stops responding.
> What do you think?
>

Share the AT command logs of when this happens, maybe there is a simpler =

fix.

Regards,
-Denis

--===============7047336494910838222==--

