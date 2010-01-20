Content-Type: multipart/mixed; boundary="===============6310369626848041978=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: RE: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Wed, 20 Jan 2010 19:24:03 +0100
Message-ID: <61D8D34BB13CFE408D154529C120E07903231BFD@eseldmw101.eemea.ericsson.se>
In-Reply-To: <1263850022.5591.145.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6310369626848041978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.
Thank you for lots of feedback on patches. Marit who has done most of the =

implementation is gone for a few days so we'll have to wait until end of
next week with the next oFono patch-set.


Marcel Holtmann wrote:
>>>> +	/* Need to change to gsm_permissive syntax in order to
>>>> +	 * parse the response from EPPSD (xml) */
>>>> +	g_at_chat_set_syntax(gcd->chat,
>>>> +g_at_syntax_new_gsm_permissive());
>>> =

>>> Is this an issue with your modem firmware or an issue in the v1
>>> parser. If it is the modem firmware, then just use the permissive
>>> parser all the time and switch to E0.
>> =

>> Setting permissive mode was done in order to be able to parse the XML
>> response from  EPPSD (Propriatery Activate PDP context).
>> But we can try if we can run with this mode default if you think this
>> is better.
> =

> Can you post an example (manually via cu or minicom and with ATE1) on
> how this looks like. My question here is if you are actually
> following the strict v1 syntax. If you don't then that is basically a
> bug on the modem side. I don't even know if v1 has any kind of
> capabilities to handle XML properly in the first place.    =

> =

> The point here is if you can not use v1 parser, then just use
> permissive from the beginning and avoid switching at runtime. The
> capability of switching at runtime mainly only exists for testing
> purposes. With the permissive parser you just have to ensure ATE0
> inside the modem plugin.    =

> See the other users for an example.

Here is an example of the output from AT*EPPSD. =


ofonod[26268]: < \r\nOK\r\n
ofonod[26268]: > AT*EPPSD=3D1,1,1\r
ofonod[26268]: < AT*EPPSD=3D1,1,1\r
ofonod[26268]: < \r\n<?xml version=3D"1.0"?>\r\n
ofonod[26268]: < <connection_parameters>\r\n   <ip_address>10.64.151.14</ip=
_address>\r\n   <subnet_mask>255.255.255.255</subnet_mask>\r\n   <mtu>1500<=
/mtu>\r\n   <dns_server>10.64.148.4</dns_server>\r\n   <dns_server>10.64.14=
8.5</dns_server>\r\n</connection_parameters>\r\n
ofonod[26268]: < \r\nOK\r\n
ofonod[26268]: ste_eppsd_up_cb got result: 1
ofonod[26268]: Final response: OK
ofonod[26268]: Response line: <?xml version=3D"1.0"?>
ofonod[26268]: Response line: <connection_parameters>
ofonod[26268]: Response line:    <ip_address>10.64.151.14</ip_address>
ofonod[26268]: Response line:    <subnet_mask>255.255.255.255</subnet_mask>
ofonod[26268]: Response line:    <mtu>1500</mtu>
ofonod[26268]: Response line:    <dns_server>10.64.148.4</dns_server>
ofonod[26268]: Response line:    <dns_server>10.64.148.5</dns_server>
ofonod[26268]: Response line: </connection_parameters>
ofonod[26268]: src/gprs.c:pri_activate_callback() 0x9bf22f8 caif0

 =

>> Sure we can fix this, but this is actually just copied from
>> gprs_context in "atmodem". =

>> BTW, the iter_init seems to be missing in atmodem's implementation,
>> this is probably a bug in "atmodem".
> =

> Sounds like a bug in atmodem then. Can you point me to the lines
> where you are seeing this. I will fix it if needed. =


cgev_notify() is on line 208 in drivers/atmodem/gprs-context.c line
missing call to g_at_result_iter_init(&iter, result);


BR/Sjur

--===============6310369626848041978==--

