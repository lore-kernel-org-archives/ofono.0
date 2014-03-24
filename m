Content-Type: multipart/mixed; boundary="===============7605221808540689554=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Setting 'legacy' property for GSM modem
Date: Mon, 24 Mar 2014 11:55:07 -0500
Message-ID: <5330636B.1090008@gmail.com>
In-Reply-To: <532CC274.6090309@boundarydevices.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7605221808540689554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 03/21/2014 05:51 PM, Eric Nelson wrote:
> Hi all,
>
> I'm an Ofono N00b trying to figure out how configuration
> should happen, and I'm a bit stuck.
>
> I'm trying to get a Novatel 3G modem configured, and seem
> to be quite close.
>
> Using the nice OFONO_AT_DEBUG=3D1 switch, I can see what appears
> to be proper traffic to the point of connection:
>
>      ofonod[1928]: Modem: > AT+CGDATA=3D"PPP",1\r
>      ofonod[1928]: Modem: < \r\nCONNECT HSDPA 3.6\r\n
>
> And using strace, I see a bunch of writes following this:
>
>          write(11, "~\377}#\300!}!}!} }$\321\265~", 17) =3D 17
>          write(11, "\377}#\300!}!}!} }$\321\265~", 16) =3D 16
>
> but no returned data.
>
> If I contrast this with the same card in my laptop running
> Network Manager, I see that the "ATD*99**1#\r" string is
> used to make the connection:
>
>      read(27, "\r\n+CGDCONT: 1,\"IP\",\"roam\",\"\",0,0"..., 1024) =3D 115
>      read(27, 0x130f623, 1024)               =3D -1 EAGAIN (Resource
> temporarily unavailable)
>      write(27, "A", 1)                       =3D 1
>      write(27, "T", 1)                       =3D 1
>      write(27, "D", 1)                       =3D 1
>      write(27, "*", 1)                       =3D 1
>      write(27, "9", 1)                       =3D 1
>      write(27, "9", 1)                       =3D 1
>      write(27, "*", 1)                       =3D 1
>      write(27, "*", 1)                       =3D 1
>      write(27, "*", 1)                       =3D 1
>      write(27, "1", 1)                       =3D 1
>      write(27, "#", 1)                       =3D 1
>      write(27, "\r", 1)                      =3D 1
>      read(27, "\r\nCONNECT HSDPA 3.6\r\n", 1024) =3D 21
>
> And data flows thereafter.
>
> Reading the code, it appears that this form of dialing string is
> supported in Ofono, by using the 'legacy' option:
>
> http://git.kernel.org/cgit/network/ofono/ofono.git/tree/gatchat/gsmdial.c=
#n397
>

gsmdial is just a developer / debug tool.  If you think that this model =

will require using ATD*99 syntax, then you will need to set a vendor =

quirk. The only vendor that currently requires using ATD*99 instead of =

+CGDATA is SIMCOM.

Try the following as a quick test, change plugins/novatel.c post_sim(): =

to do

         gc =3D ofono_gprs_context_create(modem, =

OFONO_VENDOR_SIMCOM_SIM900, "atmodem", data->modem);

and see if that solves your problem.  We have tested several Novatel =

modems and they seem to work just fine with +CGDATA, but you may have =

one that we have not tested.

Regards,
-Denis

--===============7605221808540689554==--

