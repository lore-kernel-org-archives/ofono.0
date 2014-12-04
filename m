Content-Type: multipart/mixed; boundary="===============5724818547291400938=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [help] connect 2 APN at the same time (PPP and QMI)
Date: Thu, 04 Dec 2014 10:56:30 -0600
Message-ID: <5480923E.6020006@gmail.com>
In-Reply-To: <296413424.28859588.1417710383928.JavaMail.root@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5724818547291400938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mylene,

 >
> I looked to other modem plugins. I think I understand what the slave is t=
hanks to that. It is the other interfaces to send AT commands, only, wherea=
s the "main" GAtChat serves to create the PPP connection, is not it ? If I =
am wrong, do not hesitate to make me understand how it works.
>

Pretty much.  When we pass the chat to the gprs_context driver we set =

the slave chat.  This is needed in order to monitor certain events which =

come in via AT commands when the PPP link is active.  In effect we =

require 2 AT command ports.

On some hardware there was only a single functional PPP port, so the =

driver might need to be modified to handle that case, but it sounds like =

you don't have this issue.

> I set the slave (via "g_at_chat_set_slave") to my "Application" device an=
d I succeeded to get 2 contexts. I activate them and it creates the PPP and=
 QMI connections ! I still have a problem : I did not get an IP address on =
one of the APN connection but this is another problem (connman ?) and I wil=
l search alone for that before asking for help :)
>

Cool, feel free to send a patch for this.

IP settings are notified to oFono by the gprs_context driver.  If there =

are IP settings given, then most likely they should be obtained via =

DHCP.  Running test/list-contexts should tell you all the information =

once both contexts are active.

Regards,
-Denis

--===============5724818547291400938==--

