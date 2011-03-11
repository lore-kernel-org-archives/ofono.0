Content-Type: multipart/mixed; boundary="===============5289272828219732643=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Setting PDP mode
Date: Fri, 11 Mar 2011 10:20:22 -0600
Message-ID: <4D7A4BC6.7030203@gmail.com>
In-Reply-To: <1299745991.3163.3.camel@claudio-laptop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5289272828219732643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi claudio,

On 03/10/2011 02:33 AM, claudio wrote:
> =

> Hi,
> =

> It's possible to set the pdp mode through ofono ? I need to set the pdp
> mode to auto, ip and ppp,

I'm not sure what you mean by 'auto' pdp mode.

The protocol selection (IP, IPv6 or dual stack IPv4 & IPv6 combined) is
currently work in progress, but we support IP contexts already.  Refer
to the Protocol property of ConnectionContext interface in
doc/connman-api.txt

oFono does not allow you to select the actual protocol used to talk to
the modem (e.g. PPP, high-speed, or some vendor specific) for gprs
contexts.  In fact it does not even care itself.  It is up to the modem
driver to figure out the best protocol for that particular modem.

> =

> What are the dbus interface and properties to use ?
>

Refer to doc/connman-api.txt

Regards,
-Denis

--===============5289272828219732643==--

