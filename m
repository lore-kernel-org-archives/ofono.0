Content-Type: multipart/mixed; boundary="===============5882547628066328168=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 0/6] Deprecate the Deregister() method
Date: Wed, 19 Jan 2011 23:53:49 +0200
Message-ID: <1295474035-7142-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5882547628066328168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

This set of patches removes the Deregister() method from the netreg
atom. This method serves no purpose, since the Online property is used
to control oFono's radio on/off state.

Cheers,
Aki

--===============5882547628066328168==--

