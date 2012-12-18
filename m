Content-Type: multipart/mixed; boundary="===============2125467641479742676=="
MIME-Version: 1.0
From: Mingli Wu <mingli@southpole.se>
Subject: [PATCH] Add a timer for CPIN callback
Date: Tue, 18 Dec 2012 18:14:30 +0100
Message-ID: <1355850871-28886-1-git-send-email-mingli@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2125467641479742676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

I tested your patch:
"telit: signal sim inserted when sim ready"

It did not work with some sim cards which do not support
SMS. After "AT+CPIN?" was sent, ofono could not get QSS 2
or QSS 3.

I made a patch for this problem, and please help me check if
this solution is reasonable.

Thanks.

Mingli Wu

Mingli Wu (1):
  Add a timer for CPIN callback

 plugins/telit.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

-- =

1.7.9.5


--===============2125467641479742676==--

