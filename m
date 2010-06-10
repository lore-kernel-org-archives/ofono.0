Content-Type: multipart/mixed; boundary="===============2085496709914666779=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: SMS status report
Date: Thu, 10 Jun 2010 10:05:43 +0300
Message-ID: <1276153545-22260-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2085496709914666779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that mr-numbers and msg_ids were not updated to the data
structure if the status was something else than "delivered". In
these two patches it is fixed.

So if one mr is concidered undeliverable, the whole id is removed
from the data structure and the mr numbers that still may arrive
as "delivered" are not taken into account anymore.

Do we already have a plan for how accurately we are going to check
these status report status codes?

Br,
Pasi




--===============2085496709914666779==--

