Content-Type: multipart/mixed; boundary="===============6768316892081845700=="
MIME-Version: 1.0
From: Etienne <mabille.etienne@gmail.com>
Subject: Re: PPP connection to a private APN
Date: Fri, 09 Aug 2013 09:11:51 +0000
Message-ID: <loom.20130809T104244-111@post.gmane.org>
In-Reply-To: <6F707C80-7C17-41B2-8B06-0CD95FB086F9@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6768316892081845700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@...> writes:

> =

> Hi Denis,
> =

> >> is your private APN really an X25 network? We would normally expect
types of IP, IPV6 or IPV4V6 and not
> plain X25. Are you asking for X25 network via AT+CGDCONT or does the
network turn it into one?
> >> =

> > =

> > The CGDCONT is quite clearly using an IP context type.  We don't even
support X25 context type btw ;)
> > =

> > ofonod[1911]: Modem: > AT+CGDCONT=3D1,"IP","...."\r
> > ofonod[1911]: Modem: < \r\nOK\r\n
> > ofonod[1911]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
> > ofonod[1911]: Modem: > AT+CGDATA=3D"PPP",1\r
> > ofonod[1911]: Modem: < \r\nCONNECT\r\n
> =

> maybe SIM Toolkit is turning this into an X25 connection ;)
> =

> Or the modem firmware is fully confused and not able to handle this. Time
to try this with a different modem.
> For example an Ericsson MBM or Qualcomm QMI.
> =

> Regards
> =

> Marcel
> =

> =


Hi all,

So we managed to solve our problem, we found out how to connect to a private
apn, but we have some questions to clear things up.

We compared the sequence of AT commands sent by ofono and by network manager
for the same modem (Telit HE910).
One difference is during the activation of the context :

    - ofono uses the 'AT+CGDATA=3D"PPP",<cid>'  =

the driver used by the telit is the atmodem. This command doesn't appear in
the documentation for the Telit HE910, but it still replied OK. However in
the dumps from ppp, we saw that the DCE does not ask for any authentication
protocol. So the modem doesn't send its credentials, and the DCE eventually
forces a deactivation.
 =

    - network manager used 'ATD*99***#<cid>'
With this command, the DCE asks for an authentication protocol. The modem
then sends its credentials and the connection is completed.


I am not quite sure why the first command does not work while the second
does and I am very interested in having an explanation if you have one.
Should we use another driver than the atmodem ? one that uses the ATD comma=
nd ? =



Another topic is the authentication protocol. By default the Telit HE910
uses PAP which is not handled by ofono. =

I started to implement it in gatchat/ppp_auth.c it is not quite perfect
because it does not ask to do CHAP before falling back to PAP but if anyone
is interested i would be glad to share the code. =

We then found out that there is a custom AT command for the Telit HE910 that
allows you to set the authentication protocol to use : AT#CGAUTH=3D[0,1, or=
 2]
I added it in plugins/telit.c in the post_online function and stopped
working on PAP. (I am using the telit rework patch provided by Jonas Bonn on
the 4th of April)

At the moment i just modified the source with these modifications, and it
works nice.

Thank you for your help,
Regards, =


Etienne




--===============6768316892081845700==--

