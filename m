Content-Type: multipart/mixed; boundary="===============6593633752187303905=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono can't work with ZTE MF190S
Date: Wed, 31 Oct 2012 16:02:36 -0500
Message-ID: <509191EC.8060102@gmail.com>
In-Reply-To: <CADV-EXGTZGDbRWE-KGYXVWOh+bk3FMV0kaCBwfReZ9N+fKfQiQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6593633752187303905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yevhen,

On 10/09/2012 05:44 PM, Yevhen Kyriukha wrote:
> Hello!
>
> I have a problems with Ofono while working with my 3G modem *ZTE MF190S*.
> I can't connect to GPRS network.
> I'm getting an error when I run *enable-gprs* test script.
>
> Log files are attached.
>
> As you can see there are messages like
> *GPRS not supported on this device*
> and
> *Unable to initialize Network Registration*
> in ofono.log and ofono-at.log.
>

The issue is here:

ofonod[2536]: Aux: > AT+CGREG=3D?\r
ofonod[2536]: Aux: < \r\nOK\r\n
ofonod[2536]: GPRS not supported on this device

The correct response to this query according to 27.007 is of the =

following form:

+CREG=3D?
+CREG: (list of supported <n>s)

Since the hardware simply returns 'OK' (which is not valid according to =

the spec) we do not know what modes (1 vs 2) of CREG it supports.  Hence =

we have no idea how to drive this hardware.  This can be fixed via a =

driver quirk, but we need to know whether e.g. AT+CGREG=3D2 works...

ofonod[2536]: src/gprs.c:gprs_remove() atom: 0x8f935e0
ofonod[2536]: Aux: > AT+CREG=3D?\r
ofonod[2536]: Aux: < \r\nOK\r\n
ofonod[2536]: Unable to initialize Network Registration

Same issue as above...  The response to +CREG=3D? is not valid.

Regards,
-Denis

--===============6593633752187303905==--

