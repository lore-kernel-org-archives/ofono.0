Content-Type: multipart/mixed; boundary="===============7774599304822395538=="
MIME-Version: 1.0
From: Essi Vehmersalo <essi.vehmersalo@nokia.com>
Subject: [PATCH] Phonesim HACKING updated to refer to phonesim.conf instead of
 modem.conf.
Date: Tue, 01 Feb 2011 09:31:31 +0200
Message-ID: <1296545491-474-1-git-send-email-essi.vehmersalo@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7774599304822395538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 HACKING |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/HACKING b/HACKING
index 8316ed5..7997b06 100644
--- a/HACKING
+++ b/HACKING
@@ -81,15 +81,15 @@ Running from within the source code repository
 When using "./configure --enable-maintainer-mode" the automake scripts will
 use the plugins directly from within the repository. This removes the need
 to use "make install" when testing "phonesim". The "bootstrap-configure"
-automatically includes this option.
+automatically includes this option. See phonesim.conf sample configuration =

+under ofono/plugins on how to configure oFono to use phonesim.
 =

   Run phonesim in foreground using the following options
     # ./src/phonesim -p 12345 -gui src/default.xml
 =

-Check your modem.conf file and enable the phonesim configuration before
-executing the above command. Argument -p should be followed by the proper
-port number, in case you have changed the default "12345". Argument -gui
-will launch the gui once the modem is enabled.
+Argument -p should be followed by the proper port number, in case you have =

+changed the default "12345". Argument -gui will launch the gui once the =

+modem is enabled.
 =

 To enable the modem, make sure the ofono daemon is running and execute the
 enable-modem script with /phonesim argument (default defined in modem.conf,
-- =

1.7.1


--===============7774599304822395538==--

