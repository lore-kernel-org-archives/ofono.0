Content-Type: multipart/mixed; boundary="===============2829088502993661544=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Getting gprs context username and password
Date: Thu, 06 Sep 2018 11:43:35 -0500
Message-ID: <1d1ee058-4491-83d0-a7f3-0052a586e3dd@gmail.com>
In-Reply-To: <18999ee1-a1e2-1fe5-4cbc-e8791e531094@intemo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2829088502993661544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 09/06/2018 11:31 AM, Mark van der Putten wrote:
> In the gemalto plugin (static void gemalto_post_sim(struct ofono_modem
> *modem)) or maybe something sooner in startup phase I would like to
> implement AT^SGAUTH

Hmm, are you sure you actually need the AT^SGAUTH?

Gemalto is using the atmodem driver.  This driver uses PPP.  Generally =

any CHAP/PAP authentication is done during PPP negotiation phase, not =

via any vendor +FOOAUTH commands (although I think there are a few =

exceptions now)

For modems that use a high-speed interface, the auth parameters are sent =

during context setup phase.  e.g. after +CGDCONT.  See =

drivers/ifxmodem/gprs-context.c setup_cb() for an example.

If you do need the SGAUTH, then the logical place to put it would be =

into drivers/atmodem/gprs-context.c and use a vendor quirk for gemalto. =

E.g. something like:

switch(gcd->vendor) {
case OFONO_VENDOR_GEMALTO:
	g_at_chat_send(gcd->chat, "AT^XGAUTH..."....);
	break;
}

Regards,
-Denis

--===============2829088502993661544==--

