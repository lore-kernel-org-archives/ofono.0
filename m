Content-Type: multipart/mixed; boundary="===============7672550714669197449=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PPP connection to a private APN
Date: Fri, 09 Aug 2013 09:24:36 -0500
Message-ID: <5204FBA4.6040809@gmail.com>
In-Reply-To: <loom.20130809T104244-111@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7672550714669197449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

 >
> So we managed to solve our problem, we found out how to connect to a priv=
ate
> apn, but we have some questions to clear things up.
>
> We compared the sequence of AT commands sent by ofono and by network mana=
ger
> for the same modem (Telit HE910).
> One difference is during the activation of the context :
>
>      - ofono uses the 'AT+CGDATA=3D"PPP",<cid>'
> the driver used by the telit is the atmodem. This command doesn't appear =
in
> the documentation for the Telit HE910, but it still replied OK. However in
> the dumps from ppp, we saw that the DCE does not ask for any authenticati=
on
> protocol. So the modem doesn't send its credentials, and the DCE eventual=
ly
> forces a deactivation.
>
>      - network manager used 'ATD*99***#<cid>'
> With this command, the DCE asks for an authentication protocol. The modem
> then sends its credentials and the connection is completed.
>
>
> I am not quite sure why the first command does not work while the second
> does and I am very interested in having an explanation if you have one.
> Should we use another driver than the atmodem ? one that uses the ATD com=
mand ?
>

So in theory the ATD*99... variation is a legacy context activation =

command.  It is described in 27.007 Section 10.2.1.1 Request Packet =

Domain service 'D'.  It is supposed to be superseded by AT+CGDATA, but =

many manufacturers have not updated their firmware properly.  oFono =

supports both, you might need to set a quirk if one is preferred over =

the other.

>
> Another topic is the authentication protocol. By default the Telit HE910
> uses PAP which is not handled by ofono.
> I started to implement it in gatchat/ppp_auth.c it is not quite perfect
> because it does not ask to do CHAP before falling back to PAP but if anyo=
ne
> is interested i would be glad to share the code.
> We then found out that there is a custom AT command for the Telit HE910 t=
hat
> allows you to set the authentication protocol to use : AT#CGAUTH=3D[0,1, =
or 2]
> I added it in plugins/telit.c in the post_online function and stopped
> working on PAP. (I am using the telit rework patch provided by Jonas Bonn=
 on
> the 4th of April)

Does this work with CGDATA?  If that is the case it might explain why =

CGDATA does not ask for authentication.  You can enable this command =

inside drivers/atmodem/gprs-context.c with the appropriate OFONO_VENDOR =

handling as well.

Patches are always welcome.

>
> At the moment i just modified the source with these modifications, and it
> works nice.
>

No problem.

Regards,
-Denis

--===============7672550714669197449==--

