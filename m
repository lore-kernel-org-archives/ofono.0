Content-Type: multipart/mixed; boundary="===============2824840137326623070=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCHv2] qmi: remove request when it timeouts
Date: Fri, 27 Oct 2017 16:37:16 +0200
Message-ID: <1509115037-18275-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <503730fd-fb98-e7d5-5aaa-90b3fa2f764d@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2824840137326623070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Differences from v1:
Remove cast (as proposed by Jonas Bonn)

Christophe Ronco (1):
  qmi: remove request when it timeouts

 drivers/qmimodem/qmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- =

2.7.4


--===============2824840137326623070==--

