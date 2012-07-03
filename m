Content-Type: multipart/mixed; boundary="===============8392276871139569189=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: PPP connection is not established between DUN server(linux +
 ofono) and DUN client(Win7)
Date: Tue, 03 Jul 2012 10:06:28 +0200
Message-ID: <4FF2A804.8070200@linux.intel.com>
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E0FDA2236@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8392276871139569189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Wu,

On 03/07/2012 09:29, Zheng, Wu wrote:
> Hi,
>
> I am trying the DUN feature of ofono.
>
> DUN server: Linux kernel 3.0 and ofono-1.7
>
> DUN client:win7
>
> However, PPP connection is not established between DUN server(linux + ofo=
no) and DUN client(Win7).
>
> DUN client(win7) keep at the status of "verifying user and password".
>
> The attachment is the log of ofono(DUN server).
>
> After checking the log,
>
> DUN server(ofono) got the event 7 (RCR-) firstly at ppp_enter_phase() 1.
>
> After DUN server(ofono) got the event 8 (RCA), DUN server(ofono) always n=
on-stop to get the event 7 (RCR-).
>
> What is wrong in the process? Some suggestions? Thank you.

It seems you have some PPP compression activated into Win7 client.
You have to configure your DUN properties.
When you click on connect, you have click on properties --> options tab =

--> PPP settings --> and you clear all the boxes.
Then it should work properly.

Kind regards,
Guillaume

--===============8392276871139569189==--

