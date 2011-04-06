Content-Type: multipart/mixed; boundary="===============9022605016204057027=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v4 0/4] Support of Network / Modem updated emergency numbers
Date: Wed, 06 Apr 2011 07:26:39 -0700
Message-ID: <1302100003-5488-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9022605016204057027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following set of patch adds the support for emergency number list update
from the network/modem in the oFono core.

Regards,
Jeevaka

Jeevaka Badrappan (4):
  include: Add ofono_voicecall_en_list_notify api
  voicecall: refactor emergency number list handling
  voicecall: network emergency number list support
  TODO: Mark Network/Modem EN update task as done

 TODO                |   11 ----
 doc/features.txt    |   18 +++---
 include/voicecall.h |    3 +
 src/voicecall.c     |  160 ++++++++++++++++++++++++++++-------------------=
---
 4 files changed, 103 insertions(+), 89 deletions(-)


--===============9022605016204057027==--

