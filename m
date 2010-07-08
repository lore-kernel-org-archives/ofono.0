Content-Type: multipart/mixed; boundary="===============3721713092027919780=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: RE: [PATCH 11/15] emulator: Register mandatory AT command handlers
Date: Thu, 08 Jul 2010 08:46:27 +0200
Message-ID: <899f9aec76a576bcf883c873ef7aa96f@chewa.net>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F76F8E7@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3721713092027919780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 8 Jul 2010 10:31:03 +0800, "Zhang, Zhenhua"
<zhenhua.zhang@intel.com> wrote:
> Marcel is right. Here I fake most AT commands like +CFUN to make DUN
> client happy. We don't need to power on/off real modem at all. See
> gatchat/test-server.c for similar implementation.

That depends much what you're trying to achieve. If you only care about
Dial-Up Networking, that might work. But if you care about passing various
some kinds of certification testing, AT commands _must_ work _correctly_.

So I doubt oFono will get away with this in the medium term.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============3721713092027919780==--

