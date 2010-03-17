Content-Type: multipart/mixed; boundary="===============1069435970796348034=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/6] Add test cases for GAtServer
Date: Wed, 17 Mar 2010 22:44:05 +0800
Message-ID: <1268837051-5032-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1069435970796348034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches register callback functions for each AT command.

Patch #1-#5 register basic commands into gatserver.c.
Patch #6 add a simple voice call test case in test-server.c.

TODO:
1. ATE,ATV,ATQ could share a template function.
2. Register more basic commands defined in 27.007.


--===============1069435970796348034==--

