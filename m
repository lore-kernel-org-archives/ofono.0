Content-Type: multipart/mixed; boundary="===============2300085500177090442=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Thu, 17 Apr 2014 17:12:04 -0500
Message-ID: <535051B4.6040301@gmail.com>
In-Reply-To: <53501DA7.5000301@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2300085500177090442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

> I agree that there is no need to for it to be returned by the
> provisioning plugin to the core but it's the same structure used by
> mbpi.c to return the result of parsing serviceproviders.xml to the
> provisioning plugin. Side effect of sharing the structure between two
> interfaces.

'Side-effects' that affect the core are never acceptable.  Just a
friendly hint that any changes to the core automatically trigger
scrutiny beyond our already thorough review process.

> If instead I changed the interface between mbpi and provisioning plugin
> and kept the interface with the core intact, would that look acceptable
> to you?

Perhaps, but I'm still failing to see why the service provider name as
entered in MBPI is useful to anyone.

Regards,
-Denis


--===============2300085500177090442==--

