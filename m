Content-Type: multipart/mixed; boundary="===============2982200614328317642=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Don't unregister *EPEV in *EPEV handler.
Date: Tue, 29 Jun 2010 14:03:43 -0500
Message-ID: <201006291403.43657.denkenz@gmail.com>
In-Reply-To: <1277780427-8241-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2982200614328317642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Handlers are called when looping over the unsolicited responses hash,
> registering or unregistering modifies that hash and confuses glib.
> ---

Good catch.  Applied, thanks.

Regards,
-Denis

--===============2982200614328317642==--

