Content-Type: multipart/mixed; boundary="===============9137465152526967974=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH v2 0/1] Fix possible seg fault in previous patch
Date: Tue, 21 Feb 2017 11:37:28 +0100
Message-ID: <20170221103729.23967-1-c.ronco@kerlink.fr>
In-Reply-To: <20170220163344.16670-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9137465152526967974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A segmentation fault is possible with my previous patch.
It occurs if modem is removed. In this case, modem_disconnect is called aft=
er
huawei_remove.
ofono_modem_get_data(modem) will return NULL in this case.

Christophe Ronco (1):
  huawei: reopen modem channel if it disconnects

 plugins/huawei.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 1 file changed, 50 insertions(+), 7 deletions(-)

-- =

2.11.0


--===============9137465152526967974==--

