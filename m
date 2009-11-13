Content-Type: multipart/mixed; boundary="===============4845619673903869006=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Patch on unsupported AT command
Date: Fri, 13 Nov 2009 12:18:52 +0100
Message-ID: <1258111132.3299.10.camel@violet>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001B49C0DD6@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4845619673903869006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> 	If some unsupported AT command is issued, different modem may have their=
 own response. Now at my hand is a Huawei modem (EM770W), and it returns "C=
OMMAND NOT SUPPORT". In my case, this modem doesn't support "AT+CGAUTO=3D0"=
 in atmodem/gprs.c. Current oFono will hang there for it's not a valid retu=
rn.
> 	We may have some quirk to handle this problem, the same way as current c=
ode in network-registration.c with CALYPSO. But I wonder if it's better to =
add the response string into "terminator table", so that we don't need this=
 kind of quirk here and there. I'm not sure if this is the better/best way =
to handle this problem. After all, the table may become larger and larger i=
s more and more specific terminator like this are added. =

> 	Comments are welcome!

this lovely broken Huawei modem where the firmware developers were
incapable of reading the specification and just made up a new response.

I think this might need a GAtChat quirk function where we can add extra
terminator responses that will be recognized. And maybe even translated
into something meaningful.

Denis, or do you want this quirked in every plugin or modem driver?

Regards

Marcel



--===============4845619673903869006==--

