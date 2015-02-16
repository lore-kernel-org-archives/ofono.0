Content-Type: multipart/mixed; boundary="===============2890152696739019982=="
MIME-Version: 1.0
From: Christian Gagneraud <chgans@gna.org>
Subject: Re: Which desktop linux distribution uses ofono natively?
Date: Mon, 16 Feb 2015 15:46:25 +1300
Message-ID: <54E15A01.3010903@gna.org>
In-Reply-To: <3C7F7E81E38D4A2CB43AEACBCD45AB4D@haskell.in>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2890152696739019982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 14/02/15 00:02, Sanjay Mehta wrote:
> Is there a preferred version of desktop Linux to install to experiment wi=
th ofono
> configuration?
>
> My target will be an embedded board (ARM) with a USB 3g/LTE dongle. I=E2=
=80=99d like
> to get the ofono/connman settings done before taking it to the board.

I use to use Ubuntu 13.04 and 13.10 with custom built ofono.
The problem when you experiment with ofono on your dev machine is that =

you will loose your internet connection in case ofono goes nuts. So I =

would say it's better to run ofono experiment on the embedded board.
Set up your dev computer with the cross toolchain, and mount (part of) =

the board rootfs on your dev computer and build (or install) ofono there.

My 2 cents,
Chris

>
> thanks in advance,
>
> Sanjay
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>


--===============2890152696739019982==--

