Content-Type: multipart/mixed; boundary="===============7967471056123622079=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [VPATH PATCH 0/2] Fix Makefile.am when using VPATH
Date: Tue, 30 Aug 2011 15:20:16 +0300
Message-ID: <1314706818-9720-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7967471056123622079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed there are some problems building with VPATH (if builddir and
srcdir are different from each other). E.g., make checkdist worked only
by accident. The following patches are supposed to fix the problems.

--Pekka


--===============7967471056123622079==--

