Content-Type: multipart/mixed; boundary="===============8976965156371923776=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [n900 PATCH 2/5] isigen: generic modem driver plugin for isimodems
Date: Wed, 15 Sep 2010 20:07:05 +0200
Message-ID: <5fe7a635c2abdce7711d8a5ddff2bb66@chewa.net>
In-Reply-To: <1284569974-22505-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8976965156371923776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


   Hello

Please. Don't put netlink *settings* in oFono. This kills the whole idea of
having a common socket stack that can be shared by several processes. If
you want to run against the Maemo kernel, then you have phonet-utils and
sscd taking care of that anyway. As for the Meego kernel, it should get a
up-to-date and patched Phonet stack as needed.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============8976965156371923776==--

