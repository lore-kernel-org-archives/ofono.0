Content-Type: multipart/mixed; boundary="===============4858975196023667689=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] [CHANGE 1/2] Addidng initial documentation for basic
 assisted gps
Date: Wed, 03 Nov 2010 08:49:47 +0100
Message-ID: <1288770587.9615.13.camel@aeonflux>
In-Reply-To: <CB28AA307186A940B1253A743EA1F20AA58B8B1B@orsmsx507.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4858975196023667689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> This is first attempt to send out RFC for a-gps dbus documentation. It fi=
ll be followed by RFC for Infineon modem API implementation. =

> =

> Thank you for your comments in advance. :-)

as explained in the other email, some general rules on submission needs
to be fulfilled. Use git format-patch to create your patch series and
use the cover/summary template for the introduction email. Which is
essentially [PATCH 0/x] in most cases.

And then use git send-email to send them and it will do this magically
proper for you. You can just point it to linux.intel.com mailserver and
no damage to the email will be done.

Please drop the CHANGE keyword. I don't really understand what that
means. It should be [PATCH 1/2] or [RFC 1/2] etc.

In case of revision I prefer that you indicated [RFC v2 1/2] etc. So
that we can easily track patches and to what series they belong and
don't accidentally look at outdated patches.

Also you need proper prefix: in it. This for example would be doc:

So overall this email subject should read

[RFC v2 1/2] doc: Adding ...

In case of IFX modem plugin it should be prefixed with ifx: and in case
of the modem driver with ifxmodem: or atmodem: if it is the generic one.
Changes to the core should have proper prefixes like sms:, gprs: etc.

And then please keep the subject line short. Something around 50 chars
is a good indication. And then fill the rest of the commit message with
proper explanations. Cutoff line should 72 chars per line.

I would also what out for spelling mistakes in the subject and commit
message.

Regards

Marcel



--===============4858975196023667689==--

