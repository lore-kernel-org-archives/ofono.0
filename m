Content-Type: multipart/mixed; boundary="===============0186861112279191428=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofonod crashes during enable-modem.py
Date: Sat, 31 Jan 2015 22:30:03 -0600
Message-ID: <54CDABCB.50805@gmail.com>
In-Reply-To: <AAF281A0-C021-456F-B509-A74580329A45@long-exposure.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0186861112279191428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Norbert,

On 01/31/2015 11:51 AM, Norbert Huffschmid wrote:
> Hi Denis,
>
> this is the full backtrace:
>
> (gdb) bt full
> #0  notify_status_watches (netreg=3D0x100c20) at src/network.c:1182

That's a pretty strange place to have a crash, no idea what's going on =

there.  Have you tried the latest upstream version?  1.6 is pretty old, =

that's almost 3 years old.

Regards,
-Denis

--===============0186861112279191428==--

