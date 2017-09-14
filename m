Content-Type: multipart/mixed; boundary="===============8243977923102605290=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH v2] huawei: add LTE support
Date: Thu, 14 Sep 2017 10:18:36 +0200
Message-ID: <1505377117-15001-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <7b83ba28-0c4d-6afa-b947-077403b16022@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8243977923102605290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Here is another version of the patch.
I have not added query_available_rats methods. Maybe in another patch.

Christophe

Christophe Ronco (1):
  huawei: add LTE support

 drivers/huaweimodem/radio-settings.c | 209 +++++++++++++++++++++++++++++++=
+---
 1 file changed, 192 insertions(+), 17 deletions(-)

-- =

2.7.4


--===============8243977923102605290==--

