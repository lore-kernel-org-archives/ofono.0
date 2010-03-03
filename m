Content-Type: multipart/mixed; boundary="===============6008661682447091154=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Fix remove wrong extended prefix
Date: Wed, 03 Mar 2010 13:17:39 -0600
Message-ID: <201003031317.40139.denkenz@gmail.com>
In-Reply-To: <1267525299-5740-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6008661682447091154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> ATA, ATH and ATD are belongs to basic command. So removed them.

All of these need to be handled by user callbacks, so effectively they need=
 to =

be treated like extended commands.  Especially with the weird ATD syntax ru=
les =

that 27.007 introduces.

Regards,
-Denis

--===============6008661682447091154==--

