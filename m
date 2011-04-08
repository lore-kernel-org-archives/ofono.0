Content-Type: multipart/mixed; boundary="===============0467842906765782503=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH: Motorola H24 early support]
Date: Thu, 07 Apr 2011 22:25:45 -0500
Message-ID: <4D9E8039.6030804@gmail.com>
In-Reply-To: <65D0035E6914AC478A46CFE3E20C392601E9F71C@snch1xch53.sicpa-net.ads>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0467842906765782503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 04/07/2011 06:35 AM, Ostermann, Christophe wrote:
> Hi, =

> =

> I try to send again a patch to support Motorola H24 modem.
> Sorry but I can t use git to generate the patch in my environment.
> =

> I ve attached a patch file and send my mail in plain text.  Hope you can =
easily use this patch.

This is really not going to work out.  We need a properly formatted
patch, something that I can apply that contains your authorship
information and follows our patch submission guidelines.  In the case of
this patch, it needs to be at least 6 separate commits:

- motorola vendor addition
- gprs-context driver changes
- sim driver changes
- documentation change
- udev change
- h24 plugin + Makefile

See HACKING for our patch submission guidelines.

Regards,
-Denis

--===============0467842906765782503==--

