Content-Type: multipart/mixed; boundary="===============7980895216838453757=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add dbus .service file to auto start ofonod
Date: Sat, 23 May 2009 13:35:11 +0200
Message-ID: <1243078511.13042.1.camel@localhost.localdomain>
In-Reply-To: <1243033380-2002-1-git-send-email-shane.bryan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7980895216838453757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shane,

> Signed-off-by: Shane Bryan <shane.bryan@linux.intel.com>
> ---
>  configure.ac          |    4 ++++
>  src/Makefile.am       |    4 +++-
>  src/org.ofono.service |    4 ++++

actually it would be better if we just do ofono.service.in (drop the org
in front of it) and then let autoconf fixup the actually configured
prefix.

Regards

Marcel



--===============7980895216838453757==--

