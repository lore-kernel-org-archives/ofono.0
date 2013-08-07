Content-Type: multipart/mixed; boundary="===============1004987065299673876=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: PPP connection to a private APN
Date: Wed, 07 Aug 2013 09:12:38 -0700
Message-ID: <C26D77B5-760B-46DF-AD1E-B598E35C7B2C@holtmann.org>
In-Reply-To: <loom.20130807T155127-216@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1004987065299673876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

>>> I am forced to work with version 1.3 of oFono and I want to setup a ppp
>>> connection on a private APN.
>>> It works well on a public APN but not on the private one. I looked at
>>> the debug trace and it seems like oFono doesn't give the username and
>>> password anywhere in the AT commands.
>>> Is this function possible ? If so, does anyone know when this feature
>>> was added so I can add a patch to my version ?
>>> =

>> =

>> Your subject mentions a 'PPP' connection.  So I assume you're using a =

>> modem which uses PPP.  If so, then the user/password exchange is done =

>> over the PPP link and not AT commands.  You will have to debug the PPP =

>> connection in order to understand what fails.
>> =

>> The gatchat library actually has a nice tool that might help.  It uses =

>> the oFono internal PPP implementation and can make basic context =

>> activations.  See gatchat/gsmdial.c for reference.
>> =

>> The tool also supports PPPdump file output (use --pppdump option to set =

>> a filename).  You can then view the detailed transaction log with =

>> wireshark or another protocol analyzer.
> Thank you for your help, I managed to obtain a dump of the ppp connection
> and I compared it with the ppp debug info from ofono. =

> =

> The modem negociates with the DCE for the correct DNS and IP addresses. B=
ut
> the modem receives a "CGEV: NW DEACT X25" message before obtaining the IP
> address. I checked the dump with wireshark, there is no exchange of usern=
ame
> and password. Do you know if this is supposed to happen before or after
> obtention of the IP address ?

is your private APN really an X25 network? We would normally expect types o=
f IP, IPV6 or IPV4V6 and not plain X25. Are you asking for X25 network via =
AT+CGDCONT or does the network turn it into one?

Regards

Marcel


--===============1004987065299673876==--

